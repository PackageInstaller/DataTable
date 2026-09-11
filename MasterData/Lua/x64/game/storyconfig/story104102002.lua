return {
	Play410202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410202001
		arg_1_1.duration_ = 6.97

		local var_1_0 = {
			ja = 6.966,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_1_0:Play410202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L04f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L04f")
				var_4_0.name = "L04f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L04f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L04f

				arg_1_1.bgs_.L04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L04f" then
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

			local var_4_8 = "10059"

			if arg_1_1.actors_["10059"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

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

			local var_4_11 = arg_1_1.actors_["10059"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10059 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10059", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "split_3" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -530, 35)
			end

			local var_4_14 = arg_1_1.actors_["10059"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10059 == nil then
				arg_1_1.var_.actorSpriteComps10059 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps10059 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10059 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10059 = nil
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
			local var_4_24 = 0.35

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(410202001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 14 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 14)

				if (14 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 14)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202001", "story_v_out_410202.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_410202", "410202001", "story_v_out_410202.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_410202", "410202001", "story_v_out_410202.awb")

						arg_1_1:RecordAudio("410202001", var_4_31)
						arg_1_1:RecordAudio("410202001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410202", "410202001", "story_v_out_410202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410202", "410202001", "story_v_out_410202.awb")
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
				actorName = "10059",
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
	Play410202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410202002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10059 = arg_9_1.actors_["10059"].transform.localPosition
				arg_9_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10059", 7)

				for iter_12_0 = 0, arg_9_1.actors_["10059"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10059"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_12_2 = arg_9_1.actors_["10059"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10059 == nil then
				arg_9_1.var_.actorSpriteComps10059 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10059 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10059 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_12_4 then
						iter_12_4.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10059 = nil
			end

			local var_12_5 = 0
			local var_12_6 = 1.075

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

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(410202002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 43 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 43)

				if (43 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 43)) > 0 and var_12_6 < var_12_9 then
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
				actorName = "10059",
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
	Play410202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410202003
		arg_13_1.duration_ = 11.1

		local var_13_0 = {
			ja = 1.1,
			CriLanguages = 11.1,
			zh = 11.1
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
				arg_13_0:Play410202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1061"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "1061"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["1061"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["1061"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 3)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_16_5 = arg_13_1.actors_["1061"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_4.color.r, 1, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_4.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.05

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(410202003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 2 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 2)

				if (2 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 2)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202003", "story_v_out_410202.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_410202", "410202003", "story_v_out_410202.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_410202", "410202003", "story_v_out_410202.awb")

						arg_13_1:RecordAudio("410202003", var_16_15)
						arg_13_1:RecordAudio("410202003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410202", "410202003", "story_v_out_410202.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410202", "410202003", "story_v_out_410202.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play410202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410202004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061 = arg_17_1.actors_["1061"].transform.localPosition
				arg_17_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1061", 7)

				for iter_20_0 = 0, arg_17_1.actors_["1061"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["1061"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_20_2 = 0
			local var_20_3 = 1.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(410202004).content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 57 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 57)

				if (57 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 57)) > 0 and var_20_3 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_7 and arg_17_1.time_ < var_20_2 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play410202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410202005
		arg_21_1.duration_ = 11.97

		local var_21_0 = {
			ja = 11.966,
			CriLanguages = 6.2,
			zh = 6.2
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
				arg_21_0:Play410202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = arg_21_1.actors_["1061"].transform.localPosition
				arg_21_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 3)

				for iter_24_0 = 0, arg_21_1.actors_["1061"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["1061"].transform:GetChild(iter_24_0)

					if var_24_0.name == "split_7" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_24_2 = arg_21_1.actors_["1061"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								iter_24_2.color = Color.New(Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_2.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_2.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(410202005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 22 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 22)

				if (22 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 22)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202005", "story_v_out_410202.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202005", "story_v_out_410202.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_410202", "410202005", "story_v_out_410202.awb")

						arg_21_1:RecordAudio("410202005", var_24_12)
						arg_21_1:RecordAudio("410202005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410202", "410202005", "story_v_out_410202.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410202", "410202005", "story_v_out_410202.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
	Play410202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410202006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1061"]) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = arg_25_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1061"]) then
				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1061"]) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_2 = 0
			local var_28_3 = 0.5

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(410202006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 20 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 20)

				if (20 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 20)) > 0 and var_28_3 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_7 and arg_25_1.time_ < var_28_2 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play410202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410202007
		arg_29_1.duration_ = 7.17

		local var_29_0 = {
			ja = 7.166,
			CriLanguages = 4.366,
			zh = 4.366
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
				arg_29_0:Play410202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = arg_29_1.actors_["1061"].transform.localPosition
				arg_29_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 3)

				for iter_32_0 = 0, arg_29_1.actors_["1061"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1061"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_7" or not string.find(var_32_0.name, "split") then
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

				local var_32_7 = arg_29_1:GetWordFromCfg(410202007)
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

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202007", "story_v_out_410202.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202007", "story_v_out_410202.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_410202", "410202007", "story_v_out_410202.awb")

						arg_29_1:RecordAudio("410202007", var_32_12)
						arg_29_1:RecordAudio("410202007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410202", "410202007", "story_v_out_410202.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410202", "410202007", "story_v_out_410202.awb")
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
	Play410202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410202008
		arg_33_1.duration_ = 10.47

		local var_33_0 = {
			ja = 8.766,
			CriLanguages = 10.466,
			zh = 10.466
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
				arg_33_0:Play410202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = arg_33_1.actors_["1061"].transform.localPosition
				arg_33_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 3)

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
				arg_33_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
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
			local var_36_6 = 0.8

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

				local var_36_7 = arg_33_1:GetWordFromCfg(410202008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 32 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 32)

				if (32 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 32)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202008", "story_v_out_410202.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202008", "story_v_out_410202.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410202", "410202008", "story_v_out_410202.awb")

						arg_33_1:RecordAudio("410202008", var_36_12)
						arg_33_1:RecordAudio("410202008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410202", "410202008", "story_v_out_410202.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410202", "410202008", "story_v_out_410202.awb")
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
	Play410202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410202009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = arg_37_1.actors_["1061"].transform.localPosition
				arg_37_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 7)

				for iter_40_0 = 0, arg_37_1.actors_["1061"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1061"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_40_2 = arg_37_1.actors_["1061"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								iter_40_2.color = Color.New(Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_2.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_2.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 1.225

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(410202009).content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 49 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_7) / 49)

				if (49 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_7) / 49)) > 0 and var_40_6 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_10 and arg_37_1.time_ < var_40_5 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play410202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410202010
		arg_41_1.duration_ = 7.5

		local var_41_0 = {
			ja = 7.5,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_41_0:Play410202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.STblack == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_44_0.name = "STblack"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.STblack = var_44_0
			end

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= 2 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.STblack

				arg_41_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "STblack" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_5 = 2

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_5 then
				local var_44_6 = Color.New(0, 0, 0)

				var_44_6.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_4) / var_44_5)
				arg_41_1.mask_.color = var_44_6
			end

			if arg_41_1.time_ >= var_44_4 + var_44_5 and arg_41_1.time_ < var_44_4 + var_44_5 + arg_44_0 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = 1
				arg_41_1.mask_.color = var_44_7
			end

			local var_44_8 = 2

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_9 = 2

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 then
				local var_44_10 = Color.New(0, 0, 0)

				var_44_10.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_8) / var_44_9)
				arg_41_1.mask_.color = var_44_10
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 then
				local var_44_11 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_11.a = 0
				arg_41_1.mask_.color = var_44_11
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_knock", "")
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_13 = 4
			local var_44_14 = 0.175

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_15 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_15:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(410202010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 7 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_17) / 7)

				if (7 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_17) / 7)) > 0 and var_44_14 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19
					var_44_13 = var_44_13 + 0.3

					if var_44_19 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_13
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202010", "story_v_out_410202.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_410202", "410202010", "story_v_out_410202.awb") / 1000

					if var_44_20 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_13
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_410202", "410202010", "story_v_out_410202.awb")

						arg_41_1:RecordAudio("410202010", var_44_21)
						arg_41_1:RecordAudio("410202010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410202", "410202010", "story_v_out_410202.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410202", "410202010", "story_v_out_410202.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = var_44_13 + 0.3
			local var_44_23 = math.max(var_44_14, arg_41_1.talkMaxDuration)

			if var_44_13 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_22 + var_44_23 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_22) / var_44_23

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_22 + var_44_23 and arg_41_1.time_ < var_44_22 + var_44_23 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play410202011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 410202011
		arg_47_1.duration_ = 3.4

		local var_47_0 = {
			ja = 3.4,
			CriLanguages = 3.066,
			zh = 3.066
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play410202012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.15

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(410202011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 6 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 6)

				if (6 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 6)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202011", "story_v_out_410202.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202011", "story_v_out_410202.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_410202", "410202011", "story_v_out_410202.awb")

						arg_47_1:RecordAudio("410202011", var_50_6)
						arg_47_1:RecordAudio("410202011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_410202", "410202011", "story_v_out_410202.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_410202", "410202011", "story_v_out_410202.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play410202012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 410202012
		arg_51_1.duration_ = 7

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play410202013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.bgs_.LZ0204 == nil then
				local var_54_0 = Object.Instantiate(arg_51_1.paintGo_)

				var_54_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LZ0204")
				var_54_0.name = "LZ0204"
				var_54_0.transform.parent = arg_51_1.stage_.transform
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_.LZ0204 = var_54_0
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				local var_54_1 = arg_51_1.bgs_.LZ0204

				arg_51_1.bgs_.LZ0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_54_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_2 = var_54_1:GetComponent("SpriteRenderer")

				if var_54_2 and var_54_2.sprite then
					local var_54_3 = 2 * (var_54_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_54_1.transform.localScale = Vector3.New(var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, 0)
				end

				for iter_54_0, iter_54_1 in pairs(arg_51_1.bgs_) do
					if iter_54_0 ~= "LZ0204" then
						iter_54_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_54_4 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_5 = 2

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_5 then
				local var_54_6 = Color.New(0, 0, 0)

				var_54_6.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_4) / var_54_5)
				arg_51_1.mask_.color = var_54_6
			end

			if arg_51_1.time_ >= var_54_4 + var_54_5 and arg_51_1.time_ < var_54_4 + var_54_5 + arg_54_0 then
				local var_54_7 = Color.New(0, 0, 0)

				arg_51_1.mask_.enabled = false
				var_54_7.a = 0
				arg_51_1.mask_.color = var_54_7
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_8 = 2
			local var_54_9 = 0.95

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_10 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_10:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_11 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(410202012).content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 38 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 38)

				if (38 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 38)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13
					var_54_8 = var_54_8 + 0.3

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = var_54_8 + 0.3
			local var_54_15 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_14 + var_54_15 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_14) / var_54_15

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_14 + var_54_15 and arg_51_1.time_ < var_54_14 + var_54_15 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play410202013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410202013
		arg_57_1.duration_ = 11.7

		local var_57_0 = {
			ja = 11.7,
			CriLanguages = 9.1,
			zh = 9.1
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
				arg_57_0:Play410202014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
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

				local var_60_1 = arg_57_1:GetWordFromCfg(410202013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 23 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 23)

				if (23 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 23)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202013", "story_v_out_410202.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202013", "story_v_out_410202.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_410202", "410202013", "story_v_out_410202.awb")

						arg_57_1:RecordAudio("410202013", var_60_6)
						arg_57_1:RecordAudio("410202013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410202", "410202013", "story_v_out_410202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410202", "410202013", "story_v_out_410202.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410202014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410202014
		arg_61_1.duration_ = 10.3

		local var_61_0 = {
			ja = 10.3,
			CriLanguages = 6.7,
			zh = 6.7
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
				arg_61_0:Play410202015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.625

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(410202014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 25 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 25)

				if (25 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 25)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202014", "story_v_out_410202.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202014", "story_v_out_410202.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_410202", "410202014", "story_v_out_410202.awb")

						arg_61_1:RecordAudio("410202014", var_64_6)
						arg_61_1:RecordAudio("410202014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410202", "410202014", "story_v_out_410202.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410202", "410202014", "story_v_out_410202.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play410202015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410202015
		arg_65_1.duration_ = 11.97

		local var_65_0 = {
			ja = 11.966,
			CriLanguages = 6.566,
			zh = 6.566
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
				arg_65_0:Play410202016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.65

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(410202015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 26 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 26)

				if (26 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 26)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202015", "story_v_out_410202.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202015", "story_v_out_410202.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_410202", "410202015", "story_v_out_410202.awb")

						arg_65_1:RecordAudio("410202015", var_68_6)
						arg_65_1:RecordAudio("410202015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410202", "410202015", "story_v_out_410202.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410202", "410202015", "story_v_out_410202.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play410202016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410202016
		arg_69_1.duration_ = 9.2

		local var_69_0 = {
			ja = 9.2,
			CriLanguages = 7.4,
			zh = 7.4
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
				arg_69_0:Play410202017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.875

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(410202016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 35 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 35)

				if (35 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 35)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202016", "story_v_out_410202.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202016", "story_v_out_410202.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_410202", "410202016", "story_v_out_410202.awb")

						arg_69_1:RecordAudio("410202016", var_72_6)
						arg_69_1:RecordAudio("410202016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410202", "410202016", "story_v_out_410202.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410202", "410202016", "story_v_out_410202.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410202017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410202017
		arg_73_1.duration_ = 9.27

		local var_73_0 = {
			ja = 9.266,
			CriLanguages = 7.033,
			zh = 7.033
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
				arg_73_0:Play410202018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(410202017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 27 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 27)

				if (27 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 27)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202017", "story_v_out_410202.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202017", "story_v_out_410202.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_410202", "410202017", "story_v_out_410202.awb")

						arg_73_1:RecordAudio("410202017", var_76_6)
						arg_73_1:RecordAudio("410202017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410202", "410202017", "story_v_out_410202.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410202", "410202017", "story_v_out_410202.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410202018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410202018
		arg_77_1.duration_ = 2.73

		local var_77_0 = {
			ja = 2.733,
			CriLanguages = 1.466,
			zh = 1.466
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
				arg_77_0:Play410202019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(410202018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 5 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 5)

				if (5 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 5)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202018", "story_v_out_410202.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202018", "story_v_out_410202.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_410202", "410202018", "story_v_out_410202.awb")

						arg_77_1:RecordAudio("410202018", var_80_6)
						arg_77_1:RecordAudio("410202018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410202", "410202018", "story_v_out_410202.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410202", "410202018", "story_v_out_410202.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play410202019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410202019
		arg_81_1.duration_ = 2.8

		local var_81_0 = {
			ja = 2.8,
			CriLanguages = 1.7,
			zh = 1.7
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
				arg_81_0:Play410202020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.25

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(410202019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 10 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 10)

				if (10 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 10)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202019", "story_v_out_410202.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202019", "story_v_out_410202.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_410202", "410202019", "story_v_out_410202.awb")

						arg_81_1:RecordAudio("410202019", var_84_6)
						arg_81_1:RecordAudio("410202019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410202", "410202019", "story_v_out_410202.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410202", "410202019", "story_v_out_410202.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play410202020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410202020
		arg_85_1.duration_ = 11.97

		local var_85_0 = {
			ja = 11.966,
			CriLanguages = 8.5,
			zh = 8.5
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
				arg_85_0:Play410202021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.825

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(410202020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 33)

				if (33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 33)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202020", "story_v_out_410202.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202020", "story_v_out_410202.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_410202", "410202020", "story_v_out_410202.awb")

						arg_85_1:RecordAudio("410202020", var_88_6)
						arg_85_1:RecordAudio("410202020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410202", "410202020", "story_v_out_410202.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410202", "410202020", "story_v_out_410202.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play410202021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410202021
		arg_89_1.duration_ = 18

		local var_89_0 = {
			ja = 18,
			CriLanguages = 12.333,
			zh = 12.333
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
				arg_89_0:Play410202022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.325

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(410202021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 53 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 53)

				if (53 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 53)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202021", "story_v_out_410202.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202021", "story_v_out_410202.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_410202", "410202021", "story_v_out_410202.awb")

						arg_89_1:RecordAudio("410202021", var_92_6)
						arg_89_1:RecordAudio("410202021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410202", "410202021", "story_v_out_410202.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410202", "410202021", "story_v_out_410202.awb")
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
	Play410202022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410202022
		arg_93_1.duration_ = 7.5

		local var_93_0 = {
			ja = 7.5,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_93_0:Play410202023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.8

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
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

				local var_96_1 = arg_93_1:GetWordFromCfg(410202022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 32 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 32)

				if (32 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 32)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202022", "story_v_out_410202.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202022", "story_v_out_410202.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_410202", "410202022", "story_v_out_410202.awb")

						arg_93_1:RecordAudio("410202022", var_96_6)
						arg_93_1:RecordAudio("410202022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410202", "410202022", "story_v_out_410202.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410202", "410202022", "story_v_out_410202.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play410202023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410202023
		arg_97_1.duration_ = 11.2

		local var_97_0 = {
			ja = 11.2,
			CriLanguages = 8.6,
			zh = 8.6
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
				arg_97_0:Play410202024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(410202023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 40 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 40)

				if (40 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 40)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202023", "story_v_out_410202.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202023", "story_v_out_410202.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_410202", "410202023", "story_v_out_410202.awb")

						arg_97_1:RecordAudio("410202023", var_100_6)
						arg_97_1:RecordAudio("410202023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410202", "410202023", "story_v_out_410202.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410202", "410202023", "story_v_out_410202.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play410202024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410202024
		arg_101_1.duration_ = 5.07

		local var_101_0 = {
			ja = 4.833,
			CriLanguages = 5.066,
			zh = 5.066
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
				arg_101_0:Play410202025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(410202024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 16 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 16)

				if (16 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 16)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202024", "story_v_out_410202.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202024", "story_v_out_410202.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_410202", "410202024", "story_v_out_410202.awb")

						arg_101_1:RecordAudio("410202024", var_104_6)
						arg_101_1:RecordAudio("410202024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410202", "410202024", "story_v_out_410202.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410202", "410202024", "story_v_out_410202.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play410202025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410202025
		arg_105_1.duration_ = 14.77

		local var_105_0 = {
			ja = 14.766,
			CriLanguages = 9.766,
			zh = 9.766
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
				arg_105_0:Play410202026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.075

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(410202025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 43 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 43)

				if (43 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 43)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202025", "story_v_out_410202.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202025", "story_v_out_410202.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_410202", "410202025", "story_v_out_410202.awb")

						arg_105_1:RecordAudio("410202025", var_108_6)
						arg_105_1:RecordAudio("410202025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410202", "410202025", "story_v_out_410202.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410202", "410202025", "story_v_out_410202.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play410202026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410202026
		arg_109_1.duration_ = 18.47

		local var_109_0 = {
			ja = 18.466,
			CriLanguages = 10.333,
			zh = 10.333
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
				arg_109_0:Play410202027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(410202026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 45 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 45)

				if (45 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 45)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202026", "story_v_out_410202.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202026", "story_v_out_410202.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_410202", "410202026", "story_v_out_410202.awb")

						arg_109_1:RecordAudio("410202026", var_112_6)
						arg_109_1:RecordAudio("410202026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410202", "410202026", "story_v_out_410202.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410202", "410202026", "story_v_out_410202.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play410202027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410202027
		arg_113_1.duration_ = 8.93

		local var_113_0 = {
			ja = 6.766,
			CriLanguages = 8.933,
			zh = 8.933
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
				arg_113_0:Play410202028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.025

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
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

				local var_116_1 = arg_113_1:GetWordFromCfg(410202027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 41 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 41)

				if (41 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 41)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202027", "story_v_out_410202.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202027", "story_v_out_410202.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_410202", "410202027", "story_v_out_410202.awb")

						arg_113_1:RecordAudio("410202027", var_116_6)
						arg_113_1:RecordAudio("410202027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410202", "410202027", "story_v_out_410202.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410202", "410202027", "story_v_out_410202.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play410202028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410202028
		arg_117_1.duration_ = 13.07

		local var_117_0 = {
			ja = 12.8,
			CriLanguages = 13.066,
			zh = 13.066
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
				arg_117_0:Play410202029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.475

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(410202028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 59 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 59)

				if (59 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 59)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202028", "story_v_out_410202.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202028", "story_v_out_410202.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_410202", "410202028", "story_v_out_410202.awb")

						arg_117_1:RecordAudio("410202028", var_120_6)
						arg_117_1:RecordAudio("410202028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410202", "410202028", "story_v_out_410202.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410202", "410202028", "story_v_out_410202.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play410202029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410202029
		arg_121_1.duration_ = 12.37

		local var_121_0 = {
			ja = 12.366,
			CriLanguages = 8,
			zh = 8
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
				arg_121_0:Play410202030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.825

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(410202029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 33 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 33)

				if (33 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 33)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202029", "story_v_out_410202.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202029", "story_v_out_410202.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_410202", "410202029", "story_v_out_410202.awb")

						arg_121_1:RecordAudio("410202029", var_124_6)
						arg_121_1:RecordAudio("410202029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410202", "410202029", "story_v_out_410202.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410202", "410202029", "story_v_out_410202.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play410202030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410202030
		arg_125_1.duration_ = 7.57

		local var_125_0 = {
			ja = 5.866,
			CriLanguages = 7.566,
			zh = 7.566
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
				arg_125_0:Play410202031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.725

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(410202030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 29 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 29)

				if (29 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 29)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202030", "story_v_out_410202.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202030", "story_v_out_410202.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_410202", "410202030", "story_v_out_410202.awb")

						arg_125_1:RecordAudio("410202030", var_128_6)
						arg_125_1:RecordAudio("410202030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410202", "410202030", "story_v_out_410202.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410202", "410202030", "story_v_out_410202.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play410202031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410202031
		arg_129_1.duration_ = 14.23

		local var_129_0 = {
			ja = 14.233,
			CriLanguages = 7.033,
			zh = 7.033
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
				arg_129_0:Play410202032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.875

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(410202031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 35 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 35)

				if (35 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 35)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202031", "story_v_out_410202.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202031", "story_v_out_410202.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_410202", "410202031", "story_v_out_410202.awb")

						arg_129_1:RecordAudio("410202031", var_132_6)
						arg_129_1:RecordAudio("410202031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410202", "410202031", "story_v_out_410202.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410202", "410202031", "story_v_out_410202.awb")
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
	Play410202032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410202032
		arg_133_1.duration_ = 2.4

		local var_133_0 = {
			ja = 2.4,
			CriLanguages = 2.166,
			zh = 2.166
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
				arg_133_0:Play410202033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.15

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(410202032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 6 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 6)

				if (6 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 6)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202032", "story_v_out_410202.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202032", "story_v_out_410202.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_410202", "410202032", "story_v_out_410202.awb")

						arg_133_1:RecordAudio("410202032", var_136_6)
						arg_133_1:RecordAudio("410202032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410202", "410202032", "story_v_out_410202.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410202", "410202032", "story_v_out_410202.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play410202033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410202033
		arg_137_1.duration_ = 19.9

		local var_137_0 = {
			ja = 19.9,
			CriLanguages = 10.533,
			zh = 10.533
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
				arg_137_0:Play410202034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.35

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(410202033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 54 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 54)

				if (54 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 54)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202033", "story_v_out_410202.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202033", "story_v_out_410202.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_410202", "410202033", "story_v_out_410202.awb")

						arg_137_1:RecordAudio("410202033", var_140_6)
						arg_137_1:RecordAudio("410202033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410202", "410202033", "story_v_out_410202.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410202", "410202033", "story_v_out_410202.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play410202034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410202034
		arg_141_1.duration_ = 10.53

		local var_141_0 = {
			ja = 10,
			CriLanguages = 10.533,
			zh = 10.533
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
				arg_141_0:Play410202035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(410202034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 43 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 43)

				if (43 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 43)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202034", "story_v_out_410202.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202034", "story_v_out_410202.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_410202", "410202034", "story_v_out_410202.awb")

						arg_141_1:RecordAudio("410202034", var_144_6)
						arg_141_1:RecordAudio("410202034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410202", "410202034", "story_v_out_410202.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410202", "410202034", "story_v_out_410202.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play410202035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410202035
		arg_145_1.duration_ = 5.3

		local var_145_0 = {
			ja = 5.3,
			CriLanguages = 3.466,
			zh = 3.466
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
				arg_145_0:Play410202036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(410202035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)

				if (12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202035", "story_v_out_410202.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202035", "story_v_out_410202.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_410202", "410202035", "story_v_out_410202.awb")

						arg_145_1:RecordAudio("410202035", var_148_6)
						arg_145_1:RecordAudio("410202035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410202", "410202035", "story_v_out_410202.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410202", "410202035", "story_v_out_410202.awb")
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
	Play410202036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410202036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410202037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(410202036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 18 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 18)

				if (18 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 18)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410202037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410202037
		arg_153_1.duration_ = 5.27

		local var_153_0 = {
			ja = 4.1,
			CriLanguages = 5.266,
			zh = 5.266
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
				arg_153_0:Play410202038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(410202037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)

				if (16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202037", "story_v_out_410202.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202037", "story_v_out_410202.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_410202", "410202037", "story_v_out_410202.awb")

						arg_153_1:RecordAudio("410202037", var_156_6)
						arg_153_1:RecordAudio("410202037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410202", "410202037", "story_v_out_410202.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410202", "410202037", "story_v_out_410202.awb")
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
	Play410202038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410202038
		arg_157_1.duration_ = 6.17

		local var_157_0 = {
			ja = 6.166,
			CriLanguages = 5.3,
			zh = 5.3
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
				arg_157_0:Play410202039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.bgs_.ST66 == nil then
				local var_160_0 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST66")
				var_160_0.name = "ST66"
				var_160_0.transform.parent = arg_157_1.stage_.transform
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_.ST66 = var_160_0
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_1 = arg_157_1.bgs_.ST66

				arg_157_1.bgs_.ST66.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_2 = var_160_1:GetComponent("SpriteRenderer")

				if var_160_2 and var_160_2.sprite then
					local var_160_3 = 2 * (var_160_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_1.transform.localScale = Vector3.New(var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "ST66" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_4 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_5 = 2

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_5 then
				local var_160_6 = Color.New(0, 0, 0)

				var_160_6.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_4) / var_160_5)
				arg_157_1.mask_.color = var_160_6
			end

			if arg_157_1.time_ >= var_160_4 + var_160_5 and arg_157_1.time_ < var_160_4 + var_160_5 + arg_160_0 then
				local var_160_7 = Color.New(0, 0, 0)

				var_160_7.a = 1
				arg_157_1.mask_.color = var_160_7
			end

			local var_160_8 = 2

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_9 = 2

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 then
				local var_160_10 = Color.New(0, 0, 0)

				var_160_10.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_8) / var_160_9)
				arg_157_1.mask_.color = var_160_10
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 then
				local var_160_11 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_11.a = 0
				arg_157_1.mask_.color = var_160_11
			end

			local var_160_12 = arg_157_1.actors_["10059"].transform

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= 4 + arg_160_0 then
				arg_157_1.var_.moveOldPos10059 = var_160_12.localPosition
				var_160_12.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10059", 2)

				for iter_160_2 = 0, var_160_12.childCount - 1 do
					local var_160_13 = var_160_12:GetChild(iter_160_2)

					if var_160_13.name == "" or not string.find(var_160_13.name, "split") then
						var_160_13.gameObject:SetActive(true)
					else
						var_160_13.gameObject:SetActive(false)
					end
				end
			end

			local var_160_14 = 0.001

			if 4 <= arg_157_1.time_ and arg_157_1.time_ < 4 + var_160_14 then
				var_160_12.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_157_1.time_ - 4) / var_160_14)
			end

			if arg_157_1.time_ >= 4 + var_160_14 and arg_157_1.time_ < 4 + var_160_14 + arg_160_0 then
				var_160_12.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_160_15 = arg_157_1.actors_["1061"].transform

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= 4 + arg_160_0 then
				arg_157_1.var_.moveOldPos1061 = var_160_15.localPosition
				var_160_15.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1061", 4)

				for iter_160_3 = 0, var_160_15.childCount - 1 do
					local var_160_16 = var_160_15:GetChild(iter_160_3)

					if var_160_16.name == "" or not string.find(var_160_16.name, "split") then
						var_160_16.gameObject:SetActive(true)
					else
						var_160_16.gameObject:SetActive(false)
					end
				end
			end

			local var_160_17 = 0.001

			if 4 <= arg_157_1.time_ and arg_157_1.time_ < 4 + var_160_17 then
				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_157_1.time_ - 4) / var_160_17)
			end

			if arg_157_1.time_ >= 4 + var_160_17 and arg_157_1.time_ < 4 + var_160_17 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(390, -490, 18)
			end

			local var_160_18 = arg_157_1.actors_["10059"]

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= 4 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.actorSpriteComps10059 == nil then
				arg_157_1.var_.actorSpriteComps10059 = var_160_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_19 = 0.034

			if 4 <= arg_157_1.time_ and arg_157_1.time_ < 4 + var_160_19 and not isNil(var_160_18) then
				if arg_157_1.var_.actorSpriteComps10059 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								iter_160_5.color = Color.New(Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 4) / var_160_19), Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 4) / var_160_19), (Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 4) / var_160_19)))
							else
								local var_160_20 = Mathf.Lerp(iter_160_5.color.r, 1, (arg_157_1.time_ - 4) / var_160_19)

								iter_160_5.color = Color.New(var_160_20, var_160_20, var_160_20)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 4 + var_160_19 and arg_157_1.time_ < 4 + var_160_19 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.actorSpriteComps10059 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_160_7 then
						iter_160_7.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10059 = nil
			end

			local var_160_21 = arg_157_1.actors_["1061"]

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= 4 + arg_160_0 and not isNil(var_160_21) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = var_160_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_22 = 0.034

			if 4 <= arg_157_1.time_ and arg_157_1.time_ < 4 + var_160_22 and not isNil(var_160_21) then
				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_160_9 then
							if arg_157_1.isInRecall_ then
								iter_160_9.color = Color.New(Mathf.Lerp(iter_160_9.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 4) / var_160_22), Mathf.Lerp(iter_160_9.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 4) / var_160_22), (Mathf.Lerp(iter_160_9.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 4) / var_160_22)))
							else
								local var_160_23 = Mathf.Lerp(iter_160_9.color.r, 0.5, (arg_157_1.time_ - 4) / var_160_22)

								iter_160_9.color = Color.New(var_160_23, var_160_23, var_160_23)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 4 + var_160_22 and arg_157_1.time_ < 4 + var_160_22 + arg_160_0 and not isNil(var_160_21) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_11 then
						iter_160_11.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_24 = 4
			local var_160_25 = 0.1

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_24 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_26 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_26:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_27 = arg_157_1:GetWordFromCfg(410202038)
				local var_160_28 = arg_157_1:FormatText(var_160_27.content)

				arg_157_1.text_.text = var_160_28

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_30 = 4 <= 0 and var_160_25 or var_160_25 * (utf8.len(var_160_28) / 4)

				if (4 <= 0 and var_160_25 or var_160_25 * (utf8.len(var_160_28) / 4)) > 0 and var_160_25 < var_160_30 then
					arg_157_1.talkMaxDuration = var_160_30
					var_160_24 = var_160_24 + 0.3

					if var_160_30 + var_160_24 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_30 + var_160_24
					end
				end

				arg_157_1.text_.text = var_160_28
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202038", "story_v_out_410202.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_410202", "410202038", "story_v_out_410202.awb") / 1000

					if var_160_31 + var_160_24 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_24
					end

					if var_160_27.prefab_name ~= "" and arg_157_1.actors_[var_160_27.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_27.prefab_name].transform, "story_v_out_410202", "410202038", "story_v_out_410202.awb")

						arg_157_1:RecordAudio("410202038", var_160_32)
						arg_157_1:RecordAudio("410202038", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410202", "410202038", "story_v_out_410202.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410202", "410202038", "story_v_out_410202.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_33 = var_160_24 + 0.3
			local var_160_34 = math.max(var_160_25, arg_157_1.talkMaxDuration)

			if var_160_24 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_33 + var_160_34 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_33) / var_160_34

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_33 + var_160_34 and arg_157_1.time_ < var_160_33 + var_160_34 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play410202039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410202039
		arg_163_1.duration_ = 7.67

		local var_163_0 = {
			ja = 7.666,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_163_0:Play410202040(arg_163_1)
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
			local var_166_9 = 0.4

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

				local var_166_10 = arg_163_1:GetWordFromCfg(410202039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 16 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 16)

				if (16 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 16)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202039", "story_v_out_410202.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_410202", "410202039", "story_v_out_410202.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_410202", "410202039", "story_v_out_410202.awb")

						arg_163_1:RecordAudio("410202039", var_166_15)
						arg_163_1:RecordAudio("410202039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410202", "410202039", "story_v_out_410202.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410202", "410202039", "story_v_out_410202.awb")
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
	Play410202040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410202040
		arg_167_1.duration_ = 12.5

		local var_167_0 = {
			ja = 12.5,
			CriLanguages = 7.133,
			zh = 7.133
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
				arg_167_0:Play410202041(arg_167_1)
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
			local var_170_9 = 0.875

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

				local var_170_10 = arg_167_1:GetWordFromCfg(410202040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 35 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 35)

				if (35 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 35)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202040", "story_v_out_410202.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_410202", "410202040", "story_v_out_410202.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_410202", "410202040", "story_v_out_410202.awb")

						arg_167_1:RecordAudio("410202040", var_170_15)
						arg_167_1:RecordAudio("410202040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410202", "410202040", "story_v_out_410202.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410202", "410202040", "story_v_out_410202.awb")
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
	Play410202041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410202041
		arg_171_1.duration_ = 8.5

		local var_171_0 = {
			ja = 8.5,
			CriLanguages = 6.3,
			zh = 6.3
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
				arg_171_0:Play410202042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10059 = arg_171_1.actors_["10059"].transform.localPosition
				arg_171_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10059", 2)

				for iter_174_0 = 0, arg_171_1.actors_["10059"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["10059"].transform:GetChild(iter_174_0)

					if var_174_0.name == "" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_174_2 = 0
			local var_174_3 = 0.75

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(410202041)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 30 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 30)

				if (30 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 30)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202041", "story_v_out_410202.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_410202", "410202041", "story_v_out_410202.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_410202", "410202041", "story_v_out_410202.awb")

						arg_171_1:RecordAudio("410202041", var_174_9)
						arg_171_1:RecordAudio("410202041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410202", "410202041", "story_v_out_410202.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410202", "410202041", "story_v_out_410202.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play410202042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410202042
		arg_175_1.duration_ = 9.7

		local var_175_0 = {
			ja = 9.7,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_175_0:Play410202043(arg_175_1)
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

			local var_178_2 = arg_175_1.actors_["10059"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10059 == nil then
				arg_175_1.var_.actorSpriteComps10059 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.034

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps10059 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								iter_178_2.color = Color.New(Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_2.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_2.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10059 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_178_4 then
						iter_178_4.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10059 = nil
			end

			local var_178_5 = arg_175_1.actors_["1061"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps1061 == nil then
				arg_175_1.var_.actorSpriteComps1061 = var_178_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 0.034

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.actorSpriteComps1061 then
					for iter_178_5, iter_178_6 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_178_6 then
							if arg_175_1.isInRecall_ then
								iter_178_6.color = Color.New(Mathf.Lerp(iter_178_6.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_6), Mathf.Lerp(iter_178_6.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_6), (Mathf.Lerp(iter_178_6.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_6)))
							else
								local var_178_7 = Mathf.Lerp(iter_178_6.color.r, 1, (arg_175_1.time_ - 0) / var_178_6)

								iter_178_6.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps1061 then
				for iter_178_7, iter_178_8 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_178_8 then
						iter_178_8.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1061 = nil
			end

			local var_178_8 = 0
			local var_178_9 = 0.675

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
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

				local var_178_10 = arg_175_1:GetWordFromCfg(410202042)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 27 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 27)

				if (27 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 27)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202042", "story_v_out_410202.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_410202", "410202042", "story_v_out_410202.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_410202", "410202042", "story_v_out_410202.awb")

						arg_175_1:RecordAudio("410202042", var_178_15)
						arg_175_1:RecordAudio("410202042", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410202", "410202042", "story_v_out_410202.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410202", "410202042", "story_v_out_410202.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
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
	Play410202043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410202043
		arg_179_1.duration_ = 1.83

		local var_179_0 = {
			ja = 1.833,
			CriLanguages = 1.266,
			zh = 1.266
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
				arg_179_0:Play410202044(arg_179_1)
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
			local var_182_9 = 0.1

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

				local var_182_10 = arg_179_1:GetWordFromCfg(410202043)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 4 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 4)

				if (4 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 4)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202043", "story_v_out_410202.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_410202", "410202043", "story_v_out_410202.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_410202", "410202043", "story_v_out_410202.awb")

						arg_179_1:RecordAudio("410202043", var_182_15)
						arg_179_1:RecordAudio("410202043", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410202", "410202043", "story_v_out_410202.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410202", "410202043", "story_v_out_410202.awb")
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
	Play410202044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410202044
		arg_183_1.duration_ = 2.63

		local var_183_0 = {
			ja = 2.633,
			CriLanguages = 2.2,
			zh = 2.2
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play410202045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10059 = arg_183_1.actors_["10059"].transform.localPosition
				arg_183_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10059", 7)

				for iter_186_0 = 0, arg_183_1.actors_["10059"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["10059"].transform:GetChild(iter_186_0)

					if var_186_0.name == "" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_186_2 = arg_183_1.actors_["1061"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1061 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1061", 7)

				for iter_186_1 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_1)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_186_5 = "10060"

			if arg_183_1.actors_["10060"] == nil then
				local var_186_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_186_6) then
					local var_186_7 = Object.Instantiate(var_186_6, arg_183_1.canvasGo_.transform)

					var_186_7.transform:SetSiblingIndex(1)

					var_186_7.name = var_186_5
					var_186_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_183_1.actors_[var_186_5] = var_186_7

					if arg_183_1.isInRecall_ then
						for iter_186_2, iter_186_3 in ipairs((var_186_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_186_3.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_186_8 = arg_183_1.actors_["10060"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10060 = var_186_8.localPosition
				var_186_8.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10060", 3)

				for iter_186_4 = 0, var_186_8.childCount - 1 do
					local var_186_9 = var_186_8:GetChild(iter_186_4)

					if var_186_9.name == "" or not string.find(var_186_9.name, "split") then
						var_186_9.gameObject:SetActive(true)
					else
						var_186_9.gameObject:SetActive(false)
					end
				end
			end

			local var_186_10 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_10 then
				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_183_1.time_ - 0) / var_186_10)
			end

			if arg_183_1.time_ >= 0 + var_186_10 and arg_183_1.time_ < 0 + var_186_10 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_186_11 = arg_183_1.actors_["10059"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_11) and arg_183_1.var_.actorSpriteComps10059 == nil then
				arg_183_1.var_.actorSpriteComps10059 = var_186_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_12 = 0.034

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_12 and not isNil(var_186_11) then
				if arg_183_1.var_.actorSpriteComps10059 then
					for iter_186_5, iter_186_6 in pairs(arg_183_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_186_6 then
							if arg_183_1.isInRecall_ then
								iter_186_6.color = Color.New(Mathf.Lerp(iter_186_6.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_12), Mathf.Lerp(iter_186_6.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_12), (Mathf.Lerp(iter_186_6.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_12)))
							else
								local var_186_13 = Mathf.Lerp(iter_186_6.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_12)

								iter_186_6.color = Color.New(var_186_13, var_186_13, var_186_13)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_12 and arg_183_1.time_ < 0 + var_186_12 + arg_186_0 and not isNil(var_186_11) and arg_183_1.var_.actorSpriteComps10059 then
				for iter_186_7, iter_186_8 in pairs(arg_183_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_186_8 then
						iter_186_8.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10059 = nil
			end

			local var_186_14 = arg_183_1.actors_["1061"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_14) and arg_183_1.var_.actorSpriteComps1061 == nil then
				arg_183_1.var_.actorSpriteComps1061 = var_186_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_15 = 0.034

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_15 and not isNil(var_186_14) then
				if arg_183_1.var_.actorSpriteComps1061 then
					for iter_186_9, iter_186_10 in pairs(arg_183_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_186_10 then
							if arg_183_1.isInRecall_ then
								iter_186_10.color = Color.New(Mathf.Lerp(iter_186_10.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_15), Mathf.Lerp(iter_186_10.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_15), (Mathf.Lerp(iter_186_10.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_15)))
							else
								local var_186_16 = Mathf.Lerp(iter_186_10.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_15)

								iter_186_10.color = Color.New(var_186_16, var_186_16, var_186_16)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_15 and arg_183_1.time_ < 0 + var_186_15 + arg_186_0 and not isNil(var_186_14) and arg_183_1.var_.actorSpriteComps1061 then
				for iter_186_11, iter_186_12 in pairs(arg_183_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_186_12 then
						iter_186_12.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps1061 = nil
			end

			local var_186_17 = arg_183_1.actors_["10060"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_17) and arg_183_1.var_.actorSpriteComps10060 == nil then
				arg_183_1.var_.actorSpriteComps10060 = var_186_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_18 = 0.034

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_18 and not isNil(var_186_17) then
				if arg_183_1.var_.actorSpriteComps10060 then
					for iter_186_13, iter_186_14 in pairs(arg_183_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_186_14 then
							if arg_183_1.isInRecall_ then
								iter_186_14.color = Color.New(Mathf.Lerp(iter_186_14.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_18), Mathf.Lerp(iter_186_14.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_18), (Mathf.Lerp(iter_186_14.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_18)))
							else
								local var_186_19 = Mathf.Lerp(iter_186_14.color.r, 1, (arg_183_1.time_ - 0) / var_186_18)

								iter_186_14.color = Color.New(var_186_19, var_186_19, var_186_19)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_18 and arg_183_1.time_ < 0 + var_186_18 + arg_186_0 and not isNil(var_186_17) and arg_183_1.var_.actorSpriteComps10060 then
				for iter_186_15, iter_186_16 in pairs(arg_183_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_186_16 then
						iter_186_16.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10060 = nil
			end

			local var_186_20 = 0
			local var_186_21 = 0.225

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_20 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_22 = arg_183_1:GetWordFromCfg(410202044)
				local var_186_23 = arg_183_1:FormatText(var_186_22.content)

				arg_183_1.text_.text = var_186_23

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_25 = 9 <= 0 and var_186_21 or var_186_21 * (utf8.len(var_186_23) / 9)

				if (9 <= 0 and var_186_21 or var_186_21 * (utf8.len(var_186_23) / 9)) > 0 and var_186_21 < var_186_25 then
					arg_183_1.talkMaxDuration = var_186_25

					if var_186_25 + var_186_20 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_25 + var_186_20
					end
				end

				arg_183_1.text_.text = var_186_23
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202044", "story_v_out_410202.awb") ~= 0 then
					local var_186_26 = manager.audio:GetVoiceLength("story_v_out_410202", "410202044", "story_v_out_410202.awb") / 1000

					if var_186_26 + var_186_20 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_26 + var_186_20
					end

					if var_186_22.prefab_name ~= "" and arg_183_1.actors_[var_186_22.prefab_name] ~= nil then
						local var_186_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_22.prefab_name].transform, "story_v_out_410202", "410202044", "story_v_out_410202.awb")

						arg_183_1:RecordAudio("410202044", var_186_27)
						arg_183_1:RecordAudio("410202044", var_186_27)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410202", "410202044", "story_v_out_410202.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410202", "410202044", "story_v_out_410202.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_28 = math.max(var_186_21, arg_183_1.talkMaxDuration)

			if var_186_20 <= arg_183_1.time_ and arg_183_1.time_ < var_186_20 + var_186_28 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_20) / var_186_28

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_20 + var_186_28 and arg_183_1.time_ < var_186_20 + var_186_28 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play410202045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410202045
		arg_187_1.duration_ = 3.7

		local var_187_0 = {
			ja = 3.7,
			CriLanguages = 1.366,
			zh = 1.366
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
				arg_187_0:Play410202046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10060 = arg_187_1.actors_["10060"].transform.localPosition
				arg_187_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10060", 7)

				for iter_190_0 = 0, arg_187_1.actors_["10060"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["10060"].transform:GetChild(iter_190_0)

					if var_190_0.name == "" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["10060"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_2 = arg_187_1.actors_["10059"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10059 = var_190_2.localPosition
				var_190_2.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10059", 2)

				for iter_190_1 = 0, var_190_2.childCount - 1 do
					local var_190_3 = var_190_2:GetChild(iter_190_1)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_187_1.time_ - 0) / var_190_4)
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_190_5 = arg_187_1.actors_["1061"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1061 = var_190_5.localPosition
				var_190_5.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1061", 4)

				for iter_190_2 = 0, var_190_5.childCount - 1 do
					local var_190_6 = var_190_5:GetChild(iter_190_2)

					if var_190_6.name == "" or not string.find(var_190_6.name, "split") then
						var_190_6.gameObject:SetActive(true)
					else
						var_190_6.gameObject:SetActive(false)
					end
				end
			end

			local var_190_7 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_187_1.time_ - 0) / var_190_7)
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(390, -490, 18)
			end

			local var_190_8 = arg_187_1.actors_["10060"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10060 == nil then
				arg_187_1.var_.actorSpriteComps10060 = var_190_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 0.034

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_9 and not isNil(var_190_8) then
				if arg_187_1.var_.actorSpriteComps10060 then
					for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_190_4 then
							if arg_187_1.isInRecall_ then
								iter_190_4.color = Color.New(Mathf.Lerp(iter_190_4.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_9), Mathf.Lerp(iter_190_4.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_9), (Mathf.Lerp(iter_190_4.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_9)))
							else
								local var_190_10 = Mathf.Lerp(iter_190_4.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_9)

								iter_190_4.color = Color.New(var_190_10, var_190_10, var_190_10)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_9 and arg_187_1.time_ < 0 + var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10060 then
				for iter_190_5, iter_190_6 in pairs(arg_187_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_190_6 then
						iter_190_6.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10060 = nil
			end

			local var_190_11 = arg_187_1.actors_["10059"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_11) and arg_187_1.var_.actorSpriteComps10059 == nil then
				arg_187_1.var_.actorSpriteComps10059 = var_190_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_12 = 0.034

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_12 and not isNil(var_190_11) then
				if arg_187_1.var_.actorSpriteComps10059 then
					for iter_190_7, iter_190_8 in pairs(arg_187_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_190_8 then
							if arg_187_1.isInRecall_ then
								iter_190_8.color = Color.New(Mathf.Lerp(iter_190_8.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_12), Mathf.Lerp(iter_190_8.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_12), (Mathf.Lerp(iter_190_8.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_12)))
							else
								local var_190_13 = Mathf.Lerp(iter_190_8.color.r, 1, (arg_187_1.time_ - 0) / var_190_12)

								iter_190_8.color = Color.New(var_190_13, var_190_13, var_190_13)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_12 and arg_187_1.time_ < 0 + var_190_12 + arg_190_0 and not isNil(var_190_11) and arg_187_1.var_.actorSpriteComps10059 then
				for iter_190_9, iter_190_10 in pairs(arg_187_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_190_10 then
						iter_190_10.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps10059 = nil
			end

			local var_190_14 = arg_187_1.actors_["1061"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.actorSpriteComps1061 == nil then
				arg_187_1.var_.actorSpriteComps1061 = var_190_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_15 = 0.034

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_15 and not isNil(var_190_14) then
				if arg_187_1.var_.actorSpriteComps1061 then
					for iter_190_11, iter_190_12 in pairs(arg_187_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_190_12 then
							if arg_187_1.isInRecall_ then
								iter_190_12.color = Color.New(Mathf.Lerp(iter_190_12.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_15), Mathf.Lerp(iter_190_12.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_15), (Mathf.Lerp(iter_190_12.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_15)))
							else
								local var_190_16 = Mathf.Lerp(iter_190_12.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_15)

								iter_190_12.color = Color.New(var_190_16, var_190_16, var_190_16)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_15 and arg_187_1.time_ < 0 + var_190_15 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.actorSpriteComps1061 then
				for iter_190_13, iter_190_14 in pairs(arg_187_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_190_14 then
						iter_190_14.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps1061 = nil
			end

			local var_190_17 = 0
			local var_190_18 = 0.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_19 = arg_187_1:GetWordFromCfg(410202045)
				local var_190_20 = arg_187_1:FormatText(var_190_19.content)

				arg_187_1.text_.text = var_190_20

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_22 = 5 <= 0 and var_190_18 or var_190_18 * (utf8.len(var_190_20) / 5)

				if (5 <= 0 and var_190_18 or var_190_18 * (utf8.len(var_190_20) / 5)) > 0 and var_190_18 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_17 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_17
					end
				end

				arg_187_1.text_.text = var_190_20
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202045", "story_v_out_410202.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_410202", "410202045", "story_v_out_410202.awb") / 1000

					if var_190_23 + var_190_17 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_17
					end

					if var_190_19.prefab_name ~= "" and arg_187_1.actors_[var_190_19.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_19.prefab_name].transform, "story_v_out_410202", "410202045", "story_v_out_410202.awb")

						arg_187_1:RecordAudio("410202045", var_190_24)
						arg_187_1:RecordAudio("410202045", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410202", "410202045", "story_v_out_410202.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410202", "410202045", "story_v_out_410202.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_18, arg_187_1.talkMaxDuration)

			if var_190_17 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_17) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_17 + var_190_25 and arg_187_1.time_ < var_190_17 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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

		arg_187_1:InitPlayNodeList()
	end,
	Play410202046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410202046
		arg_191_1.duration_ = 10.17

		local var_191_0 = {
			ja = 10.166,
			CriLanguages = 6.166,
			zh = 6.166
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play410202047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1061 = arg_191_1.actors_["1061"].transform.localPosition
				arg_191_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1061", 4)

				for iter_194_0 = 0, arg_191_1.actors_["1061"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["1061"].transform:GetChild(iter_194_0)

					if var_194_0.name == "split_5" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_194_2 = arg_191_1.actors_["10059"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10059 == nil then
				arg_191_1.var_.actorSpriteComps10059 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.034

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps10059 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								iter_194_2.color = Color.New(Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_2.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_2.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10059 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_194_4 then
						iter_194_4.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps10059 = nil
			end

			local var_194_5 = arg_191_1.actors_["1061"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.actorSpriteComps1061 == nil then
				arg_191_1.var_.actorSpriteComps1061 = var_194_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_6 = 0.034

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 and not isNil(var_194_5) then
				if arg_191_1.var_.actorSpriteComps1061 then
					for iter_194_5, iter_194_6 in pairs(arg_191_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_194_6 then
							if arg_191_1.isInRecall_ then
								iter_194_6.color = Color.New(Mathf.Lerp(iter_194_6.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_6), Mathf.Lerp(iter_194_6.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_6), (Mathf.Lerp(iter_194_6.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_6)))
							else
								local var_194_7 = Mathf.Lerp(iter_194_6.color.r, 1, (arg_191_1.time_ - 0) / var_194_6)

								iter_194_6.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.actorSpriteComps1061 then
				for iter_194_7, iter_194_8 in pairs(arg_191_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_194_8 then
						iter_194_8.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps1061 = nil
			end

			local var_194_8 = 0
			local var_194_9 = 0.675

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(410202046)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 27 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 27)

				if (27 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 27)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202046", "story_v_out_410202.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_410202", "410202046", "story_v_out_410202.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_410202", "410202046", "story_v_out_410202.awb")

						arg_191_1:RecordAudio("410202046", var_194_15)
						arg_191_1:RecordAudio("410202046", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_410202", "410202046", "story_v_out_410202.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_410202", "410202046", "story_v_out_410202.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play410202047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410202047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play410202048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1061"]) and arg_195_1.var_.actorSpriteComps1061 == nil then
				arg_195_1.var_.actorSpriteComps1061 = arg_195_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.034

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1061"]) then
				if arg_195_1.var_.actorSpriteComps1061 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1061"]) and arg_195_1.var_.actorSpriteComps1061 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps1061 = nil
			end

			local var_198_2 = 0
			local var_198_3 = 0.875

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(410202047).content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 35 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_4) / 35)

				if (35 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_4) / 35)) > 0 and var_198_3 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_7 and arg_195_1.time_ < var_198_2 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play410202048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410202048
		arg_199_1.duration_ = 7.97

		local var_199_0 = {
			ja = 6.866,
			CriLanguages = 7.966,
			zh = 7.966
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play410202049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10059 = arg_199_1.actors_["10059"].transform.localPosition
				arg_199_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10059", 2)

				for iter_202_0 = 0, arg_199_1.actors_["10059"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["10059"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_202_2 = arg_199_1.actors_["10059"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10059 == nil then
				arg_199_1.var_.actorSpriteComps10059 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.034

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10059 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								iter_202_2.color = Color.New(Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_2.color.r, 1, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_2.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10059 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10059 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 0.975

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(410202048)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 39 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 39)

				if (39 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 39)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202048", "story_v_out_410202.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202048", "story_v_out_410202.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_410202", "410202048", "story_v_out_410202.awb")

						arg_199_1:RecordAudio("410202048", var_202_12)
						arg_199_1:RecordAudio("410202048", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410202", "410202048", "story_v_out_410202.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410202", "410202048", "story_v_out_410202.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_13 and arg_199_1.time_ < var_202_5 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play410202049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410202049
		arg_203_1.duration_ = 7.77

		local var_203_0 = {
			ja = 7.766,
			CriLanguages = 7.7,
			zh = 7.7
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play410202050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.bgs_.ST64a == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST64a")
				var_206_0.name = "ST64a"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.ST64a = var_206_0
			end

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.ST64a

				arg_203_1.bgs_.ST64a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST64a" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_5 = 2

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_5 then
				local var_206_6 = Color.New(0, 0, 0)

				var_206_6.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_4) / var_206_5)
				arg_203_1.mask_.color = var_206_6
			end

			if arg_203_1.time_ >= var_206_4 + var_206_5 and arg_203_1.time_ < var_206_4 + var_206_5 + arg_206_0 then
				local var_206_7 = Color.New(0, 0, 0)

				var_206_7.a = 1
				arg_203_1.mask_.color = var_206_7
			end

			local var_206_8 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_9 = 2

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 then
				local var_206_10 = Color.New(0, 0, 0)

				var_206_10.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_8) / var_206_9)
				arg_203_1.mask_.color = var_206_10
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 then
				local var_206_11 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_11.a = 0
				arg_203_1.mask_.color = var_206_11
			end

			local var_206_12 = "10063"

			if arg_203_1.actors_["10063"] == nil then
				local var_206_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10063")

				if not isNil(var_206_13) then
					local var_206_14 = Object.Instantiate(var_206_13, arg_203_1.canvasGo_.transform)

					var_206_14.transform:SetSiblingIndex(1)

					var_206_14.name = var_206_12
					var_206_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_203_1.actors_[var_206_12] = var_206_14

					if arg_203_1.isInRecall_ then
						for iter_206_2, iter_206_3 in ipairs((var_206_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_206_3.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_206_15 = arg_203_1.actors_["10063"].transform

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= 4 + arg_206_0 then
				arg_203_1.var_.moveOldPos10063 = var_206_15.localPosition
				var_206_15.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10063", 3)

				for iter_206_4 = 0, var_206_15.childCount - 1 do
					local var_206_16 = var_206_15:GetChild(iter_206_4)

					if var_206_16.name == "" or not string.find(var_206_16.name, "split") then
						var_206_16.gameObject:SetActive(true)
					else
						var_206_16.gameObject:SetActive(false)
					end
				end
			end

			local var_206_17 = 0.001

			if 4 <= arg_203_1.time_ and arg_203_1.time_ < 4 + var_206_17 then
				var_206_15.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10063, Vector3.New(0, -535, -105), (arg_203_1.time_ - 4) / var_206_17)
			end

			if arg_203_1.time_ >= 4 + var_206_17 and arg_203_1.time_ < 4 + var_206_17 + arg_206_0 then
				var_206_15.localPosition = Vector3.New(0, -535, -105)
			end

			local var_206_18 = arg_203_1.actors_["10063"]

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= 4 + arg_206_0 and not isNil(var_206_18) and arg_203_1.var_.actorSpriteComps10063 == nil then
				arg_203_1.var_.actorSpriteComps10063 = var_206_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_19 = 0.034

			if 4 <= arg_203_1.time_ and arg_203_1.time_ < 4 + var_206_19 and not isNil(var_206_18) then
				if arg_203_1.var_.actorSpriteComps10063 then
					for iter_206_5, iter_206_6 in pairs(arg_203_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_206_6 then
							if arg_203_1.isInRecall_ then
								iter_206_6.color = Color.New(Mathf.Lerp(iter_206_6.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 4) / var_206_19), Mathf.Lerp(iter_206_6.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 4) / var_206_19), (Mathf.Lerp(iter_206_6.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 4) / var_206_19)))
							else
								local var_206_20 = Mathf.Lerp(iter_206_6.color.r, 1, (arg_203_1.time_ - 4) / var_206_19)

								iter_206_6.color = Color.New(var_206_20, var_206_20, var_206_20)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 4 + var_206_19 and arg_203_1.time_ < 4 + var_206_19 + arg_206_0 and not isNil(var_206_18) and arg_203_1.var_.actorSpriteComps10063 then
				for iter_206_7, iter_206_8 in pairs(arg_203_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_206_8 then
						iter_206_8.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps10063 = nil
			end

			local var_206_21 = arg_203_1.actors_["1061"].transform

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				arg_203_1.var_.moveOldPos1061 = var_206_21.localPosition
				var_206_21.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1061", 7)

				for iter_206_9 = 0, var_206_21.childCount - 1 do
					local var_206_22 = var_206_21:GetChild(iter_206_9)

					if var_206_22.name == "" or not string.find(var_206_22.name, "split") then
						var_206_22.gameObject:SetActive(true)
					else
						var_206_22.gameObject:SetActive(false)
					end
				end
			end

			local var_206_23 = 0.001

			if 2 <= arg_203_1.time_ and arg_203_1.time_ < 2 + var_206_23 then
				var_206_21.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_203_1.time_ - 2) / var_206_23)
			end

			if arg_203_1.time_ >= 2 + var_206_23 and arg_203_1.time_ < 2 + var_206_23 + arg_206_0 then
				var_206_21.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_206_24 = arg_203_1.actors_["10059"].transform

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				arg_203_1.var_.moveOldPos10059 = var_206_24.localPosition
				var_206_24.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10059", 7)

				for iter_206_10 = 0, var_206_24.childCount - 1 do
					local var_206_25 = var_206_24:GetChild(iter_206_10)

					if var_206_25.name == "" or not string.find(var_206_25.name, "split") then
						var_206_25.gameObject:SetActive(true)
					else
						var_206_25.gameObject:SetActive(false)
					end
				end
			end

			local var_206_26 = 0.001

			if 2 <= arg_203_1.time_ and arg_203_1.time_ < 2 + var_206_26 then
				var_206_24.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_203_1.time_ - 2) / var_206_26)
			end

			if arg_203_1.time_ >= 2 + var_206_26 and arg_203_1.time_ < 2 + var_206_26 + arg_206_0 then
				var_206_24.localPosition = Vector3.New(0, -2000, 35)
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_27 = 4
			local var_206_28 = 0.275

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_27 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_29 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_29:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_30 = arg_203_1:GetWordFromCfg(410202049)
				local var_206_31 = arg_203_1:FormatText(var_206_30.content)

				arg_203_1.text_.text = var_206_31

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_33 = 11 <= 0 and var_206_28 or var_206_28 * (utf8.len(var_206_31) / 11)

				if (11 <= 0 and var_206_28 or var_206_28 * (utf8.len(var_206_31) / 11)) > 0 and var_206_28 < var_206_33 then
					arg_203_1.talkMaxDuration = var_206_33
					var_206_27 = var_206_27 + 0.3

					if var_206_33 + var_206_27 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_33 + var_206_27
					end
				end

				arg_203_1.text_.text = var_206_31
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202049", "story_v_out_410202.awb") ~= 0 then
					local var_206_34 = manager.audio:GetVoiceLength("story_v_out_410202", "410202049", "story_v_out_410202.awb") / 1000

					if var_206_34 + var_206_27 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_34 + var_206_27
					end

					if var_206_30.prefab_name ~= "" and arg_203_1.actors_[var_206_30.prefab_name] ~= nil then
						local var_206_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_30.prefab_name].transform, "story_v_out_410202", "410202049", "story_v_out_410202.awb")

						arg_203_1:RecordAudio("410202049", var_206_35)
						arg_203_1:RecordAudio("410202049", var_206_35)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_410202", "410202049", "story_v_out_410202.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_410202", "410202049", "story_v_out_410202.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_36 = var_206_27 + 0.3
			local var_206_37 = math.max(var_206_28, arg_203_1.talkMaxDuration)

			if var_206_27 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_36 + var_206_37 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_36) / var_206_37

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_36 + var_206_37 and arg_203_1.time_ < var_206_36 + var_206_37 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play410202050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410202050
		arg_209_1.duration_ = 3.57

		local var_209_0 = {
			ja = 2.7,
			CriLanguages = 3.566,
			zh = 3.566
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
				arg_209_0:Play410202051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10063 = arg_209_1.actors_["10063"].transform.localPosition
				arg_209_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10063", 7)

				for iter_212_0 = 0, arg_209_1.actors_["10063"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["10063"].transform:GetChild(iter_212_0)

					if var_212_0.name == "" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10063"].transform.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_212_2 = arg_209_1.actors_["1061"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1061 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1061", 3)

				for iter_212_1 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_1)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_212_5 = arg_209_1.actors_["10063"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10063 == nil then
				arg_209_1.var_.actorSpriteComps10063 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps10063 then
					for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_212_3 then
							if arg_209_1.isInRecall_ then
								iter_212_3.color = Color.New(Mathf.Lerp(iter_212_3.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_3.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_3.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_3.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_3.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10063 then
				for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_212_5 then
						iter_212_5.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10063 = nil
			end

			local var_212_8 = arg_209_1.actors_["1061"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps1061 == nil then
				arg_209_1.var_.actorSpriteComps1061 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_9 and not isNil(var_212_8) then
				if arg_209_1.var_.actorSpriteComps1061 then
					for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_212_7 then
							if arg_209_1.isInRecall_ then
								iter_212_7.color = Color.New(Mathf.Lerp(iter_212_7.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_9), Mathf.Lerp(iter_212_7.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_9), (Mathf.Lerp(iter_212_7.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_9)))
							else
								local var_212_10 = Mathf.Lerp(iter_212_7.color.r, 1, (arg_209_1.time_ - 0) / var_212_9)

								iter_212_7.color = Color.New(var_212_10, var_212_10, var_212_10)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_9 and arg_209_1.time_ < 0 + var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps1061 then
				for iter_212_8, iter_212_9 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_212_9 then
						iter_212_9.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1061 = nil
			end

			local var_212_11 = 0
			local var_212_12 = 0.35

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_13 = arg_209_1:GetWordFromCfg(410202050)
				local var_212_14 = arg_209_1:FormatText(var_212_13.content)

				arg_209_1.text_.text = var_212_14

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_16 = 14 <= 0 and var_212_12 or var_212_12 * (utf8.len(var_212_14) / 14)

				if (14 <= 0 and var_212_12 or var_212_12 * (utf8.len(var_212_14) / 14)) > 0 and var_212_12 < var_212_16 then
					arg_209_1.talkMaxDuration = var_212_16

					if var_212_16 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_11
					end
				end

				arg_209_1.text_.text = var_212_14
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202050", "story_v_out_410202.awb") ~= 0 then
					local var_212_17 = manager.audio:GetVoiceLength("story_v_out_410202", "410202050", "story_v_out_410202.awb") / 1000

					if var_212_17 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_17 + var_212_11
					end

					if var_212_13.prefab_name ~= "" and arg_209_1.actors_[var_212_13.prefab_name] ~= nil then
						local var_212_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_13.prefab_name].transform, "story_v_out_410202", "410202050", "story_v_out_410202.awb")

						arg_209_1:RecordAudio("410202050", var_212_18)
						arg_209_1:RecordAudio("410202050", var_212_18)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410202", "410202050", "story_v_out_410202.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410202", "410202050", "story_v_out_410202.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_19 = math.max(var_212_12, arg_209_1.talkMaxDuration)

			if var_212_11 <= arg_209_1.time_ and arg_209_1.time_ < var_212_11 + var_212_19 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_11) / var_212_19

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_11 + var_212_19 and arg_209_1.time_ < var_212_11 + var_212_19 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play410202051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410202051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410202052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1061 = arg_213_1.actors_["1061"].transform.localPosition
				arg_213_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1061", 7)

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
				arg_213_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_213_1.time_ - 0) / var_216_1)
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
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
								iter_216_2.color = Color.New(Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_2.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_2.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1061 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1061 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 0.9

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(410202051).content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 36 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 36)

				if (36 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 36)) > 0 and var_216_6 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_10 and arg_213_1.time_ < var_216_5 + var_216_10 + arg_216_0 then
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
	Play410202052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410202052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410202053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.95

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(410202052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 38 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 38)

				if (38 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 38)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410202053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410202053
		arg_221_1.duration_ = 1.8

		local var_221_0 = {
			ja = 1.8,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_221_0:Play410202054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1061 = arg_221_1.actors_["1061"].transform.localPosition
				arg_221_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1061", 3)

				for iter_224_0 = 0, arg_221_1.actors_["1061"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["1061"].transform:GetChild(iter_224_0)

					if var_224_0.name == "" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_224_2 = arg_221_1.actors_["1061"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1061 == nil then
				arg_221_1.var_.actorSpriteComps1061 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps1061 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 1, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1061 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1061 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.125

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(410202053)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 5 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 5)

				if (5 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 5)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202053", "story_v_out_410202.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202053", "story_v_out_410202.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_410202", "410202053", "story_v_out_410202.awb")

						arg_221_1:RecordAudio("410202053", var_224_12)
						arg_221_1:RecordAudio("410202053", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410202", "410202053", "story_v_out_410202.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410202", "410202053", "story_v_out_410202.awb")
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
				actorName = "1061",
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
	Play410202054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410202054
		arg_225_1.duration_ = 6.43

		local var_225_0 = {
			ja = 6.433,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_225_0:Play410202055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10063 = arg_225_1.actors_["10063"].transform.localPosition
				arg_225_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10063", 7)

				for iter_228_0 = 0, arg_225_1.actors_["10063"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["10063"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["10063"].transform.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_228_2 = arg_225_1.actors_["10060"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10060 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10060", 3)

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
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_228_5 = arg_225_1.actors_["10063"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps10063 == nil then
				arg_225_1.var_.actorSpriteComps10063 = var_228_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_6 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.actorSpriteComps10063 then
					for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps10063 then
				for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_228_5 then
						iter_228_5.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10063 = nil
			end

			local var_228_8 = arg_225_1.actors_["10060"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10060 == nil then
				arg_225_1.var_.actorSpriteComps10060 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_9 and not isNil(var_228_8) then
				if arg_225_1.var_.actorSpriteComps10060 then
					for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_228_7 then
							if arg_225_1.isInRecall_ then
								iter_228_7.color = Color.New(Mathf.Lerp(iter_228_7.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_9), Mathf.Lerp(iter_228_7.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_9), (Mathf.Lerp(iter_228_7.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_9)))
							else
								local var_228_10 = Mathf.Lerp(iter_228_7.color.r, 1, (arg_225_1.time_ - 0) / var_228_9)

								iter_228_7.color = Color.New(var_228_10, var_228_10, var_228_10)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_9 and arg_225_1.time_ < 0 + var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10060 then
				for iter_228_8, iter_228_9 in pairs(arg_225_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_228_9 then
						iter_228_9.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10060 = nil
			end

			local var_228_11 = 0
			local var_228_12 = 0.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_13 = arg_225_1:GetWordFromCfg(410202054)
				local var_228_14 = arg_225_1:FormatText(var_228_13.content)

				arg_225_1.text_.text = var_228_14

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_16 = 13 <= 0 and var_228_12 or var_228_12 * (utf8.len(var_228_14) / 13)

				if (13 <= 0 and var_228_12 or var_228_12 * (utf8.len(var_228_14) / 13)) > 0 and var_228_12 < var_228_16 then
					arg_225_1.talkMaxDuration = var_228_16

					if var_228_16 + var_228_11 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_16 + var_228_11
					end
				end

				arg_225_1.text_.text = var_228_14
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202054", "story_v_out_410202.awb") ~= 0 then
					local var_228_17 = manager.audio:GetVoiceLength("story_v_out_410202", "410202054", "story_v_out_410202.awb") / 1000

					if var_228_17 + var_228_11 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_17 + var_228_11
					end

					if var_228_13.prefab_name ~= "" and arg_225_1.actors_[var_228_13.prefab_name] ~= nil then
						local var_228_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_13.prefab_name].transform, "story_v_out_410202", "410202054", "story_v_out_410202.awb")

						arg_225_1:RecordAudio("410202054", var_228_18)
						arg_225_1:RecordAudio("410202054", var_228_18)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410202", "410202054", "story_v_out_410202.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410202", "410202054", "story_v_out_410202.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_19 = math.max(var_228_12, arg_225_1.talkMaxDuration)

			if var_228_11 <= arg_225_1.time_ and arg_225_1.time_ < var_228_11 + var_228_19 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_11) / var_228_19

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_11 + var_228_19 and arg_225_1.time_ < var_228_11 + var_228_19 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
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
	Play410202055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410202055
		arg_229_1.duration_ = 5.57

		local var_229_0 = {
			ja = 5.566,
			CriLanguages = 2.566,
			zh = 2.566
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
				arg_229_0:Play410202056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1061 = arg_229_1.actors_["1061"].transform.localPosition
				arg_229_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1061", 3)

				for iter_232_0 = 0, arg_229_1.actors_["1061"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["1061"].transform:GetChild(iter_232_0)

					if var_232_0.name == "split_5" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_232_2 = arg_229_1.actors_["1061"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1061 == nil then
				arg_229_1.var_.actorSpriteComps1061 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps1061 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1061 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_232_4 then
						iter_232_4.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1061 = nil
			end

			local var_232_5 = 0
			local var_232_6 = 0.35

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(410202055)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 14 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 14)

				if (14 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 14)) > 0 and var_232_6 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202055", "story_v_out_410202.awb") ~= 0 then
					local var_232_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202055", "story_v_out_410202.awb") / 1000

					if var_232_11 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_5
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_410202", "410202055", "story_v_out_410202.awb")

						arg_229_1:RecordAudio("410202055", var_232_12)
						arg_229_1:RecordAudio("410202055", var_232_12)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410202", "410202055", "story_v_out_410202.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410202", "410202055", "story_v_out_410202.awb")
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
				actorName = "1061",
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
	Play410202056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410202056
		arg_233_1.duration_ = 3.77

		local var_233_0 = {
			ja = 3.766,
			CriLanguages = 3.666,
			zh = 3.666
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
				arg_233_0:Play410202057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1061 = arg_233_1.actors_["1061"].transform.localPosition
				arg_233_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1061", 3)

				for iter_236_0 = 0, arg_233_1.actors_["1061"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["1061"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_236_2 = arg_233_1.actors_["1061"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1061 == nil then
				arg_233_1.var_.actorSpriteComps1061 = var_236_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_3 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.actorSpriteComps1061 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1061 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps1061 = nil
			end

			local var_236_5 = 0
			local var_236_6 = 0.45

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_7 = arg_233_1:GetWordFromCfg(410202056)
				local var_236_8 = arg_233_1:FormatText(var_236_7.content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 18 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 18)

				if (18 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 18)) > 0 and var_236_6 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202056", "story_v_out_410202.awb") ~= 0 then
					local var_236_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202056", "story_v_out_410202.awb") / 1000

					if var_236_11 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_5
					end

					if var_236_7.prefab_name ~= "" and arg_233_1.actors_[var_236_7.prefab_name] ~= nil then
						local var_236_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_7.prefab_name].transform, "story_v_out_410202", "410202056", "story_v_out_410202.awb")

						arg_233_1:RecordAudio("410202056", var_236_12)
						arg_233_1:RecordAudio("410202056", var_236_12)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410202", "410202056", "story_v_out_410202.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410202", "410202056", "story_v_out_410202.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_6, arg_233_1.talkMaxDuration)

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_5) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_5 + var_236_13 and arg_233_1.time_ < var_236_5 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play410202057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410202057
		arg_237_1.duration_ = 8.43

		local var_237_0 = {
			ja = 6.5,
			CriLanguages = 8.433,
			zh = 8.433
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
				arg_237_0:Play410202058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1061 = arg_237_1.actors_["1061"].transform.localPosition
				arg_237_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1061", 7)

				for iter_240_0 = 0, arg_237_1.actors_["1061"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["1061"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
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

			local var_240_2 = arg_237_1.actors_["10063"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10063 = var_240_2.localPosition
				var_240_2.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10063", 3)

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
				var_240_2.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10063, Vector3.New(0, -535, -105), (arg_237_1.time_ - 0) / var_240_4)
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_2.localPosition = Vector3.New(0, -535, -105)
			end

			local var_240_5 = arg_237_1.actors_["1061"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps1061 == nil then
				arg_237_1.var_.actorSpriteComps1061 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps1061 then
					for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_240_3 then
							if arg_237_1.isInRecall_ then
								iter_240_3.color = Color.New(Mathf.Lerp(iter_240_3.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_6), Mathf.Lerp(iter_240_3.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_6), (Mathf.Lerp(iter_240_3.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_6)))
							else
								local var_240_7 = Mathf.Lerp(iter_240_3.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_6)

								iter_240_3.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps1061 then
				for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_240_5 then
						iter_240_5.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps1061 = nil
			end

			local var_240_8 = arg_237_1.actors_["10063"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10063 == nil then
				arg_237_1.var_.actorSpriteComps10063 = var_240_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_9 and not isNil(var_240_8) then
				if arg_237_1.var_.actorSpriteComps10063 then
					for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_240_7 then
							if arg_237_1.isInRecall_ then
								iter_240_7.color = Color.New(Mathf.Lerp(iter_240_7.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_9), Mathf.Lerp(iter_240_7.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_9), (Mathf.Lerp(iter_240_7.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_9)))
							else
								local var_240_10 = Mathf.Lerp(iter_240_7.color.r, 1, (arg_237_1.time_ - 0) / var_240_9)

								iter_240_7.color = Color.New(var_240_10, var_240_10, var_240_10)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_9 and arg_237_1.time_ < 0 + var_240_9 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10063 then
				for iter_240_8, iter_240_9 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_240_9 then
						iter_240_9.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps10063 = nil
			end

			local var_240_11 = 0
			local var_240_12 = 0.925

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(410202057)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_16 = 37 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 37)

				if (37 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 37)) > 0 and var_240_12 < var_240_16 then
					arg_237_1.talkMaxDuration = var_240_16

					if var_240_16 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_11
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202057", "story_v_out_410202.awb") ~= 0 then
					local var_240_17 = manager.audio:GetVoiceLength("story_v_out_410202", "410202057", "story_v_out_410202.awb") / 1000

					if var_240_17 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_11
					end

					if var_240_13.prefab_name ~= "" and arg_237_1.actors_[var_240_13.prefab_name] ~= nil then
						local var_240_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_13.prefab_name].transform, "story_v_out_410202", "410202057", "story_v_out_410202.awb")

						arg_237_1:RecordAudio("410202057", var_240_18)
						arg_237_1:RecordAudio("410202057", var_240_18)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410202", "410202057", "story_v_out_410202.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410202", "410202057", "story_v_out_410202.awb")
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
				actorName = "10063",
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
	Play410202058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410202058
		arg_241_1.duration_ = 4.77

		local var_241_0 = {
			ja = 4.766,
			CriLanguages = 4.633,
			zh = 4.633
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
				arg_241_0:Play410202059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10063 = arg_241_1.actors_["10063"].transform.localPosition
				arg_241_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10063", 7)

				for iter_244_0 = 0, arg_241_1.actors_["10063"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["10063"].transform:GetChild(iter_244_0)

					if var_244_0.name == "" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["10063"].transform.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_244_2 = arg_241_1.actors_["1061"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1061 = var_244_2.localPosition
				var_244_2.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1061", 3)

				for iter_244_1 = 0, var_244_2.childCount - 1 do
					local var_244_3 = var_244_2:GetChild(iter_244_1)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				var_244_2.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_241_1.time_ - 0) / var_244_4)
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				var_244_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_244_5 = arg_241_1.actors_["10063"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.actorSpriteComps10063 == nil then
				arg_241_1.var_.actorSpriteComps10063 = var_244_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_6 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 and not isNil(var_244_5) then
				if arg_241_1.var_.actorSpriteComps10063 then
					for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_244_3 then
							if arg_241_1.isInRecall_ then
								iter_244_3.color = Color.New(Mathf.Lerp(iter_244_3.color.r, arg_241_1.hightColor2.r, (arg_241_1.time_ - 0) / var_244_6), Mathf.Lerp(iter_244_3.color.g, arg_241_1.hightColor2.g, (arg_241_1.time_ - 0) / var_244_6), (Mathf.Lerp(iter_244_3.color.b, arg_241_1.hightColor2.b, (arg_241_1.time_ - 0) / var_244_6)))
							else
								local var_244_7 = Mathf.Lerp(iter_244_3.color.r, 0.5, (arg_241_1.time_ - 0) / var_244_6)

								iter_244_3.color = Color.New(var_244_7, var_244_7, var_244_7)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.actorSpriteComps10063 then
				for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_244_5 then
						iter_244_5.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps10063 = nil
			end

			local var_244_8 = arg_241_1.actors_["1061"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps1061 == nil then
				arg_241_1.var_.actorSpriteComps1061 = var_244_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_9 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_9 and not isNil(var_244_8) then
				if arg_241_1.var_.actorSpriteComps1061 then
					for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_244_7 then
							if arg_241_1.isInRecall_ then
								iter_244_7.color = Color.New(Mathf.Lerp(iter_244_7.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_9), Mathf.Lerp(iter_244_7.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_9), (Mathf.Lerp(iter_244_7.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_9)))
							else
								local var_244_10 = Mathf.Lerp(iter_244_7.color.r, 1, (arg_241_1.time_ - 0) / var_244_9)

								iter_244_7.color = Color.New(var_244_10, var_244_10, var_244_10)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_9 and arg_241_1.time_ < 0 + var_244_9 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps1061 then
				for iter_244_8, iter_244_9 in pairs(arg_241_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_244_9 then
						iter_244_9.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1061 = nil
			end

			local var_244_11 = 0
			local var_244_12 = 0.525

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_13 = arg_241_1:GetWordFromCfg(410202058)
				local var_244_14 = arg_241_1:FormatText(var_244_13.content)

				arg_241_1.text_.text = var_244_14

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_16 = 21 <= 0 and var_244_12 or var_244_12 * (utf8.len(var_244_14) / 21)

				if (21 <= 0 and var_244_12 or var_244_12 * (utf8.len(var_244_14) / 21)) > 0 and var_244_12 < var_244_16 then
					arg_241_1.talkMaxDuration = var_244_16

					if var_244_16 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_11
					end
				end

				arg_241_1.text_.text = var_244_14
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202058", "story_v_out_410202.awb") ~= 0 then
					local var_244_17 = manager.audio:GetVoiceLength("story_v_out_410202", "410202058", "story_v_out_410202.awb") / 1000

					if var_244_17 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_17 + var_244_11
					end

					if var_244_13.prefab_name ~= "" and arg_241_1.actors_[var_244_13.prefab_name] ~= nil then
						local var_244_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_13.prefab_name].transform, "story_v_out_410202", "410202058", "story_v_out_410202.awb")

						arg_241_1:RecordAudio("410202058", var_244_18)
						arg_241_1:RecordAudio("410202058", var_244_18)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410202", "410202058", "story_v_out_410202.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410202", "410202058", "story_v_out_410202.awb")
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
				actorName = "10063",
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

		arg_241_1:InitPlayNodeList()
	end,
	Play410202059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410202059
		arg_245_1.duration_ = 6.07

		local var_245_0 = {
			ja = 6.066,
			CriLanguages = 5.266,
			zh = 5.266
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
				arg_245_0:Play410202060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1061 = arg_245_1.actors_["1061"].transform.localPosition
				arg_245_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1061", 3)

				for iter_248_0 = 0, arg_245_1.actors_["1061"].transform.childCount - 1 do
					local var_248_0 = arg_245_1.actors_["1061"].transform:GetChild(iter_248_0)

					if var_248_0.name == "" or not string.find(var_248_0.name, "split") then
						var_248_0.gameObject:SetActive(true)
					else
						var_248_0.gameObject:SetActive(false)
					end
				end
			end

			local var_248_1 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				arg_245_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_245_1.time_ - 0) / var_248_1)
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 then
				arg_245_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_248_2 = arg_245_1.actors_["1061"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1061 == nil then
				arg_245_1.var_.actorSpriteComps1061 = var_248_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_3 = 0.034

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.actorSpriteComps1061 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1061 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_248_4 then
						iter_248_4.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_245_1.var_.actorSpriteComps1061 = nil
			end

			local var_248_5 = 0
			local var_248_6 = 0.6

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_7 = arg_245_1:GetWordFromCfg(410202059)
				local var_248_8 = arg_245_1:FormatText(var_248_7.content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 24 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 24)

				if (24 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 24)) > 0 and var_248_6 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10

					if var_248_10 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202059", "story_v_out_410202.awb") ~= 0 then
					local var_248_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202059", "story_v_out_410202.awb") / 1000

					if var_248_11 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_5
					end

					if var_248_7.prefab_name ~= "" and arg_245_1.actors_[var_248_7.prefab_name] ~= nil then
						local var_248_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_7.prefab_name].transform, "story_v_out_410202", "410202059", "story_v_out_410202.awb")

						arg_245_1:RecordAudio("410202059", var_248_12)
						arg_245_1:RecordAudio("410202059", var_248_12)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410202", "410202059", "story_v_out_410202.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410202", "410202059", "story_v_out_410202.awb")
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
				actorName = "1061",
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
	Play410202060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410202060
		arg_249_1.duration_ = 7.5

		local var_249_0 = {
			ja = 7.5,
			CriLanguages = 4.266,
			zh = 4.266
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
				arg_249_0:Play410202061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1061"]) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = arg_249_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1061"]) then
				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								iter_252_1.color = Color.New(Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_0), Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_0), (Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_0)))
							else
								local var_252_1 = Mathf.Lerp(iter_252_1.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_0)

								iter_252_1.color = Color.New(var_252_1, var_252_1, var_252_1)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1061"]) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_2 = 0
			local var_252_3 = 0.575

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_4 = arg_249_1:GetWordFromCfg(410202060)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 23 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 23)

				if (23 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 23)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202060", "story_v_out_410202.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_410202", "410202060", "story_v_out_410202.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_out_410202", "410202060", "story_v_out_410202.awb")

						arg_249_1:RecordAudio("410202060", var_252_9)
						arg_249_1:RecordAudio("410202060", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410202", "410202060", "story_v_out_410202.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410202", "410202060", "story_v_out_410202.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play410202061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410202061
		arg_253_1.duration_ = 9.97

		local var_253_0 = {
			ja = 9.666,
			CriLanguages = 9.966,
			zh = 9.966
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
				arg_253_0:Play410202062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.25

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(410202061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 50 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 50)

				if (50 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 50)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202061", "story_v_out_410202.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202061", "story_v_out_410202.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_410202", "410202061", "story_v_out_410202.awb")

						arg_253_1:RecordAudio("410202061", var_256_6)
						arg_253_1:RecordAudio("410202061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410202", "410202061", "story_v_out_410202.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410202", "410202061", "story_v_out_410202.awb")
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
	Play410202062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410202062
		arg_257_1.duration_ = 12.73

		local var_257_0 = {
			ja = 12.733,
			CriLanguages = 9.566,
			zh = 9.566
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
				arg_257_0:Play410202063(arg_257_1)
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
			local var_260_6 = 0.9

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

				local var_260_7 = arg_257_1:GetWordFromCfg(410202062)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 36 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 36)

				if (36 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 36)) > 0 and var_260_6 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202062", "story_v_out_410202.awb") ~= 0 then
					local var_260_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202062", "story_v_out_410202.awb") / 1000

					if var_260_11 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_5
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_410202", "410202062", "story_v_out_410202.awb")

						arg_257_1:RecordAudio("410202062", var_260_12)
						arg_257_1:RecordAudio("410202062", var_260_12)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410202", "410202062", "story_v_out_410202.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410202", "410202062", "story_v_out_410202.awb")
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
	Play410202063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410202063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play410202064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1061 = arg_261_1.actors_["1061"].transform.localPosition
				arg_261_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1061", 7)

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
				arg_261_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
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
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 1

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(410202063).content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 40 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_7) / 40)

				if (40 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_7) / 40)) > 0 and var_264_6 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_10 and arg_261_1.time_ < var_264_5 + var_264_10 + arg_264_0 then
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
	Play410202064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410202064
		arg_265_1.duration_ = 6.73

		local var_265_0 = {
			ja = 6.733,
			CriLanguages = 6,
			zh = 6
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
				arg_265_0:Play410202065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.475

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[608].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:GetWordFromCfg(410202064)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 19 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 19)

				if (19 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 19)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202064", "story_v_out_410202.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202064", "story_v_out_410202.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_410202", "410202064", "story_v_out_410202.awb")

						arg_265_1:RecordAudio("410202064", var_268_6)
						arg_265_1:RecordAudio("410202064", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410202", "410202064", "story_v_out_410202.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410202", "410202064", "story_v_out_410202.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play410202065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410202065
		arg_269_1.duration_ = 6.77

		local var_269_0 = {
			ja = 6.566,
			CriLanguages = 6.766,
			zh = 6.766
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
				arg_269_0:Play410202066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1061 = arg_269_1.actors_["1061"].transform.localPosition
				arg_269_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1061", 3)

				for iter_272_0 = 0, arg_269_1.actors_["1061"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["1061"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_5" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_272_2 = arg_269_1.actors_["1061"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_5 = 0
			local var_272_6 = 0.725

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:GetWordFromCfg(410202065)
				local var_272_8 = arg_269_1:FormatText(var_272_7.content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 29 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 29)

				if (29 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 29)) > 0 and var_272_6 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202065", "story_v_out_410202.awb") ~= 0 then
					local var_272_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202065", "story_v_out_410202.awb") / 1000

					if var_272_11 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_5
					end

					if var_272_7.prefab_name ~= "" and arg_269_1.actors_[var_272_7.prefab_name] ~= nil then
						local var_272_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_7.prefab_name].transform, "story_v_out_410202", "410202065", "story_v_out_410202.awb")

						arg_269_1:RecordAudio("410202065", var_272_12)
						arg_269_1:RecordAudio("410202065", var_272_12)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410202", "410202065", "story_v_out_410202.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410202", "410202065", "story_v_out_410202.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_13 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_13 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_13

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_13 and arg_269_1.time_ < var_272_5 + var_272_13 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play410202066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410202066
		arg_273_1.duration_ = 4.3

		local var_273_0 = {
			ja = 4.3,
			CriLanguages = 3.566,
			zh = 3.566
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
				arg_273_0:Play410202067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1061"]) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = arg_273_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_0 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1061"]) then
				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								iter_276_1.color = Color.New(Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_0), Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_0), (Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_0)))
							else
								local var_276_1 = Mathf.Lerp(iter_276_1.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_0)

								iter_276_1.color = Color.New(var_276_1, var_276_1, var_276_1)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1061"]) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_2 = 0
			local var_276_3 = 0.375

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[610].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_4 = arg_273_1:GetWordFromCfg(410202066)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_7 = 15 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 15)

				if (15 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 15)) > 0 and var_276_3 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202066", "story_v_out_410202.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_410202", "410202066", "story_v_out_410202.awb") / 1000

					if var_276_8 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_2
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_out_410202", "410202066", "story_v_out_410202.awb")

						arg_273_1:RecordAudio("410202066", var_276_9)
						arg_273_1:RecordAudio("410202066", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410202", "410202066", "story_v_out_410202.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410202", "410202066", "story_v_out_410202.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_10 and arg_273_1.time_ < var_276_2 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play410202067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410202067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play410202068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = arg_277_1.actors_["1061"].transform.localPosition
				arg_277_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 7)

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
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
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
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 1.65

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(410202067).content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 66 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_7) / 66)

				if (66 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_7) / 66)) > 0 and var_280_6 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_10 and arg_277_1.time_ < var_280_5 + var_280_10 + arg_280_0 then
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
	Play410202068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410202068
		arg_281_1.duration_ = 6.4

		local var_281_0 = {
			ja = 6.4,
			CriLanguages = 3.766,
			zh = 3.766
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
				arg_281_0:Play410202069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.45

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
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

				local var_284_1 = arg_281_1:GetWordFromCfg(410202068)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 18 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 18)

				if (18 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 18)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202068", "story_v_out_410202.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202068", "story_v_out_410202.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_410202", "410202068", "story_v_out_410202.awb")

						arg_281_1:RecordAudio("410202068", var_284_6)
						arg_281_1:RecordAudio("410202068", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410202", "410202068", "story_v_out_410202.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410202", "410202068", "story_v_out_410202.awb")
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
	Play410202069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410202069
		arg_285_1.duration_ = 5.17

		local var_285_0 = {
			ja = 5.166,
			CriLanguages = 4.733,
			zh = 4.733
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
				arg_285_0:Play410202070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.625

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(410202069)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 25 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 25)

				if (25 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 25)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202069", "story_v_out_410202.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202069", "story_v_out_410202.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_410202", "410202069", "story_v_out_410202.awb")

						arg_285_1:RecordAudio("410202069", var_288_6)
						arg_285_1:RecordAudio("410202069", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410202", "410202069", "story_v_out_410202.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410202", "410202069", "story_v_out_410202.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play410202070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410202070
		arg_289_1.duration_ = 12

		local var_289_0 = {
			ja = 8.333,
			CriLanguages = 12,
			zh = 12
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
				arg_289_0:Play410202071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.225

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[610].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:GetWordFromCfg(410202070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 49 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 49)

				if (49 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 49)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202070", "story_v_out_410202.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202070", "story_v_out_410202.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_410202", "410202070", "story_v_out_410202.awb")

						arg_289_1:RecordAudio("410202070", var_292_6)
						arg_289_1:RecordAudio("410202070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410202", "410202070", "story_v_out_410202.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410202", "410202070", "story_v_out_410202.awb")
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
	Play410202071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410202071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play410202072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.95

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(410202071).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 78 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 78)

				if (78 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 78)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play410202072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410202072
		arg_297_1.duration_ = 8.63

		local var_297_0 = {
			ja = 8.633,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_297_0:Play410202073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1061 = arg_297_1.actors_["1061"].transform.localPosition
				arg_297_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1061", 3)

				for iter_300_0 = 0, arg_297_1.actors_["1061"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["1061"].transform:GetChild(iter_300_0)

					if var_300_0.name == "" or not string.find(var_300_0.name, "split") then
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
			local var_300_6 = 0.55

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

				local var_300_7 = arg_297_1:GetWordFromCfg(410202072)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 22 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 22)

				if (22 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 22)) > 0 and var_300_6 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202072", "story_v_out_410202.awb") ~= 0 then
					local var_300_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202072", "story_v_out_410202.awb") / 1000

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_410202", "410202072", "story_v_out_410202.awb")

						arg_297_1:RecordAudio("410202072", var_300_12)
						arg_297_1:RecordAudio("410202072", var_300_12)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410202", "410202072", "story_v_out_410202.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410202", "410202072", "story_v_out_410202.awb")
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
	Play410202073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410202073
		arg_301_1.duration_ = 5.6

		local var_301_0 = {
			ja = 5.6,
			CriLanguages = 3.533,
			zh = 3.533
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
				arg_301_0:Play410202074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.4

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(410202073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 16 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 16)

				if (16 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 16)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202073", "story_v_out_410202.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_410202", "410202073", "story_v_out_410202.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_410202", "410202073", "story_v_out_410202.awb")

						arg_301_1:RecordAudio("410202073", var_304_6)
						arg_301_1:RecordAudio("410202073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410202", "410202073", "story_v_out_410202.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410202", "410202073", "story_v_out_410202.awb")
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
	Play410202074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410202074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play410202075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1061"]) and arg_305_1.var_.actorSpriteComps1061 == nil then
				arg_305_1.var_.actorSpriteComps1061 = arg_305_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1061"]) then
				if arg_305_1.var_.actorSpriteComps1061 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								iter_308_1.color = Color.New(Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_0), Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_0), (Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_0)))
							else
								local var_308_1 = Mathf.Lerp(iter_308_1.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_0)

								iter_308_1.color = Color.New(var_308_1, var_308_1, var_308_1)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1061"]) and arg_305_1.var_.actorSpriteComps1061 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps1061 = nil
			end

			local var_308_2 = 0
			local var_308_3 = 1.625

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_4 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(410202074).content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_6 = 65 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_4) / 65)

				if (65 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_4) / 65)) > 0 and var_308_3 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_2
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_3, arg_305_1.talkMaxDuration)

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_2) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_2 + var_308_7 and arg_305_1.time_ < var_308_2 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play410202075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410202075
		arg_309_1.duration_ = 12.23

		local var_309_0 = {
			ja = 12.233,
			CriLanguages = 6.533,
			zh = 6.533
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
				arg_309_0:Play410202076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1061 = arg_309_1.actors_["1061"].transform.localPosition
				arg_309_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1061", 3)

				for iter_312_0 = 0, arg_309_1.actors_["1061"].transform.childCount - 1 do
					local var_312_0 = arg_309_1.actors_["1061"].transform:GetChild(iter_312_0)

					if var_312_0.name == "" or not string.find(var_312_0.name, "split") then
						var_312_0.gameObject:SetActive(true)
					else
						var_312_0.gameObject:SetActive(false)
					end
				end
			end

			local var_312_1 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 then
				arg_309_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_309_1.time_ - 0) / var_312_1)
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 then
				arg_309_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_312_2 = arg_309_1.actors_["1061"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1061 == nil then
				arg_309_1.var_.actorSpriteComps1061 = var_312_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_3 = 0.034

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.actorSpriteComps1061 then
					for iter_312_1, iter_312_2 in pairs(arg_309_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1061 then
				for iter_312_3, iter_312_4 in pairs(arg_309_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_312_4 then
						iter_312_4.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps1061 = nil
			end

			local var_312_5 = 0
			local var_312_6 = 0.875

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(410202075)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 35 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 35)

				if (35 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 35)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202075", "story_v_out_410202.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202075", "story_v_out_410202.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_410202", "410202075", "story_v_out_410202.awb")

						arg_309_1:RecordAudio("410202075", var_312_12)
						arg_309_1:RecordAudio("410202075", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410202", "410202075", "story_v_out_410202.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410202", "410202075", "story_v_out_410202.awb")
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

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play410202076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410202076
		arg_313_1.duration_ = 17.2

		local var_313_0 = {
			ja = 17.2,
			CriLanguages = 8.233,
			zh = 8.233
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
				arg_313_0:Play410202077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1061 = arg_313_1.actors_["1061"].transform.localPosition
				arg_313_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1061", 3)

				for iter_316_0 = 0, arg_313_1.actors_["1061"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["1061"].transform:GetChild(iter_316_0)

					if var_316_0.name == "" or not string.find(var_316_0.name, "split") then
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
			local var_316_6 = 0.975

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

				local var_316_7 = arg_313_1:GetWordFromCfg(410202076)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 39 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 39)

				if (39 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 39)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202076", "story_v_out_410202.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202076", "story_v_out_410202.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_410202", "410202076", "story_v_out_410202.awb")

						arg_313_1:RecordAudio("410202076", var_316_12)
						arg_313_1:RecordAudio("410202076", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410202", "410202076", "story_v_out_410202.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410202", "410202076", "story_v_out_410202.awb")
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
	Play410202077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410202077
		arg_317_1.duration_ = 8.83

		local var_317_0 = {
			ja = 8.833,
			CriLanguages = 6.666,
			zh = 6.666
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
				arg_317_0:Play410202078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1061 = arg_317_1.actors_["1061"].transform.localPosition
				arg_317_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1061", 7)

				for iter_320_0 = 0, arg_317_1.actors_["1061"].transform.childCount - 1 do
					local var_320_0 = arg_317_1.actors_["1061"].transform:GetChild(iter_320_0)

					if var_320_0.name == "" or not string.find(var_320_0.name, "split") then
						var_320_0.gameObject:SetActive(true)
					else
						var_320_0.gameObject:SetActive(false)
					end
				end
			end

			local var_320_1 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 then
				arg_317_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_317_1.time_ - 0) / var_320_1)
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 then
				arg_317_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_320_2 = arg_317_1.actors_["10063"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10063 = var_320_2.localPosition
				var_320_2.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10063", 3)

				for iter_320_1 = 0, var_320_2.childCount - 1 do
					local var_320_3 = var_320_2:GetChild(iter_320_1)

					if var_320_3.name == "split_4" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_2.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10063, Vector3.New(0, -535, -105), (arg_317_1.time_ - 0) / var_320_4)
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_2.localPosition = Vector3.New(0, -535, -105)
			end

			local var_320_5 = arg_317_1.actors_["1061"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.actorSpriteComps1061 == nil then
				arg_317_1.var_.actorSpriteComps1061 = var_320_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_6 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.actorSpriteComps1061 then
					for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_320_3 then
							if arg_317_1.isInRecall_ then
								iter_320_3.color = Color.New(Mathf.Lerp(iter_320_3.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_6), Mathf.Lerp(iter_320_3.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_6), (Mathf.Lerp(iter_320_3.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_6)))
							else
								local var_320_7 = Mathf.Lerp(iter_320_3.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_6)

								iter_320_3.color = Color.New(var_320_7, var_320_7, var_320_7)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.actorSpriteComps1061 then
				for iter_320_4, iter_320_5 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_320_5 then
						iter_320_5.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps1061 = nil
			end

			local var_320_8 = arg_317_1.actors_["10063"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.actorSpriteComps10063 == nil then
				arg_317_1.var_.actorSpriteComps10063 = var_320_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_9 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_9 and not isNil(var_320_8) then
				if arg_317_1.var_.actorSpriteComps10063 then
					for iter_320_6, iter_320_7 in pairs(arg_317_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_320_7 then
							if arg_317_1.isInRecall_ then
								iter_320_7.color = Color.New(Mathf.Lerp(iter_320_7.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_9), Mathf.Lerp(iter_320_7.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_9), (Mathf.Lerp(iter_320_7.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_9)))
							else
								local var_320_10 = Mathf.Lerp(iter_320_7.color.r, 1, (arg_317_1.time_ - 0) / var_320_9)

								iter_320_7.color = Color.New(var_320_10, var_320_10, var_320_10)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_9 and arg_317_1.time_ < 0 + var_320_9 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.actorSpriteComps10063 then
				for iter_320_8, iter_320_9 in pairs(arg_317_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_320_9 then
						iter_320_9.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps10063 = nil
			end

			local var_320_11 = 0
			local var_320_12 = 0.375

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_13 = arg_317_1:GetWordFromCfg(410202077)
				local var_320_14 = arg_317_1:FormatText(var_320_13.content)

				arg_317_1.text_.text = var_320_14

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_16 = 14 <= 0 and var_320_12 or var_320_12 * (utf8.len(var_320_14) / 14)

				if (14 <= 0 and var_320_12 or var_320_12 * (utf8.len(var_320_14) / 14)) > 0 and var_320_12 < var_320_16 then
					arg_317_1.talkMaxDuration = var_320_16

					if var_320_16 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_16 + var_320_11
					end
				end

				arg_317_1.text_.text = var_320_14
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202077", "story_v_out_410202.awb") ~= 0 then
					local var_320_17 = manager.audio:GetVoiceLength("story_v_out_410202", "410202077", "story_v_out_410202.awb") / 1000

					if var_320_17 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_17 + var_320_11
					end

					if var_320_13.prefab_name ~= "" and arg_317_1.actors_[var_320_13.prefab_name] ~= nil then
						local var_320_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_13.prefab_name].transform, "story_v_out_410202", "410202077", "story_v_out_410202.awb")

						arg_317_1:RecordAudio("410202077", var_320_18)
						arg_317_1:RecordAudio("410202077", var_320_18)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410202", "410202077", "story_v_out_410202.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410202", "410202077", "story_v_out_410202.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_19 = math.max(var_320_12, arg_317_1.talkMaxDuration)

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_19 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_11) / var_320_19

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_11 + var_320_19 and arg_317_1.time_ < var_320_11 + var_320_19 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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
				actorName = "10063",
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
	Play410202078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410202078
		arg_321_1.duration_ = 4.83

		local var_321_0 = {
			ja = 4.833,
			CriLanguages = 2.9,
			zh = 2.9
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
				arg_321_0:Play410202079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10063 = arg_321_1.actors_["10063"].transform.localPosition
				arg_321_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10063", 7)

				for iter_324_0 = 0, arg_321_1.actors_["10063"].transform.childCount - 1 do
					local var_324_0 = arg_321_1.actors_["10063"].transform:GetChild(iter_324_0)

					if var_324_0.name == "" or not string.find(var_324_0.name, "split") then
						var_324_0.gameObject:SetActive(true)
					else
						var_324_0.gameObject:SetActive(false)
					end
				end
			end

			local var_324_1 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 then
				arg_321_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_321_1.time_ - 0) / var_324_1)
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 then
				arg_321_1.actors_["10063"].transform.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_324_2 = arg_321_1.actors_["1061"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1061 = var_324_2.localPosition
				var_324_2.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1061", 3)

				for iter_324_1 = 0, var_324_2.childCount - 1 do
					local var_324_3 = var_324_2:GetChild(iter_324_1)

					if var_324_3.name == "" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_2.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_321_1.time_ - 0) / var_324_4)
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_324_5 = arg_321_1.actors_["10063"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.actorSpriteComps10063 == nil then
				arg_321_1.var_.actorSpriteComps10063 = var_324_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_6 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_6 and not isNil(var_324_5) then
				if arg_321_1.var_.actorSpriteComps10063 then
					for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_324_3 then
							if arg_321_1.isInRecall_ then
								iter_324_3.color = Color.New(Mathf.Lerp(iter_324_3.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 0) / var_324_6), Mathf.Lerp(iter_324_3.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 0) / var_324_6), (Mathf.Lerp(iter_324_3.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 0) / var_324_6)))
							else
								local var_324_7 = Mathf.Lerp(iter_324_3.color.r, 0.5, (arg_321_1.time_ - 0) / var_324_6)

								iter_324_3.color = Color.New(var_324_7, var_324_7, var_324_7)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_6 and arg_321_1.time_ < 0 + var_324_6 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.actorSpriteComps10063 then
				for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_324_5 then
						iter_324_5.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps10063 = nil
			end

			local var_324_8 = arg_321_1.actors_["1061"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_8) and arg_321_1.var_.actorSpriteComps1061 == nil then
				arg_321_1.var_.actorSpriteComps1061 = var_324_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_9 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_9 and not isNil(var_324_8) then
				if arg_321_1.var_.actorSpriteComps1061 then
					for iter_324_6, iter_324_7 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_324_7 then
							if arg_321_1.isInRecall_ then
								iter_324_7.color = Color.New(Mathf.Lerp(iter_324_7.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_9), Mathf.Lerp(iter_324_7.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_9), (Mathf.Lerp(iter_324_7.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_9)))
							else
								local var_324_10 = Mathf.Lerp(iter_324_7.color.r, 1, (arg_321_1.time_ - 0) / var_324_9)

								iter_324_7.color = Color.New(var_324_10, var_324_10, var_324_10)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_9 and arg_321_1.time_ < 0 + var_324_9 + arg_324_0 and not isNil(var_324_8) and arg_321_1.var_.actorSpriteComps1061 then
				for iter_324_8, iter_324_9 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_324_9 then
						iter_324_9.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps1061 = nil
			end

			local var_324_11 = 0
			local var_324_12 = 0.325

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
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

				local var_324_13 = arg_321_1:GetWordFromCfg(410202078)
				local var_324_14 = arg_321_1:FormatText(var_324_13.content)

				arg_321_1.text_.text = var_324_14

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_16 = 13 <= 0 and var_324_12 or var_324_12 * (utf8.len(var_324_14) / 13)

				if (13 <= 0 and var_324_12 or var_324_12 * (utf8.len(var_324_14) / 13)) > 0 and var_324_12 < var_324_16 then
					arg_321_1.talkMaxDuration = var_324_16

					if var_324_16 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_16 + var_324_11
					end
				end

				arg_321_1.text_.text = var_324_14
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202078", "story_v_out_410202.awb") ~= 0 then
					local var_324_17 = manager.audio:GetVoiceLength("story_v_out_410202", "410202078", "story_v_out_410202.awb") / 1000

					if var_324_17 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_17 + var_324_11
					end

					if var_324_13.prefab_name ~= "" and arg_321_1.actors_[var_324_13.prefab_name] ~= nil then
						local var_324_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_13.prefab_name].transform, "story_v_out_410202", "410202078", "story_v_out_410202.awb")

						arg_321_1:RecordAudio("410202078", var_324_18)
						arg_321_1:RecordAudio("410202078", var_324_18)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410202", "410202078", "story_v_out_410202.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410202", "410202078", "story_v_out_410202.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_19 = math.max(var_324_12, arg_321_1.talkMaxDuration)

			if var_324_11 <= arg_321_1.time_ and arg_321_1.time_ < var_324_11 + var_324_19 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_11) / var_324_19

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_11 + var_324_19 and arg_321_1.time_ < var_324_11 + var_324_19 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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

		arg_321_1:InitPlayNodeList()
	end,
	Play410202079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410202079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play410202080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1061"]) and arg_325_1.var_.actorSpriteComps1061 == nil then
				arg_325_1.var_.actorSpriteComps1061 = arg_325_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.034

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1061"]) then
				if arg_325_1.var_.actorSpriteComps1061 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1061"]) and arg_325_1.var_.actorSpriteComps1061 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps1061 = nil
			end

			local var_328_2 = 0
			local var_328_3 = 0.975

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(410202079).content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 39 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 39)

				if (39 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 39)) > 0 and var_328_3 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_7 and arg_325_1.time_ < var_328_2 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play410202080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410202080
		arg_329_1.duration_ = 16.6

		local var_329_0 = {
			ja = 16.6,
			CriLanguages = 9.266,
			zh = 9.266
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
				arg_329_0:Play410202081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1061 = arg_329_1.actors_["1061"].transform.localPosition
				arg_329_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1061", 3)

				for iter_332_0 = 0, arg_329_1.actors_["1061"].transform.childCount - 1 do
					local var_332_0 = arg_329_1.actors_["1061"].transform:GetChild(iter_332_0)

					if var_332_0.name == "" or not string.find(var_332_0.name, "split") then
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
			local var_332_6 = 0.875

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

				local var_332_7 = arg_329_1:GetWordFromCfg(410202080)
				local var_332_8 = arg_329_1:FormatText(var_332_7.content)

				arg_329_1.text_.text = var_332_8

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 35 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 35)

				if (35 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 35)) > 0 and var_332_6 < var_332_10 then
					arg_329_1.talkMaxDuration = var_332_10

					if var_332_10 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_5
					end
				end

				arg_329_1.text_.text = var_332_8
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202080", "story_v_out_410202.awb") ~= 0 then
					local var_332_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202080", "story_v_out_410202.awb") / 1000

					if var_332_11 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_11 + var_332_5
					end

					if var_332_7.prefab_name ~= "" and arg_329_1.actors_[var_332_7.prefab_name] ~= nil then
						local var_332_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_7.prefab_name].transform, "story_v_out_410202", "410202080", "story_v_out_410202.awb")

						arg_329_1:RecordAudio("410202080", var_332_12)
						arg_329_1:RecordAudio("410202080", var_332_12)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_410202", "410202080", "story_v_out_410202.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_410202", "410202080", "story_v_out_410202.awb")
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
	Play410202081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410202081
		arg_333_1.duration_ = 4.97

		local var_333_0 = {
			ja = 2.966,
			CriLanguages = 4.966,
			zh = 4.966
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
			local var_336_6 = 0.4

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

				local var_336_7 = arg_333_1:GetWordFromCfg(410202081)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 16 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 16)

				if (16 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 16)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410202", "410202081", "story_v_out_410202.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_410202", "410202081", "story_v_out_410202.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_410202", "410202081", "story_v_out_410202.awb")

						arg_333_1:RecordAudio("410202081", var_336_12)
						arg_333_1:RecordAudio("410202081", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410202", "410202081", "story_v_out_410202.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410202", "410202081", "story_v_out_410202.awb")
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
	assets = {
		"TextureConfig/Background/L04f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/LZ0204",
		"TextureConfig/Background/ST66",
		"TextureConfig/Background/ST64a"
	},
	voices = {
		"story_v_out_410202.awb"
	}
}
