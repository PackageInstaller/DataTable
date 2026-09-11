return {
	Play410021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410021002(arg_1_1)
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(410021001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 52 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 52)

				if (52 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 52)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410021002
		arg_9_1.duration_ = 5.5

		local var_9_0 = {
			zh = 4.2,
			ja = 5.5
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
				arg_9_0:Play410021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10061"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10061")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10061"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10061"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10061"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10061 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10061", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_2" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10061, Vector3.New(0, -517.5, -100), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_12_5 = arg_9_1.actors_["10061"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10061 == nil then
				arg_9_1.var_.actorSpriteComps10061 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10061 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 1, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10061 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10061 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(410021002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 15 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 15)

				if (15 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 15)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021002", "story_v_out_410021.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021002", "story_v_out_410021.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_410021", "410021002", "story_v_out_410021.awb")

						arg_9_1:RecordAudio("410021002", var_12_15)
						arg_9_1:RecordAudio("410021002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410021", "410021002", "story_v_out_410021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410021", "410021002", "story_v_out_410021.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play410021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410021003
		arg_13_1.duration_ = 11.9

		local var_13_0 = {
			zh = 6.8,
			ja = 11.9
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
				arg_13_0:Play410021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10061"]) and arg_13_1.var_.actorSpriteComps10061 == nil then
				arg_13_1.var_.actorSpriteComps10061 = arg_13_1.actors_["10061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10061"]) then
				if arg_13_1.var_.actorSpriteComps10061 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10061"]) and arg_13_1.var_.actorSpriteComps10061 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10061 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_4 = arg_13_1:GetWordFromCfg(410021003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 24 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 24)

				if (24 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 24)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021003", "story_v_out_410021.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_410021", "410021003", "story_v_out_410021.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_410021", "410021003", "story_v_out_410021.awb")

						arg_13_1:RecordAudio("410021003", var_16_9)
						arg_13_1:RecordAudio("410021003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410021", "410021003", "story_v_out_410021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410021", "410021003", "story_v_out_410021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play410021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410021004
		arg_17_1.duration_ = 8.73

		local var_17_0 = {
			zh = 4.8,
			ja = 8.733
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
				arg_17_0:Play410021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10061 = arg_17_1.actors_["10061"].transform.localPosition
				arg_17_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10061", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10061"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10061"].transform:GetChild(iter_20_0)

					if var_20_0.name == "split_2" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10061, Vector3.New(0, -517.5, -100), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10061"].transform.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_20_2 = arg_17_1.actors_["10061"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10061 == nil then
				arg_17_1.var_.actorSpriteComps10061 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10061 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10061 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10061 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(410021004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 20 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 20)

				if (20 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 20)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021004", "story_v_out_410021.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021004", "story_v_out_410021.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_410021", "410021004", "story_v_out_410021.awb")

						arg_17_1:RecordAudio("410021004", var_20_12)
						arg_17_1:RecordAudio("410021004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410021", "410021004", "story_v_out_410021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410021", "410021004", "story_v_out_410021.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_13 and arg_17_1.time_ < var_20_5 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play410021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410021005
		arg_21_1.duration_ = 14.8

		local var_21_0 = {
			zh = 8.7,
			ja = 14.8
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
				arg_21_0:Play410021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10061"]) and arg_21_1.var_.actorSpriteComps10061 == nil then
				arg_21_1.var_.actorSpriteComps10061 = arg_21_1.actors_["10061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10061"]) then
				if arg_21_1.var_.actorSpriteComps10061 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10061"]) and arg_21_1.var_.actorSpriteComps10061 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10061 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.825

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(410021005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 33 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 33)

				if (33 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 33)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021005", "story_v_out_410021.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_410021", "410021005", "story_v_out_410021.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_410021", "410021005", "story_v_out_410021.awb")

						arg_21_1:RecordAudio("410021005", var_24_9)
						arg_21_1:RecordAudio("410021005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410021", "410021005", "story_v_out_410021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410021", "410021005", "story_v_out_410021.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play410021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410021006
		arg_25_1.duration_ = 8.93

		local var_25_0 = {
			zh = 7.633,
			ja = 8.933
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
				arg_25_0:Play410021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10061 = arg_25_1.actors_["10061"].transform.localPosition
				arg_25_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10061", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10061"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10061"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_2" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10061, Vector3.New(0, -517.5, -100), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10061"].transform.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_28_2 = arg_25_1.actors_["10061"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10061 == nil then
				arg_25_1.var_.actorSpriteComps10061 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10061 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10061 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10061 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(410021006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 32 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 32)

				if (32 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 32)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021006", "story_v_out_410021.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021006", "story_v_out_410021.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_410021", "410021006", "story_v_out_410021.awb")

						arg_25_1:RecordAudio("410021006", var_28_12)
						arg_25_1:RecordAudio("410021006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410021", "410021006", "story_v_out_410021.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410021", "410021006", "story_v_out_410021.awb")
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
				actorName = "10061",
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
	Play410021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410021007
		arg_29_1.duration_ = 7.7

		local var_29_0 = {
			zh = 7.7,
			ja = 5.533
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
				arg_29_0:Play410021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10061 = arg_29_1.actors_["10061"].transform.localPosition
				arg_29_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10061", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10061"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10061"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_2" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10061, Vector3.New(0, -517.5, -100), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10061"].transform.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_32_2 = arg_29_1.actors_["10061"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10061 == nil then
				arg_29_1.var_.actorSpriteComps10061 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10061 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10061 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10061 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.875

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(410021007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 35 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 35)

				if (35 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 35)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021007", "story_v_out_410021.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021007", "story_v_out_410021.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_410021", "410021007", "story_v_out_410021.awb")

						arg_29_1:RecordAudio("410021007", var_32_12)
						arg_29_1:RecordAudio("410021007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410021", "410021007", "story_v_out_410021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410021", "410021007", "story_v_out_410021.awb")
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
				actorName = "10061",
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
	Play410021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410021008
		arg_33_1.duration_ = 2.03

		local var_33_0 = {
			zh = 2.033,
			ja = 1.833
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
				arg_33_0:Play410021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10061"]) and arg_33_1.var_.actorSpriteComps10061 == nil then
				arg_33_1.var_.actorSpriteComps10061 = arg_33_1.actors_["10061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10061"]) then
				if arg_33_1.var_.actorSpriteComps10061 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10061"]) and arg_33_1.var_.actorSpriteComps10061 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10061 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:GetWordFromCfg(410021008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 3 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 3)

				if (3 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 3)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021008", "story_v_out_410021.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_410021", "410021008", "story_v_out_410021.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_410021", "410021008", "story_v_out_410021.awb")

						arg_33_1:RecordAudio("410021008", var_36_9)
						arg_33_1:RecordAudio("410021008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410021", "410021008", "story_v_out_410021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410021", "410021008", "story_v_out_410021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play410021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410021009
		arg_37_1.duration_ = 8.57

		local var_37_0 = {
			zh = 5.766,
			ja = 8.566
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
				arg_37_0:Play410021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10061 = arg_37_1.actors_["10061"].transform.localPosition
				arg_37_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10061", 3)

				for iter_40_0 = 0, arg_37_1.actors_["10061"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10061"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_2" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10061, Vector3.New(0, -517.5, -100), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10061"].transform.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_40_2 = arg_37_1.actors_["10061"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10061 == nil then
				arg_37_1.var_.actorSpriteComps10061 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10061 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10061 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10061 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(410021009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 16 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 16)

				if (16 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 16)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021009", "story_v_out_410021.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021009", "story_v_out_410021.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_410021", "410021009", "story_v_out_410021.awb")

						arg_37_1:RecordAudio("410021009", var_40_12)
						arg_37_1:RecordAudio("410021009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410021", "410021009", "story_v_out_410021.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410021", "410021009", "story_v_out_410021.awb")
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
				actorName = "10061",
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
	Play410021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410021010
		arg_41_1.duration_ = 4.73

		local var_41_0 = {
			zh = 2.6,
			ja = 4.733
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
				arg_41_0:Play410021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10061 = arg_41_1.actors_["10061"].transform.localPosition
				arg_41_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10061", 4)

				for iter_44_0 = 0, arg_41_1.actors_["10061"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10061"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_1" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_44_2 = "1056"

			if arg_41_1.actors_["1056"] == nil then
				local var_44_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_44_3) then
					local var_44_4 = Object.Instantiate(var_44_3, arg_41_1.canvasGo_.transform)

					var_44_4.transform:SetSiblingIndex(1)

					var_44_4.name = var_44_2
					var_44_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_[var_44_2] = var_44_4

					if arg_41_1.isInRecall_ then
						for iter_44_1, iter_44_2 in ipairs((var_44_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_44_2.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_5 = arg_41_1.actors_["1056"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1056 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1056", 2)

				for iter_44_3 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_3)

					if var_44_6.name == "split_1" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_44_8 = arg_41_1.actors_["10061"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10061 == nil then
				arg_41_1.var_.actorSpriteComps10061 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.actorSpriteComps10061 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_5.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10061 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10061 = nil
			end

			local var_44_11 = arg_41_1.actors_["1056"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.actorSpriteComps1056 == nil then
				arg_41_1.var_.actorSpriteComps1056 = var_44_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_12 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_12 and not isNil(var_44_11) then
				if arg_41_1.var_.actorSpriteComps1056 then
					for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_44_9 then
							if arg_41_1.isInRecall_ then
								iter_44_9.color = Color.New(Mathf.Lerp(iter_44_9.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_12), Mathf.Lerp(iter_44_9.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_12), (Mathf.Lerp(iter_44_9.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_12)))
							else
								local var_44_13 = Mathf.Lerp(iter_44_9.color.r, 1, (arg_41_1.time_ - 0) / var_44_12)

								iter_44_9.color = Color.New(var_44_13, var_44_13, var_44_13)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_12 and arg_41_1.time_ < 0 + var_44_12 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.actorSpriteComps1056 then
				for iter_44_10, iter_44_11 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_44_11 then
						iter_44_11.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1056 = nil
			end

			local var_44_14 = 0
			local var_44_15 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(410021010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 10 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 10)

				if (10 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 10)) > 0 and var_44_15 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021010", "story_v_out_410021.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_410021", "410021010", "story_v_out_410021.awb") / 1000

					if var_44_20 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_14
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_410021", "410021010", "story_v_out_410021.awb")

						arg_41_1:RecordAudio("410021010", var_44_21)
						arg_41_1:RecordAudio("410021010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410021", "410021010", "story_v_out_410021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410021", "410021010", "story_v_out_410021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_15, arg_41_1.talkMaxDuration)

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_14) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_14 + var_44_22 and arg_41_1.time_ < var_44_14 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "1056",
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
	Play410021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410021011
		arg_45_1.duration_ = 10.73

		local var_45_0 = {
			zh = 4.733,
			ja = 10.733
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
				arg_45_0:Play410021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1056"]) and arg_45_1.var_.actorSpriteComps1056 == nil then
				arg_45_1.var_.actorSpriteComps1056 = arg_45_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1056"]) then
				if arg_45_1.var_.actorSpriteComps1056 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1056"]) and arg_45_1.var_.actorSpriteComps1056 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1056 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:GetWordFromCfg(410021011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 14 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 14)

				if (14 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 14)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021011", "story_v_out_410021.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_410021", "410021011", "story_v_out_410021.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_410021", "410021011", "story_v_out_410021.awb")

						arg_45_1:RecordAudio("410021011", var_48_9)
						arg_45_1:RecordAudio("410021011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410021", "410021011", "story_v_out_410021.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410021", "410021011", "story_v_out_410021.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410021012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play410021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.975

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(410021012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 39 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 39)

				if (39 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 39)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play410021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410021013
		arg_53_1.duration_ = 3.6

		local var_53_0 = {
			zh = 3.6,
			ja = 3.133
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
				arg_53_0:Play410021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(410021013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 9 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 9)

				if (9 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 9)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021013", "story_v_out_410021.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_410021", "410021013", "story_v_out_410021.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_410021", "410021013", "story_v_out_410021.awb")

						arg_53_1:RecordAudio("410021013", var_56_6)
						arg_53_1:RecordAudio("410021013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410021", "410021013", "story_v_out_410021.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410021", "410021013", "story_v_out_410021.awb")
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
	Play410021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410021014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1056 = arg_57_1.actors_["1056"].transform.localPosition
				arg_57_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1056", 7)

				for iter_60_0 = 0, arg_57_1.actors_["1056"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1056"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1056"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_60_2 = arg_57_1.actors_["10061"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10061 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10061", 7)

				for iter_60_1 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_1)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10061, Vector3.New(0, -2000, -100), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_60_5 = arg_57_1.actors_["1056"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps1056 == nil then
				arg_57_1.var_.actorSpriteComps1056 = var_60_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.actorSpriteComps1056 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								iter_60_3.color = Color.New(Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_6), Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_6), (Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_6)))
							else
								local var_60_7 = Mathf.Lerp(iter_60_3.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_6)

								iter_60_3.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps1056 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_60_5 then
						iter_60_5.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1056 = nil
			end

			local var_60_8 = arg_57_1.actors_["10061"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10061 == nil then
				arg_57_1.var_.actorSpriteComps10061 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_9 and not isNil(var_60_8) then
				if arg_57_1.var_.actorSpriteComps10061 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								iter_60_7.color = Color.New(Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_9), Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_9), (Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_9)))
							else
								local var_60_10 = Mathf.Lerp(iter_60_7.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_9)

								iter_60_7.color = Color.New(var_60_10, var_60_10, var_60_10)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_9 and arg_57_1.time_ < 0 + var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10061 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_60_9 then
						iter_60_9.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10061 = nil
			end

			local var_60_11 = 0
			local var_60_12 = 1.75

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_13 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(410021014).content)

				arg_57_1.text_.text = var_60_13

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_15 = 70 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_13) / 70)

				if (70 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_13) / 70)) > 0 and var_60_12 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_13
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_16 and arg_57_1.time_ < var_60_11 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_57_1:InitPlayNodeList()
	end,
	Play410021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410021015
		arg_61_1.duration_ = 12.8

		local var_61_0 = {
			zh = 6.2,
			ja = 12.8
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
				arg_61_0:Play410021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["1060"] == nil then
				local var_64_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_64_0) then
					local var_64_1 = Object.Instantiate(var_64_0, arg_61_1.canvasGo_.transform)

					var_64_1.transform:SetSiblingIndex(1)

					var_64_1.name = "1060"
					var_64_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_["1060"] = var_64_1

					if arg_61_1.isInRecall_ then
						for iter_64_0, iter_64_1 in ipairs((var_64_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_64_1.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_2 = arg_61_1.actors_["1060"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1060 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1060", 2)

				for iter_64_2 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_2)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_64_5 = arg_61_1.actors_["1060"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps1060 == nil then
				arg_61_1.var_.actorSpriteComps1060 = var_64_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.actorSpriteComps1060 then
					for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_64_4 then
							if arg_61_1.isInRecall_ then
								iter_64_4.color = Color.New(Mathf.Lerp(iter_64_4.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_6), Mathf.Lerp(iter_64_4.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_6), (Mathf.Lerp(iter_64_4.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_6)))
							else
								local var_64_7 = Mathf.Lerp(iter_64_4.color.r, 1, (arg_61_1.time_ - 0) / var_64_6)

								iter_64_4.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps1060 then
				for iter_64_5, iter_64_6 in pairs(arg_61_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_64_6 then
						iter_64_6.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1060 = nil
			end

			local var_64_8 = arg_61_1.actors_["1056"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1056 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1056", 4)

				for iter_64_7 = 0, var_64_8.childCount - 1 do
					local var_64_9 = var_64_8:GetChild(iter_64_7)

					if var_64_9.name == "" or not string.find(var_64_9.name, "split") then
						var_64_9.gameObject:SetActive(true)
					else
						var_64_9.gameObject:SetActive(false)
					end
				end
			end

			local var_64_10 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_10 then
				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_61_1.time_ - 0) / var_64_10)
			end

			if arg_61_1.time_ >= 0 + var_64_10 and arg_61_1.time_ < 0 + var_64_10 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(390, -350, -180)
			end

			local var_64_11 = arg_61_1.actors_["1056"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.actorSpriteComps1056 == nil then
				arg_61_1.var_.actorSpriteComps1056 = var_64_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_12 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_12 and not isNil(var_64_11) then
				if arg_61_1.var_.actorSpriteComps1056 then
					for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_64_9 then
							if arg_61_1.isInRecall_ then
								iter_64_9.color = Color.New(Mathf.Lerp(iter_64_9.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_12), Mathf.Lerp(iter_64_9.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_12), (Mathf.Lerp(iter_64_9.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_12)))
							else
								local var_64_13 = Mathf.Lerp(iter_64_9.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_12)

								iter_64_9.color = Color.New(var_64_13, var_64_13, var_64_13)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_12 and arg_61_1.time_ < 0 + var_64_12 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.actorSpriteComps1056 then
				for iter_64_10, iter_64_11 in pairs(arg_61_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_64_11 then
						iter_64_11.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1056 = nil
			end

			local var_64_14 = 0
			local var_64_15 = 0.675

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:GetWordFromCfg(410021015)
				local var_64_17 = arg_61_1:FormatText(var_64_16.content)

				arg_61_1.text_.text = var_64_17

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_19 = 27 <= 0 and var_64_15 or var_64_15 * (utf8.len(var_64_17) / 27)

				if (27 <= 0 and var_64_15 or var_64_15 * (utf8.len(var_64_17) / 27)) > 0 and var_64_15 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_14
					end
				end

				arg_61_1.text_.text = var_64_17
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021015", "story_v_out_410021.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_410021", "410021015", "story_v_out_410021.awb") / 1000

					if var_64_20 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_14
					end

					if var_64_16.prefab_name ~= "" and arg_61_1.actors_[var_64_16.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_16.prefab_name].transform, "story_v_out_410021", "410021015", "story_v_out_410021.awb")

						arg_61_1:RecordAudio("410021015", var_64_21)
						arg_61_1:RecordAudio("410021015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410021", "410021015", "story_v_out_410021.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410021", "410021015", "story_v_out_410021.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_15, arg_61_1.talkMaxDuration)

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_14) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_14 + var_64_22 and arg_61_1.time_ < var_64_14 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "1056",
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
	Play410021016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410021016
		arg_65_1.duration_ = 14.67

		local var_65_0 = {
			zh = 6.533,
			ja = 14.666
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
				arg_65_0:Play410021017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1056 = arg_65_1.actors_["1056"].transform.localPosition
				arg_65_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1056", 4)

				for iter_68_0 = 0, arg_65_1.actors_["1056"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["1056"].transform:GetChild(iter_68_0)

					if var_68_0.name == "split_3" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_68_2 = arg_65_1.actors_["1056"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1056 == nil then
				arg_65_1.var_.actorSpriteComps1056 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1056 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1056 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1056 = nil
			end

			local var_68_5 = arg_65_1.actors_["1060"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1060 == nil then
				arg_65_1.var_.actorSpriteComps1060 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps1060 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1060 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_68_8 then
						iter_68_8.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1060 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(410021016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 28 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 28)

				if (28 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 28)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021016", "story_v_out_410021.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021016", "story_v_out_410021.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_410021", "410021016", "story_v_out_410021.awb")

						arg_65_1:RecordAudio("410021016", var_68_15)
						arg_65_1:RecordAudio("410021016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410021", "410021016", "story_v_out_410021.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410021", "410021016", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410021017
		arg_69_1.duration_ = 11

		local var_69_0 = {
			zh = 10.7,
			ja = 11
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
				arg_69_0:Play410021018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1056 = arg_69_1.actors_["1056"].transform.localPosition
				arg_69_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1056", 4)

				for iter_72_0 = 0, arg_69_1.actors_["1056"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1056"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_3" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_72_2 = arg_69_1.actors_["1056"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1056 == nil then
				arg_69_1.var_.actorSpriteComps1056 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1056 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1056 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1056 = nil
			end

			local var_72_5 = 0
			local var_72_6 = 1.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(410021017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 52 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 52)

				if (52 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 52)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021017", "story_v_out_410021.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021017", "story_v_out_410021.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_410021", "410021017", "story_v_out_410021.awb")

						arg_69_1:RecordAudio("410021017", var_72_12)
						arg_69_1:RecordAudio("410021017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410021", "410021017", "story_v_out_410021.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410021", "410021017", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410021018
		arg_73_1.duration_ = 11.4

		local var_73_0 = {
			zh = 7.3,
			ja = 11.4
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
				arg_73_0:Play410021019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1056 = arg_73_1.actors_["1056"].transform.localPosition
				arg_73_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1056", 4)

				for iter_76_0 = 0, arg_73_1.actors_["1056"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1056"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_3" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_76_2 = arg_73_1.actors_["1056"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1056 == nil then
				arg_73_1.var_.actorSpriteComps1056 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps1056 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								iter_76_2.color = Color.New(Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_2.color.r, 1, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_2.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1056 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1056 = nil
			end

			local var_76_5 = 0
			local var_76_6 = 0.925

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(410021018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 37 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 37)

				if (37 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 37)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021018", "story_v_out_410021.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021018", "story_v_out_410021.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_410021", "410021018", "story_v_out_410021.awb")

						arg_73_1:RecordAudio("410021018", var_76_12)
						arg_73_1:RecordAudio("410021018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410021", "410021018", "story_v_out_410021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410021", "410021018", "story_v_out_410021.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_13 and arg_73_1.time_ < var_76_5 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410021019
		arg_77_1.duration_ = 13.97

		local var_77_0 = {
			zh = 7.333,
			ja = 13.966
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
				arg_77_0:Play410021020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1060 = arg_77_1.actors_["1060"].transform.localPosition
				arg_77_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1060", 2)

				for iter_80_0 = 0, arg_77_1.actors_["1060"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["1060"].transform:GetChild(iter_80_0)

					if var_80_0.name == "" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_80_2 = arg_77_1.actors_["1060"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1060 == nil then
				arg_77_1.var_.actorSpriteComps1060 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1060 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1060 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1060 = nil
			end

			local var_80_5 = arg_77_1.actors_["1056"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps1056 == nil then
				arg_77_1.var_.actorSpriteComps1056 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps1056 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps1056 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_80_8 then
						iter_80_8.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1056 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.95

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(410021019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 38 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 38)

				if (38 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 38)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021019", "story_v_out_410021.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021019", "story_v_out_410021.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_410021", "410021019", "story_v_out_410021.awb")

						arg_77_1:RecordAudio("410021019", var_80_15)
						arg_77_1:RecordAudio("410021019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410021", "410021019", "story_v_out_410021.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410021", "410021019", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410021020
		arg_81_1.duration_ = 10.9

		local var_81_0 = {
			zh = 10.9,
			ja = 9.633
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
				arg_81_0:Play410021021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1056 = arg_81_1.actors_["1056"].transform.localPosition
				arg_81_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1056", 4)

				for iter_84_0 = 0, arg_81_1.actors_["1056"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["1056"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_84_2 = arg_81_1.actors_["1056"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1056 == nil then
				arg_81_1.var_.actorSpriteComps1056 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.034

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps1056 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1056 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1056 = nil
			end

			local var_84_5 = arg_81_1.actors_["1060"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps1060 == nil then
				arg_81_1.var_.actorSpriteComps1060 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 0.034

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps1060 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								iter_84_6.color = Color.New(Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_6.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_6.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps1060 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_84_8 then
						iter_84_8.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps1060 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 1.3

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(410021020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 52 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 52)

				if (52 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 52)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021020", "story_v_out_410021.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021020", "story_v_out_410021.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_410021", "410021020", "story_v_out_410021.awb")

						arg_81_1:RecordAudio("410021020", var_84_15)
						arg_81_1:RecordAudio("410021020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410021", "410021020", "story_v_out_410021.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410021", "410021020", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410021021
		arg_85_1.duration_ = 13.87

		local var_85_0 = {
			zh = 11.466,
			ja = 13.866
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
				arg_85_0:Play410021022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1056 = arg_85_1.actors_["1056"].transform.localPosition
				arg_85_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1056", 4)

				for iter_88_0 = 0, arg_85_1.actors_["1056"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1056"].transform:GetChild(iter_88_0)

					if var_88_0.name == "" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_88_2 = arg_85_1.actors_["1056"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1056 == nil then
				arg_85_1.var_.actorSpriteComps1056 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1056 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1056 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1056 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 1.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(410021021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 56 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 56)

				if (56 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 56)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021021", "story_v_out_410021.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021021", "story_v_out_410021.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_410021", "410021021", "story_v_out_410021.awb")

						arg_85_1:RecordAudio("410021021", var_88_12)
						arg_85_1:RecordAudio("410021021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410021", "410021021", "story_v_out_410021.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410021", "410021021", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410021022
		arg_89_1.duration_ = 10.47

		local var_89_0 = {
			zh = 3.866,
			ja = 10.466
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
				arg_89_0:Play410021023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1060 = arg_89_1.actors_["1060"].transform.localPosition
				arg_89_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1060", 2)

				for iter_92_0 = 0, arg_89_1.actors_["1060"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["1060"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_92_2 = arg_89_1.actors_["1060"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1060 == nil then
				arg_89_1.var_.actorSpriteComps1060 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps1060 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								iter_92_2.color = Color.New(Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_2.color.r, 1, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_2.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1060 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1060 = nil
			end

			local var_92_5 = arg_89_1.actors_["1056"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1056 == nil then
				arg_89_1.var_.actorSpriteComps1056 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps1056 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								iter_92_6.color = Color.New(Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_6.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_6.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps1056 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_92_8 then
						iter_92_8.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps1056 = nil
			end

			local var_92_8 = 0
			local var_92_9 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(410021022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 19 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 19)

				if (19 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 19)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021022", "story_v_out_410021.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021022", "story_v_out_410021.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_410021", "410021022", "story_v_out_410021.awb")

						arg_89_1:RecordAudio("410021022", var_92_15)
						arg_89_1:RecordAudio("410021022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410021", "410021022", "story_v_out_410021.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410021", "410021022", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410021023
		arg_93_1.duration_ = 9.43

		local var_93_0 = {
			zh = 9.233,
			ja = 9.433
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
				arg_93_0:Play410021024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1060 = arg_93_1.actors_["1060"].transform.localPosition
				arg_93_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1060", 2)

				for iter_96_0 = 0, arg_93_1.actors_["1060"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["1060"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_96_2 = arg_93_1.actors_["1060"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1060 == nil then
				arg_93_1.var_.actorSpriteComps1060 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1060 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1060 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1060 = nil
			end

			local var_96_5 = 0
			local var_96_6 = 1.175

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(410021023)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 47 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 47)

				if (47 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 47)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021023", "story_v_out_410021.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021023", "story_v_out_410021.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_410021", "410021023", "story_v_out_410021.awb")

						arg_93_1:RecordAudio("410021023", var_96_12)
						arg_93_1:RecordAudio("410021023", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410021", "410021023", "story_v_out_410021.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410021", "410021023", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410021024
		arg_97_1.duration_ = 10.1

		local var_97_0 = {
			zh = 4.7,
			ja = 10.1
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
				arg_97_0:Play410021025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1056 = arg_97_1.actors_["1056"].transform.localPosition
				arg_97_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1056", 4)

				for iter_100_0 = 0, arg_97_1.actors_["1056"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["1056"].transform:GetChild(iter_100_0)

					if var_100_0.name == "split_3" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_100_2 = arg_97_1.actors_["1056"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1056 == nil then
				arg_97_1.var_.actorSpriteComps1056 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps1056 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								iter_100_2.color = Color.New(Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_2.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_2.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1056 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_100_4 then
						iter_100_4.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps1056 = nil
			end

			local var_100_5 = arg_97_1.actors_["1060"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps1060 == nil then
				arg_97_1.var_.actorSpriteComps1060 = var_100_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_6 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.actorSpriteComps1060 then
					for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_100_6 then
							if arg_97_1.isInRecall_ then
								iter_100_6.color = Color.New(Mathf.Lerp(iter_100_6.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_6), Mathf.Lerp(iter_100_6.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_6), (Mathf.Lerp(iter_100_6.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_6)))
							else
								local var_100_7 = Mathf.Lerp(iter_100_6.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_6)

								iter_100_6.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps1060 then
				for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_100_8 then
						iter_100_8.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1060 = nil
			end

			local var_100_8 = 0
			local var_100_9 = 0.725

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(410021024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 29 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 29)

				if (29 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 29)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021024", "story_v_out_410021.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021024", "story_v_out_410021.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_410021", "410021024", "story_v_out_410021.awb")

						arg_97_1:RecordAudio("410021024", var_100_15)
						arg_97_1:RecordAudio("410021024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410021", "410021024", "story_v_out_410021.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410021", "410021024", "story_v_out_410021.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410021025
		arg_101_1.duration_ = 8.17

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play410021026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1056 = arg_101_1.actors_["1056"].transform.localPosition
				arg_101_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1056", 4)

				for iter_104_0 = 0, arg_101_1.actors_["1056"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["1056"].transform:GetChild(iter_104_0)

					if var_104_0.name == "split_3" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_2 = arg_101_1.actors_["1056"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1056 == nil then
				arg_101_1.var_.actorSpriteComps1056 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps1056 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1056 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1056 = nil
			end

			local var_104_5 = 0
			local var_104_6 = 1.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(410021025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 42 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 42)

				if (42 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 42)) > 0 and var_104_6 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021025", "story_v_out_410021.awb") ~= 0 then
					local var_104_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021025", "story_v_out_410021.awb") / 1000

					if var_104_11 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_5
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_410021", "410021025", "story_v_out_410021.awb")

						arg_101_1:RecordAudio("410021025", var_104_12)
						arg_101_1:RecordAudio("410021025", var_104_12)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410021", "410021025", "story_v_out_410021.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410021", "410021025", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410021026
		arg_105_1.duration_ = 7.5

		local var_105_0 = {
			zh = 4.566,
			ja = 7.5
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
				arg_105_0:Play410021027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1056 = arg_105_1.actors_["1056"].transform.localPosition
				arg_105_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1056", 4)

				for iter_108_0 = 0, arg_105_1.actors_["1056"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["1056"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_3" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_108_2 = arg_105_1.actors_["1056"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps1056 == nil then
				arg_105_1.var_.actorSpriteComps1056 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps1056 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps1056 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps1056 = nil
			end

			local var_108_5 = 0
			local var_108_6 = 0.575

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(410021026)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 23 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 23)

				if (23 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 23)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021026", "story_v_out_410021.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021026", "story_v_out_410021.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_410021", "410021026", "story_v_out_410021.awb")

						arg_105_1:RecordAudio("410021026", var_108_12)
						arg_105_1:RecordAudio("410021026", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410021", "410021026", "story_v_out_410021.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410021", "410021026", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410021027
		arg_109_1.duration_ = 9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play410021028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.bgs_.ST61 == nil then
				local var_112_0 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_112_0.name = "ST61"
				var_112_0.transform.parent = arg_109_1.stage_.transform
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_.ST61 = var_112_0
			end

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				local var_112_1 = arg_109_1.bgs_.ST61

				arg_109_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_2 = var_112_1:GetComponent("SpriteRenderer")

				if var_112_2 and var_112_2.sprite then
					local var_112_3 = 2 * (var_112_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_1.transform.localScale = Vector3.New(var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST61" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_4 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_5 = 2

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_5 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_4) / var_112_5)
				arg_109_1.mask_.color = var_112_6
			end

			if arg_109_1.time_ >= var_112_4 + var_112_5 and arg_109_1.time_ < var_112_4 + var_112_5 + arg_112_0 then
				local var_112_7 = Color.New(0, 0, 0)

				var_112_7.a = 1
				arg_109_1.mask_.color = var_112_7
			end

			local var_112_8 = 2

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_9 = 2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 then
				local var_112_10 = Color.New(0, 0, 0)

				var_112_10.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_8) / var_112_9)
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 then
				local var_112_11 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_11.a = 0
				arg_109_1.mask_.color = var_112_11
			end

			local var_112_12 = arg_109_1.actors_["1060"].transform

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.var_.moveOldPos1060 = var_112_12.localPosition
				var_112_12.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1060", 7)

				for iter_112_2 = 0, var_112_12.childCount - 1 do
					local var_112_13 = var_112_12:GetChild(iter_112_2)

					if var_112_13.name == "" or not string.find(var_112_13.name, "split") then
						var_112_13.gameObject:SetActive(true)
					else
						var_112_13.gameObject:SetActive(false)
					end
				end
			end

			local var_112_14 = 0.001

			if 2 <= arg_109_1.time_ and arg_109_1.time_ < 2 + var_112_14 then
				var_112_12.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_109_1.time_ - 2) / var_112_14)
			end

			if arg_109_1.time_ >= 2 + var_112_14 and arg_109_1.time_ < 2 + var_112_14 + arg_112_0 then
				var_112_12.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_112_15 = arg_109_1.actors_["1056"].transform

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.var_.moveOldPos1056 = var_112_15.localPosition
				var_112_15.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1056", 7)

				for iter_112_3 = 0, var_112_15.childCount - 1 do
					local var_112_16 = var_112_15:GetChild(iter_112_3)

					if var_112_16.name == "" or not string.find(var_112_16.name, "split") then
						var_112_16.gameObject:SetActive(true)
					else
						var_112_16.gameObject:SetActive(false)
					end
				end
			end

			local var_112_17 = 0.001

			if 2 <= arg_109_1.time_ and arg_109_1.time_ < 2 + var_112_17 then
				var_112_15.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_109_1.time_ - 2) / var_112_17)
			end

			if arg_109_1.time_ >= 2 + var_112_17 and arg_109_1.time_ < 2 + var_112_17 + arg_112_0 then
				var_112_15.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_112_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_20 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_20

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_20
						arg_109_1.bgmTxt2_.text = var_112_20
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_109_1.time_ and arg_109_1.time_ <= 0.3 + arg_112_0 then
				arg_109_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_112_23 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_23 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_23

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_23
						arg_109_1.bgmTxt2_.text = var_112_23
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_24 = 4
			local var_112_25 = 0.7

			if 4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_24 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_26 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_26:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_109_1.dialogCg_.alpha = arg_115_0
				end))
				var_112_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_27 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(410021027).content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_29 = 28 <= 0 and var_112_25 or var_112_25 * (utf8.len(var_112_27) / 28)

				if (28 <= 0 and var_112_25 or var_112_25 * (utf8.len(var_112_27) / 28)) > 0 and var_112_25 < var_112_29 then
					arg_109_1.talkMaxDuration = var_112_29
					var_112_24 = var_112_24 + 0.3

					if var_112_29 + var_112_24 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_29 + var_112_24
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_30 = var_112_24 + 0.3
			local var_112_31 = math.max(var_112_25, arg_109_1.talkMaxDuration)

			if var_112_24 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_30 + var_112_31 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_30) / var_112_31

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_30 + var_112_31 and arg_109_1.time_ < var_112_30 + var_112_31 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play410021028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410021028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play410021029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(410021028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 56 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 56)

				if (56 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 56)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play410021029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410021029
		arg_121_1.duration_ = 6.5

		local var_121_0 = {
			zh = 4.1,
			ja = 6.5
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play410021030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1060 = arg_121_1.actors_["1060"].transform.localPosition
				arg_121_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1060", 2)

				for iter_124_0 = 0, arg_121_1.actors_["1060"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["1060"].transform:GetChild(iter_124_0)

					if var_124_0.name == "split_1" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_124_2 = arg_121_1.actors_["1056"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1056 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1056", 4)

				for iter_124_1 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_1)

					if var_124_3.name == "split_1" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_124_5 = arg_121_1.actors_["1060"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1060 == nil then
				arg_121_1.var_.actorSpriteComps1060 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps1060 then
					for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_124_3 then
							if arg_121_1.isInRecall_ then
								iter_124_3.color = Color.New(Mathf.Lerp(iter_124_3.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_3.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_3.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_3.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_3.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1060 then
				for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_124_5 then
						iter_124_5.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1060 = nil
			end

			local var_124_8 = arg_121_1.actors_["1056"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1056 == nil then
				arg_121_1.var_.actorSpriteComps1056 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_9 and not isNil(var_124_8) then
				if arg_121_1.var_.actorSpriteComps1056 then
					for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_124_7 then
							if arg_121_1.isInRecall_ then
								iter_124_7.color = Color.New(Mathf.Lerp(iter_124_7.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_9), Mathf.Lerp(iter_124_7.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_9), (Mathf.Lerp(iter_124_7.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_9)))
							else
								local var_124_10 = Mathf.Lerp(iter_124_7.color.r, 1, (arg_121_1.time_ - 0) / var_124_9)

								iter_124_7.color = Color.New(var_124_10, var_124_10, var_124_10)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_9 and arg_121_1.time_ < 0 + var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1056 then
				for iter_124_8, iter_124_9 in pairs(arg_121_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_124_9 then
						iter_124_9.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps1056 = nil
			end

			local var_124_11 = 0
			local var_124_12 = 0.525

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(410021029)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 21 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 21)

				if (21 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 21)) > 0 and var_124_12 < var_124_16 then
					arg_121_1.talkMaxDuration = var_124_16

					if var_124_16 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021029", "story_v_out_410021.awb") ~= 0 then
					local var_124_17 = manager.audio:GetVoiceLength("story_v_out_410021", "410021029", "story_v_out_410021.awb") / 1000

					if var_124_17 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_11
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_410021", "410021029", "story_v_out_410021.awb")

						arg_121_1:RecordAudio("410021029", var_124_18)
						arg_121_1:RecordAudio("410021029", var_124_18)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410021", "410021029", "story_v_out_410021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410021", "410021029", "story_v_out_410021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_19 = math.max(var_124_12, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_19 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_19

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_19 and arg_121_1.time_ < var_124_11 + var_124_19 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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
				actorName = "1056",
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
	Play410021030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410021030
		arg_125_1.duration_ = 8.57

		local var_125_0 = {
			zh = 8.566,
			ja = 7.3
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
				arg_125_0:Play410021031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1060 = arg_125_1.actors_["1060"].transform.localPosition
				arg_125_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1060", 2)

				for iter_128_0 = 0, arg_125_1.actors_["1060"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["1060"].transform:GetChild(iter_128_0)

					if var_128_0.name == "split_2" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_128_2 = arg_125_1.actors_["1060"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1060 == nil then
				arg_125_1.var_.actorSpriteComps1060 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps1060 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1060 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_128_4 then
						iter_128_4.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps1060 = nil
			end

			local var_128_5 = arg_125_1.actors_["1056"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps1056 == nil then
				arg_125_1.var_.actorSpriteComps1056 = var_128_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_6 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.actorSpriteComps1056 then
					for iter_128_5, iter_128_6 in pairs(arg_125_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_128_6 then
							if arg_125_1.isInRecall_ then
								iter_128_6.color = Color.New(Mathf.Lerp(iter_128_6.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_6), Mathf.Lerp(iter_128_6.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_6), (Mathf.Lerp(iter_128_6.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_6)))
							else
								local var_128_7 = Mathf.Lerp(iter_128_6.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_6)

								iter_128_6.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps1056 then
				for iter_128_7, iter_128_8 in pairs(arg_125_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_128_8 then
						iter_128_8.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps1056 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 0.875

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(410021030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 35 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 35)

				if (35 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 35)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021030", "story_v_out_410021.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021030", "story_v_out_410021.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_410021", "410021030", "story_v_out_410021.awb")

						arg_125_1:RecordAudio("410021030", var_128_15)
						arg_125_1:RecordAudio("410021030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410021", "410021030", "story_v_out_410021.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410021", "410021030", "story_v_out_410021.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play410021031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410021031
		arg_129_1.duration_ = 11.57

		local var_129_0 = {
			zh = 6.833,
			ja = 11.566
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
				arg_129_0:Play410021032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1056 = arg_129_1.actors_["1056"].transform.localPosition
				arg_129_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1056", 4)

				for iter_132_0 = 0, arg_129_1.actors_["1056"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["1056"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_1" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_132_2 = arg_129_1.actors_["1056"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps1056 == nil then
				arg_129_1.var_.actorSpriteComps1056 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps1056 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								iter_132_2.color = Color.New(Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_2.color.r, 1, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_2.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps1056 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps1056 = nil
			end

			local var_132_5 = arg_129_1.actors_["1060"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps1060 == nil then
				arg_129_1.var_.actorSpriteComps1060 = var_132_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_6 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.actorSpriteComps1060 then
					for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_132_6 then
							if arg_129_1.isInRecall_ then
								iter_132_6.color = Color.New(Mathf.Lerp(iter_132_6.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_6), Mathf.Lerp(iter_132_6.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_6), (Mathf.Lerp(iter_132_6.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_6)))
							else
								local var_132_7 = Mathf.Lerp(iter_132_6.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_6)

								iter_132_6.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps1060 then
				for iter_132_7, iter_132_8 in pairs(arg_129_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_132_8 then
						iter_132_8.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps1060 = nil
			end

			local var_132_8 = 0
			local var_132_9 = 0.85

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(410021031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 34 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 34)

				if (34 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 34)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021031", "story_v_out_410021.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021031", "story_v_out_410021.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_410021", "410021031", "story_v_out_410021.awb")

						arg_129_1:RecordAudio("410021031", var_132_15)
						arg_129_1:RecordAudio("410021031", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410021", "410021031", "story_v_out_410021.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410021", "410021031", "story_v_out_410021.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410021032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play410021033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1056"]) and arg_133_1.var_.actorSpriteComps1056 == nil then
				arg_133_1.var_.actorSpriteComps1056 = arg_133_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1056"]) then
				if arg_133_1.var_.actorSpriteComps1056 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1056"]) and arg_133_1.var_.actorSpriteComps1056 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps1056 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 1.225

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(410021032).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 49 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 49)

				if (49 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 49)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play410021033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410021033
		arg_137_1.duration_ = 8.43

		local var_137_0 = {
			zh = 6.633,
			ja = 8.433
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play410021034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1056 = arg_137_1.actors_["1056"].transform.localPosition
				arg_137_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1056", 4)

				for iter_140_0 = 0, arg_137_1.actors_["1056"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1056"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_140_2 = arg_137_1.actors_["1056"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1056 == nil then
				arg_137_1.var_.actorSpriteComps1056 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps1056 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 1, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1056 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps1056 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 0.875

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(410021033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 35 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 35)

				if (35 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 35)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021033", "story_v_out_410021.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021033", "story_v_out_410021.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_410021", "410021033", "story_v_out_410021.awb")

						arg_137_1:RecordAudio("410021033", var_140_12)
						arg_137_1:RecordAudio("410021033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410021", "410021033", "story_v_out_410021.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410021", "410021033", "story_v_out_410021.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_13 and arg_137_1.time_ < var_140_5 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410021034
		arg_141_1.duration_ = 8.2

		local var_141_0 = {
			zh = 4.966,
			ja = 8.2
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
				arg_141_0:Play410021035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1060 = arg_141_1.actors_["1060"].transform.localPosition
				arg_141_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1060", 2)

				for iter_144_0 = 0, arg_141_1.actors_["1060"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["1060"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_144_2 = arg_141_1.actors_["1060"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1060 == nil then
				arg_141_1.var_.actorSpriteComps1060 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps1060 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 1, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1060 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps1060 = nil
			end

			local var_144_5 = arg_141_1.actors_["1056"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps1056 == nil then
				arg_141_1.var_.actorSpriteComps1056 = var_144_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_6 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.actorSpriteComps1056 then
					for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_144_6 then
							if arg_141_1.isInRecall_ then
								iter_144_6.color = Color.New(Mathf.Lerp(iter_144_6.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_6), Mathf.Lerp(iter_144_6.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_6), (Mathf.Lerp(iter_144_6.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_6)))
							else
								local var_144_7 = Mathf.Lerp(iter_144_6.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_6)

								iter_144_6.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps1056 then
				for iter_144_7, iter_144_8 in pairs(arg_141_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_144_8 then
						iter_144_8.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps1056 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(410021034)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 19 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 19)

				if (19 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 19)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021034", "story_v_out_410021.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021034", "story_v_out_410021.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_410021", "410021034", "story_v_out_410021.awb")

						arg_141_1:RecordAudio("410021034", var_144_15)
						arg_141_1:RecordAudio("410021034", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410021", "410021034", "story_v_out_410021.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410021", "410021034", "story_v_out_410021.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play410021035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410021035
		arg_145_1.duration_ = 3.67

		local var_145_0 = {
			zh = 3.666,
			ja = 2.5
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
				arg_145_0:Play410021036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1056 = arg_145_1.actors_["1056"].transform.localPosition
				arg_145_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1056", 4)

				for iter_148_0 = 0, arg_145_1.actors_["1056"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1056"].transform:GetChild(iter_148_0)

					if var_148_0.name == "" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_148_2 = arg_145_1.actors_["1056"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1056 == nil then
				arg_145_1.var_.actorSpriteComps1056 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.034

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1056 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1056 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1056 = nil
			end

			local var_148_5 = arg_145_1.actors_["1060"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps1060 == nil then
				arg_145_1.var_.actorSpriteComps1060 = var_148_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 0.034

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.actorSpriteComps1060 then
					for iter_148_5, iter_148_6 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_148_6 then
							if arg_145_1.isInRecall_ then
								iter_148_6.color = Color.New(Mathf.Lerp(iter_148_6.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_6), Mathf.Lerp(iter_148_6.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_6), (Mathf.Lerp(iter_148_6.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_6)))
							else
								local var_148_7 = Mathf.Lerp(iter_148_6.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_6)

								iter_148_6.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps1060 then
				for iter_148_7, iter_148_8 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_148_8 then
						iter_148_8.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps1060 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(410021035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 17 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 17)

				if (17 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 17)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021035", "story_v_out_410021.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021035", "story_v_out_410021.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_410021", "410021035", "story_v_out_410021.awb")

						arg_145_1:RecordAudio("410021035", var_148_15)
						arg_145_1:RecordAudio("410021035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410021", "410021035", "story_v_out_410021.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410021", "410021035", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410021036
		arg_149_1.duration_ = 8.67

		local var_149_0 = {
			zh = 5.966,
			ja = 8.666
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
				arg_149_0:Play410021037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1060 = arg_149_1.actors_["1060"].transform.localPosition
				arg_149_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1060", 2)

				for iter_152_0 = 0, arg_149_1.actors_["1060"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["1060"].transform:GetChild(iter_152_0)

					if var_152_0.name == "" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_152_2 = arg_149_1.actors_["1060"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1060 == nil then
				arg_149_1.var_.actorSpriteComps1060 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps1060 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1060 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps1060 = nil
			end

			local var_152_5 = arg_149_1.actors_["1056"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps1056 == nil then
				arg_149_1.var_.actorSpriteComps1056 = var_152_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_6 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.actorSpriteComps1056 then
					for iter_152_5, iter_152_6 in pairs(arg_149_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps1056 then
				for iter_152_7, iter_152_8 in pairs(arg_149_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_152_8 then
						iter_152_8.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1056 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.525

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(410021036)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 21 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 21)

				if (21 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 21)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021036", "story_v_out_410021.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021036", "story_v_out_410021.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_410021", "410021036", "story_v_out_410021.awb")

						arg_149_1:RecordAudio("410021036", var_152_15)
						arg_149_1:RecordAudio("410021036", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410021", "410021036", "story_v_out_410021.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410021", "410021036", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410021037
		arg_153_1.duration_ = 15.4

		local var_153_0 = {
			zh = 9.166,
			ja = 15.4
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
				arg_153_0:Play410021038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1060 = arg_153_1.actors_["1060"].transform.localPosition
				arg_153_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1060", 2)

				for iter_156_0 = 0, arg_153_1.actors_["1060"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1060"].transform:GetChild(iter_156_0)

					if var_156_0.name == "split_4" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_156_2 = arg_153_1.actors_["1060"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1060 == nil then
				arg_153_1.var_.actorSpriteComps1060 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1060 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1060 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1060 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 1.025

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(410021037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 41 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 41)

				if (41 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 41)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021037", "story_v_out_410021.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021037", "story_v_out_410021.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_410021", "410021037", "story_v_out_410021.awb")

						arg_153_1:RecordAudio("410021037", var_156_12)
						arg_153_1:RecordAudio("410021037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410021", "410021037", "story_v_out_410021.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410021", "410021037", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410021038
		arg_157_1.duration_ = 7.1

		local var_157_0 = {
			zh = 4.5,
			ja = 7.1
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
				arg_157_0:Play410021039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1060 = arg_157_1.actors_["1060"].transform.localPosition
				arg_157_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1060", 2)

				for iter_160_0 = 0, arg_157_1.actors_["1060"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["1060"].transform:GetChild(iter_160_0)

					if var_160_0.name == "split_4" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_160_2 = arg_157_1.actors_["1060"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1060 == nil then
				arg_157_1.var_.actorSpriteComps1060 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps1060 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1060 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1060 = nil
			end

			local var_160_5 = 0
			local var_160_6 = 0.575

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_7 = arg_157_1:GetWordFromCfg(410021038)
				local var_160_8 = arg_157_1:FormatText(var_160_7.content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 23 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_8) / 23)

				if (23 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_8) / 23)) > 0 and var_160_6 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_5
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021038", "story_v_out_410021.awb") ~= 0 then
					local var_160_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021038", "story_v_out_410021.awb") / 1000

					if var_160_11 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_5
					end

					if var_160_7.prefab_name ~= "" and arg_157_1.actors_[var_160_7.prefab_name] ~= nil then
						local var_160_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_7.prefab_name].transform, "story_v_out_410021", "410021038", "story_v_out_410021.awb")

						arg_157_1:RecordAudio("410021038", var_160_12)
						arg_157_1:RecordAudio("410021038", var_160_12)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410021", "410021038", "story_v_out_410021.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410021", "410021038", "story_v_out_410021.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_6, arg_157_1.talkMaxDuration)

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_5) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_5 + var_160_13 and arg_157_1.time_ < var_160_5 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play410021039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410021039
		arg_161_1.duration_ = 12.87

		local var_161_0 = {
			zh = 10.2,
			ja = 12.866
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410021040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1056 = arg_161_1.actors_["1056"].transform.localPosition
				arg_161_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1056", 4)

				for iter_164_0 = 0, arg_161_1.actors_["1056"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["1056"].transform:GetChild(iter_164_0)

					if var_164_0.name == "split_1" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_164_2 = arg_161_1.actors_["1056"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1056 == nil then
				arg_161_1.var_.actorSpriteComps1056 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps1056 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								iter_164_2.color = Color.New(Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_2.color.r, 1, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_2.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1056 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_164_4 then
						iter_164_4.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps1056 = nil
			end

			local var_164_5 = arg_161_1.actors_["1060"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.actorSpriteComps1060 == nil then
				arg_161_1.var_.actorSpriteComps1060 = var_164_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_6 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.actorSpriteComps1060 then
					for iter_164_5, iter_164_6 in pairs(arg_161_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_164_6 then
							if arg_161_1.isInRecall_ then
								iter_164_6.color = Color.New(Mathf.Lerp(iter_164_6.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_6), Mathf.Lerp(iter_164_6.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_6), (Mathf.Lerp(iter_164_6.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_6)))
							else
								local var_164_7 = Mathf.Lerp(iter_164_6.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_6)

								iter_164_6.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.actorSpriteComps1060 then
				for iter_164_7, iter_164_8 in pairs(arg_161_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_164_8 then
						iter_164_8.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps1060 = nil
			end

			local var_164_8 = 0
			local var_164_9 = 1.275

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(410021039)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 51 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 51)

				if (51 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 51)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021039", "story_v_out_410021.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021039", "story_v_out_410021.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_410021", "410021039", "story_v_out_410021.awb")

						arg_161_1:RecordAudio("410021039", var_164_15)
						arg_161_1:RecordAudio("410021039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410021", "410021039", "story_v_out_410021.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410021", "410021039", "story_v_out_410021.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410021040
		arg_165_1.duration_ = 8.77

		local var_165_0 = {
			zh = 6.7,
			ja = 8.766
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
				arg_165_0:Play410021041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1056 = arg_165_1.actors_["1056"].transform.localPosition
				arg_165_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1056", 4)

				for iter_168_0 = 0, arg_165_1.actors_["1056"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1056"].transform:GetChild(iter_168_0)

					if var_168_0.name == "split_1" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_168_2 = arg_165_1.actors_["1056"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1056 == nil then
				arg_165_1.var_.actorSpriteComps1056 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1056 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1056 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1056 = nil
			end

			local var_168_5 = 0
			local var_168_6 = 0.875

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(410021040)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 35 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 35)

				if (35 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 35)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021040", "story_v_out_410021.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021040", "story_v_out_410021.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_410021", "410021040", "story_v_out_410021.awb")

						arg_165_1:RecordAudio("410021040", var_168_12)
						arg_165_1:RecordAudio("410021040", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410021", "410021040", "story_v_out_410021.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410021", "410021040", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410021041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410021042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1056"]) and arg_169_1.var_.actorSpriteComps1056 == nil then
				arg_169_1.var_.actorSpriteComps1056 = arg_169_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1056"]) then
				if arg_169_1.var_.actorSpriteComps1056 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1056"]) and arg_169_1.var_.actorSpriteComps1056 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1056 = nil
			end

			local var_172_2 = arg_169_1.actors_["1060"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1060 == nil then
				arg_169_1.var_.actorSpriteComps1060 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps1060 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_172_5 then
							if arg_169_1.isInRecall_ then
								iter_172_5.color = Color.New(Mathf.Lerp(iter_172_5.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_5.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_5.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_5.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_5.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1060 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_172_7 then
						iter_172_7.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1060 = nil
			end

			local var_172_5 = 0
			local var_172_6 = 1.725

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(410021041).content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 69 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 69)

				if (69 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 69)) > 0 and var_172_6 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_10 and arg_169_1.time_ < var_172_5 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play410021042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410021042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play410021043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.8

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

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(410021042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 32 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 32)

				if (32 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 32)) > 0 and var_176_0 < var_176_3 then
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
	Play410021043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410021043
		arg_177_1.duration_ = 8.93

		local var_177_0 = {
			zh = 6.233,
			ja = 8.933
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
				arg_177_0:Play410021044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1056 = arg_177_1.actors_["1056"].transform.localPosition
				arg_177_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1056", 4)

				for iter_180_0 = 0, arg_177_1.actors_["1056"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["1056"].transform:GetChild(iter_180_0)

					if var_180_0.name == "split_1" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_180_2 = arg_177_1.actors_["1056"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1056 == nil then
				arg_177_1.var_.actorSpriteComps1056 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps1056 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1056 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1056 = nil
			end

			local var_180_5 = 0
			local var_180_6 = 0.9

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(410021043)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 36 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 36)

				if (36 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 36)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021043", "story_v_out_410021.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021043", "story_v_out_410021.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_410021", "410021043", "story_v_out_410021.awb")

						arg_177_1:RecordAudio("410021043", var_180_12)
						arg_177_1:RecordAudio("410021043", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410021", "410021043", "story_v_out_410021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410021", "410021043", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410021044
		arg_181_1.duration_ = 12.27

		local var_181_0 = {
			zh = 9.966,
			ja = 12.266
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
				arg_181_0:Play410021045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1060 = arg_181_1.actors_["1060"].transform.localPosition
				arg_181_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1060", 2)

				for iter_184_0 = 0, arg_181_1.actors_["1060"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["1060"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_184_2 = arg_181_1.actors_["1060"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1060 == nil then
				arg_181_1.var_.actorSpriteComps1060 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1060 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								iter_184_2.color = Color.New(Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_2.color.r, 1, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_2.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1060 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1060 = nil
			end

			local var_184_5 = arg_181_1.actors_["1056"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps1056 == nil then
				arg_181_1.var_.actorSpriteComps1056 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps1056 then
					for iter_184_5, iter_184_6 in pairs(arg_181_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_184_6 then
							if arg_181_1.isInRecall_ then
								iter_184_6.color = Color.New(Mathf.Lerp(iter_184_6.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_6.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_6.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_6.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_6.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps1056 then
				for iter_184_7, iter_184_8 in pairs(arg_181_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_184_8 then
						iter_184_8.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1056 = nil
			end

			local var_184_8 = 0
			local var_184_9 = 1.15

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(410021044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 46 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 46)

				if (46 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 46)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021044", "story_v_out_410021.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021044", "story_v_out_410021.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_410021", "410021044", "story_v_out_410021.awb")

						arg_181_1:RecordAudio("410021044", var_184_15)
						arg_181_1:RecordAudio("410021044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410021", "410021044", "story_v_out_410021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410021", "410021044", "story_v_out_410021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play410021045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410021045
		arg_185_1.duration_ = 3.67

		local var_185_0 = {
			zh = 2.8,
			ja = 3.666
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
				arg_185_0:Play410021046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1056 = arg_185_1.actors_["1056"].transform.localPosition
				arg_185_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1056", 4)

				for iter_188_0 = 0, arg_185_1.actors_["1056"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["1056"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_4" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_188_2 = arg_185_1.actors_["1056"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps1056 == nil then
				arg_185_1.var_.actorSpriteComps1056 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps1056 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 1, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps1056 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps1056 = nil
			end

			local var_188_5 = arg_185_1.actors_["1060"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps1060 == nil then
				arg_185_1.var_.actorSpriteComps1060 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps1060 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								iter_188_6.color = Color.New(Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_6.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_6.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps1060 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_188_8 then
						iter_188_8.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1060 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.275

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(410021045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 11 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 11)

				if (11 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 11)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021045", "story_v_out_410021.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021045", "story_v_out_410021.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_410021", "410021045", "story_v_out_410021.awb")

						arg_185_1:RecordAudio("410021045", var_188_15)
						arg_185_1:RecordAudio("410021045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410021", "410021045", "story_v_out_410021.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410021", "410021045", "story_v_out_410021.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410021046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410021046
		arg_189_1.duration_ = 5.3

		local var_189_0 = {
			zh = 4.533,
			ja = 5.3
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
				arg_189_0:Play410021047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1060 = arg_189_1.actors_["1060"].transform.localPosition
				arg_189_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1060", 2)

				for iter_192_0 = 0, arg_189_1.actors_["1060"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1060"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_192_2 = arg_189_1.actors_["1060"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps1060 == nil then
				arg_189_1.var_.actorSpriteComps1060 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps1060 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								iter_192_2.color = Color.New(Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_2.color.r, 1, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_2.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps1060 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1060 = nil
			end

			local var_192_5 = arg_189_1.actors_["1056"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps1056 == nil then
				arg_189_1.var_.actorSpriteComps1056 = var_192_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_6 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.actorSpriteComps1056 then
					for iter_192_5, iter_192_6 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_192_6 then
							if arg_189_1.isInRecall_ then
								iter_192_6.color = Color.New(Mathf.Lerp(iter_192_6.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_6), Mathf.Lerp(iter_192_6.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_6), (Mathf.Lerp(iter_192_6.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_6)))
							else
								local var_192_7 = Mathf.Lerp(iter_192_6.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_6)

								iter_192_6.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps1056 then
				for iter_192_7, iter_192_8 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_192_8 then
						iter_192_8.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps1056 = nil
			end

			local var_192_8 = 0
			local var_192_9 = 0.425

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(410021046)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 17 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 17)

				if (17 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 17)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021046", "story_v_out_410021.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021046", "story_v_out_410021.awb") / 1000

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_410021", "410021046", "story_v_out_410021.awb")

						arg_189_1:RecordAudio("410021046", var_192_15)
						arg_189_1:RecordAudio("410021046", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410021", "410021046", "story_v_out_410021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410021", "410021046", "story_v_out_410021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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

		arg_189_1:InitPlayNodeList()
	end,
	Play410021047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410021047
		arg_193_1.duration_ = 5.27

		local var_193_0 = {
			zh = 3.566,
			ja = 5.266
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
				arg_193_0:Play410021048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1056 = arg_193_1.actors_["1056"].transform.localPosition
				arg_193_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1056", 4)

				for iter_196_0 = 0, arg_193_1.actors_["1056"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["1056"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_4" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_196_2 = arg_193_1.actors_["1056"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1056 == nil then
				arg_193_1.var_.actorSpriteComps1056 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps1056 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1056 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1056 = nil
			end

			local var_196_5 = arg_193_1.actors_["1060"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps1060 == nil then
				arg_193_1.var_.actorSpriteComps1060 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps1060 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								iter_196_6.color = Color.New(Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_6.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_6.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps1060 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_196_8 then
						iter_196_8.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1060 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 0.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(410021047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 11 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 11)

				if (11 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 11)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021047", "story_v_out_410021.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021047", "story_v_out_410021.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_410021", "410021047", "story_v_out_410021.awb")

						arg_193_1:RecordAudio("410021047", var_196_15)
						arg_193_1:RecordAudio("410021047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410021", "410021047", "story_v_out_410021.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410021", "410021047", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410021048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410021049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1056 = arg_197_1.actors_["1056"].transform.localPosition
				arg_197_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1056", 2)

				for iter_200_0 = 0, arg_197_1.actors_["1056"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1056"].transform:GetChild(iter_200_0)

					if var_200_0.name == "" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_200_2 = arg_197_1.actors_["10061"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10061 = var_200_2.localPosition
				var_200_2.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10061", 4)

				for iter_200_1 = 0, var_200_2.childCount - 1 do
					local var_200_3 = var_200_2:GetChild(iter_200_1)

					if var_200_3.name == "" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_2.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_197_1.time_ - 0) / var_200_4)
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_2.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_200_5 = arg_197_1.actors_["1060"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1060 = var_200_5.localPosition
				var_200_5.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1060", 7)

				for iter_200_2 = 0, var_200_5.childCount - 1 do
					local var_200_6 = var_200_5:GetChild(iter_200_2)

					if var_200_6.name == "" or not string.find(var_200_6.name, "split") then
						var_200_6.gameObject:SetActive(true)
					else
						var_200_6.gameObject:SetActive(false)
					end
				end
			end

			local var_200_7 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				var_200_5.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_197_1.time_ - 0) / var_200_7)
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				var_200_5.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_200_8 = arg_197_1.actors_["1056"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps1056 == nil then
				arg_197_1.var_.actorSpriteComps1056 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_9 and not isNil(var_200_8) then
				if arg_197_1.var_.actorSpriteComps1056 then
					for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_200_4 then
							if arg_197_1.isInRecall_ then
								iter_200_4.color = Color.New(Mathf.Lerp(iter_200_4.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_9), Mathf.Lerp(iter_200_4.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_9), (Mathf.Lerp(iter_200_4.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_9)))
							else
								local var_200_10 = Mathf.Lerp(iter_200_4.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_9)

								iter_200_4.color = Color.New(var_200_10, var_200_10, var_200_10)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_9 and arg_197_1.time_ < 0 + var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps1056 then
				for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_200_6 then
						iter_200_6.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps1056 = nil
			end

			local var_200_11 = arg_197_1.actors_["10061"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_11) and arg_197_1.var_.actorSpriteComps10061 == nil then
				arg_197_1.var_.actorSpriteComps10061 = var_200_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_12 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_12 and not isNil(var_200_11) then
				if arg_197_1.var_.actorSpriteComps10061 then
					for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_200_8 then
							if arg_197_1.isInRecall_ then
								iter_200_8.color = Color.New(Mathf.Lerp(iter_200_8.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_12), Mathf.Lerp(iter_200_8.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_12), (Mathf.Lerp(iter_200_8.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_12)))
							else
								local var_200_13 = Mathf.Lerp(iter_200_8.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_12)

								iter_200_8.color = Color.New(var_200_13, var_200_13, var_200_13)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_12 and arg_197_1.time_ < 0 + var_200_12 + arg_200_0 and not isNil(var_200_11) and arg_197_1.var_.actorSpriteComps10061 then
				for iter_200_9, iter_200_10 in pairs(arg_197_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_200_10 then
						iter_200_10.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10061 = nil
			end

			local var_200_14 = arg_197_1.actors_["1060"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_14) and arg_197_1.var_.actorSpriteComps1060 == nil then
				arg_197_1.var_.actorSpriteComps1060 = var_200_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_15 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_15 and not isNil(var_200_14) then
				if arg_197_1.var_.actorSpriteComps1060 then
					for iter_200_11, iter_200_12 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_200_12 then
							if arg_197_1.isInRecall_ then
								iter_200_12.color = Color.New(Mathf.Lerp(iter_200_12.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_15), Mathf.Lerp(iter_200_12.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_15), (Mathf.Lerp(iter_200_12.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_15)))
							else
								local var_200_16 = Mathf.Lerp(iter_200_12.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_15)

								iter_200_12.color = Color.New(var_200_16, var_200_16, var_200_16)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_15 and arg_197_1.time_ < 0 + var_200_15 + arg_200_0 and not isNil(var_200_14) and arg_197_1.var_.actorSpriteComps1060 then
				for iter_200_13, iter_200_14 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_200_14 then
						iter_200_14.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps1060 = nil
			end

			local var_200_17 = 0
			local var_200_18 = 1.025

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_17 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_19 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(410021048).content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_21 = 41 <= 0 and var_200_18 or var_200_18 * (utf8.len(var_200_19) / 41)

				if (41 <= 0 and var_200_18 or var_200_18 * (utf8.len(var_200_19) / 41)) > 0 and var_200_18 < var_200_21 then
					arg_197_1.talkMaxDuration = var_200_21

					if var_200_21 + var_200_17 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_21 + var_200_17
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = math.max(var_200_18, arg_197_1.talkMaxDuration)

			if var_200_17 <= arg_197_1.time_ and arg_197_1.time_ < var_200_17 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_17) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_17 + var_200_22 and arg_197_1.time_ < var_200_17 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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
				actorName = "1060",
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
	Play410021049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410021049
		arg_201_1.duration_ = 2.53

		local var_201_0 = {
			zh = 2.533,
			ja = 2.433
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
				arg_201_0:Play410021050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1056 = arg_201_1.actors_["1056"].transform.localPosition
				arg_201_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1056", 2)

				for iter_204_0 = 0, arg_201_1.actors_["1056"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["1056"].transform:GetChild(iter_204_0)

					if var_204_0.name == "" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_204_2 = arg_201_1.actors_["1056"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1056 == nil then
				arg_201_1.var_.actorSpriteComps1056 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps1056 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1056 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps1056 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 0.275

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(410021049)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 11 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 11)

				if (11 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 11)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021049", "story_v_out_410021.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021049", "story_v_out_410021.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_410021", "410021049", "story_v_out_410021.awb")

						arg_201_1:RecordAudio("410021049", var_204_12)
						arg_201_1:RecordAudio("410021049", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410021", "410021049", "story_v_out_410021.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410021", "410021049", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410021050
		arg_205_1.duration_ = 10.83

		local var_205_0 = {
			zh = 8.633,
			ja = 10.833
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
				arg_205_0:Play410021051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10061 = arg_205_1.actors_["10061"].transform.localPosition
				arg_205_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10061", 4)

				for iter_208_0 = 0, arg_205_1.actors_["10061"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["10061"].transform:GetChild(iter_208_0)

					if var_208_0.name == "" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_208_2 = arg_205_1.actors_["10061"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10061 == nil then
				arg_205_1.var_.actorSpriteComps10061 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps10061 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10061 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10061 = nil
			end

			local var_208_5 = arg_205_1.actors_["1056"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1056 == nil then
				arg_205_1.var_.actorSpriteComps1056 = var_208_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_6 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 and not isNil(var_208_5) then
				if arg_205_1.var_.actorSpriteComps1056 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								iter_208_6.color = Color.New(Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_6), Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_6), (Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_6)))
							else
								local var_208_7 = Mathf.Lerp(iter_208_6.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_6)

								iter_208_6.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1056 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_208_8 then
						iter_208_8.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1056 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.825

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(410021050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 33 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 33)

				if (33 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 33)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021050", "story_v_out_410021.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021050", "story_v_out_410021.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_410021", "410021050", "story_v_out_410021.awb")

						arg_205_1:RecordAudio("410021050", var_208_15)
						arg_205_1:RecordAudio("410021050", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410021", "410021050", "story_v_out_410021.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410021", "410021050", "story_v_out_410021.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play410021051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410021051
		arg_209_1.duration_ = 5.53

		local var_209_0 = {
			zh = 4.5,
			ja = 5.533
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
				arg_209_0:Play410021052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1056 = arg_209_1.actors_["1056"].transform.localPosition
				arg_209_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1056", 2)

				for iter_212_0 = 0, arg_209_1.actors_["1056"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["1056"].transform:GetChild(iter_212_0)

					if var_212_0.name == "" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_212_2 = arg_209_1.actors_["1056"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1056 == nil then
				arg_209_1.var_.actorSpriteComps1056 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps1056 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								iter_212_2.color = Color.New(Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_2.color.r, 1, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_2.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1056 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_212_4 then
						iter_212_4.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1056 = nil
			end

			local var_212_5 = arg_209_1.actors_["10061"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10061 == nil then
				arg_209_1.var_.actorSpriteComps10061 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps10061 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								iter_212_6.color = Color.New(Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_6.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_6.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10061 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_212_8 then
						iter_212_8.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10061 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.475

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(410021051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 19 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 19)

				if (19 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 19)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021051", "story_v_out_410021.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021051", "story_v_out_410021.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_410021", "410021051", "story_v_out_410021.awb")

						arg_209_1:RecordAudio("410021051", var_212_15)
						arg_209_1:RecordAudio("410021051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410021", "410021051", "story_v_out_410021.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410021", "410021051", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410021052
		arg_213_1.duration_ = 1.33

		local var_213_0 = {
			zh = 1.066,
			ja = 1.333
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
				arg_213_0:Play410021053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10061 = arg_213_1.actors_["10061"].transform.localPosition
				arg_213_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10061", 4)

				for iter_216_0 = 0, arg_213_1.actors_["10061"].transform.childCount - 1 do
					local var_216_0 = arg_213_1.actors_["10061"].transform:GetChild(iter_216_0)

					if var_216_0.name == "" or not string.find(var_216_0.name, "split") then
						var_216_0.gameObject:SetActive(true)
					else
						var_216_0.gameObject:SetActive(false)
					end
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_213_1.time_ - 0) / var_216_1)
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_216_2 = arg_213_1.actors_["10061"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10061 == nil then
				arg_213_1.var_.actorSpriteComps10061 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.034

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10061 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10061 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10061 = nil
			end

			local var_216_5 = arg_213_1.actors_["1056"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.actorSpriteComps1056 == nil then
				arg_213_1.var_.actorSpriteComps1056 = var_216_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_6 = 0.034

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_6 and not isNil(var_216_5) then
				if arg_213_1.var_.actorSpriteComps1056 then
					for iter_216_5, iter_216_6 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_216_6 then
							if arg_213_1.isInRecall_ then
								iter_216_6.color = Color.New(Mathf.Lerp(iter_216_6.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_6), Mathf.Lerp(iter_216_6.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_6), (Mathf.Lerp(iter_216_6.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_6)))
							else
								local var_216_7 = Mathf.Lerp(iter_216_6.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_6)

								iter_216_6.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_6 and arg_213_1.time_ < 0 + var_216_6 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.actorSpriteComps1056 then
				for iter_216_7, iter_216_8 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_216_8 then
						iter_216_8.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1056 = nil
			end

			local var_216_8 = 0
			local var_216_9 = 0.1

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(410021052)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 4 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 4)

				if (4 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 4)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021052", "story_v_out_410021.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021052", "story_v_out_410021.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_410021", "410021052", "story_v_out_410021.awb")

						arg_213_1:RecordAudio("410021052", var_216_15)
						arg_213_1:RecordAudio("410021052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410021", "410021052", "story_v_out_410021.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410021", "410021052", "story_v_out_410021.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play410021053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410021053
		arg_217_1.duration_ = 8.33

		local var_217_0 = {
			zh = 7.966,
			ja = 8.333
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
				arg_217_0:Play410021054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10061 = arg_217_1.actors_["10061"].transform.localPosition
				arg_217_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10061", 4)

				for iter_220_0 = 0, arg_217_1.actors_["10061"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10061"].transform:GetChild(iter_220_0)

					if var_220_0.name == "" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_220_2 = arg_217_1.actors_["10061"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10061 == nil then
				arg_217_1.var_.actorSpriteComps10061 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.034

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps10061 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10061 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_220_4 then
						iter_220_4.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10061 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 0.875

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(410021053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 35 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 35)

				if (35 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 35)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021053", "story_v_out_410021.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021053", "story_v_out_410021.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_410021", "410021053", "story_v_out_410021.awb")

						arg_217_1:RecordAudio("410021053", var_220_12)
						arg_217_1:RecordAudio("410021053", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410021", "410021053", "story_v_out_410021.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410021", "410021053", "story_v_out_410021.awb")
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
				actorName = "10061",
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
	Play410021054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410021054
		arg_221_1.duration_ = 6.5

		local var_221_0 = {
			zh = 6.5,
			ja = 6.266
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
				arg_221_0:Play410021055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1060 = arg_221_1.actors_["1060"].transform.localPosition
				arg_221_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1060", 2)

				for iter_224_0 = 0, arg_221_1.actors_["1060"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["1060"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_2" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_224_2 = arg_221_1.actors_["1056"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = var_224_2.localPosition
				var_224_2.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 7)

				for iter_224_1 = 0, var_224_2.childCount - 1 do
					local var_224_3 = var_224_2:GetChild(iter_224_1)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_2.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_221_1.time_ - 0) / var_224_4)
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_224_5 = arg_221_1.actors_["1060"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps1060 == nil then
				arg_221_1.var_.actorSpriteComps1060 = var_224_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_6 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.actorSpriteComps1060 then
					for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_224_3 then
							if arg_221_1.isInRecall_ then
								iter_224_3.color = Color.New(Mathf.Lerp(iter_224_3.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_6), Mathf.Lerp(iter_224_3.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_6), (Mathf.Lerp(iter_224_3.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_6)))
							else
								local var_224_7 = Mathf.Lerp(iter_224_3.color.r, 1, (arg_221_1.time_ - 0) / var_224_6)

								iter_224_3.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps1060 then
				for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_224_5 then
						iter_224_5.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1060 = nil
			end

			local var_224_8 = arg_221_1.actors_["1056"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.actorSpriteComps1056 == nil then
				arg_221_1.var_.actorSpriteComps1056 = var_224_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_9 and not isNil(var_224_8) then
				if arg_221_1.var_.actorSpriteComps1056 then
					for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_224_7 then
							if arg_221_1.isInRecall_ then
								iter_224_7.color = Color.New(Mathf.Lerp(iter_224_7.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_9), Mathf.Lerp(iter_224_7.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_9), (Mathf.Lerp(iter_224_7.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_9)))
							else
								local var_224_10 = Mathf.Lerp(iter_224_7.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_9)

								iter_224_7.color = Color.New(var_224_10, var_224_10, var_224_10)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_9 and arg_221_1.time_ < 0 + var_224_9 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.actorSpriteComps1056 then
				for iter_224_8, iter_224_9 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_224_9 then
						iter_224_9.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1056 = nil
			end

			local var_224_11 = arg_221_1.actors_["10061"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.actorSpriteComps10061 == nil then
				arg_221_1.var_.actorSpriteComps10061 = var_224_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_12 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_12 and not isNil(var_224_11) then
				if arg_221_1.var_.actorSpriteComps10061 then
					for iter_224_10, iter_224_11 in pairs(arg_221_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_224_11 then
							if arg_221_1.isInRecall_ then
								iter_224_11.color = Color.New(Mathf.Lerp(iter_224_11.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_12), Mathf.Lerp(iter_224_11.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_12), (Mathf.Lerp(iter_224_11.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_12)))
							else
								local var_224_13 = Mathf.Lerp(iter_224_11.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_12)

								iter_224_11.color = Color.New(var_224_13, var_224_13, var_224_13)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_12 and arg_221_1.time_ < 0 + var_224_12 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.actorSpriteComps10061 then
				for iter_224_12, iter_224_13 in pairs(arg_221_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_224_13 then
						iter_224_13.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10061 = nil
			end

			local var_224_14 = 0
			local var_224_15 = 0.775

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_16 = arg_221_1:GetWordFromCfg(410021054)
				local var_224_17 = arg_221_1:FormatText(var_224_16.content)

				arg_221_1.text_.text = var_224_17

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 31 <= 0 and var_224_15 or var_224_15 * (utf8.len(var_224_17) / 31)

				if (31 <= 0 and var_224_15 or var_224_15 * (utf8.len(var_224_17) / 31)) > 0 and var_224_15 < var_224_19 then
					arg_221_1.talkMaxDuration = var_224_19

					if var_224_19 + var_224_14 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_19 + var_224_14
					end
				end

				arg_221_1.text_.text = var_224_17
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021054", "story_v_out_410021.awb") ~= 0 then
					local var_224_20 = manager.audio:GetVoiceLength("story_v_out_410021", "410021054", "story_v_out_410021.awb") / 1000

					if var_224_20 + var_224_14 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_20 + var_224_14
					end

					if var_224_16.prefab_name ~= "" and arg_221_1.actors_[var_224_16.prefab_name] ~= nil then
						local var_224_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_16.prefab_name].transform, "story_v_out_410021", "410021054", "story_v_out_410021.awb")

						arg_221_1:RecordAudio("410021054", var_224_21)
						arg_221_1:RecordAudio("410021054", var_224_21)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410021", "410021054", "story_v_out_410021.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410021", "410021054", "story_v_out_410021.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = math.max(var_224_15, arg_221_1.talkMaxDuration)

			if var_224_14 <= arg_221_1.time_ and arg_221_1.time_ < var_224_14 + var_224_22 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_14) / var_224_22

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_14 + var_224_22 and arg_221_1.time_ < var_224_14 + var_224_22 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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
				actorName = "1056",
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
	Play410021055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410021055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play410021056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1056 = arg_225_1.actors_["1056"].transform.localPosition
				arg_225_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1056", 4)

				for iter_228_0 = 0, arg_225_1.actors_["1056"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["1056"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_228_2 = arg_225_1.actors_["10061"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10061 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10061", 7)

				for iter_228_1 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_1)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10061, Vector3.New(0, -2000, -100), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_228_5 = arg_225_1.actors_["1056"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps1056 == nil then
				arg_225_1.var_.actorSpriteComps1056 = var_228_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_6 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.actorSpriteComps1056 then
					for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_228_3 then
							if arg_225_1.isInRecall_ then
								iter_228_3.color = Color.New(Mathf.Lerp(iter_228_3.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_6), Mathf.Lerp(iter_228_3.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_6), (Mathf.Lerp(iter_228_3.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_6)))
							else
								local var_228_7 = Mathf.Lerp(iter_228_3.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_6)

								iter_228_3.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps1056 then
				for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_228_5 then
						iter_228_5.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps1056 = nil
			end

			local var_228_8 = arg_225_1.actors_["10061"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10061 == nil then
				arg_225_1.var_.actorSpriteComps10061 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_9 and not isNil(var_228_8) then
				if arg_225_1.var_.actorSpriteComps10061 then
					for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_228_7 then
							if arg_225_1.isInRecall_ then
								iter_228_7.color = Color.New(Mathf.Lerp(iter_228_7.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_9), Mathf.Lerp(iter_228_7.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_9), (Mathf.Lerp(iter_228_7.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_9)))
							else
								local var_228_10 = Mathf.Lerp(iter_228_7.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_9)

								iter_228_7.color = Color.New(var_228_10, var_228_10, var_228_10)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_9 and arg_225_1.time_ < 0 + var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10061 then
				for iter_228_8, iter_228_9 in pairs(arg_225_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_228_9 then
						iter_228_9.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10061 = nil
			end

			local var_228_11 = arg_225_1.actors_["1060"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_12 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_12 and not isNil(var_228_11) then
				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_10, iter_228_11 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_228_11 then
							if arg_225_1.isInRecall_ then
								iter_228_11.color = Color.New(Mathf.Lerp(iter_228_11.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_12), Mathf.Lerp(iter_228_11.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_12), (Mathf.Lerp(iter_228_11.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_12)))
							else
								local var_228_13 = Mathf.Lerp(iter_228_11.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_12)

								iter_228_11.color = Color.New(var_228_13, var_228_13, var_228_13)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_12 and arg_225_1.time_ < 0 + var_228_12 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_12, iter_228_13 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_13 then
						iter_228_13.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_14 = 0
			local var_228_15 = 1.275

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_16 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(410021055).content)

				arg_225_1.text_.text = var_228_16

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_18 = 51 <= 0 and var_228_15 or var_228_15 * (utf8.len(var_228_16) / 51)

				if (51 <= 0 and var_228_15 or var_228_15 * (utf8.len(var_228_16) / 51)) > 0 and var_228_15 < var_228_18 then
					arg_225_1.talkMaxDuration = var_228_18

					if var_228_18 + var_228_14 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_18 + var_228_14
					end
				end

				arg_225_1.text_.text = var_228_16
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_19 = math.max(var_228_15, arg_225_1.talkMaxDuration)

			if var_228_14 <= arg_225_1.time_ and arg_225_1.time_ < var_228_14 + var_228_19 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_14) / var_228_19

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_14 + var_228_19 and arg_225_1.time_ < var_228_14 + var_228_19 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_225_1:InitPlayNodeList()
	end,
	Play410021056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410021056
		arg_229_1.duration_ = 4.77

		local var_229_0 = {
			zh = 2.366,
			ja = 4.766
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
				arg_229_0:Play410021057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1060 = arg_229_1.actors_["1060"].transform.localPosition
				arg_229_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1060", 2)

				for iter_232_0 = 0, arg_229_1.actors_["1060"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["1060"].transform:GetChild(iter_232_0)

					if var_232_0.name == "" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_232_2 = arg_229_1.actors_["1060"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1060 == nil then
				arg_229_1.var_.actorSpriteComps1060 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps1060 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								iter_232_2.color = Color.New(Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_3), Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_3), (Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_3)))
							else
								local var_232_4 = Mathf.Lerp(iter_232_2.color.r, 1, (arg_229_1.time_ - 0) / var_232_3)

								iter_232_2.color = Color.New(var_232_4, var_232_4, var_232_4)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1060 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_232_4 then
						iter_232_4.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1060 = nil
			end

			local var_232_5 = 0
			local var_232_6 = 0.225

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(410021056)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 9 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 9)

				if (9 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 9)) > 0 and var_232_6 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021056", "story_v_out_410021.awb") ~= 0 then
					local var_232_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021056", "story_v_out_410021.awb") / 1000

					if var_232_11 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_5
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_410021", "410021056", "story_v_out_410021.awb")

						arg_229_1:RecordAudio("410021056", var_232_12)
						arg_229_1:RecordAudio("410021056", var_232_12)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410021", "410021056", "story_v_out_410021.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410021", "410021056", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410021057
		arg_233_1.duration_ = 6.1

		local var_233_0 = {
			zh = 1.9,
			ja = 6.1
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
				arg_233_0:Play410021058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1056 = arg_233_1.actors_["1056"].transform.localPosition
				arg_233_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1056", 4)

				for iter_236_0 = 0, arg_233_1.actors_["1056"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["1056"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_236_2 = arg_233_1.actors_["1056"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1056 == nil then
				arg_233_1.var_.actorSpriteComps1056 = var_236_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_3 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.actorSpriteComps1056 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								iter_236_2.color = Color.New(Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_3), Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_3), (Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_3)))
							else
								local var_236_4 = Mathf.Lerp(iter_236_2.color.r, 1, (arg_233_1.time_ - 0) / var_236_3)

								iter_236_2.color = Color.New(var_236_4, var_236_4, var_236_4)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1056 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps1056 = nil
			end

			local var_236_5 = arg_233_1.actors_["1060"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps1060 == nil then
				arg_233_1.var_.actorSpriteComps1060 = var_236_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_6 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.actorSpriteComps1060 then
					for iter_236_5, iter_236_6 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_236_6 then
							if arg_233_1.isInRecall_ then
								iter_236_6.color = Color.New(Mathf.Lerp(iter_236_6.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_6), Mathf.Lerp(iter_236_6.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_6), (Mathf.Lerp(iter_236_6.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_6)))
							else
								local var_236_7 = Mathf.Lerp(iter_236_6.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_6)

								iter_236_6.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps1060 then
				for iter_236_7, iter_236_8 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_236_8 then
						iter_236_8.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps1060 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 0.25

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(410021057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 10 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 10)

				if (10 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 10)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021057", "story_v_out_410021.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021057", "story_v_out_410021.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_410021", "410021057", "story_v_out_410021.awb")

						arg_233_1:RecordAudio("410021057", var_236_15)
						arg_233_1:RecordAudio("410021057", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410021", "410021057", "story_v_out_410021.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410021", "410021057", "story_v_out_410021.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410021058
		arg_237_1.duration_ = 11.4

		local var_237_0 = {
			zh = 7.066,
			ja = 11.4
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
				arg_237_0:Play410021059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1056 = arg_237_1.actors_["1056"].transform.localPosition
				arg_237_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1056", 4)

				for iter_240_0 = 0, arg_237_1.actors_["1056"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["1056"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_240_2 = arg_237_1.actors_["1056"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1056 == nil then
				arg_237_1.var_.actorSpriteComps1056 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps1056 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								iter_240_2.color = Color.New(Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_2.color.r, 1, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_2.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1056 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps1056 = nil
			end

			local var_240_5 = 0
			local var_240_6 = 0.95

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_7 = arg_237_1:GetWordFromCfg(410021058)
				local var_240_8 = arg_237_1:FormatText(var_240_7.content)

				arg_237_1.text_.text = var_240_8

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 40 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 40)

				if (40 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 40)) > 0 and var_240_6 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_5
					end
				end

				arg_237_1.text_.text = var_240_8
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021058", "story_v_out_410021.awb") ~= 0 then
					local var_240_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021058", "story_v_out_410021.awb") / 1000

					if var_240_11 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_5
					end

					if var_240_7.prefab_name ~= "" and arg_237_1.actors_[var_240_7.prefab_name] ~= nil then
						local var_240_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_7.prefab_name].transform, "story_v_out_410021", "410021058", "story_v_out_410021.awb")

						arg_237_1:RecordAudio("410021058", var_240_12)
						arg_237_1:RecordAudio("410021058", var_240_12)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410021", "410021058", "story_v_out_410021.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410021", "410021058", "story_v_out_410021.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_6, arg_237_1.talkMaxDuration)

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_5) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_5 + var_240_13 and arg_237_1.time_ < var_240_5 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410021059
		arg_241_1.duration_ = 9.77

		local var_241_0 = {
			zh = 7.833,
			ja = 9.766
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
				arg_241_0:Play410021060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1056 = arg_241_1.actors_["1056"].transform.localPosition
				arg_241_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1056", 4)

				for iter_244_0 = 0, arg_241_1.actors_["1056"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["1056"].transform:GetChild(iter_244_0)

					if var_244_0.name == "split_1" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_244_2 = arg_241_1.actors_["1056"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1056 == nil then
				arg_241_1.var_.actorSpriteComps1056 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps1056 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								iter_244_2.color = Color.New(Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_3), Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_3), (Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_3)))
							else
								local var_244_4 = Mathf.Lerp(iter_244_2.color.r, 1, (arg_241_1.time_ - 0) / var_244_3)

								iter_244_2.color = Color.New(var_244_4, var_244_4, var_244_4)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1056 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_244_4 then
						iter_244_4.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1056 = nil
			end

			local var_244_5 = 0
			local var_244_6 = 1.15

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(410021059)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 46 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 46)

				if (46 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 46)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021059", "story_v_out_410021.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021059", "story_v_out_410021.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_410021", "410021059", "story_v_out_410021.awb")

						arg_241_1:RecordAudio("410021059", var_244_12)
						arg_241_1:RecordAudio("410021059", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410021", "410021059", "story_v_out_410021.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410021", "410021059", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410021060
		arg_245_1.duration_ = 12.13

		local var_245_0 = {
			zh = 9.833,
			ja = 12.133
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
				arg_245_0:Play410021061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1056 = arg_245_1.actors_["1056"].transform.localPosition
				arg_245_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1056", 4)

				for iter_248_0 = 0, arg_245_1.actors_["1056"].transform.childCount - 1 do
					local var_248_0 = arg_245_1.actors_["1056"].transform:GetChild(iter_248_0)

					if var_248_0.name == "split_1" or not string.find(var_248_0.name, "split") then
						var_248_0.gameObject:SetActive(true)
					else
						var_248_0.gameObject:SetActive(false)
					end
				end
			end

			local var_248_1 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				arg_245_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_245_1.time_ - 0) / var_248_1)
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 then
				arg_245_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_248_2 = arg_245_1.actors_["1056"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1056 == nil then
				arg_245_1.var_.actorSpriteComps1056 = var_248_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_3 = 0.034

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.actorSpriteComps1056 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_248_2 then
							if arg_245_1.isInRecall_ then
								iter_248_2.color = Color.New(Mathf.Lerp(iter_248_2.color.r, arg_245_1.hightColor1.r, (arg_245_1.time_ - 0) / var_248_3), Mathf.Lerp(iter_248_2.color.g, arg_245_1.hightColor1.g, (arg_245_1.time_ - 0) / var_248_3), (Mathf.Lerp(iter_248_2.color.b, arg_245_1.hightColor1.b, (arg_245_1.time_ - 0) / var_248_3)))
							else
								local var_248_4 = Mathf.Lerp(iter_248_2.color.r, 1, (arg_245_1.time_ - 0) / var_248_3)

								iter_248_2.color = Color.New(var_248_4, var_248_4, var_248_4)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1056 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_248_4 then
						iter_248_4.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_245_1.var_.actorSpriteComps1056 = nil
			end

			local var_248_5 = 0
			local var_248_6 = 1.4

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_7 = arg_245_1:GetWordFromCfg(410021060)
				local var_248_8 = arg_245_1:FormatText(var_248_7.content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 56 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 56)

				if (56 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 56)) > 0 and var_248_6 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10

					if var_248_10 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021060", "story_v_out_410021.awb") ~= 0 then
					local var_248_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021060", "story_v_out_410021.awb") / 1000

					if var_248_11 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_5
					end

					if var_248_7.prefab_name ~= "" and arg_245_1.actors_[var_248_7.prefab_name] ~= nil then
						local var_248_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_7.prefab_name].transform, "story_v_out_410021", "410021060", "story_v_out_410021.awb")

						arg_245_1:RecordAudio("410021060", var_248_12)
						arg_245_1:RecordAudio("410021060", var_248_12)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410021", "410021060", "story_v_out_410021.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410021", "410021060", "story_v_out_410021.awb")
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

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410021061
		arg_249_1.duration_ = 8.37

		local var_249_0 = {
			zh = 3.366,
			ja = 8.366
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
				arg_249_0:Play410021062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1060 = arg_249_1.actors_["1060"].transform.localPosition
				arg_249_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1060", 2)

				for iter_252_0 = 0, arg_249_1.actors_["1060"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["1060"].transform:GetChild(iter_252_0)

					if var_252_0.name == "" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_252_2 = arg_249_1.actors_["1060"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1060 == nil then
				arg_249_1.var_.actorSpriteComps1060 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps1060 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1060 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_252_4 then
						iter_252_4.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1060 = nil
			end

			local var_252_5 = arg_249_1.actors_["1056"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1056 == nil then
				arg_249_1.var_.actorSpriteComps1056 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps1056 then
					for iter_252_5, iter_252_6 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_252_6 then
							if arg_249_1.isInRecall_ then
								iter_252_6.color = Color.New(Mathf.Lerp(iter_252_6.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_6.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_6.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_6.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_6.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1056 then
				for iter_252_7, iter_252_8 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_252_8 then
						iter_252_8.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps1056 = nil
			end

			local var_252_8 = 0
			local var_252_9 = 0.375

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(410021061)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 15 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 15)

				if (15 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 15)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021061", "story_v_out_410021.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021061", "story_v_out_410021.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_410021", "410021061", "story_v_out_410021.awb")

						arg_249_1:RecordAudio("410021061", var_252_15)
						arg_249_1:RecordAudio("410021061", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410021", "410021061", "story_v_out_410021.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410021", "410021061", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410021062
		arg_253_1.duration_ = 6.8

		local var_253_0 = {
			zh = 6.533,
			ja = 6.8
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
				arg_253_0:Play410021063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1056 = arg_253_1.actors_["1056"].transform.localPosition
				arg_253_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1056", 4)

				for iter_256_0 = 0, arg_253_1.actors_["1056"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1056"].transform:GetChild(iter_256_0)

					if var_256_0.name == "" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_256_2 = arg_253_1.actors_["1056"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1056 == nil then
				arg_253_1.var_.actorSpriteComps1056 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1056 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1056 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_256_4 then
						iter_256_4.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps1056 = nil
			end

			local var_256_5 = arg_253_1.actors_["1060"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps1060 == nil then
				arg_253_1.var_.actorSpriteComps1060 = var_256_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_6 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.actorSpriteComps1060 then
					for iter_256_5, iter_256_6 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_256_6 then
							if arg_253_1.isInRecall_ then
								iter_256_6.color = Color.New(Mathf.Lerp(iter_256_6.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_6), Mathf.Lerp(iter_256_6.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_6), (Mathf.Lerp(iter_256_6.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_6)))
							else
								local var_256_7 = Mathf.Lerp(iter_256_6.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_6)

								iter_256_6.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps1060 then
				for iter_256_7, iter_256_8 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_256_8 then
						iter_256_8.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1060 = nil
			end

			local var_256_8 = 0
			local var_256_9 = 0.825

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(410021062)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 33 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 33)

				if (33 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 33)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021062", "story_v_out_410021.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021062", "story_v_out_410021.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_410021", "410021062", "story_v_out_410021.awb")

						arg_253_1:RecordAudio("410021062", var_256_15)
						arg_253_1:RecordAudio("410021062", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410021", "410021062", "story_v_out_410021.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410021", "410021062", "story_v_out_410021.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410021063
		arg_257_1.duration_ = 9.8

		local var_257_0 = {
			zh = 7.9,
			ja = 9.8
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
				arg_257_0:Play410021064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1056 = arg_257_1.actors_["1056"].transform.localPosition
				arg_257_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1056", 4)

				for iter_260_0 = 0, arg_257_1.actors_["1056"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["1056"].transform:GetChild(iter_260_0)

					if var_260_0.name == "" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_260_2 = arg_257_1.actors_["1056"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1056 == nil then
				arg_257_1.var_.actorSpriteComps1056 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps1056 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1056 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps1056 = nil
			end

			local var_260_5 = 0
			local var_260_6 = 1.075

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(410021063)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 43 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 43)

				if (43 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 43)) > 0 and var_260_6 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021063", "story_v_out_410021.awb") ~= 0 then
					local var_260_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021063", "story_v_out_410021.awb") / 1000

					if var_260_11 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_5
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_410021", "410021063", "story_v_out_410021.awb")

						arg_257_1:RecordAudio("410021063", var_260_12)
						arg_257_1:RecordAudio("410021063", var_260_12)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410021", "410021063", "story_v_out_410021.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410021", "410021063", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410021064
		arg_261_1.duration_ = 8.3

		local var_261_0 = {
			zh = 6.5,
			ja = 8.3
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
				arg_261_0:Play410021065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1056 = arg_261_1.actors_["1056"].transform.localPosition
				arg_261_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1056", 4)

				for iter_264_0 = 0, arg_261_1.actors_["1056"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["1056"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_1" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_264_2 = arg_261_1.actors_["1056"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1056 == nil then
				arg_261_1.var_.actorSpriteComps1056 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps1056 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1056 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1056 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.675

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(410021064)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 27 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 27)

				if (27 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 27)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021064", "story_v_out_410021.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021064", "story_v_out_410021.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_410021", "410021064", "story_v_out_410021.awb")

						arg_261_1:RecordAudio("410021064", var_264_12)
						arg_261_1:RecordAudio("410021064", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410021", "410021064", "story_v_out_410021.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410021", "410021064", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410021065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play410021066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1056"]) and arg_265_1.var_.actorSpriteComps1056 == nil then
				arg_265_1.var_.actorSpriteComps1056 = arg_265_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1056"]) then
				if arg_265_1.var_.actorSpriteComps1056 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1056"]) and arg_265_1.var_.actorSpriteComps1056 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps1056 = nil
			end

			local var_268_2 = 0
			local var_268_3 = 1.4

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(410021065).content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 56 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 56)

				if (56 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 56)) > 0 and var_268_3 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_7 and arg_265_1.time_ < var_268_2 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play410021066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410021066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play410021067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.95

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(410021066).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 38 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 38)

				if (38 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 38)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410021067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410021067
		arg_273_1.duration_ = 7

		local var_273_0 = {
			zh = 3.766,
			ja = 7
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
				arg_273_0:Play410021068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = arg_273_1.actors_["1060"].transform.localPosition
				arg_273_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 2)

				for iter_276_0 = 0, arg_273_1.actors_["1060"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["1060"].transform:GetChild(iter_276_0)

					if var_276_0.name == "" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_276_2 = arg_273_1.actors_["1060"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1060 == nil then
				arg_273_1.var_.actorSpriteComps1060 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps1060 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1060 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps1060 = nil
			end

			local var_276_5 = 0
			local var_276_6 = 0.45

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:GetWordFromCfg(410021067)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 18 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 18)

				if (18 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 18)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021067", "story_v_out_410021.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021067", "story_v_out_410021.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_410021", "410021067", "story_v_out_410021.awb")

						arg_273_1:RecordAudio("410021067", var_276_12)
						arg_273_1:RecordAudio("410021067", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410021", "410021067", "story_v_out_410021.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410021", "410021067", "story_v_out_410021.awb")
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
				actorName = "1060",
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
	Play410021068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410021068
		arg_277_1.duration_ = 5.4

		local var_277_0 = {
			zh = 4.066,
			ja = 5.4
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
				arg_277_0:Play410021069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1056 = arg_277_1.actors_["1056"].transform.localPosition
				arg_277_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1056", 4)

				for iter_280_0 = 0, arg_277_1.actors_["1056"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["1056"].transform:GetChild(iter_280_0)

					if var_280_0.name == "" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_280_2 = arg_277_1.actors_["1056"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1056 == nil then
				arg_277_1.var_.actorSpriteComps1056 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps1056 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1056 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps1056 = nil
			end

			local var_280_5 = arg_277_1.actors_["1060"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.actorSpriteComps1060 == nil then
				arg_277_1.var_.actorSpriteComps1060 = var_280_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_6 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_6 and not isNil(var_280_5) then
				if arg_277_1.var_.actorSpriteComps1060 then
					for iter_280_5, iter_280_6 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_280_6 then
							if arg_277_1.isInRecall_ then
								iter_280_6.color = Color.New(Mathf.Lerp(iter_280_6.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_6), Mathf.Lerp(iter_280_6.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_6), (Mathf.Lerp(iter_280_6.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_6)))
							else
								local var_280_7 = Mathf.Lerp(iter_280_6.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_6)

								iter_280_6.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_6 and arg_277_1.time_ < 0 + var_280_6 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.actorSpriteComps1060 then
				for iter_280_7, iter_280_8 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_280_8 then
						iter_280_8.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps1060 = nil
			end

			local var_280_8 = 0
			local var_280_9 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_10 = arg_277_1:GetWordFromCfg(410021068)
				local var_280_11 = arg_277_1:FormatText(var_280_10.content)

				arg_277_1.text_.text = var_280_11

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 21 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 21)

				if (21 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 21)) > 0 and var_280_9 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_11
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021068", "story_v_out_410021.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021068", "story_v_out_410021.awb") / 1000

					if var_280_14 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_8
					end

					if var_280_10.prefab_name ~= "" and arg_277_1.actors_[var_280_10.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_10.prefab_name].transform, "story_v_out_410021", "410021068", "story_v_out_410021.awb")

						arg_277_1:RecordAudio("410021068", var_280_15)
						arg_277_1:RecordAudio("410021068", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410021", "410021068", "story_v_out_410021.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410021", "410021068", "story_v_out_410021.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_16 and arg_277_1.time_ < var_280_8 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410021069
		arg_281_1.duration_ = 9.73

		local var_281_0 = {
			zh = 3.4,
			ja = 9.733
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
				arg_281_0:Play410021070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1060 = arg_281_1.actors_["1060"].transform.localPosition
				arg_281_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1060", 2)

				for iter_284_0 = 0, arg_281_1.actors_["1060"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["1060"].transform:GetChild(iter_284_0)

					if var_284_0.name == "split_3" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_284_2 = arg_281_1.actors_["1060"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1060 == nil then
				arg_281_1.var_.actorSpriteComps1060 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps1060 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								iter_284_2.color = Color.New(Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_2.color.r, 1, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_2.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1060 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps1060 = nil
			end

			local var_284_5 = arg_281_1.actors_["1056"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.actorSpriteComps1056 == nil then
				arg_281_1.var_.actorSpriteComps1056 = var_284_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_6 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_6 and not isNil(var_284_5) then
				if arg_281_1.var_.actorSpriteComps1056 then
					for iter_284_5, iter_284_6 in pairs(arg_281_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_284_6 then
							if arg_281_1.isInRecall_ then
								iter_284_6.color = Color.New(Mathf.Lerp(iter_284_6.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_6), Mathf.Lerp(iter_284_6.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_6), (Mathf.Lerp(iter_284_6.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_6)))
							else
								local var_284_7 = Mathf.Lerp(iter_284_6.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_6)

								iter_284_6.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_6 and arg_281_1.time_ < 0 + var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.actorSpriteComps1056 then
				for iter_284_7, iter_284_8 in pairs(arg_281_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_284_8 then
						iter_284_8.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps1056 = nil
			end

			local var_284_8 = 0
			local var_284_9 = 0.375

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(410021069)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 15 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 15)

				if (15 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 15)) > 0 and var_284_9 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021069", "story_v_out_410021.awb") ~= 0 then
					local var_284_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021069", "story_v_out_410021.awb") / 1000

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end

					if var_284_10.prefab_name ~= "" and arg_281_1.actors_[var_284_10.prefab_name] ~= nil then
						local var_284_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_10.prefab_name].transform, "story_v_out_410021", "410021069", "story_v_out_410021.awb")

						arg_281_1:RecordAudio("410021069", var_284_15)
						arg_281_1:RecordAudio("410021069", var_284_15)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410021", "410021069", "story_v_out_410021.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410021", "410021069", "story_v_out_410021.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_16 and arg_281_1.time_ < var_284_8 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play410021070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410021070
		arg_285_1.duration_ = 14.37

		local var_285_0 = {
			zh = 14.2,
			ja = 14.366
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
				arg_285_0:Play410021071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1056 = arg_285_1.actors_["1056"].transform.localPosition
				arg_285_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1056", 4)

				for iter_288_0 = 0, arg_285_1.actors_["1056"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["1056"].transform:GetChild(iter_288_0)

					if var_288_0.name == "split_2" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_288_2 = arg_285_1.actors_["1056"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1056 == nil then
				arg_285_1.var_.actorSpriteComps1056 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps1056 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1056 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_288_4 then
						iter_288_4.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1056 = nil
			end

			local var_288_5 = arg_285_1.actors_["1060"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_6 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								iter_288_6.color = Color.New(Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_6), Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_6), (Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_6)))
							else
								local var_288_7 = Mathf.Lerp(iter_288_6.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_6)

								iter_288_6.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_8 then
						iter_288_8.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_8 = 0
			local var_288_9 = 1.725

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(410021070)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 69 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 69)

				if (69 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 69)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021070", "story_v_out_410021.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021070", "story_v_out_410021.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_410021", "410021070", "story_v_out_410021.awb")

						arg_285_1:RecordAudio("410021070", var_288_15)
						arg_285_1:RecordAudio("410021070", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410021", "410021070", "story_v_out_410021.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410021", "410021070", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410021071
		arg_289_1.duration_ = 9.9

		local var_289_0 = {
			zh = 6,
			ja = 9.9
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
				arg_289_0:Play410021072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1056 = arg_289_1.actors_["1056"].transform.localPosition
				arg_289_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1056", 4)

				for iter_292_0 = 0, arg_289_1.actors_["1056"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["1056"].transform:GetChild(iter_292_0)

					if var_292_0.name == "split_2" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_292_2 = arg_289_1.actors_["1056"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1056 == nil then
				arg_289_1.var_.actorSpriteComps1056 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps1056 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1056 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps1056 = nil
			end

			local var_292_5 = 0
			local var_292_6 = 0.9

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_7 = arg_289_1:GetWordFromCfg(410021071)
				local var_292_8 = arg_289_1:FormatText(var_292_7.content)

				arg_289_1.text_.text = var_292_8

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 36 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 36)

				if (36 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 36)) > 0 and var_292_6 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_8
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021071", "story_v_out_410021.awb") ~= 0 then
					local var_292_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021071", "story_v_out_410021.awb") / 1000

					if var_292_11 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_5
					end

					if var_292_7.prefab_name ~= "" and arg_289_1.actors_[var_292_7.prefab_name] ~= nil then
						local var_292_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_7.prefab_name].transform, "story_v_out_410021", "410021071", "story_v_out_410021.awb")

						arg_289_1:RecordAudio("410021071", var_292_12)
						arg_289_1:RecordAudio("410021071", var_292_12)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410021", "410021071", "story_v_out_410021.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410021", "410021071", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410021072
		arg_293_1.duration_ = 7.8

		local var_293_0 = {
			zh = 2.466,
			ja = 7.8
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
				arg_293_0:Play410021073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1060 = arg_293_1.actors_["1060"].transform.localPosition
				arg_293_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1060", 2)

				for iter_296_0 = 0, arg_293_1.actors_["1060"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["1060"].transform:GetChild(iter_296_0)

					if var_296_0.name == "split_3" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_296_2 = arg_293_1.actors_["1060"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps1060 == nil then
				arg_293_1.var_.actorSpriteComps1060 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps1060 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps1060 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1060 = nil
			end

			local var_296_5 = arg_293_1.actors_["1056"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.actorSpriteComps1056 == nil then
				arg_293_1.var_.actorSpriteComps1056 = var_296_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_6 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_6 and not isNil(var_296_5) then
				if arg_293_1.var_.actorSpriteComps1056 then
					for iter_296_5, iter_296_6 in pairs(arg_293_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_296_6 then
							if arg_293_1.isInRecall_ then
								iter_296_6.color = Color.New(Mathf.Lerp(iter_296_6.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_6), Mathf.Lerp(iter_296_6.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_6), (Mathf.Lerp(iter_296_6.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_6)))
							else
								local var_296_7 = Mathf.Lerp(iter_296_6.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_6)

								iter_296_6.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_6 and arg_293_1.time_ < 0 + var_296_6 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.actorSpriteComps1056 then
				for iter_296_7, iter_296_8 in pairs(arg_293_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_296_8 then
						iter_296_8.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps1056 = nil
			end

			local var_296_8 = 0
			local var_296_9 = 0.325

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(410021072)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 13 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 13)

				if (13 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 13)) > 0 and var_296_9 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021072", "story_v_out_410021.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021072", "story_v_out_410021.awb") / 1000

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_out_410021", "410021072", "story_v_out_410021.awb")

						arg_293_1:RecordAudio("410021072", var_296_15)
						arg_293_1:RecordAudio("410021072", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410021", "410021072", "story_v_out_410021.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410021", "410021072", "story_v_out_410021.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_16 and arg_293_1.time_ < var_296_8 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play410021073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410021073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410021074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1060"]) and arg_297_1.var_.actorSpriteComps1060 == nil then
				arg_297_1.var_.actorSpriteComps1060 = arg_297_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1060"]) then
				if arg_297_1.var_.actorSpriteComps1060 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 0.5, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1060"]) and arg_297_1.var_.actorSpriteComps1060 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps1060 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.775

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(410021073).content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_6 = 31 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 31)

				if (31 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 31)) > 0 and var_300_3 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_7 and arg_297_1.time_ < var_300_2 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play410021074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410021074
		arg_301_1.duration_ = 14.4

		local var_301_0 = {
			zh = 8.7,
			ja = 14.4
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
				arg_301_0:Play410021075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1056 = arg_301_1.actors_["1056"].transform.localPosition
				arg_301_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1056", 4)

				for iter_304_0 = 0, arg_301_1.actors_["1056"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["1056"].transform:GetChild(iter_304_0)

					if var_304_0.name == "split_3" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_304_2 = arg_301_1.actors_["1056"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps1056 == nil then
				arg_301_1.var_.actorSpriteComps1056 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps1056 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								iter_304_2.color = Color.New(Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_2.color.r, 1, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_2.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps1056 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps1056 = nil
			end

			local var_304_5 = 0
			local var_304_6 = 1.1

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_7 = arg_301_1:GetWordFromCfg(410021074)
				local var_304_8 = arg_301_1:FormatText(var_304_7.content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 44 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 44)

				if (44 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 44)) > 0 and var_304_6 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_5
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021074", "story_v_out_410021.awb") ~= 0 then
					local var_304_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021074", "story_v_out_410021.awb") / 1000

					if var_304_11 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_5
					end

					if var_304_7.prefab_name ~= "" and arg_301_1.actors_[var_304_7.prefab_name] ~= nil then
						local var_304_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_7.prefab_name].transform, "story_v_out_410021", "410021074", "story_v_out_410021.awb")

						arg_301_1:RecordAudio("410021074", var_304_12)
						arg_301_1:RecordAudio("410021074", var_304_12)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410021", "410021074", "story_v_out_410021.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410021", "410021074", "story_v_out_410021.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_6, arg_301_1.talkMaxDuration)

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_5) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_5 + var_304_13 and arg_301_1.time_ < var_304_5 + var_304_13 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410021075
		arg_305_1.duration_ = 13.1

		local var_305_0 = {
			zh = 11.8,
			ja = 13.1
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
				arg_305_0:Play410021076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1056 = arg_305_1.actors_["1056"].transform.localPosition
				arg_305_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1056", 4)

				for iter_308_0 = 0, arg_305_1.actors_["1056"].transform.childCount - 1 do
					local var_308_0 = arg_305_1.actors_["1056"].transform:GetChild(iter_308_0)

					if var_308_0.name == "split_3" or not string.find(var_308_0.name, "split") then
						var_308_0.gameObject:SetActive(true)
					else
						var_308_0.gameObject:SetActive(false)
					end
				end
			end

			local var_308_1 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 then
				arg_305_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_305_1.time_ - 0) / var_308_1)
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 then
				arg_305_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_308_2 = arg_305_1.actors_["1056"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps1056 == nil then
				arg_305_1.var_.actorSpriteComps1056 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps1056 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								iter_308_2.color = Color.New(Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 0) / var_308_3), Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 0) / var_308_3), (Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 0) / var_308_3)))
							else
								local var_308_4 = Mathf.Lerp(iter_308_2.color.r, 1, (arg_305_1.time_ - 0) / var_308_3)

								iter_308_2.color = Color.New(var_308_4, var_308_4, var_308_4)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps1056 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_308_4 then
						iter_308_4.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps1056 = nil
			end

			local var_308_5 = 0
			local var_308_6 = 1.375

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:GetWordFromCfg(410021075)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 55 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 55)

				if (55 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 55)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021075", "story_v_out_410021.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021075", "story_v_out_410021.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_410021", "410021075", "story_v_out_410021.awb")

						arg_305_1:RecordAudio("410021075", var_308_12)
						arg_305_1:RecordAudio("410021075", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410021", "410021075", "story_v_out_410021.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410021", "410021075", "story_v_out_410021.awb")
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

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play410021076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410021076
		arg_309_1.duration_ = 6.8

		local var_309_0 = {
			zh = 6.133,
			ja = 6.8
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
				arg_309_0:Play410021077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1060 = arg_309_1.actors_["1060"].transform.localPosition
				arg_309_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1060", 2)

				for iter_312_0 = 0, arg_309_1.actors_["1060"].transform.childCount - 1 do
					local var_312_0 = arg_309_1.actors_["1060"].transform:GetChild(iter_312_0)

					if var_312_0.name == "split_4" or not string.find(var_312_0.name, "split") then
						var_312_0.gameObject:SetActive(true)
					else
						var_312_0.gameObject:SetActive(false)
					end
				end
			end

			local var_312_1 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 then
				arg_309_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_309_1.time_ - 0) / var_312_1)
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 then
				arg_309_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_312_2 = arg_309_1.actors_["1060"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1060 == nil then
				arg_309_1.var_.actorSpriteComps1060 = var_312_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_3 = 0.034

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.actorSpriteComps1060 then
					for iter_312_1, iter_312_2 in pairs(arg_309_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_312_2 then
							if arg_309_1.isInRecall_ then
								iter_312_2.color = Color.New(Mathf.Lerp(iter_312_2.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_3), Mathf.Lerp(iter_312_2.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_3), (Mathf.Lerp(iter_312_2.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_3)))
							else
								local var_312_4 = Mathf.Lerp(iter_312_2.color.r, 1, (arg_309_1.time_ - 0) / var_312_3)

								iter_312_2.color = Color.New(var_312_4, var_312_4, var_312_4)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1060 then
				for iter_312_3, iter_312_4 in pairs(arg_309_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_312_4 then
						iter_312_4.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps1060 = nil
			end

			local var_312_5 = arg_309_1.actors_["1056"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_5) and arg_309_1.var_.actorSpriteComps1056 == nil then
				arg_309_1.var_.actorSpriteComps1056 = var_312_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_6 = 0.034

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_6 and not isNil(var_312_5) then
				if arg_309_1.var_.actorSpriteComps1056 then
					for iter_312_5, iter_312_6 in pairs(arg_309_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_312_6 then
							if arg_309_1.isInRecall_ then
								iter_312_6.color = Color.New(Mathf.Lerp(iter_312_6.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_6), Mathf.Lerp(iter_312_6.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_6), (Mathf.Lerp(iter_312_6.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_6)))
							else
								local var_312_7 = Mathf.Lerp(iter_312_6.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_6)

								iter_312_6.color = Color.New(var_312_7, var_312_7, var_312_7)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_6 and arg_309_1.time_ < 0 + var_312_6 + arg_312_0 and not isNil(var_312_5) and arg_309_1.var_.actorSpriteComps1056 then
				for iter_312_7, iter_312_8 in pairs(arg_309_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_312_8 then
						iter_312_8.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps1056 = nil
			end

			local var_312_8 = 0
			local var_312_9 = 0.375

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_10 = arg_309_1:GetWordFromCfg(410021076)
				local var_312_11 = arg_309_1:FormatText(var_312_10.content)

				arg_309_1.text_.text = var_312_11

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_13 = 15 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 15)

				if (15 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 15)) > 0 and var_312_9 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_8
					end
				end

				arg_309_1.text_.text = var_312_11
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021076", "story_v_out_410021.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021076", "story_v_out_410021.awb") / 1000

					if var_312_14 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_8
					end

					if var_312_10.prefab_name ~= "" and arg_309_1.actors_[var_312_10.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_10.prefab_name].transform, "story_v_out_410021", "410021076", "story_v_out_410021.awb")

						arg_309_1:RecordAudio("410021076", var_312_15)
						arg_309_1:RecordAudio("410021076", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410021", "410021076", "story_v_out_410021.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410021", "410021076", "story_v_out_410021.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_9, arg_309_1.talkMaxDuration)

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_8) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_8 + var_312_16 and arg_309_1.time_ < var_312_8 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play410021077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410021077
		arg_313_1.duration_ = 8.97

		local var_313_0 = {
			zh = 8.9,
			ja = 8.966
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
				arg_313_0:Play410021078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1056 = arg_313_1.actors_["1056"].transform.localPosition
				arg_313_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1056", 4)

				for iter_316_0 = 0, arg_313_1.actors_["1056"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["1056"].transform:GetChild(iter_316_0)

					if var_316_0.name == "split_3" or not string.find(var_316_0.name, "split") then
						var_316_0.gameObject:SetActive(true)
					else
						var_316_0.gameObject:SetActive(false)
					end
				end
			end

			local var_316_1 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 then
				arg_313_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_313_1.time_ - 0) / var_316_1)
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 then
				arg_313_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_316_2 = arg_313_1.actors_["1056"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps1056 == nil then
				arg_313_1.var_.actorSpriteComps1056 = var_316_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_3 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.actorSpriteComps1056 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps1056 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_316_4 then
						iter_316_4.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps1056 = nil
			end

			local var_316_5 = arg_313_1.actors_["1060"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.actorSpriteComps1060 == nil then
				arg_313_1.var_.actorSpriteComps1060 = var_316_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_6 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.actorSpriteComps1060 then
					for iter_316_5, iter_316_6 in pairs(arg_313_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_316_6 then
							if arg_313_1.isInRecall_ then
								iter_316_6.color = Color.New(Mathf.Lerp(iter_316_6.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_6), Mathf.Lerp(iter_316_6.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_6), (Mathf.Lerp(iter_316_6.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_6)))
							else
								local var_316_7 = Mathf.Lerp(iter_316_6.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_6)

								iter_316_6.color = Color.New(var_316_7, var_316_7, var_316_7)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.actorSpriteComps1060 then
				for iter_316_7, iter_316_8 in pairs(arg_313_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_316_8 then
						iter_316_8.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1060 = nil
			end

			local var_316_8 = 0
			local var_316_9 = 1.175

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(410021077)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 47 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 47)

				if (47 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 47)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021077", "story_v_out_410021.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021077", "story_v_out_410021.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_410021", "410021077", "story_v_out_410021.awb")

						arg_313_1:RecordAudio("410021077", var_316_15)
						arg_313_1:RecordAudio("410021077", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410021", "410021077", "story_v_out_410021.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410021", "410021077", "story_v_out_410021.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410021078
		arg_317_1.duration_ = 5.8

		local var_317_0 = {
			zh = 4.966,
			ja = 5.8
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
				arg_317_0:Play410021079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1056 = arg_317_1.actors_["1056"].transform.localPosition
				arg_317_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1056", 4)

				for iter_320_0 = 0, arg_317_1.actors_["1056"].transform.childCount - 1 do
					local var_320_0 = arg_317_1.actors_["1056"].transform:GetChild(iter_320_0)

					if var_320_0.name == "split_3" or not string.find(var_320_0.name, "split") then
						var_320_0.gameObject:SetActive(true)
					else
						var_320_0.gameObject:SetActive(false)
					end
				end
			end

			local var_320_1 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 then
				arg_317_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_317_1.time_ - 0) / var_320_1)
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 then
				arg_317_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_320_2 = arg_317_1.actors_["1056"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps1056 == nil then
				arg_317_1.var_.actorSpriteComps1056 = var_320_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_3 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.actorSpriteComps1056 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								iter_320_2.color = Color.New(Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_3), Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_3), (Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_3)))
							else
								local var_320_4 = Mathf.Lerp(iter_320_2.color.r, 1, (arg_317_1.time_ - 0) / var_320_3)

								iter_320_2.color = Color.New(var_320_4, var_320_4, var_320_4)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps1056 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_320_4 then
						iter_320_4.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps1056 = nil
			end

			local var_320_5 = 0
			local var_320_6 = 0.675

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_7 = arg_317_1:GetWordFromCfg(410021078)
				local var_320_8 = arg_317_1:FormatText(var_320_7.content)

				arg_317_1.text_.text = var_320_8

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 27 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 27)

				if (27 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 27)) > 0 and var_320_6 < var_320_10 then
					arg_317_1.talkMaxDuration = var_320_10

					if var_320_10 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_5
					end
				end

				arg_317_1.text_.text = var_320_8
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021078", "story_v_out_410021.awb") ~= 0 then
					local var_320_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021078", "story_v_out_410021.awb") / 1000

					if var_320_11 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_5
					end

					if var_320_7.prefab_name ~= "" and arg_317_1.actors_[var_320_7.prefab_name] ~= nil then
						local var_320_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_7.prefab_name].transform, "story_v_out_410021", "410021078", "story_v_out_410021.awb")

						arg_317_1:RecordAudio("410021078", var_320_12)
						arg_317_1:RecordAudio("410021078", var_320_12)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410021", "410021078", "story_v_out_410021.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410021", "410021078", "story_v_out_410021.awb")
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
				actorName = "1056",
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
	Play410021079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410021079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play410021080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1056"]) and arg_321_1.var_.actorSpriteComps1056 == nil then
				arg_321_1.var_.actorSpriteComps1056 = arg_321_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1056"]) then
				if arg_321_1.var_.actorSpriteComps1056 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 0.5, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1056"]) and arg_321_1.var_.actorSpriteComps1056 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps1056 = nil
			end

			local var_324_2 = 0
			local var_324_3 = 0.625

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(410021079).content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_6 = 25 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_4) / 25)

				if (25 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_4) / 25)) > 0 and var_324_3 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_7 and arg_321_1.time_ < var_324_2 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play410021080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410021080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play410021081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 1.575

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(410021080).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 63 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 63)

				if (63 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 63)) > 0 and var_328_0 < var_328_3 then
					arg_325_1.talkMaxDuration = var_328_3

					if var_328_3 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_3 + 0
					end
				end

				arg_325_1.text_.text = var_328_1
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_4 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_4

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play410021081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410021081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play410021082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 1.675

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(410021081).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 67 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 67)

				if (67 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 67)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play410021082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410021082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play410021083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 1.625

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(410021082).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 65 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 65)

				if (65 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 65)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play410021083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410021083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play410021084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.825

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(410021083).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 33 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 33)

				if (33 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 33)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play410021084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 410021084
		arg_341_1.duration_ = 11.5

		local var_341_0 = {
			zh = 4.133,
			ja = 11.5
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
				arg_341_0:Play410021085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1060 = arg_341_1.actors_["1060"].transform.localPosition
				arg_341_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1060", 2)

				for iter_344_0 = 0, arg_341_1.actors_["1060"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["1060"].transform:GetChild(iter_344_0)

					if var_344_0.name == "" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_344_2 = arg_341_1.actors_["1060"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps1060 == nil then
				arg_341_1.var_.actorSpriteComps1060 = var_344_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_3 = 0.034

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.actorSpriteComps1060 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								iter_344_2.color = Color.New(Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_3), Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_3), (Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_3)))
							else
								local var_344_4 = Mathf.Lerp(iter_344_2.color.r, 1, (arg_341_1.time_ - 0) / var_344_3)

								iter_344_2.color = Color.New(var_344_4, var_344_4, var_344_4)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps1060 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_344_4 then
						iter_344_4.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps1060 = nil
			end

			local var_344_5 = 0
			local var_344_6 = 0.375

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_7 = arg_341_1:GetWordFromCfg(410021084)
				local var_344_8 = arg_341_1:FormatText(var_344_7.content)

				arg_341_1.text_.text = var_344_8

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_10 = 15 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_8) / 15)

				if (15 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_8) / 15)) > 0 and var_344_6 < var_344_10 then
					arg_341_1.talkMaxDuration = var_344_10

					if var_344_10 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_5
					end
				end

				arg_341_1.text_.text = var_344_8
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021084", "story_v_out_410021.awb") ~= 0 then
					local var_344_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021084", "story_v_out_410021.awb") / 1000

					if var_344_11 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_11 + var_344_5
					end

					if var_344_7.prefab_name ~= "" and arg_341_1.actors_[var_344_7.prefab_name] ~= nil then
						local var_344_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_7.prefab_name].transform, "story_v_out_410021", "410021084", "story_v_out_410021.awb")

						arg_341_1:RecordAudio("410021084", var_344_12)
						arg_341_1:RecordAudio("410021084", var_344_12)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_410021", "410021084", "story_v_out_410021.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_410021", "410021084", "story_v_out_410021.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_13 = math.max(var_344_6, arg_341_1.talkMaxDuration)

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_13 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_5) / var_344_13

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_5 + var_344_13 and arg_341_1.time_ < var_344_5 + var_344_13 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play410021085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 410021085
		arg_345_1.duration_ = 6.03

		local var_345_0 = {
			zh = 3,
			ja = 6.033
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
				arg_345_0:Play410021086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1056 = arg_345_1.actors_["1056"].transform.localPosition
				arg_345_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1056", 4)

				for iter_348_0 = 0, arg_345_1.actors_["1056"].transform.childCount - 1 do
					local var_348_0 = arg_345_1.actors_["1056"].transform:GetChild(iter_348_0)

					if var_348_0.name == "split_4" or not string.find(var_348_0.name, "split") then
						var_348_0.gameObject:SetActive(true)
					else
						var_348_0.gameObject:SetActive(false)
					end
				end
			end

			local var_348_1 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				arg_345_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_345_1.time_ - 0) / var_348_1)
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 then
				arg_345_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_348_2 = arg_345_1.actors_["1056"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1056 == nil then
				arg_345_1.var_.actorSpriteComps1056 = var_348_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_3 = 0.034

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.actorSpriteComps1056 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1056 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_348_4 then
						iter_348_4.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps1056 = nil
			end

			local var_348_5 = arg_345_1.actors_["1060"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.actorSpriteComps1060 == nil then
				arg_345_1.var_.actorSpriteComps1060 = var_348_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_6 = 0.034

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 and not isNil(var_348_5) then
				if arg_345_1.var_.actorSpriteComps1060 then
					for iter_348_5, iter_348_6 in pairs(arg_345_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_348_6 then
							if arg_345_1.isInRecall_ then
								iter_348_6.color = Color.New(Mathf.Lerp(iter_348_6.color.r, arg_345_1.hightColor2.r, (arg_345_1.time_ - 0) / var_348_6), Mathf.Lerp(iter_348_6.color.g, arg_345_1.hightColor2.g, (arg_345_1.time_ - 0) / var_348_6), (Mathf.Lerp(iter_348_6.color.b, arg_345_1.hightColor2.b, (arg_345_1.time_ - 0) / var_348_6)))
							else
								local var_348_7 = Mathf.Lerp(iter_348_6.color.r, 0.5, (arg_345_1.time_ - 0) / var_348_6)

								iter_348_6.color = Color.New(var_348_7, var_348_7, var_348_7)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.actorSpriteComps1060 then
				for iter_348_7, iter_348_8 in pairs(arg_345_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_348_8 then
						iter_348_8.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_345_1.var_.actorSpriteComps1060 = nil
			end

			local var_348_8 = 0
			local var_348_9 = 0.3

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_10 = arg_345_1:GetWordFromCfg(410021085)
				local var_348_11 = arg_345_1:FormatText(var_348_10.content)

				arg_345_1.text_.text = var_348_11

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_13 = 12 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 12)

				if (12 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 12)) > 0 and var_348_9 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_11
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021085", "story_v_out_410021.awb") ~= 0 then
					local var_348_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021085", "story_v_out_410021.awb") / 1000

					if var_348_14 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_8
					end

					if var_348_10.prefab_name ~= "" and arg_345_1.actors_[var_348_10.prefab_name] ~= nil then
						local var_348_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_10.prefab_name].transform, "story_v_out_410021", "410021085", "story_v_out_410021.awb")

						arg_345_1:RecordAudio("410021085", var_348_15)
						arg_345_1:RecordAudio("410021085", var_348_15)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_410021", "410021085", "story_v_out_410021.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_410021", "410021085", "story_v_out_410021.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_8) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_8 + var_348_16 and arg_345_1.time_ < var_348_8 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 410021086
		arg_349_1.duration_ = 8.4

		local var_349_0 = {
			zh = 4.866,
			ja = 8.4
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play410021087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1060 = arg_349_1.actors_["1060"].transform.localPosition
				arg_349_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("1060", 2)

				for iter_352_0 = 0, arg_349_1.actors_["1060"].transform.childCount - 1 do
					local var_352_0 = arg_349_1.actors_["1060"].transform:GetChild(iter_352_0)

					if var_352_0.name == "" or not string.find(var_352_0.name, "split") then
						var_352_0.gameObject:SetActive(true)
					else
						var_352_0.gameObject:SetActive(false)
					end
				end
			end

			local var_352_1 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 then
				arg_349_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_349_1.time_ - 0) / var_352_1)
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 then
				arg_349_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_352_2 = arg_349_1.actors_["1060"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps1060 == nil then
				arg_349_1.var_.actorSpriteComps1060 = var_352_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_3 = 0.034

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.actorSpriteComps1060 then
					for iter_352_1, iter_352_2 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_352_2 then
							if arg_349_1.isInRecall_ then
								iter_352_2.color = Color.New(Mathf.Lerp(iter_352_2.color.r, arg_349_1.hightColor1.r, (arg_349_1.time_ - 0) / var_352_3), Mathf.Lerp(iter_352_2.color.g, arg_349_1.hightColor1.g, (arg_349_1.time_ - 0) / var_352_3), (Mathf.Lerp(iter_352_2.color.b, arg_349_1.hightColor1.b, (arg_349_1.time_ - 0) / var_352_3)))
							else
								local var_352_4 = Mathf.Lerp(iter_352_2.color.r, 1, (arg_349_1.time_ - 0) / var_352_3)

								iter_352_2.color = Color.New(var_352_4, var_352_4, var_352_4)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps1060 then
				for iter_352_3, iter_352_4 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_352_4 then
						iter_352_4.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_349_1.var_.actorSpriteComps1060 = nil
			end

			local var_352_5 = arg_349_1.actors_["1056"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.actorSpriteComps1056 == nil then
				arg_349_1.var_.actorSpriteComps1056 = var_352_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_6 = 0.034

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.actorSpriteComps1056 then
					for iter_352_5, iter_352_6 in pairs(arg_349_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_352_6 then
							if arg_349_1.isInRecall_ then
								iter_352_6.color = Color.New(Mathf.Lerp(iter_352_6.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_6), Mathf.Lerp(iter_352_6.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_6), (Mathf.Lerp(iter_352_6.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_6)))
							else
								local var_352_7 = Mathf.Lerp(iter_352_6.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_6)

								iter_352_6.color = Color.New(var_352_7, var_352_7, var_352_7)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_6 and arg_349_1.time_ < 0 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.actorSpriteComps1056 then
				for iter_352_7, iter_352_8 in pairs(arg_349_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_352_8 then
						iter_352_8.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps1056 = nil
			end

			local var_352_8 = 0
			local var_352_9 = 0.55

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(410021086)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_13 = 22 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 22)

				if (22 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 22)) > 0 and var_352_9 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021086", "story_v_out_410021.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021086", "story_v_out_410021.awb") / 1000

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end

					if var_352_10.prefab_name ~= "" and arg_349_1.actors_[var_352_10.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_10.prefab_name].transform, "story_v_out_410021", "410021086", "story_v_out_410021.awb")

						arg_349_1:RecordAudio("410021086", var_352_15)
						arg_349_1:RecordAudio("410021086", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_410021", "410021086", "story_v_out_410021.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_410021", "410021086", "story_v_out_410021.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_16 and arg_349_1.time_ < var_352_8 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play410021087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 410021087
		arg_353_1.duration_ = 6.1

		local var_353_0 = {
			zh = 2.633,
			ja = 6.1
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
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play410021088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1056 = arg_353_1.actors_["1056"].transform.localPosition
				arg_353_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1056", 4)

				for iter_356_0 = 0, arg_353_1.actors_["1056"].transform.childCount - 1 do
					local var_356_0 = arg_353_1.actors_["1056"].transform:GetChild(iter_356_0)

					if var_356_0.name == "split_4" or not string.find(var_356_0.name, "split") then
						var_356_0.gameObject:SetActive(true)
					else
						var_356_0.gameObject:SetActive(false)
					end
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_353_1.time_ - 0) / var_356_1)
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_356_2 = arg_353_1.actors_["1056"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1056 == nil then
				arg_353_1.var_.actorSpriteComps1056 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.034

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps1056 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1056 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_356_4 then
						iter_356_4.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps1056 = nil
			end

			local var_356_5 = arg_353_1.actors_["1060"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_5) and arg_353_1.var_.actorSpriteComps1060 == nil then
				arg_353_1.var_.actorSpriteComps1060 = var_356_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_6 = 0.034

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_6 and not isNil(var_356_5) then
				if arg_353_1.var_.actorSpriteComps1060 then
					for iter_356_5, iter_356_6 in pairs(arg_353_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_356_6 then
							if arg_353_1.isInRecall_ then
								iter_356_6.color = Color.New(Mathf.Lerp(iter_356_6.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_6), Mathf.Lerp(iter_356_6.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_6), (Mathf.Lerp(iter_356_6.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_6)))
							else
								local var_356_7 = Mathf.Lerp(iter_356_6.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_6)

								iter_356_6.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_6 and arg_353_1.time_ < 0 + var_356_6 + arg_356_0 and not isNil(var_356_5) and arg_353_1.var_.actorSpriteComps1060 then
				for iter_356_7, iter_356_8 in pairs(arg_353_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_356_8 then
						iter_356_8.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps1060 = nil
			end

			local var_356_8 = 0
			local var_356_9 = 0.4

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(410021087)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 16 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 16)

				if (16 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 16)) > 0 and var_356_9 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021087", "story_v_out_410021.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021087", "story_v_out_410021.awb") / 1000

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_410021", "410021087", "story_v_out_410021.awb")

						arg_353_1:RecordAudio("410021087", var_356_15)
						arg_353_1:RecordAudio("410021087", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_410021", "410021087", "story_v_out_410021.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_410021", "410021087", "story_v_out_410021.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_16 and arg_353_1.time_ < var_356_8 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410021088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 410021088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play410021089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1056"]) and arg_357_1.var_.actorSpriteComps1056 == nil then
				arg_357_1.var_.actorSpriteComps1056 = arg_357_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.034

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1056"]) then
				if arg_357_1.var_.actorSpriteComps1056 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1056"]) and arg_357_1.var_.actorSpriteComps1056 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps1056 = nil
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:AudioAction("play", "effect", "se_story_128", "se_story_128_projection", "")
			end

			local var_360_3 = 0
			local var_360_4 = 1.95

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_5 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(410021088).content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 78 <= 0 and var_360_4 or var_360_4 * (utf8.len(var_360_5) / 78)

				if (78 <= 0 and var_360_4 or var_360_4 * (utf8.len(var_360_5) / 78)) > 0 and var_360_4 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_3 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_3
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_4, arg_357_1.talkMaxDuration)

			if var_360_3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_3 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_3) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_3 + var_360_8 and arg_357_1.time_ < var_360_3 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play410021089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 410021089
		arg_361_1.duration_ = 9.93

		local var_361_0 = {
			zh = 7.466,
			ja = 9.933
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play410021090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1060 = arg_361_1.actors_["1060"].transform.localPosition
				arg_361_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1060", 2)

				for iter_364_0 = 0, arg_361_1.actors_["1060"].transform.childCount - 1 do
					local var_364_0 = arg_361_1.actors_["1060"].transform:GetChild(iter_364_0)

					if var_364_0.name == "" or not string.find(var_364_0.name, "split") then
						var_364_0.gameObject:SetActive(true)
					else
						var_364_0.gameObject:SetActive(false)
					end
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_361_1.time_ - 0) / var_364_1)
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_364_2 = arg_361_1.actors_["1060"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps1060 == nil then
				arg_361_1.var_.actorSpriteComps1060 = var_364_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_3 = 0.034

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.actorSpriteComps1060 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								iter_364_2.color = Color.New(Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_3), Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_3), (Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_3)))
							else
								local var_364_4 = Mathf.Lerp(iter_364_2.color.r, 1, (arg_361_1.time_ - 0) / var_364_3)

								iter_364_2.color = Color.New(var_364_4, var_364_4, var_364_4)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps1060 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_364_4 then
						iter_364_4.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps1060 = nil
			end

			local var_364_5 = 0
			local var_364_6 = 0.7

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:GetWordFromCfg(410021089)
				local var_364_8 = arg_361_1:FormatText(var_364_7.content)

				arg_361_1.text_.text = var_364_8

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 28 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 28)

				if (28 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 28)) > 0 and var_364_6 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_8
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021089", "story_v_out_410021.awb") ~= 0 then
					local var_364_11 = manager.audio:GetVoiceLength("story_v_out_410021", "410021089", "story_v_out_410021.awb") / 1000

					if var_364_11 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_11 + var_364_5
					end

					if var_364_7.prefab_name ~= "" and arg_361_1.actors_[var_364_7.prefab_name] ~= nil then
						local var_364_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_7.prefab_name].transform, "story_v_out_410021", "410021089", "story_v_out_410021.awb")

						arg_361_1:RecordAudio("410021089", var_364_12)
						arg_361_1:RecordAudio("410021089", var_364_12)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_410021", "410021089", "story_v_out_410021.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_410021", "410021089", "story_v_out_410021.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_13 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_13 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_13

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_13 and arg_361_1.time_ < var_364_5 + var_364_13 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play410021090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 410021090
		arg_365_1.duration_ = 5.37

		local var_365_0 = {
			zh = 3.833,
			ja = 5.366
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
			arg_365_1.auto_ = false
		end

		function arg_365_1.playNext_(arg_367_0)
			arg_365_1.onStoryFinished_()
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1056 = arg_365_1.actors_["1056"].transform.localPosition
				arg_365_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1056", 4)

				for iter_368_0 = 0, arg_365_1.actors_["1056"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["1056"].transform:GetChild(iter_368_0)

					if var_368_0.name == "split_2" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_368_2 = arg_365_1.actors_["1056"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1056 == nil then
				arg_365_1.var_.actorSpriteComps1056 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 0.034

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps1056 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								iter_368_2.color = Color.New(Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, (arg_365_1.time_ - 0) / var_368_3), Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, (arg_365_1.time_ - 0) / var_368_3), (Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, (arg_365_1.time_ - 0) / var_368_3)))
							else
								local var_368_4 = Mathf.Lerp(iter_368_2.color.r, 1, (arg_365_1.time_ - 0) / var_368_3)

								iter_368_2.color = Color.New(var_368_4, var_368_4, var_368_4)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1056 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_368_4 then
						iter_368_4.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps1056 = nil
			end

			local var_368_5 = arg_365_1.actors_["1060"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps1060 == nil then
				arg_365_1.var_.actorSpriteComps1060 = var_368_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_6 = 0.034

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_6 and not isNil(var_368_5) then
				if arg_365_1.var_.actorSpriteComps1060 then
					for iter_368_5, iter_368_6 in pairs(arg_365_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_368_6 then
							if arg_365_1.isInRecall_ then
								iter_368_6.color = Color.New(Mathf.Lerp(iter_368_6.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_6), Mathf.Lerp(iter_368_6.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_6), (Mathf.Lerp(iter_368_6.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_6)))
							else
								local var_368_7 = Mathf.Lerp(iter_368_6.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_6)

								iter_368_6.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_6 and arg_365_1.time_ < 0 + var_368_6 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps1060 then
				for iter_368_7, iter_368_8 in pairs(arg_365_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_368_8 then
						iter_368_8.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps1060 = nil
			end

			local var_368_8 = 0
			local var_368_9 = 0.375

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:GetWordFromCfg(410021090)
				local var_368_11 = arg_365_1:FormatText(var_368_10.content)

				arg_365_1.text_.text = var_368_11

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_13 = 15 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 15)

				if (15 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 15)) > 0 and var_368_9 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_11
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410021", "410021090", "story_v_out_410021.awb") ~= 0 then
					local var_368_14 = manager.audio:GetVoiceLength("story_v_out_410021", "410021090", "story_v_out_410021.awb") / 1000

					if var_368_14 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_8
					end

					if var_368_10.prefab_name ~= "" and arg_365_1.actors_[var_368_10.prefab_name] ~= nil then
						local var_368_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_10.prefab_name].transform, "story_v_out_410021", "410021090", "story_v_out_410021.awb")

						arg_365_1:RecordAudio("410021090", var_368_15)
						arg_365_1:RecordAudio("410021090", var_368_15)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_410021", "410021090", "story_v_out_410021.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_410021", "410021090", "story_v_out_410021.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_16 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_16 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_16

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_16 and arg_365_1.time_ < var_368_8 + var_368_16 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST61"
	},
	voices = {
		"story_v_out_410021.awb"
	}
}
