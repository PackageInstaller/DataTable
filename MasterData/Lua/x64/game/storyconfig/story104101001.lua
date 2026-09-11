return {
	Play410101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410101001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			zh = 4.5,
			ja = 4.1
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
				arg_1_0:Play410101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J02c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02c")
				var_4_0.name = "J02c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J02c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J02c

				arg_1_1.bgs_.J02c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J02c" then
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

			local var_4_8 = "10064"

			if arg_1_1.actors_["10064"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10064")

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

			local var_4_11 = arg_1_1.actors_["10064"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10064 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10064", 3)

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
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_4_14 = arg_1_1.actors_["10064"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10064 == nil then
				arg_1_1.var_.actorSpriteComps10064 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps10064 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10064 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10064 = nil
			end

			local var_4_17 = 0

			arg_1_1.isInRecall_ = false

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					for iter_4_11, iter_4_12 in ipairs((iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_12.color = iter_4_12.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_18 = 0.0339999999999998

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_17) / var_4_18)
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 2
			local var_4_26 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(410101001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)

				if (10 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 10)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101001", "story_v_out_410101.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_410101", "410101001", "story_v_out_410101.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_410101", "410101001", "story_v_out_410101.awb")

						arg_1_1:RecordAudio("410101001", var_4_33)
						arg_1_1:RecordAudio("410101001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410101", "410101001", "story_v_out_410101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410101", "410101001", "story_v_out_410101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410101002
		arg_9_1.duration_ = 6.27

		local var_9_0 = {
			zh = 3.633,
			ja = 6.266
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
				arg_9_0:Play410101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10064"]) and arg_9_1.var_.actorSpriteComps10064 == nil then
				arg_9_1.var_.actorSpriteComps10064 = arg_9_1.actors_["10064"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10064"]) then
				if arg_9_1.var_.actorSpriteComps10064 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10064"]) and arg_9_1.var_.actorSpriteComps10064 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10064 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 0.475

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012_split_1")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_4 = arg_9_1:GetWordFromCfg(410101002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 19 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 19)

				if (19 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 19)) > 0 and var_12_3 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101002", "story_v_out_410101.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101002", "story_v_out_410101.awb") / 1000

					if var_12_8 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_2
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_410101", "410101002", "story_v_out_410101.awb")

						arg_9_1:RecordAudio("410101002", var_12_9)
						arg_9_1:RecordAudio("410101002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410101", "410101002", "story_v_out_410101.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410101", "410101002", "story_v_out_410101.awb")
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
	Play410101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410101003
		arg_13_1.duration_ = 6.93

		local var_13_0 = {
			zh = 5.333,
			ja = 6.933
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
				arg_13_0:Play410101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10064 = arg_13_1.actors_["10064"].transform.localPosition
				arg_13_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10064", 3)

				for iter_16_0 = 0, arg_13_1.actors_["10064"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10064"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_16_2 = arg_13_1.actors_["10064"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10064 == nil then
				arg_13_1.var_.actorSpriteComps10064 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10064 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								iter_16_2.color = Color.New(Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_2.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_2.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10064 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10064 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.725

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(410101003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 29 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 29)

				if (29 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 29)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101003", "story_v_out_410101.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101003", "story_v_out_410101.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_410101", "410101003", "story_v_out_410101.awb")

						arg_13_1:RecordAudio("410101003", var_16_12)
						arg_13_1:RecordAudio("410101003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410101", "410101003", "story_v_out_410101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410101", "410101003", "story_v_out_410101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_13 and arg_13_1.time_ < var_16_5 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410101004
		arg_17_1.duration_ = 10.33

		local var_17_0 = {
			zh = 6.033,
			ja = 10.333
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
				arg_17_0:Play410101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10064"]) and arg_17_1.var_.actorSpriteComps10064 == nil then
				arg_17_1.var_.actorSpriteComps10064 = arg_17_1.actors_["10064"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10064"]) then
				if arg_17_1.var_.actorSpriteComps10064 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10064"]) and arg_17_1.var_.actorSpriteComps10064 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10064 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.875

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012_split_3")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:GetWordFromCfg(410101004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 35 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 35)

				if (35 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 35)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101004", "story_v_out_410101.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101004", "story_v_out_410101.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_410101", "410101004", "story_v_out_410101.awb")

						arg_17_1:RecordAudio("410101004", var_20_9)
						arg_17_1:RecordAudio("410101004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410101", "410101004", "story_v_out_410101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410101", "410101004", "story_v_out_410101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410101005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play410101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10064 = arg_21_1.actors_["10064"].transform.localPosition
				arg_21_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10064", 7)

				for iter_24_0 = 0, arg_21_1.actors_["10064"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10064"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_24_2 = arg_21_1.actors_["10064"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10064 == nil then
				arg_21_1.var_.actorSpriteComps10064 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10064 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10064 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10064 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 1.6

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(410101005).content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 64 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 64)

				if (64 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 64)) > 0 and var_24_6 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_10 and arg_21_1.time_ < var_24_5 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1060"] == nil then
				local var_28_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_28_0) then
					local var_28_1 = Object.Instantiate(var_28_0, arg_25_1.canvasGo_.transform)

					var_28_1.transform:SetSiblingIndex(1)

					var_28_1.name = "1060"
					var_28_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_["1060"] = var_28_1

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs((var_28_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_2 = arg_25_1.actors_["1060"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1060 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1060", 7)

				for iter_28_2 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_2)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_28_5 = 0
			local var_28_6 = 1.525

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(410101006).content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 61 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 61)

				if (61 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 61)) > 0 and var_28_6 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_10 and arg_25_1.time_ < var_28_5 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play410101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410101007
		arg_29_1.duration_ = 4.27

		local var_29_0 = {
			zh = 1.833,
			ja = 4.266
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
				arg_29_0:Play410101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10064 = arg_29_1.actors_["10064"].transform.localPosition
				arg_29_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10064", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10064"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10064"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_32_2 = arg_29_1.actors_["10064"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10064 == nil then
				arg_29_1.var_.actorSpriteComps10064 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10064 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10064 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10064 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(410101007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 11 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 11)

				if (11 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 11)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101007", "story_v_out_410101.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101007", "story_v_out_410101.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_410101", "410101007", "story_v_out_410101.awb")

						arg_29_1:RecordAudio("410101007", var_32_12)
						arg_29_1:RecordAudio("410101007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410101", "410101007", "story_v_out_410101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410101", "410101007", "story_v_out_410101.awb")
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
				actorName = "10064",
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
	Play410101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410101008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10064 = arg_33_1.actors_["10064"].transform.localPosition
				arg_33_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10064", 7)

				for iter_36_0 = 0, arg_33_1.actors_["10064"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10064"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_36_2 = 0
			local var_36_3 = 0.35

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

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(410101008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 14 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 14)

				if (14 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 14)) > 0 and var_36_3 < var_36_6 then
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

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410101009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.STblack == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_40_0.name = "STblack"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.STblack = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.STblack

				arg_37_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "STblack" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_5 = 2

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_5 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_4) / var_40_5)
				arg_37_1.mask_.color = var_40_6
			end

			if arg_37_1.time_ >= var_40_4 + var_40_5 and arg_37_1.time_ < var_40_4 + var_40_5 + arg_40_0 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = 1
				arg_37_1.mask_.color = var_40_7
			end

			local var_40_8 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 then
				local var_40_10 = Color.New(0, 0, 0)

				var_40_10.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_8) / var_40_9)
				arg_37_1.mask_.color = var_40_10
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 then
				local var_40_11 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_11.a = 0
				arg_37_1.mask_.color = var_40_11
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_12 = 4
			local var_40_13 = 1.65

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_14 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_14:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(410101009).content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 66 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 66)

				if (66 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 66)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17
					var_40_12 = var_40_12 + 0.3

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = var_40_12 + 0.3
			local var_40_19 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_18) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_18 + var_40_19 and arg_37_1.time_ < var_40_18 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410101010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 410101010
		arg_43_1.duration_ = 8.5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play410101011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.bgs_.ST31a == nil then
				local var_46_0 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31a")
				var_46_0.name = "ST31a"
				var_46_0.transform.parent = arg_43_1.stage_.transform
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_.ST31a = var_46_0
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_1 = arg_43_1.bgs_.ST31a

				arg_43_1.bgs_.ST31a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_2 = var_46_1:GetComponent("SpriteRenderer")

				if var_46_2 and var_46_2.sprite then
					local var_46_3 = 2 * (var_46_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_1.transform.localScale = Vector3.New(var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "ST31a" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_4 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_5 = 3.5

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_5 then
				local var_46_6 = Color.New(0, 0, 0)

				var_46_6.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_4) / var_46_5)
				arg_43_1.mask_.color = var_46_6
			end

			if arg_43_1.time_ >= var_46_4 + var_46_5 and arg_43_1.time_ < var_46_4 + var_46_5 + arg_46_0 then
				local var_46_7 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_7.a = 0
				arg_43_1.mask_.color = var_46_7
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_8 = 3.5
			local var_46_9 = 0.625

			if 3.5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_10 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_10:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_11 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(410101010).content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 25 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 25)

				if (25 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 25)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13
					var_46_8 = var_46_8 + 0.3

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = var_46_8 + 0.3
			local var_46_15 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_14 + var_46_15 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_14) / var_46_15

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_14 + var_46_15 and arg_43_1.time_ < var_46_14 + var_46_15 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play410101011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410101011
		arg_49_1.duration_ = 1.3

		local var_49_0 = {
			zh = 1.3,
			ja = 1.266
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
				arg_49_0:Play410101012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["1012"] == nil then
				local var_52_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

				if not isNil(var_52_0) then
					local var_52_1 = Object.Instantiate(var_52_0, arg_49_1.canvasGo_.transform)

					var_52_1.transform:SetSiblingIndex(1)

					var_52_1.name = "1012"
					var_52_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_49_1.actors_["1012"] = var_52_1

					if arg_49_1.isInRecall_ then
						for iter_52_0, iter_52_1 in ipairs((var_52_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_52_1.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_52_2 = arg_49_1.actors_["1012"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1012 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1012", 3)

				for iter_52_2 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_2)

					if var_52_3.name == "split_3" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -465, 300)
			end

			local var_52_5 = arg_49_1.actors_["1012"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1012 == nil then
				arg_49_1.var_.actorSpriteComps1012 = var_52_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.actorSpriteComps1012 then
					for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_52_4 then
							if arg_49_1.isInRecall_ then
								iter_52_4.color = Color.New(Mathf.Lerp(iter_52_4.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_6), Mathf.Lerp(iter_52_4.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_6), (Mathf.Lerp(iter_52_4.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_6)))
							else
								local var_52_7 = Mathf.Lerp(iter_52_4.color.r, 1, (arg_49_1.time_ - 0) / var_52_6)

								iter_52_4.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1012 then
				for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_52_6 then
						iter_52_6.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1012 = nil
			end

			local var_52_8 = manager.ui.mainCamera.transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.shakeOldPos = var_52_8.localPosition
			end

			local var_52_9 = 0.5

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_9 then
				local var_52_10, var_52_11 = math.modf((arg_49_1.time_ - 0) / 0.066)

				var_52_8.localPosition = Vector3.New(var_52_11 * 0.13, var_52_11 * 0.13, var_52_11 * 0.13) + arg_49_1.var_.shakeOldPos
			end

			if arg_49_1.time_ >= 0 + var_52_9 and arg_49_1.time_ < 0 + var_52_9 + arg_52_0 then
				var_52_8.localPosition = arg_49_1.var_.shakeOldPos
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_table", "")
			end

			local var_52_13 = 0
			local var_52_14 = 0.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(410101011)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_18 = 3 <= 0 and var_52_14 or var_52_14 * (utf8.len(var_52_16) / 3)

				if (3 <= 0 and var_52_14 or var_52_14 * (utf8.len(var_52_16) / 3)) > 0 and var_52_14 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_13 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_13
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101011", "story_v_out_410101.awb") ~= 0 then
					local var_52_19 = manager.audio:GetVoiceLength("story_v_out_410101", "410101011", "story_v_out_410101.awb") / 1000

					if var_52_19 + var_52_13 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_13
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_410101", "410101011", "story_v_out_410101.awb")

						arg_49_1:RecordAudio("410101011", var_52_20)
						arg_49_1:RecordAudio("410101011", var_52_20)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410101", "410101011", "story_v_out_410101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410101", "410101011", "story_v_out_410101.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = math.max(var_52_14, arg_49_1.talkMaxDuration)

			if var_52_13 <= arg_49_1.time_ and arg_49_1.time_ < var_52_13 + var_52_21 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_13) / var_52_21

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_13 + var_52_21 and arg_49_1.time_ < var_52_13 + var_52_21 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410101012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410101012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410101013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1012"]) and arg_53_1.var_.actorSpriteComps1012 == nil then
				arg_53_1.var_.actorSpriteComps1012 = arg_53_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1012"]) then
				if arg_53_1.var_.actorSpriteComps1012 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1012"]) and arg_53_1.var_.actorSpriteComps1012 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1012 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 1.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(410101012).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 44 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 44)

				if (44 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 44)) > 0 and var_56_3 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_7 and arg_53_1.time_ < var_56_2 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410101013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410101013
		arg_57_1.duration_ = 12

		local var_57_0 = {
			zh = 10.2,
			ja = 12
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
				arg_57_0:Play410101014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1012 = arg_57_1.actors_["1012"].transform.localPosition
				arg_57_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1012", 2)

				for iter_60_0 = 0, arg_57_1.actors_["1012"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1012"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_3" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_60_2 = arg_57_1.actors_["1012"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1012 == nil then
				arg_57_1.var_.actorSpriteComps1012 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1012 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1012 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1012 = nil
			end

			local var_60_5 = arg_57_1.actors_["10064"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10064 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10064", 4)

				for iter_60_5 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_5)

					if var_60_6.name == "" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_60_8 = arg_57_1.actors_["10064"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10064 == nil then
				arg_57_1.var_.actorSpriteComps10064 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_9 and not isNil(var_60_8) then
				if arg_57_1.var_.actorSpriteComps10064 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_9 and arg_57_1.time_ < 0 + var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10064 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_60_9 then
						iter_60_9.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10064 = nil
			end

			local var_60_11 = 0
			local var_60_12 = 1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_13 = arg_57_1:GetWordFromCfg(410101013)
				local var_60_14 = arg_57_1:FormatText(var_60_13.content)

				arg_57_1.text_.text = var_60_14

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 40 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 40)

				if (40 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 40)) > 0 and var_60_12 < var_60_16 then
					arg_57_1.talkMaxDuration = var_60_16

					if var_60_16 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_14
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101013", "story_v_out_410101.awb") ~= 0 then
					local var_60_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101013", "story_v_out_410101.awb") / 1000

					if var_60_17 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_11
					end

					if var_60_13.prefab_name ~= "" and arg_57_1.actors_[var_60_13.prefab_name] ~= nil then
						local var_60_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_13.prefab_name].transform, "story_v_out_410101", "410101013", "story_v_out_410101.awb")

						arg_57_1:RecordAudio("410101013", var_60_18)
						arg_57_1:RecordAudio("410101013", var_60_18)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410101", "410101013", "story_v_out_410101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410101", "410101013", "story_v_out_410101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_19 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_19 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_19

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_19 and arg_57_1.time_ < var_60_11 + var_60_19 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410101014
		arg_61_1.duration_ = 17.17

		local var_61_0 = {
			zh = 9.666,
			ja = 17.166
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
				arg_61_0:Play410101015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.05

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(410101014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 42 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 42)

				if (42 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 42)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101014", "story_v_out_410101.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101014", "story_v_out_410101.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_410101", "410101014", "story_v_out_410101.awb")

						arg_61_1:RecordAudio("410101014", var_64_6)
						arg_61_1:RecordAudio("410101014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410101", "410101014", "story_v_out_410101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410101", "410101014", "story_v_out_410101.awb")
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
	Play410101015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410101015
		arg_65_1.duration_ = 15.63

		local var_65_0 = {
			zh = 12.5,
			ja = 15.633
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
				arg_65_0:Play410101016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.25

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(410101015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 50 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 50)

				if (50 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 50)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101015", "story_v_out_410101.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101015", "story_v_out_410101.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_410101", "410101015", "story_v_out_410101.awb")

						arg_65_1:RecordAudio("410101015", var_68_6)
						arg_65_1:RecordAudio("410101015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410101", "410101015", "story_v_out_410101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410101", "410101015", "story_v_out_410101.awb")
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
	Play410101016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410101016
		arg_69_1.duration_ = 11.23

		local var_69_0 = {
			zh = 6.1,
			ja = 11.233
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
				arg_69_0:Play410101017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1012 = arg_69_1.actors_["1012"].transform.localPosition
				arg_69_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1012", 2)

				for iter_72_0 = 0, arg_69_1.actors_["1012"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1012"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_3" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_72_2 = arg_69_1.actors_["1012"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1012 == nil then
				arg_69_1.var_.actorSpriteComps1012 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1012 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1012 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1012 = nil
			end

			local var_72_5 = arg_69_1.actors_["10064"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10064 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10064", 4)

				for iter_72_5 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_5)

					if var_72_6.name == "" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_72_8 = arg_69_1.actors_["10064"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10064 == nil then
				arg_69_1.var_.actorSpriteComps10064 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 and not isNil(var_72_8) then
				if arg_69_1.var_.actorSpriteComps10064 then
					for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_72_7 then
							if arg_69_1.isInRecall_ then
								iter_72_7.color = Color.New(Mathf.Lerp(iter_72_7.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_9), Mathf.Lerp(iter_72_7.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_9), (Mathf.Lerp(iter_72_7.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_9)))
							else
								local var_72_10 = Mathf.Lerp(iter_72_7.color.r, 1, (arg_69_1.time_ - 0) / var_72_9)

								iter_72_7.color = Color.New(var_72_10, var_72_10, var_72_10)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10064 then
				for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_72_9 then
						iter_72_9.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10064 = nil
			end

			local var_72_11 = 0
			local var_72_12 = 0.65

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(410101016)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 26 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 26)

				if (26 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 26)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101016", "story_v_out_410101.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101016", "story_v_out_410101.awb") / 1000

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_410101", "410101016", "story_v_out_410101.awb")

						arg_69_1:RecordAudio("410101016", var_72_18)
						arg_69_1:RecordAudio("410101016", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410101", "410101016", "story_v_out_410101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410101", "410101016", "story_v_out_410101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_19 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_19 and arg_69_1.time_ < var_72_11 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410101017
		arg_73_1.duration_ = 11.73

		local var_73_0 = {
			zh = 4,
			ja = 11.733
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
				arg_73_0:Play410101018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1012 = arg_73_1.actors_["1012"].transform.localPosition
				arg_73_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1012", 2)

				for iter_76_0 = 0, arg_73_1.actors_["1012"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1012"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_76_2 = arg_73_1.actors_["1012"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1012 == nil then
				arg_73_1.var_.actorSpriteComps1012 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps1012 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1012 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1012 = nil
			end

			local var_76_5 = arg_73_1.actors_["10064"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10064 == nil then
				arg_73_1.var_.actorSpriteComps10064 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps10064 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								iter_76_6.color = Color.New(Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_6.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_6.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10064 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_76_8 then
						iter_76_8.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10064 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(410101017)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 19 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 19)

				if (19 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 19)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101017", "story_v_out_410101.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101017", "story_v_out_410101.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_410101", "410101017", "story_v_out_410101.awb")

						arg_73_1:RecordAudio("410101017", var_76_15)
						arg_73_1:RecordAudio("410101017", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410101", "410101017", "story_v_out_410101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410101", "410101017", "story_v_out_410101.awb")
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
				actorName = "1012",
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
	Play410101018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410101018
		arg_77_1.duration_ = 20.77

		local var_77_0 = {
			zh = 8.433,
			ja = 20.766
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
				arg_77_0:Play410101019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1012 = arg_77_1.actors_["1012"].transform.localPosition
				arg_77_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1012", 2)

				for iter_80_0 = 0, arg_77_1.actors_["1012"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["1012"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_1" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_80_2 = arg_77_1.actors_["1012"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1012 == nil then
				arg_77_1.var_.actorSpriteComps1012 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1012 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1012 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1012 = nil
			end

			local var_80_5 = arg_77_1.actors_["10064"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10064 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10064", 4)

				for iter_80_5 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_5)

					if var_80_6.name == "" or not string.find(var_80_6.name, "split") then
						var_80_6.gameObject:SetActive(true)
					else
						var_80_6.gameObject:SetActive(false)
					end
				end
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_77_1.time_ - 0) / var_80_7)
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_80_8 = arg_77_1.actors_["10064"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10064 == nil then
				arg_77_1.var_.actorSpriteComps10064 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 and not isNil(var_80_8) then
				if arg_77_1.var_.actorSpriteComps10064 then
					for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_80_7 then
							if arg_77_1.isInRecall_ then
								iter_80_7.color = Color.New(Mathf.Lerp(iter_80_7.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_9), Mathf.Lerp(iter_80_7.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_9), (Mathf.Lerp(iter_80_7.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_9)))
							else
								local var_80_10 = Mathf.Lerp(iter_80_7.color.r, 1, (arg_77_1.time_ - 0) / var_80_9)

								iter_80_7.color = Color.New(var_80_10, var_80_10, var_80_10)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10064 then
				for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_80_9 then
						iter_80_9.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10064 = nil
			end

			local var_80_11 = 0
			local var_80_12 = 1.025

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
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

				local var_80_13 = arg_77_1:GetWordFromCfg(410101018)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 41 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 41)

				if (41 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 41)) > 0 and var_80_12 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101018", "story_v_out_410101.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101018", "story_v_out_410101.awb") / 1000

					if var_80_17 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_11
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_410101", "410101018", "story_v_out_410101.awb")

						arg_77_1:RecordAudio("410101018", var_80_18)
						arg_77_1:RecordAudio("410101018", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410101", "410101018", "story_v_out_410101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410101", "410101018", "story_v_out_410101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_19 and arg_77_1.time_ < var_80_11 + var_80_19 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410101019
		arg_81_1.duration_ = 13

		local var_81_0 = {
			zh = 5.2,
			ja = 13
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
				arg_81_0:Play410101020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.675

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(410101019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 27 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 27)

				if (27 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 27)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101019", "story_v_out_410101.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101019", "story_v_out_410101.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_410101", "410101019", "story_v_out_410101.awb")

						arg_81_1:RecordAudio("410101019", var_84_6)
						arg_81_1:RecordAudio("410101019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410101", "410101019", "story_v_out_410101.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410101", "410101019", "story_v_out_410101.awb")
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
	Play410101020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410101020
		arg_85_1.duration_ = 6.63

		local var_85_0 = {
			zh = 6.633,
			ja = 4.966
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
				arg_85_0:Play410101021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1012 = arg_85_1.actors_["1012"].transform.localPosition
				arg_85_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1012", 2)

				for iter_88_0 = 0, arg_85_1.actors_["1012"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1012"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_1" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_88_2 = arg_85_1.actors_["1012"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1012 == nil then
				arg_85_1.var_.actorSpriteComps1012 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1012 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1012 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1012 = nil
			end

			local var_88_5 = arg_85_1.actors_["10064"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10064 = var_88_5.localPosition
				var_88_5.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10064", 4)

				for iter_88_5 = 0, var_88_5.childCount - 1 do
					local var_88_6 = var_88_5:GetChild(iter_88_5)

					if var_88_6.name == "" or not string.find(var_88_6.name, "split") then
						var_88_6.gameObject:SetActive(true)
					else
						var_88_6.gameObject:SetActive(false)
					end
				end
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_85_1.time_ - 0) / var_88_7)
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_88_8 = arg_85_1.actors_["10064"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10064 == nil then
				arg_85_1.var_.actorSpriteComps10064 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_9 and not isNil(var_88_8) then
				if arg_85_1.var_.actorSpriteComps10064 then
					for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_88_7 then
							if arg_85_1.isInRecall_ then
								iter_88_7.color = Color.New(Mathf.Lerp(iter_88_7.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_9), Mathf.Lerp(iter_88_7.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_9), (Mathf.Lerp(iter_88_7.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_9)))
							else
								local var_88_10 = Mathf.Lerp(iter_88_7.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_9)

								iter_88_7.color = Color.New(var_88_10, var_88_10, var_88_10)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_9 and arg_85_1.time_ < 0 + var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10064 then
				for iter_88_8, iter_88_9 in pairs(arg_85_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_88_9 then
						iter_88_9.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10064 = nil
			end

			local var_88_11 = 0
			local var_88_12 = 0.725

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_13 = arg_85_1:GetWordFromCfg(410101020)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_16 = 29 <= 0 and var_88_12 or var_88_12 * (utf8.len(var_88_14) / 29)

				if (29 <= 0 and var_88_12 or var_88_12 * (utf8.len(var_88_14) / 29)) > 0 and var_88_12 < var_88_16 then
					arg_85_1.talkMaxDuration = var_88_16

					if var_88_16 + var_88_11 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_11
					end
				end

				arg_85_1.text_.text = var_88_14
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101020", "story_v_out_410101.awb") ~= 0 then
					local var_88_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101020", "story_v_out_410101.awb") / 1000

					if var_88_17 + var_88_11 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_11
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_410101", "410101020", "story_v_out_410101.awb")

						arg_85_1:RecordAudio("410101020", var_88_18)
						arg_85_1:RecordAudio("410101020", var_88_18)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410101", "410101020", "story_v_out_410101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410101", "410101020", "story_v_out_410101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_19 = math.max(var_88_12, arg_85_1.talkMaxDuration)

			if var_88_11 <= arg_85_1.time_ and arg_85_1.time_ < var_88_11 + var_88_19 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_11) / var_88_19

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_11 + var_88_19 and arg_85_1.time_ < var_88_11 + var_88_19 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410101021
		arg_89_1.duration_ = 11.07

		local var_89_0 = {
			zh = 5.5,
			ja = 11.066
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
				arg_89_0:Play410101022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.575

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(410101021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 23 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 23)

				if (23 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 23)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101021", "story_v_out_410101.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101021", "story_v_out_410101.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_410101", "410101021", "story_v_out_410101.awb")

						arg_89_1:RecordAudio("410101021", var_92_6)
						arg_89_1:RecordAudio("410101021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410101", "410101021", "story_v_out_410101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410101", "410101021", "story_v_out_410101.awb")
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
	Play410101022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410101022
		arg_93_1.duration_ = 13.57

		local var_93_0 = {
			zh = 3.2,
			ja = 13.566
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
				arg_93_0:Play410101023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1012 = arg_93_1.actors_["1012"].transform.localPosition
				arg_93_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1012", 2)

				for iter_96_0 = 0, arg_93_1.actors_["1012"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["1012"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_1" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_96_2 = arg_93_1.actors_["1012"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1012 == nil then
				arg_93_1.var_.actorSpriteComps1012 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1012 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1012 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1012 = nil
			end

			local var_96_5 = arg_93_1.actors_["10064"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10064 = var_96_5.localPosition
				var_96_5.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10064", 4)

				for iter_96_5 = 0, var_96_5.childCount - 1 do
					local var_96_6 = var_96_5:GetChild(iter_96_5)

					if var_96_6.name == "" or not string.find(var_96_6.name, "split") then
						var_96_6.gameObject:SetActive(true)
					else
						var_96_6.gameObject:SetActive(false)
					end
				end
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_93_1.time_ - 0) / var_96_7)
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_96_8 = arg_93_1.actors_["10064"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10064 == nil then
				arg_93_1.var_.actorSpriteComps10064 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10064 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 1, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10064 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10064 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.45

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
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

				local var_96_13 = arg_93_1:GetWordFromCfg(410101022)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 18 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 18)

				if (18 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 18)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101022", "story_v_out_410101.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101022", "story_v_out_410101.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_410101", "410101022", "story_v_out_410101.awb")

						arg_93_1:RecordAudio("410101022", var_96_18)
						arg_93_1:RecordAudio("410101022", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410101", "410101022", "story_v_out_410101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410101", "410101022", "story_v_out_410101.awb")
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410101023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play410101024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_0 = 0.5

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				local var_100_1 = Color.New(1, 1, 1)

				var_100_1.a = Mathf.Lerp(1, 0, (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.mask_.color = var_100_1
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				local var_100_2 = Color.New(1, 1, 1)

				arg_97_1.mask_.enabled = false
				var_100_2.a = 0
				arg_97_1.mask_.color = var_100_2
			end

			local var_100_3 = arg_97_1.actors_["1012"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1012 = var_100_3.localPosition
				var_100_3.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1012", 7)

				for iter_100_0 = 0, var_100_3.childCount - 1 do
					local var_100_4 = var_100_3:GetChild(iter_100_0)

					if var_100_4.name == "split_1" or not string.find(var_100_4.name, "split") then
						var_100_4.gameObject:SetActive(true)
					else
						var_100_4.gameObject:SetActive(false)
					end
				end
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_97_1.time_ - 0) / var_100_5)
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_100_6 = arg_97_1.actors_["10064"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10064 = var_100_6.localPosition
				var_100_6.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10064", 7)

				for iter_100_1 = 0, var_100_6.childCount - 1 do
					local var_100_7 = var_100_6:GetChild(iter_100_1)

					if var_100_7.name == "" or not string.find(var_100_7.name, "split") then
						var_100_7.gameObject:SetActive(true)
					else
						var_100_7.gameObject:SetActive(false)
					end
				end
			end

			local var_100_8 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_8 then
				var_100_6.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_97_1.time_ - 0) / var_100_8)
			end

			if arg_97_1.time_ >= 0 + var_100_8 and arg_97_1.time_ < 0 + var_100_8 + arg_100_0 then
				var_100_6.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_100_9 = 0
			local var_100_10 = 1.2

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_11 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_11:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_12 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(410101023).content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_14 = 48 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_12) / 48)

				if (48 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_12) / 48)) > 0 and var_100_10 < var_100_14 then
					arg_97_1.talkMaxDuration = var_100_14
					var_100_9 = var_100_9 + 0.3

					if var_100_14 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_15 = var_100_9 + 0.3
			local var_100_16 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 + 0.3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_16 and arg_97_1.time_ < var_100_15 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410101024
		arg_103_1.duration_ = 5.23

		local var_103_0 = {
			zh = 2.266,
			ja = 5.233
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410101025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1012 = arg_103_1.actors_["1012"].transform.localPosition
				arg_103_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1012", 2)

				for iter_106_0 = 0, arg_103_1.actors_["1012"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["1012"].transform:GetChild(iter_106_0)

					if var_106_0.name == "" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_106_2 = arg_103_1.actors_["1012"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1012 == nil then
				arg_103_1.var_.actorSpriteComps1012 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps1012 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_106_2 then
							if arg_103_1.isInRecall_ then
								iter_106_2.color = Color.New(Mathf.Lerp(iter_106_2.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_3), Mathf.Lerp(iter_106_2.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_3), (Mathf.Lerp(iter_106_2.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_3)))
							else
								local var_106_4 = Mathf.Lerp(iter_106_2.color.r, 1, (arg_103_1.time_ - 0) / var_106_3)

								iter_106_2.color = Color.New(var_106_4, var_106_4, var_106_4)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1012 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_106_4 then
						iter_106_4.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1012 = nil
			end

			local var_106_5 = 0
			local var_106_6 = 0.125

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(410101024)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 5 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 5)

				if (5 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 5)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101024", "story_v_out_410101.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101024", "story_v_out_410101.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_410101", "410101024", "story_v_out_410101.awb")

						arg_103_1:RecordAudio("410101024", var_106_12)
						arg_103_1:RecordAudio("410101024", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410101", "410101024", "story_v_out_410101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410101", "410101024", "story_v_out_410101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play410101025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410101025
		arg_107_1.duration_ = 4.8

		local var_107_0 = {
			zh = 2.366,
			ja = 4.8
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
				arg_107_0:Play410101026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1012 = arg_107_1.actors_["1012"].transform.localPosition
				arg_107_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1012", 2)

				for iter_110_0 = 0, arg_107_1.actors_["1012"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["1012"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_1" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_110_2 = arg_107_1.actors_["1012"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps1012 == nil then
				arg_107_1.var_.actorSpriteComps1012 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps1012 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								iter_110_2.color = Color.New(Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_2.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_2.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps1012 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_110_4 then
						iter_110_4.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1012 = nil
			end

			local var_110_5 = arg_107_1.actors_["10064"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10064 = var_110_5.localPosition
				var_110_5.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10064", 4)

				for iter_110_5 = 0, var_110_5.childCount - 1 do
					local var_110_6 = var_110_5:GetChild(iter_110_5)

					if var_110_6.name == "" or not string.find(var_110_6.name, "split") then
						var_110_6.gameObject:SetActive(true)
					else
						var_110_6.gameObject:SetActive(false)
					end
				end
			end

			local var_110_7 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_107_1.time_ - 0) / var_110_7)
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_110_8 = arg_107_1.actors_["10064"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10064 == nil then
				arg_107_1.var_.actorSpriteComps10064 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_9 and not isNil(var_110_8) then
				if arg_107_1.var_.actorSpriteComps10064 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								iter_110_7.color = Color.New(Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_9), Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_9), (Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_9)))
							else
								local var_110_10 = Mathf.Lerp(iter_110_7.color.r, 1, (arg_107_1.time_ - 0) / var_110_9)

								iter_110_7.color = Color.New(var_110_10, var_110_10, var_110_10)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_9 and arg_107_1.time_ < 0 + var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10064 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_110_9 then
						iter_110_9.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10064 = nil
			end

			local var_110_11 = 0
			local var_110_12 = 0.3

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(410101025)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 12 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 12)

				if (12 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 12)) > 0 and var_110_12 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101025", "story_v_out_410101.awb") ~= 0 then
					local var_110_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101025", "story_v_out_410101.awb") / 1000

					if var_110_17 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_11
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_410101", "410101025", "story_v_out_410101.awb")

						arg_107_1:RecordAudio("410101025", var_110_18)
						arg_107_1:RecordAudio("410101025", var_110_18)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410101", "410101025", "story_v_out_410101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410101", "410101025", "story_v_out_410101.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_19 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_19 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_19

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_19 and arg_107_1.time_ < var_110_11 + var_110_19 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410101026
		arg_111_1.duration_ = 12.37

		local var_111_0 = {
			zh = 2.566,
			ja = 12.366
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
				arg_111_0:Play410101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1012 = arg_111_1.actors_["1012"].transform.localPosition
				arg_111_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1012", 2)

				for iter_114_0 = 0, arg_111_1.actors_["1012"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["1012"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_1" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_114_2 = arg_111_1.actors_["1012"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1012 == nil then
				arg_111_1.var_.actorSpriteComps1012 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps1012 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1012 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1012 = nil
			end

			local var_114_5 = arg_111_1.actors_["10064"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10064 = var_114_5.localPosition
				var_114_5.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10064", 4)

				for iter_114_5 = 0, var_114_5.childCount - 1 do
					local var_114_6 = var_114_5:GetChild(iter_114_5)

					if var_114_6.name == "" or not string.find(var_114_6.name, "split") then
						var_114_6.gameObject:SetActive(true)
					else
						var_114_6.gameObject:SetActive(false)
					end
				end
			end

			local var_114_7 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_111_1.time_ - 0) / var_114_7)
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_114_8 = arg_111_1.actors_["10064"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10064 == nil then
				arg_111_1.var_.actorSpriteComps10064 = var_114_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_9 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 and not isNil(var_114_8) then
				if arg_111_1.var_.actorSpriteComps10064 then
					for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_114_7 then
							if arg_111_1.isInRecall_ then
								iter_114_7.color = Color.New(Mathf.Lerp(iter_114_7.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_9), Mathf.Lerp(iter_114_7.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_9), (Mathf.Lerp(iter_114_7.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_9)))
							else
								local var_114_10 = Mathf.Lerp(iter_114_7.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_9)

								iter_114_7.color = Color.New(var_114_10, var_114_10, var_114_10)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10064 then
				for iter_114_8, iter_114_9 in pairs(arg_111_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_114_9 then
						iter_114_9.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10064 = nil
			end

			local var_114_11 = 0
			local var_114_12 = 0.325

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_13 = arg_111_1:GetWordFromCfg(410101026)
				local var_114_14 = arg_111_1:FormatText(var_114_13.content)

				arg_111_1.text_.text = var_114_14

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_16 = 13 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_14) / 13)

				if (13 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_14) / 13)) > 0 and var_114_12 < var_114_16 then
					arg_111_1.talkMaxDuration = var_114_16

					if var_114_16 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_11
					end
				end

				arg_111_1.text_.text = var_114_14
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101026", "story_v_out_410101.awb") ~= 0 then
					local var_114_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101026", "story_v_out_410101.awb") / 1000

					if var_114_17 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_11
					end

					if var_114_13.prefab_name ~= "" and arg_111_1.actors_[var_114_13.prefab_name] ~= nil then
						local var_114_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_13.prefab_name].transform, "story_v_out_410101", "410101026", "story_v_out_410101.awb")

						arg_111_1:RecordAudio("410101026", var_114_18)
						arg_111_1:RecordAudio("410101026", var_114_18)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410101", "410101026", "story_v_out_410101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410101", "410101026", "story_v_out_410101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_19 = math.max(var_114_12, arg_111_1.talkMaxDuration)

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_19 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_11) / var_114_19

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_11 + var_114_19 and arg_111_1.time_ < var_114_11 + var_114_19 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410101027
		arg_115_1.duration_ = 23.7

		local var_115_0 = {
			zh = 14.833,
			ja = 23.7
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
				arg_115_0:Play410101028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.6

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(410101027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 64 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 64)

				if (64 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 64)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101027", "story_v_out_410101.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101027", "story_v_out_410101.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_410101", "410101027", "story_v_out_410101.awb")

						arg_115_1:RecordAudio("410101027", var_118_6)
						arg_115_1:RecordAudio("410101027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410101", "410101027", "story_v_out_410101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410101", "410101027", "story_v_out_410101.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410101028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410101028
		arg_119_1.duration_ = 14.9

		local var_119_0 = {
			zh = 9.6,
			ja = 14.9
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
				arg_119_0:Play410101029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 1.075

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(410101028)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 43 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 43)

				if (43 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 43)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101028", "story_v_out_410101.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101028", "story_v_out_410101.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_410101", "410101028", "story_v_out_410101.awb")

						arg_119_1:RecordAudio("410101028", var_122_6)
						arg_119_1:RecordAudio("410101028", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410101", "410101028", "story_v_out_410101.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410101", "410101028", "story_v_out_410101.awb")
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
	Play410101029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410101029
		arg_123_1.duration_ = 20.77

		local var_123_0 = {
			zh = 11.933,
			ja = 20.766
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
				arg_123_0:Play410101030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(410101029)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 59 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 59)

				if (59 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 59)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101029", "story_v_out_410101.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101029", "story_v_out_410101.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_410101", "410101029", "story_v_out_410101.awb")

						arg_123_1:RecordAudio("410101029", var_126_6)
						arg_123_1:RecordAudio("410101029", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410101", "410101029", "story_v_out_410101.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410101", "410101029", "story_v_out_410101.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play410101030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410101030
		arg_127_1.duration_ = 7.97

		local var_127_0 = {
			zh = 7.966,
			ja = 7.8
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
				arg_127_0:Play410101031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1012 = arg_127_1.actors_["1012"].transform.localPosition
				arg_127_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1012", 2)

				for iter_130_0 = 0, arg_127_1.actors_["1012"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["1012"].transform:GetChild(iter_130_0)

					if var_130_0.name == "split_1" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_130_2 = arg_127_1.actors_["1012"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1012 == nil then
				arg_127_1.var_.actorSpriteComps1012 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps1012 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1012 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1012 = nil
			end

			local var_130_5 = arg_127_1.actors_["10064"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10064 = var_130_5.localPosition
				var_130_5.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10064", 4)

				for iter_130_5 = 0, var_130_5.childCount - 1 do
					local var_130_6 = var_130_5:GetChild(iter_130_5)

					if var_130_6.name == "" or not string.find(var_130_6.name, "split") then
						var_130_6.gameObject:SetActive(true)
					else
						var_130_6.gameObject:SetActive(false)
					end
				end
			end

			local var_130_7 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_127_1.time_ - 0) / var_130_7)
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_130_8 = arg_127_1.actors_["10064"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10064 == nil then
				arg_127_1.var_.actorSpriteComps10064 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.actorSpriteComps10064 then
					for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_130_7 then
							if arg_127_1.isInRecall_ then
								iter_130_7.color = Color.New(Mathf.Lerp(iter_130_7.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_9), Mathf.Lerp(iter_130_7.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_9), (Mathf.Lerp(iter_130_7.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_9)))
							else
								local var_130_10 = Mathf.Lerp(iter_130_7.color.r, 1, (arg_127_1.time_ - 0) / var_130_9)

								iter_130_7.color = Color.New(var_130_10, var_130_10, var_130_10)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10064 then
				for iter_130_8, iter_130_9 in pairs(arg_127_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_130_9 then
						iter_130_9.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10064 = nil
			end

			local var_130_11 = 0
			local var_130_12 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(410101030)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 29 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 29)

				if (29 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 29)) > 0 and var_130_12 < var_130_16 then
					arg_127_1.talkMaxDuration = var_130_16

					if var_130_16 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101030", "story_v_out_410101.awb") ~= 0 then
					local var_130_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101030", "story_v_out_410101.awb") / 1000

					if var_130_17 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_11
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_410101", "410101030", "story_v_out_410101.awb")

						arg_127_1:RecordAudio("410101030", var_130_18)
						arg_127_1:RecordAudio("410101030", var_130_18)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410101", "410101030", "story_v_out_410101.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410101", "410101030", "story_v_out_410101.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_19 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_19 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_19

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_19 and arg_127_1.time_ < var_130_11 + var_130_19 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410101031
		arg_131_1.duration_ = 5.27

		local var_131_0 = {
			zh = 5.266,
			ja = 3.766
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
				arg_131_0:Play410101032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.55

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(410101031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 22 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 22)

				if (22 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 22)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101031", "story_v_out_410101.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101031", "story_v_out_410101.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_410101", "410101031", "story_v_out_410101.awb")

						arg_131_1:RecordAudio("410101031", var_134_6)
						arg_131_1:RecordAudio("410101031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410101", "410101031", "story_v_out_410101.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410101", "410101031", "story_v_out_410101.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play410101032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410101032
		arg_135_1.duration_ = 8.9

		local var_135_0 = {
			zh = 1.733,
			ja = 8.9
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
				arg_135_0:Play410101033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1012 = arg_135_1.actors_["1012"].transform.localPosition
				arg_135_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1012", 2)

				for iter_138_0 = 0, arg_135_1.actors_["1012"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["1012"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_3" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_138_2 = arg_135_1.actors_["1012"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1012 == nil then
				arg_135_1.var_.actorSpriteComps1012 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1012 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1012 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1012 = nil
			end

			local var_138_5 = arg_135_1.actors_["10064"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10064 = var_138_5.localPosition
				var_138_5.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10064", 4)

				for iter_138_5 = 0, var_138_5.childCount - 1 do
					local var_138_6 = var_138_5:GetChild(iter_138_5)

					if var_138_6.name == "" or not string.find(var_138_6.name, "split") then
						var_138_6.gameObject:SetActive(true)
					else
						var_138_6.gameObject:SetActive(false)
					end
				end
			end

			local var_138_7 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_135_1.time_ - 0) / var_138_7)
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_138_8 = arg_135_1.actors_["10064"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10064 == nil then
				arg_135_1.var_.actorSpriteComps10064 = var_138_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 and not isNil(var_138_8) then
				if arg_135_1.var_.actorSpriteComps10064 then
					for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_138_7 then
							if arg_135_1.isInRecall_ then
								iter_138_7.color = Color.New(Mathf.Lerp(iter_138_7.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_9), Mathf.Lerp(iter_138_7.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_9), (Mathf.Lerp(iter_138_7.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_9)))
							else
								local var_138_10 = Mathf.Lerp(iter_138_7.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_9)

								iter_138_7.color = Color.New(var_138_10, var_138_10, var_138_10)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10064 then
				for iter_138_8, iter_138_9 in pairs(arg_135_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_138_9 then
						iter_138_9.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10064 = nil
			end

			local var_138_11 = 0
			local var_138_12 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(410101032)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 8 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 8)

				if (8 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 8)) > 0 and var_138_12 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101032", "story_v_out_410101.awb") ~= 0 then
					local var_138_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101032", "story_v_out_410101.awb") / 1000

					if var_138_17 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_11
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_410101", "410101032", "story_v_out_410101.awb")

						arg_135_1:RecordAudio("410101032", var_138_18)
						arg_135_1:RecordAudio("410101032", var_138_18)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410101", "410101032", "story_v_out_410101.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410101", "410101032", "story_v_out_410101.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_19 and arg_135_1.time_ < var_138_11 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410101033
		arg_139_1.duration_ = 2.73

		local var_139_0 = {
			zh = 1.3,
			ja = 2.733
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
				arg_139_0:Play410101034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1012 = arg_139_1.actors_["1012"].transform.localPosition
				arg_139_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1012", 2)

				for iter_142_0 = 0, arg_139_1.actors_["1012"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["1012"].transform:GetChild(iter_142_0)

					if var_142_0.name == "split_1" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_142_2 = arg_139_1.actors_["1012"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1012 == nil then
				arg_139_1.var_.actorSpriteComps1012 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1012 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1012 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1012 = nil
			end

			local var_142_5 = arg_139_1.actors_["10064"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10064 = var_142_5.localPosition
				var_142_5.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10064", 4)

				for iter_142_5 = 0, var_142_5.childCount - 1 do
					local var_142_6 = var_142_5:GetChild(iter_142_5)

					if var_142_6.name == "" or not string.find(var_142_6.name, "split") then
						var_142_6.gameObject:SetActive(true)
					else
						var_142_6.gameObject:SetActive(false)
					end
				end
			end

			local var_142_7 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_139_1.time_ - 0) / var_142_7)
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_142_8 = arg_139_1.actors_["10064"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10064 == nil then
				arg_139_1.var_.actorSpriteComps10064 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_9 and not isNil(var_142_8) then
				if arg_139_1.var_.actorSpriteComps10064 then
					for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_142_7 then
							if arg_139_1.isInRecall_ then
								iter_142_7.color = Color.New(Mathf.Lerp(iter_142_7.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_9), Mathf.Lerp(iter_142_7.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_9), (Mathf.Lerp(iter_142_7.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_9)))
							else
								local var_142_10 = Mathf.Lerp(iter_142_7.color.r, 1, (arg_139_1.time_ - 0) / var_142_9)

								iter_142_7.color = Color.New(var_142_10, var_142_10, var_142_10)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_9 and arg_139_1.time_ < 0 + var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10064 then
				for iter_142_8, iter_142_9 in pairs(arg_139_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_142_9 then
						iter_142_9.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10064 = nil
			end

			local var_142_11 = 0
			local var_142_12 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_13 = arg_139_1:GetWordFromCfg(410101033)
				local var_142_14 = arg_139_1:FormatText(var_142_13.content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 5 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 5)

				if (5 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 5)) > 0 and var_142_12 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101033", "story_v_out_410101.awb") ~= 0 then
					local var_142_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101033", "story_v_out_410101.awb") / 1000

					if var_142_17 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_11
					end

					if var_142_13.prefab_name ~= "" and arg_139_1.actors_[var_142_13.prefab_name] ~= nil then
						local var_142_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_13.prefab_name].transform, "story_v_out_410101", "410101033", "story_v_out_410101.awb")

						arg_139_1:RecordAudio("410101033", var_142_18)
						arg_139_1:RecordAudio("410101033", var_142_18)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410101", "410101033", "story_v_out_410101.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410101", "410101033", "story_v_out_410101.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_19 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_19 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_19

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_19 and arg_139_1.time_ < var_142_11 + var_142_19 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410101034
		arg_143_1.duration_ = 12.9

		local var_143_0 = {
			zh = 5.6,
			ja = 12.9
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
				arg_143_0:Play410101035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1012 = arg_143_1.actors_["1012"].transform.localPosition
				arg_143_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1012", 2)

				for iter_146_0 = 0, arg_143_1.actors_["1012"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["1012"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_1" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_146_2 = arg_143_1.actors_["1012"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1012 == nil then
				arg_143_1.var_.actorSpriteComps1012 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps1012 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1012 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1012 = nil
			end

			local var_146_5 = arg_143_1.actors_["10064"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10064 = var_146_5.localPosition
				var_146_5.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10064", 4)

				for iter_146_5 = 0, var_146_5.childCount - 1 do
					local var_146_6 = var_146_5:GetChild(iter_146_5)

					if var_146_6.name == "" or not string.find(var_146_6.name, "split") then
						var_146_6.gameObject:SetActive(true)
					else
						var_146_6.gameObject:SetActive(false)
					end
				end
			end

			local var_146_7 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				var_146_5.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10064, Vector3.New(390, -570, 192.5), (arg_143_1.time_ - 0) / var_146_7)
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				var_146_5.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_146_8 = arg_143_1.actors_["10064"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps10064 == nil then
				arg_143_1.var_.actorSpriteComps10064 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_9 and not isNil(var_146_8) then
				if arg_143_1.var_.actorSpriteComps10064 then
					for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_146_7 then
							if arg_143_1.isInRecall_ then
								iter_146_7.color = Color.New(Mathf.Lerp(iter_146_7.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_9), Mathf.Lerp(iter_146_7.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_9), (Mathf.Lerp(iter_146_7.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_9)))
							else
								local var_146_10 = Mathf.Lerp(iter_146_7.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_9)

								iter_146_7.color = Color.New(var_146_10, var_146_10, var_146_10)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_9 and arg_143_1.time_ < 0 + var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps10064 then
				for iter_146_8, iter_146_9 in pairs(arg_143_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_146_9 then
						iter_146_9.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10064 = nil
			end

			local var_146_11 = 0
			local var_146_12 = 0.7

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_13 = arg_143_1:GetWordFromCfg(410101034)
				local var_146_14 = arg_143_1:FormatText(var_146_13.content)

				arg_143_1.text_.text = var_146_14

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 28 <= 0 and var_146_12 or var_146_12 * (utf8.len(var_146_14) / 28)

				if (28 <= 0 and var_146_12 or var_146_12 * (utf8.len(var_146_14) / 28)) > 0 and var_146_12 < var_146_16 then
					arg_143_1.talkMaxDuration = var_146_16

					if var_146_16 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_16 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_14
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101034", "story_v_out_410101.awb") ~= 0 then
					local var_146_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101034", "story_v_out_410101.awb") / 1000

					if var_146_17 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_17 + var_146_11
					end

					if var_146_13.prefab_name ~= "" and arg_143_1.actors_[var_146_13.prefab_name] ~= nil then
						local var_146_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_13.prefab_name].transform, "story_v_out_410101", "410101034", "story_v_out_410101.awb")

						arg_143_1:RecordAudio("410101034", var_146_18)
						arg_143_1:RecordAudio("410101034", var_146_18)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410101", "410101034", "story_v_out_410101.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410101", "410101034", "story_v_out_410101.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_19 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_19 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_19

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_19 and arg_143_1.time_ < var_146_11 + var_146_19 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410101035
		arg_147_1.duration_ = 12.67

		local var_147_0 = {
			zh = 9.2,
			ja = 12.666
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
				arg_147_0:Play410101036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.05

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(410101035)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 42 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 42)

				if (42 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 42)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101035", "story_v_out_410101.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101035", "story_v_out_410101.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_410101", "410101035", "story_v_out_410101.awb")

						arg_147_1:RecordAudio("410101035", var_150_6)
						arg_147_1:RecordAudio("410101035", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410101", "410101035", "story_v_out_410101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410101", "410101035", "story_v_out_410101.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play410101036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410101036
		arg_151_1.duration_ = 15.3

		local var_151_0 = {
			zh = 5.8,
			ja = 15.3
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
				arg_151_0:Play410101037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.8

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(410101036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 32 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 32)

				if (32 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 32)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101036", "story_v_out_410101.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101036", "story_v_out_410101.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_410101", "410101036", "story_v_out_410101.awb")

						arg_151_1:RecordAudio("410101036", var_154_6)
						arg_151_1:RecordAudio("410101036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410101", "410101036", "story_v_out_410101.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410101", "410101036", "story_v_out_410101.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play410101037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410101037
		arg_155_1.duration_ = 18.87

		local var_155_0 = {
			zh = 10.833,
			ja = 18.866
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
				arg_155_0:Play410101038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(410101037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 46 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 46)

				if (46 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 46)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101037", "story_v_out_410101.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101037", "story_v_out_410101.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_410101", "410101037", "story_v_out_410101.awb")

						arg_155_1:RecordAudio("410101037", var_158_6)
						arg_155_1:RecordAudio("410101037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410101", "410101037", "story_v_out_410101.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410101", "410101037", "story_v_out_410101.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play410101038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410101038
		arg_159_1.duration_ = 15.3

		local var_159_0 = {
			zh = 6.766,
			ja = 15.3
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
				arg_159_0:Play410101039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.775

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(410101038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 31 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 31)

				if (31 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 31)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101038", "story_v_out_410101.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101038", "story_v_out_410101.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_410101", "410101038", "story_v_out_410101.awb")

						arg_159_1:RecordAudio("410101038", var_162_6)
						arg_159_1:RecordAudio("410101038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410101", "410101038", "story_v_out_410101.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410101", "410101038", "story_v_out_410101.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play410101039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410101039
		arg_163_1.duration_ = 9

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play410101040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if arg_163_1.bgs_.L02g == nil then
				local var_166_0 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02g")
				var_166_0.name = "L02g"
				var_166_0.transform.parent = arg_163_1.stage_.transform
				var_166_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_.L02g = var_166_0
			end

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				local var_166_1 = arg_163_1.bgs_.L02g

				arg_163_1.bgs_.L02g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_166_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_2 = var_166_1:GetComponent("SpriteRenderer")

				if var_166_2 and var_166_2.sprite then
					local var_166_3 = 2 * (var_166_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_166_1.transform.localScale = Vector3.New(var_166_3 / var_166_2.sprite.bounds.size.y < var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x and var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x or var_166_3 / var_166_2.sprite.bounds.size.y, var_166_3 / var_166_2.sprite.bounds.size.y < var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x and var_166_3 * manager.ui.mainCameraCom_.aspect / var_166_2.sprite.bounds.size.x or var_166_3 / var_166_2.sprite.bounds.size.y, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "L02g" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_4 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_5 = 2

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_5 then
				local var_166_6 = Color.New(0, 0, 0)

				var_166_6.a = Mathf.Lerp(0, 1, (arg_163_1.time_ - var_166_4) / var_166_5)
				arg_163_1.mask_.color = var_166_6
			end

			if arg_163_1.time_ >= var_166_4 + var_166_5 and arg_163_1.time_ < var_166_4 + var_166_5 + arg_166_0 then
				local var_166_7 = Color.New(0, 0, 0)

				var_166_7.a = 1
				arg_163_1.mask_.color = var_166_7
			end

			local var_166_8 = 2

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 then
				local var_166_10 = Color.New(0, 0, 0)

				var_166_10.a = Mathf.Lerp(1, 0, (arg_163_1.time_ - var_166_8) / var_166_9)
				arg_163_1.mask_.color = var_166_10
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 then
				local var_166_11 = Color.New(0, 0, 0)

				arg_163_1.mask_.enabled = false
				var_166_11.a = 0
				arg_163_1.mask_.color = var_166_11
			end

			local var_166_12 = arg_163_1.actors_["1012"].transform

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				arg_163_1.var_.moveOldPos1012 = var_166_12.localPosition
				var_166_12.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1012", 7)

				for iter_166_2 = 0, var_166_12.childCount - 1 do
					local var_166_13 = var_166_12:GetChild(iter_166_2)

					if var_166_13.name == "" or not string.find(var_166_13.name, "split") then
						var_166_13.gameObject:SetActive(true)
					else
						var_166_13.gameObject:SetActive(false)
					end
				end
			end

			local var_166_14 = 0.001

			if 2 <= arg_163_1.time_ and arg_163_1.time_ < 2 + var_166_14 then
				var_166_12.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_163_1.time_ - 2) / var_166_14)
			end

			if arg_163_1.time_ >= 2 + var_166_14 and arg_163_1.time_ < 2 + var_166_14 + arg_166_0 then
				var_166_12.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_166_15 = arg_163_1.actors_["10064"].transform

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				arg_163_1.var_.moveOldPos10064 = var_166_15.localPosition
				var_166_15.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10064", 7)

				for iter_166_3 = 0, var_166_15.childCount - 1 do
					local var_166_16 = var_166_15:GetChild(iter_166_3)

					if var_166_16.name == "" or not string.find(var_166_16.name, "split") then
						var_166_16.gameObject:SetActive(true)
					else
						var_166_16.gameObject:SetActive(false)
					end
				end
			end

			local var_166_17 = 0.001

			if 2 <= arg_163_1.time_ and arg_163_1.time_ < 2 + var_166_17 then
				var_166_15.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_163_1.time_ - 2) / var_166_17)
			end

			if arg_163_1.time_ >= 2 + var_166_17 and arg_163_1.time_ < 2 + var_166_17 + arg_166_0 then
				var_166_15.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_166_18 = 2

			arg_163_1.isInRecall_ = false

			if var_166_18 < arg_163_1.time_ and arg_163_1.time_ <= var_166_18 + arg_166_0 then
				arg_163_1.screenFilterGo_:SetActive(false)

				for iter_166_4, iter_166_5 in pairs(arg_163_1.actors_) do
					for iter_166_6, iter_166_7 in ipairs((iter_166_5:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_166_7.color = iter_166_7.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_166_19 = 0.0339999999999998

			if var_166_18 <= arg_163_1.time_ and arg_163_1.time_ < var_166_18 + var_166_19 then
				arg_163_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_163_1.time_ - var_166_18) / var_166_19)
			end

			if arg_163_1.time_ >= var_166_18 + var_166_19 and arg_163_1.time_ < var_166_18 + var_166_19 + arg_166_0 then
				arg_163_1.screenFilterEffect_.weight = 0
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_166_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_22 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_22

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_22
						arg_163_1.bgmTxt2_.text = var_166_22
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_163_1.time_ and arg_163_1.time_ <= 0.3 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_166_25 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_25 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_25

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_25
						arg_163_1.bgmTxt2_.text = var_166_25
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_26 = 4
			local var_166_27 = 1.25

			if 4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_26 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_28 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_28:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_163_1.dialogCg_.alpha = arg_169_0
				end))
				var_166_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_29 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(410101039).content)

				arg_163_1.text_.text = var_166_29

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_31 = 50 <= 0 and var_166_27 or var_166_27 * (utf8.len(var_166_29) / 50)

				if (50 <= 0 and var_166_27 or var_166_27 * (utf8.len(var_166_29) / 50)) > 0 and var_166_27 < var_166_31 then
					arg_163_1.talkMaxDuration = var_166_31
					var_166_26 = var_166_26 + 0.3

					if var_166_31 + var_166_26 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_26
					end
				end

				arg_163_1.text_.text = var_166_29
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_32 = var_166_26 + 0.3
			local var_166_33 = math.max(var_166_27, arg_163_1.talkMaxDuration)

			if var_166_26 + 0.3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_32 + var_166_33 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_32) / var_166_33

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_32 + var_166_33 and arg_163_1.time_ < var_166_32 + var_166_33 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play410101040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410101040
		arg_171_1.duration_ = 13.2

		local var_171_0 = {
			zh = 9,
			ja = 13.2
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
				arg_171_0:Play410101041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1060 = arg_171_1.actors_["1060"].transform.localPosition
				arg_171_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1060", 3)

				for iter_174_0 = 0, arg_171_1.actors_["1060"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["1060"].transform:GetChild(iter_174_0)

					if var_174_0.name == "" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_174_2 = arg_171_1.actors_["1060"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1060 == nil then
				arg_171_1.var_.actorSpriteComps1060 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.034

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps1060 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								iter_174_2.color = Color.New(Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_2.color.r, 1, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_2.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1060 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_174_4 then
						iter_174_4.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1060 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 1.05

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(410101040)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 42 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 42)

				if (42 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 42)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101040", "story_v_out_410101.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101040", "story_v_out_410101.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_410101", "410101040", "story_v_out_410101.awb")

						arg_171_1:RecordAudio("410101040", var_174_12)
						arg_171_1:RecordAudio("410101040", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410101", "410101040", "story_v_out_410101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410101", "410101040", "story_v_out_410101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play410101041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410101041
		arg_175_1.duration_ = 16.77

		local var_175_0 = {
			zh = 13.533,
			ja = 16.766
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
				arg_175_0:Play410101042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.6

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(410101041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 64 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 64)

				if (64 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 64)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101041", "story_v_out_410101.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101041", "story_v_out_410101.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_410101", "410101041", "story_v_out_410101.awb")

						arg_175_1:RecordAudio("410101041", var_178_6)
						arg_175_1:RecordAudio("410101041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410101", "410101041", "story_v_out_410101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410101", "410101041", "story_v_out_410101.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play410101042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410101042
		arg_179_1.duration_ = 14.13

		local var_179_0 = {
			zh = 6.133,
			ja = 14.133
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
				arg_179_0:Play410101043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.725

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(410101042)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 29 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 29)

				if (29 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 29)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101042", "story_v_out_410101.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101042", "story_v_out_410101.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_410101", "410101042", "story_v_out_410101.awb")

						arg_179_1:RecordAudio("410101042", var_182_6)
						arg_179_1:RecordAudio("410101042", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410101", "410101042", "story_v_out_410101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410101", "410101042", "story_v_out_410101.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play410101043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410101043
		arg_183_1.duration_ = 18.07

		local var_183_0 = {
			zh = 10.7,
			ja = 18.066
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
				arg_183_0:Play410101044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.125

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(410101043)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 45 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 45)

				if (45 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 45)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101043", "story_v_out_410101.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101043", "story_v_out_410101.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_410101", "410101043", "story_v_out_410101.awb")

						arg_183_1:RecordAudio("410101043", var_186_6)
						arg_183_1:RecordAudio("410101043", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410101", "410101043", "story_v_out_410101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410101", "410101043", "story_v_out_410101.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play410101044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410101044
		arg_187_1.duration_ = 13.4

		local var_187_0 = {
			zh = 7.5,
			ja = 13.4
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
				arg_187_0:Play410101045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.75

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(410101044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 30 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 30)

				if (30 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 30)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101044", "story_v_out_410101.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101044", "story_v_out_410101.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_410101", "410101044", "story_v_out_410101.awb")

						arg_187_1:RecordAudio("410101044", var_190_6)
						arg_187_1:RecordAudio("410101044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410101", "410101044", "story_v_out_410101.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410101", "410101044", "story_v_out_410101.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play410101045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410101045
		arg_191_1.duration_ = 14.33

		local var_191_0 = {
			zh = 7.766,
			ja = 14.333
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
				arg_191_0:Play410101046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.75

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(410101045)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 30 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 30)

				if (30 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 30)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101045", "story_v_out_410101.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101045", "story_v_out_410101.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_410101", "410101045", "story_v_out_410101.awb")

						arg_191_1:RecordAudio("410101045", var_194_6)
						arg_191_1:RecordAudio("410101045", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_410101", "410101045", "story_v_out_410101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_410101", "410101045", "story_v_out_410101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play410101046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410101046
		arg_195_1.duration_ = 4.83

		local var_195_0 = {
			zh = 2.466,
			ja = 4.833
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play410101047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1060 = arg_195_1.actors_["1060"].transform.localPosition
				arg_195_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1060", 2)

				for iter_198_0 = 0, arg_195_1.actors_["1060"].transform.childCount - 1 do
					local var_198_0 = arg_195_1.actors_["1060"].transform:GetChild(iter_198_0)

					if var_198_0.name == "" or not string.find(var_198_0.name, "split") then
						var_198_0.gameObject:SetActive(true)
					else
						var_198_0.gameObject:SetActive(false)
					end
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_195_1.time_ - 0) / var_198_1)
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_198_2 = arg_195_1.actors_["1012"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1012 = var_198_2.localPosition
				var_198_2.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1012", 4)

				for iter_198_1 = 0, var_198_2.childCount - 1 do
					local var_198_3 = var_198_2:GetChild(iter_198_1)

					if var_198_3.name == "" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(390, -465, 300)
			end

			local var_198_5 = arg_195_1.actors_["1060"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps1060 == nil then
				arg_195_1.var_.actorSpriteComps1060 = var_198_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_6 = 0.034

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.actorSpriteComps1060 then
					for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_198_3 then
							if arg_195_1.isInRecall_ then
								iter_198_3.color = Color.New(Mathf.Lerp(iter_198_3.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_6), Mathf.Lerp(iter_198_3.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_6), (Mathf.Lerp(iter_198_3.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_6)))
							else
								local var_198_7 = Mathf.Lerp(iter_198_3.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_6)

								iter_198_3.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps1060 then
				for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_198_5 then
						iter_198_5.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps1060 = nil
			end

			local var_198_8 = arg_195_1.actors_["1012"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps1012 == nil then
				arg_195_1.var_.actorSpriteComps1012 = var_198_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_9 = 0.034

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_9 and not isNil(var_198_8) then
				if arg_195_1.var_.actorSpriteComps1012 then
					for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_198_7 then
							if arg_195_1.isInRecall_ then
								iter_198_7.color = Color.New(Mathf.Lerp(iter_198_7.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_9), Mathf.Lerp(iter_198_7.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_9), (Mathf.Lerp(iter_198_7.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_9)))
							else
								local var_198_10 = Mathf.Lerp(iter_198_7.color.r, 1, (arg_195_1.time_ - 0) / var_198_9)

								iter_198_7.color = Color.New(var_198_10, var_198_10, var_198_10)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_9 and arg_195_1.time_ < 0 + var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps1012 then
				for iter_198_8, iter_198_9 in pairs(arg_195_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_198_9 then
						iter_198_9.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1012 = nil
			end

			local var_198_11 = 0
			local var_198_12 = 0.175

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(410101046)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_16 = 7 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 7)

				if (7 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 7)) > 0 and var_198_12 < var_198_16 then
					arg_195_1.talkMaxDuration = var_198_16

					if var_198_16 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_11
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101046", "story_v_out_410101.awb") ~= 0 then
					local var_198_17 = manager.audio:GetVoiceLength("story_v_out_410101", "410101046", "story_v_out_410101.awb") / 1000

					if var_198_17 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_11
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_410101", "410101046", "story_v_out_410101.awb")

						arg_195_1:RecordAudio("410101046", var_198_18)
						arg_195_1:RecordAudio("410101046", var_198_18)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_410101", "410101046", "story_v_out_410101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_410101", "410101046", "story_v_out_410101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_19 = math.max(var_198_12, arg_195_1.talkMaxDuration)

			if var_198_11 <= arg_195_1.time_ and arg_195_1.time_ < var_198_11 + var_198_19 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_11) / var_198_19

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_11 + var_198_19 and arg_195_1.time_ < var_198_11 + var_198_19 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play410101047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410101047
		arg_199_1.duration_ = 10.63

		local var_199_0 = {
			zh = 3.233,
			ja = 10.633
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
				arg_199_0:Play410101048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1060 = arg_199_1.actors_["1060"].transform.localPosition
				arg_199_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1060", 2)

				for iter_202_0 = 0, arg_199_1.actors_["1060"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["1060"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_202_2 = arg_199_1.actors_["1060"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1060 == nil then
				arg_199_1.var_.actorSpriteComps1060 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.034

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps1060 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1060 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps1060 = nil
			end

			local var_202_5 = arg_199_1.actors_["1012"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps1012 == nil then
				arg_199_1.var_.actorSpriteComps1012 = var_202_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_6 = 0.034

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_6 and not isNil(var_202_5) then
				if arg_199_1.var_.actorSpriteComps1012 then
					for iter_202_5, iter_202_6 in pairs(arg_199_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_202_6 then
							if arg_199_1.isInRecall_ then
								iter_202_6.color = Color.New(Mathf.Lerp(iter_202_6.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_6), Mathf.Lerp(iter_202_6.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_6), (Mathf.Lerp(iter_202_6.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_6)))
							else
								local var_202_7 = Mathf.Lerp(iter_202_6.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_6)

								iter_202_6.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_6 and arg_199_1.time_ < 0 + var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps1012 then
				for iter_202_7, iter_202_8 in pairs(arg_199_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_202_8 then
						iter_202_8.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1012 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.425

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(410101047)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 17 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 17)

				if (17 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 17)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101047", "story_v_out_410101.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101047", "story_v_out_410101.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_410101", "410101047", "story_v_out_410101.awb")

						arg_199_1:RecordAudio("410101047", var_202_15)
						arg_199_1:RecordAudio("410101047", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410101", "410101047", "story_v_out_410101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410101", "410101047", "story_v_out_410101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play410101048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410101048
		arg_203_1.duration_ = 9.3

		local var_203_0 = {
			zh = 4.4,
			ja = 9.3
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
				arg_203_0:Play410101049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1012 = arg_203_1.actors_["1012"].transform.localPosition
				arg_203_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1012", 4)

				for iter_206_0 = 0, arg_203_1.actors_["1012"].transform.childCount - 1 do
					local var_206_0 = arg_203_1.actors_["1012"].transform:GetChild(iter_206_0)

					if var_206_0.name == "" or not string.find(var_206_0.name, "split") then
						var_206_0.gameObject:SetActive(true)
					else
						var_206_0.gameObject:SetActive(false)
					end
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_203_1.time_ - 0) / var_206_1)
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_206_2 = arg_203_1.actors_["1012"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1012 == nil then
				arg_203_1.var_.actorSpriteComps1012 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 0.034

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps1012 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_206_2 then
							if arg_203_1.isInRecall_ then
								iter_206_2.color = Color.New(Mathf.Lerp(iter_206_2.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_3), Mathf.Lerp(iter_206_2.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_3), (Mathf.Lerp(iter_206_2.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_3)))
							else
								local var_206_4 = Mathf.Lerp(iter_206_2.color.r, 1, (arg_203_1.time_ - 0) / var_206_3)

								iter_206_2.color = Color.New(var_206_4, var_206_4, var_206_4)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1012 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_206_4 then
						iter_206_4.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1012 = nil
			end

			local var_206_5 = arg_203_1.actors_["1060"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_5) and arg_203_1.var_.actorSpriteComps1060 == nil then
				arg_203_1.var_.actorSpriteComps1060 = var_206_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_6 = 0.034

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_6 and not isNil(var_206_5) then
				if arg_203_1.var_.actorSpriteComps1060 then
					for iter_206_5, iter_206_6 in pairs(arg_203_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_206_6 then
							if arg_203_1.isInRecall_ then
								iter_206_6.color = Color.New(Mathf.Lerp(iter_206_6.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_6), Mathf.Lerp(iter_206_6.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_6), (Mathf.Lerp(iter_206_6.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_6)))
							else
								local var_206_7 = Mathf.Lerp(iter_206_6.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_6)

								iter_206_6.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_6 and arg_203_1.time_ < 0 + var_206_6 + arg_206_0 and not isNil(var_206_5) and arg_203_1.var_.actorSpriteComps1060 then
				for iter_206_7, iter_206_8 in pairs(arg_203_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_206_8 then
						iter_206_8.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps1060 = nil
			end

			local var_206_8 = 0
			local var_206_9 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(410101048)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 20 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 20)

				if (20 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 20)) > 0 and var_206_9 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101048", "story_v_out_410101.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101048", "story_v_out_410101.awb") / 1000

					if var_206_14 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_8
					end

					if var_206_10.prefab_name ~= "" and arg_203_1.actors_[var_206_10.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_10.prefab_name].transform, "story_v_out_410101", "410101048", "story_v_out_410101.awb")

						arg_203_1:RecordAudio("410101048", var_206_15)
						arg_203_1:RecordAudio("410101048", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_410101", "410101048", "story_v_out_410101.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_410101", "410101048", "story_v_out_410101.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play410101049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 410101049
		arg_207_1.duration_ = 13.93

		local var_207_0 = {
			zh = 5.7,
			ja = 13.933
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play410101050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.7

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(410101049)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 28 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 28)

				if (28 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 28)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101049", "story_v_out_410101.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101049", "story_v_out_410101.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_410101", "410101049", "story_v_out_410101.awb")

						arg_207_1:RecordAudio("410101049", var_210_6)
						arg_207_1:RecordAudio("410101049", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_410101", "410101049", "story_v_out_410101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_410101", "410101049", "story_v_out_410101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play410101050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 410101050
		arg_211_1.duration_ = 2.03

		local var_211_0 = {
			zh = 2.033,
			ja = 1.833
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play410101051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1060 = arg_211_1.actors_["1060"].transform.localPosition
				arg_211_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1060", 2)

				for iter_214_0 = 0, arg_211_1.actors_["1060"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["1060"].transform:GetChild(iter_214_0)

					if var_214_0.name == "" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_211_1.time_ - 0) / var_214_1)
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_214_2 = arg_211_1.actors_["1060"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1060 == nil then
				arg_211_1.var_.actorSpriteComps1060 = var_214_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_3 = 0.034

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.actorSpriteComps1060 then
					for iter_214_1, iter_214_2 in pairs(arg_211_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_214_2 then
							if arg_211_1.isInRecall_ then
								iter_214_2.color = Color.New(Mathf.Lerp(iter_214_2.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_3), Mathf.Lerp(iter_214_2.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_3), (Mathf.Lerp(iter_214_2.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_3)))
							else
								local var_214_4 = Mathf.Lerp(iter_214_2.color.r, 1, (arg_211_1.time_ - 0) / var_214_3)

								iter_214_2.color = Color.New(var_214_4, var_214_4, var_214_4)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1060 then
				for iter_214_3, iter_214_4 in pairs(arg_211_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_214_4 then
						iter_214_4.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps1060 = nil
			end

			local var_214_5 = arg_211_1.actors_["1012"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.actorSpriteComps1012 == nil then
				arg_211_1.var_.actorSpriteComps1012 = var_214_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_6 = 0.034

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.actorSpriteComps1012 then
					for iter_214_5, iter_214_6 in pairs(arg_211_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_214_6 then
							if arg_211_1.isInRecall_ then
								iter_214_6.color = Color.New(Mathf.Lerp(iter_214_6.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_6), Mathf.Lerp(iter_214_6.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_6), (Mathf.Lerp(iter_214_6.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_6)))
							else
								local var_214_7 = Mathf.Lerp(iter_214_6.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_6)

								iter_214_6.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.actorSpriteComps1012 then
				for iter_214_7, iter_214_8 in pairs(arg_211_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_214_8 then
						iter_214_8.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps1012 = nil
			end

			local var_214_8 = 0
			local var_214_9 = 0.2

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_10 = arg_211_1:GetWordFromCfg(410101050)
				local var_214_11 = arg_211_1:FormatText(var_214_10.content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 8 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 8)

				if (8 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 8)) > 0 and var_214_9 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101050", "story_v_out_410101.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101050", "story_v_out_410101.awb") / 1000

					if var_214_14 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_8
					end

					if var_214_10.prefab_name ~= "" and arg_211_1.actors_[var_214_10.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_10.prefab_name].transform, "story_v_out_410101", "410101050", "story_v_out_410101.awb")

						arg_211_1:RecordAudio("410101050", var_214_15)
						arg_211_1:RecordAudio("410101050", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_410101", "410101050", "story_v_out_410101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_410101", "410101050", "story_v_out_410101.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play410101051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410101051
		arg_215_1.duration_ = 15.5

		local var_215_0 = {
			zh = 10.9,
			ja = 15.5
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
				arg_215_0:Play410101052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1012 = arg_215_1.actors_["1012"].transform.localPosition
				arg_215_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1012", 4)

				for iter_218_0 = 0, arg_215_1.actors_["1012"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["1012"].transform:GetChild(iter_218_0)

					if var_218_0.name == "" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_215_1.time_ - 0) / var_218_1)
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_218_2 = arg_215_1.actors_["1012"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1012 == nil then
				arg_215_1.var_.actorSpriteComps1012 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 0.034

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps1012 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_218_2 then
							if arg_215_1.isInRecall_ then
								iter_218_2.color = Color.New(Mathf.Lerp(iter_218_2.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_3), Mathf.Lerp(iter_218_2.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_3), (Mathf.Lerp(iter_218_2.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_3)))
							else
								local var_218_4 = Mathf.Lerp(iter_218_2.color.r, 1, (arg_215_1.time_ - 0) / var_218_3)

								iter_218_2.color = Color.New(var_218_4, var_218_4, var_218_4)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1012 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_218_4 then
						iter_218_4.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1012 = nil
			end

			local var_218_5 = arg_215_1.actors_["1060"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.actorSpriteComps1060 == nil then
				arg_215_1.var_.actorSpriteComps1060 = var_218_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_6 = 0.034

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 and not isNil(var_218_5) then
				if arg_215_1.var_.actorSpriteComps1060 then
					for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_218_6 then
							if arg_215_1.isInRecall_ then
								iter_218_6.color = Color.New(Mathf.Lerp(iter_218_6.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_6), Mathf.Lerp(iter_218_6.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_6), (Mathf.Lerp(iter_218_6.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_6)))
							else
								local var_218_7 = Mathf.Lerp(iter_218_6.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_6)

								iter_218_6.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.actorSpriteComps1060 then
				for iter_218_7, iter_218_8 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_218_8 then
						iter_218_8.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps1060 = nil
			end

			local var_218_8 = 0
			local var_218_9 = 1.15

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(410101051)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 46 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 46)

				if (46 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 46)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101051", "story_v_out_410101.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101051", "story_v_out_410101.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_410101", "410101051", "story_v_out_410101.awb")

						arg_215_1:RecordAudio("410101051", var_218_15)
						arg_215_1:RecordAudio("410101051", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_410101", "410101051", "story_v_out_410101.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_410101", "410101051", "story_v_out_410101.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_9, arg_215_1.talkMaxDuration)

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_8) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_8 + var_218_16 and arg_215_1.time_ < var_218_8 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play410101052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410101052
		arg_219_1.duration_ = 4.6

		local var_219_0 = {
			zh = 4.366,
			ja = 4.6
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play410101053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(410101052)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 12 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 12)

				if (12 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 12)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101052", "story_v_out_410101.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101052", "story_v_out_410101.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_410101", "410101052", "story_v_out_410101.awb")

						arg_219_1:RecordAudio("410101052", var_222_6)
						arg_219_1:RecordAudio("410101052", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_410101", "410101052", "story_v_out_410101.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_410101", "410101052", "story_v_out_410101.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play410101053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 410101053
		arg_223_1.duration_ = 5.53

		local var_223_0 = {
			zh = 1.9,
			ja = 5.533
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play410101054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1060 = arg_223_1.actors_["1060"].transform.localPosition
				arg_223_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1060", 2)

				for iter_226_0 = 0, arg_223_1.actors_["1060"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["1060"].transform:GetChild(iter_226_0)

					if var_226_0.name == "" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_226_2 = arg_223_1.actors_["1060"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1060 == nil then
				arg_223_1.var_.actorSpriteComps1060 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.034

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps1060 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								iter_226_2.color = Color.New(Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_2.color.r, 1, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_2.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1060 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_226_4 then
						iter_226_4.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps1060 = nil
			end

			local var_226_5 = arg_223_1.actors_["1012"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.actorSpriteComps1012 == nil then
				arg_223_1.var_.actorSpriteComps1012 = var_226_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_6 = 0.034

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_6 and not isNil(var_226_5) then
				if arg_223_1.var_.actorSpriteComps1012 then
					for iter_226_5, iter_226_6 in pairs(arg_223_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_226_6 then
							if arg_223_1.isInRecall_ then
								iter_226_6.color = Color.New(Mathf.Lerp(iter_226_6.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_6), Mathf.Lerp(iter_226_6.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_6), (Mathf.Lerp(iter_226_6.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_6)))
							else
								local var_226_7 = Mathf.Lerp(iter_226_6.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_6)

								iter_226_6.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_6 and arg_223_1.time_ < 0 + var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.actorSpriteComps1012 then
				for iter_226_7, iter_226_8 in pairs(arg_223_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_226_8 then
						iter_226_8.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps1012 = nil
			end

			local var_226_8 = 0
			local var_226_9 = 0.125

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(410101053)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 5 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 5)

				if (5 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 5)) > 0 and var_226_9 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101053", "story_v_out_410101.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101053", "story_v_out_410101.awb") / 1000

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_410101", "410101053", "story_v_out_410101.awb")

						arg_223_1:RecordAudio("410101053", var_226_15)
						arg_223_1:RecordAudio("410101053", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_410101", "410101053", "story_v_out_410101.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_410101", "410101053", "story_v_out_410101.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_16 and arg_223_1.time_ < var_226_8 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play410101054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 410101054
		arg_227_1.duration_ = 8.37

		local var_227_0 = {
			zh = 1.3,
			ja = 8.366
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play410101055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1012 = arg_227_1.actors_["1012"].transform.localPosition
				arg_227_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1012", 4)

				for iter_230_0 = 0, arg_227_1.actors_["1012"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["1012"].transform:GetChild(iter_230_0)

					if var_230_0.name == "" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_230_2 = arg_227_1.actors_["1012"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1012 == nil then
				arg_227_1.var_.actorSpriteComps1012 = var_230_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_3 = 0.034

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.actorSpriteComps1012 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								iter_230_2.color = Color.New(Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_3), Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_3), (Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_3)))
							else
								local var_230_4 = Mathf.Lerp(iter_230_2.color.r, 1, (arg_227_1.time_ - 0) / var_230_3)

								iter_230_2.color = Color.New(var_230_4, var_230_4, var_230_4)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1012 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_230_4 then
						iter_230_4.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1012 = nil
			end

			local var_230_5 = arg_227_1.actors_["1060"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.actorSpriteComps1060 == nil then
				arg_227_1.var_.actorSpriteComps1060 = var_230_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_6 = 0.034

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.actorSpriteComps1060 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								iter_230_6.color = Color.New(Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_6), Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_6), (Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_6)))
							else
								local var_230_7 = Mathf.Lerp(iter_230_6.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_6)

								iter_230_6.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.actorSpriteComps1060 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_230_8 then
						iter_230_8.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps1060 = nil
			end

			local var_230_8 = 0
			local var_230_9 = 0.1

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(410101054)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 4 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 4)

				if (4 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 4)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101054", "story_v_out_410101.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101054", "story_v_out_410101.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_out_410101", "410101054", "story_v_out_410101.awb")

						arg_227_1:RecordAudio("410101054", var_230_15)
						arg_227_1:RecordAudio("410101054", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_410101", "410101054", "story_v_out_410101.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_410101", "410101054", "story_v_out_410101.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play410101055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 410101055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play410101056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1012"]) and arg_231_1.var_.actorSpriteComps1012 == nil then
				arg_231_1.var_.actorSpriteComps1012 = arg_231_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1012"]) then
				if arg_231_1.var_.actorSpriteComps1012 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1012"]) and arg_231_1.var_.actorSpriteComps1012 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps1012 = nil
			end

			local var_234_2 = 0
			local var_234_3 = 0.725

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(410101055).content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_6 = 29 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_4) / 29)

				if (29 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_4) / 29)) > 0 and var_234_3 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_7 and arg_231_1.time_ < var_234_2 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play410101056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 410101056
		arg_235_1.duration_ = 5.63

		local var_235_0 = {
			zh = 2.833,
			ja = 5.633
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play410101057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1012 = arg_235_1.actors_["1012"].transform.localPosition
				arg_235_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1012", 4)

				for iter_238_0 = 0, arg_235_1.actors_["1012"].transform.childCount - 1 do
					local var_238_0 = arg_235_1.actors_["1012"].transform:GetChild(iter_238_0)

					if var_238_0.name == "" or not string.find(var_238_0.name, "split") then
						var_238_0.gameObject:SetActive(true)
					else
						var_238_0.gameObject:SetActive(false)
					end
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_235_1.time_ - 0) / var_238_1)
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_238_2 = arg_235_1.actors_["1012"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps1012 == nil then
				arg_235_1.var_.actorSpriteComps1012 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.034

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps1012 then
					for iter_238_1, iter_238_2 in pairs(arg_235_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_238_2 then
							if arg_235_1.isInRecall_ then
								iter_238_2.color = Color.New(Mathf.Lerp(iter_238_2.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_2.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_2.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_2.color.r, 1, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_2.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps1012 then
				for iter_238_3, iter_238_4 in pairs(arg_235_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_238_4 then
						iter_238_4.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps1012 = nil
			end

			local var_238_5 = 0
			local var_238_6 = 0.375

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(410101056)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 15 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 15)

				if (15 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 15)) > 0 and var_238_6 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101056", "story_v_out_410101.awb") ~= 0 then
					local var_238_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101056", "story_v_out_410101.awb") / 1000

					if var_238_11 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_5
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_410101", "410101056", "story_v_out_410101.awb")

						arg_235_1:RecordAudio("410101056", var_238_12)
						arg_235_1:RecordAudio("410101056", var_238_12)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_410101", "410101056", "story_v_out_410101.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_410101", "410101056", "story_v_out_410101.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_13 = math.max(var_238_6, arg_235_1.talkMaxDuration)

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_13 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_5) / var_238_13

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_5 + var_238_13 and arg_235_1.time_ < var_238_5 + var_238_13 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play410101057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 410101057
		arg_239_1.duration_ = 12.37

		local var_239_0 = {
			zh = 6.066,
			ja = 12.366
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
				arg_239_0:Play410101058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1060 = arg_239_1.actors_["1060"].transform.localPosition
				arg_239_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1060", 2)

				for iter_242_0 = 0, arg_239_1.actors_["1060"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["1060"].transform:GetChild(iter_242_0)

					if var_242_0.name == "" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_242_2 = arg_239_1.actors_["1060"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1060 == nil then
				arg_239_1.var_.actorSpriteComps1060 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps1060 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1060 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1060 = nil
			end

			local var_242_5 = arg_239_1.actors_["1012"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.actorSpriteComps1012 == nil then
				arg_239_1.var_.actorSpriteComps1012 = var_242_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_6 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_6 and not isNil(var_242_5) then
				if arg_239_1.var_.actorSpriteComps1012 then
					for iter_242_5, iter_242_6 in pairs(arg_239_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_242_6 then
							if arg_239_1.isInRecall_ then
								iter_242_6.color = Color.New(Mathf.Lerp(iter_242_6.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_6), Mathf.Lerp(iter_242_6.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_6), (Mathf.Lerp(iter_242_6.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_6)))
							else
								local var_242_7 = Mathf.Lerp(iter_242_6.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_6)

								iter_242_6.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_6 and arg_239_1.time_ < 0 + var_242_6 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.actorSpriteComps1012 then
				for iter_242_7, iter_242_8 in pairs(arg_239_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_242_8 then
						iter_242_8.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps1012 = nil
			end

			local var_242_8 = 0
			local var_242_9 = 0.725

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_10 = arg_239_1:GetWordFromCfg(410101057)
				local var_242_11 = arg_239_1:FormatText(var_242_10.content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 29 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 29)

				if (29 <= 0 and var_242_9 or var_242_9 * (utf8.len(var_242_11) / 29)) > 0 and var_242_9 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101057", "story_v_out_410101.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101057", "story_v_out_410101.awb") / 1000

					if var_242_14 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_8
					end

					if var_242_10.prefab_name ~= "" and arg_239_1.actors_[var_242_10.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_10.prefab_name].transform, "story_v_out_410101", "410101057", "story_v_out_410101.awb")

						arg_239_1:RecordAudio("410101057", var_242_15)
						arg_239_1:RecordAudio("410101057", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_410101", "410101057", "story_v_out_410101.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_410101", "410101057", "story_v_out_410101.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_16 and arg_239_1.time_ < var_242_8 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play410101058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 410101058
		arg_243_1.duration_ = 12.17

		local var_243_0 = {
			zh = 8.433,
			ja = 12.166
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play410101059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1060"]) and arg_243_1.var_.actorSpriteComps1060 == nil then
				arg_243_1.var_.actorSpriteComps1060 = arg_243_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.034

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1060"]) then
				if arg_243_1.var_.actorSpriteComps1060 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1060"]) and arg_243_1.var_.actorSpriteComps1060 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1060 = nil
			end

			local var_246_2 = arg_243_1.actors_["1012"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1012 == nil then
				arg_243_1.var_.actorSpriteComps1012 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.034

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps1012 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_246_5 then
							if arg_243_1.isInRecall_ then
								iter_246_5.color = Color.New(Mathf.Lerp(iter_246_5.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_5.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_5.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_5.color.r, 1, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_5.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1012 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_246_7 then
						iter_246_7.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1012 = nil
			end

			local var_246_5 = 0
			local var_246_6 = 1

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:GetWordFromCfg(410101058)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 40 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 40)

				if (40 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 40)) > 0 and var_246_6 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101058", "story_v_out_410101.awb") ~= 0 then
					local var_246_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101058", "story_v_out_410101.awb") / 1000

					if var_246_11 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_5
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_410101", "410101058", "story_v_out_410101.awb")

						arg_243_1:RecordAudio("410101058", var_246_12)
						arg_243_1:RecordAudio("410101058", var_246_12)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_410101", "410101058", "story_v_out_410101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_410101", "410101058", "story_v_out_410101.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_13 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_13 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_13

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_13 and arg_243_1.time_ < var_246_5 + var_246_13 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play410101059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 410101059
		arg_247_1.duration_ = 12.47

		local var_247_0 = {
			zh = 8.266,
			ja = 12.466
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play410101060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(410101059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)

				if (44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101059", "story_v_out_410101.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101059", "story_v_out_410101.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_410101", "410101059", "story_v_out_410101.awb")

						arg_247_1:RecordAudio("410101059", var_250_6)
						arg_247_1:RecordAudio("410101059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_410101", "410101059", "story_v_out_410101.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_410101", "410101059", "story_v_out_410101.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play410101060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 410101060
		arg_251_1.duration_ = 8.13

		local var_251_0 = {
			zh = 7.333,
			ja = 8.133
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play410101061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1060 = arg_251_1.actors_["1060"].transform.localPosition
				arg_251_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1060", 2)

				for iter_254_0 = 0, arg_251_1.actors_["1060"].transform.childCount - 1 do
					local var_254_0 = arg_251_1.actors_["1060"].transform:GetChild(iter_254_0)

					if var_254_0.name == "" or not string.find(var_254_0.name, "split") then
						var_254_0.gameObject:SetActive(true)
					else
						var_254_0.gameObject:SetActive(false)
					end
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_251_1.time_ - 0) / var_254_1)
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_254_2 = arg_251_1.actors_["1060"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps1060 == nil then
				arg_251_1.var_.actorSpriteComps1060 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 0.034

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps1060 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								iter_254_2.color = Color.New(Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_3), Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_3), (Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_3)))
							else
								local var_254_4 = Mathf.Lerp(iter_254_2.color.r, 1, (arg_251_1.time_ - 0) / var_254_3)

								iter_254_2.color = Color.New(var_254_4, var_254_4, var_254_4)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps1060 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_254_4 then
						iter_254_4.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1060 = nil
			end

			local var_254_5 = arg_251_1.actors_["1012"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.actorSpriteComps1012 == nil then
				arg_251_1.var_.actorSpriteComps1012 = var_254_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_6 = 0.034

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_6 and not isNil(var_254_5) then
				if arg_251_1.var_.actorSpriteComps1012 then
					for iter_254_5, iter_254_6 in pairs(arg_251_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_254_6 then
							if arg_251_1.isInRecall_ then
								iter_254_6.color = Color.New(Mathf.Lerp(iter_254_6.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_6), Mathf.Lerp(iter_254_6.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_6), (Mathf.Lerp(iter_254_6.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_6)))
							else
								local var_254_7 = Mathf.Lerp(iter_254_6.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_6)

								iter_254_6.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_6 and arg_251_1.time_ < 0 + var_254_6 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.actorSpriteComps1012 then
				for iter_254_7, iter_254_8 in pairs(arg_251_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_254_8 then
						iter_254_8.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps1012 = nil
			end

			local var_254_8 = 0
			local var_254_9 = 0.825

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(410101060)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 33 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 33)

				if (33 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 33)) > 0 and var_254_9 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101060", "story_v_out_410101.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101060", "story_v_out_410101.awb") / 1000

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_out_410101", "410101060", "story_v_out_410101.awb")

						arg_251_1:RecordAudio("410101060", var_254_15)
						arg_251_1:RecordAudio("410101060", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_410101", "410101060", "story_v_out_410101.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_410101", "410101060", "story_v_out_410101.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play410101061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 410101061
		arg_255_1.duration_ = 11.83

		local var_255_0 = {
			zh = 6.866,
			ja = 11.833
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play410101062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1060"]) and arg_255_1.var_.actorSpriteComps1060 == nil then
				arg_255_1.var_.actorSpriteComps1060 = arg_255_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.034

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1060"]) then
				if arg_255_1.var_.actorSpriteComps1060 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1060"]) and arg_255_1.var_.actorSpriteComps1060 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps1060 = nil
			end

			local var_258_2 = arg_255_1.actors_["1012"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1012 == nil then
				arg_255_1.var_.actorSpriteComps1012 = var_258_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_3 = 0.034

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.actorSpriteComps1012 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								iter_258_5.color = Color.New(Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_3), Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_3), (Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_3)))
							else
								local var_258_4 = Mathf.Lerp(iter_258_5.color.r, 1, (arg_255_1.time_ - 0) / var_258_3)

								iter_258_5.color = Color.New(var_258_4, var_258_4, var_258_4)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1012 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_258_7 then
						iter_258_7.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1012 = nil
			end

			local var_258_5 = 0
			local var_258_6 = 0.875

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(410101061)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 35 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 35)

				if (35 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 35)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101061", "story_v_out_410101.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101061", "story_v_out_410101.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_410101", "410101061", "story_v_out_410101.awb")

						arg_255_1:RecordAudio("410101061", var_258_12)
						arg_255_1:RecordAudio("410101061", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_410101", "410101061", "story_v_out_410101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_410101", "410101061", "story_v_out_410101.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play410101062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 410101062
		arg_259_1.duration_ = 13.03

		local var_259_0 = {
			zh = 6.3,
			ja = 13.033
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play410101063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.825

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(410101062)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 33 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 33)

				if (33 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 33)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101062", "story_v_out_410101.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_410101", "410101062", "story_v_out_410101.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_410101", "410101062", "story_v_out_410101.awb")

						arg_259_1:RecordAudio("410101062", var_262_6)
						arg_259_1:RecordAudio("410101062", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_410101", "410101062", "story_v_out_410101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_410101", "410101062", "story_v_out_410101.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play410101063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 410101063
		arg_263_1.duration_ = 4.47

		local var_263_0 = {
			zh = 2.866,
			ja = 4.466
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play410101064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1060 = arg_263_1.actors_["1060"].transform.localPosition
				arg_263_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1060", 2)

				for iter_266_0 = 0, arg_263_1.actors_["1060"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["1060"].transform:GetChild(iter_266_0)

					if var_266_0.name == "" or not string.find(var_266_0.name, "split") then
						var_266_0.gameObject:SetActive(true)
					else
						var_266_0.gameObject:SetActive(false)
					end
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_263_1.time_ - 0) / var_266_1)
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_266_2 = arg_263_1.actors_["1060"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps1060 == nil then
				arg_263_1.var_.actorSpriteComps1060 = var_266_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_3 = 0.034

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_3 and not isNil(var_266_2) then
				if arg_263_1.var_.actorSpriteComps1060 then
					for iter_266_1, iter_266_2 in pairs(arg_263_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_266_2 then
							if arg_263_1.isInRecall_ then
								iter_266_2.color = Color.New(Mathf.Lerp(iter_266_2.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_3), Mathf.Lerp(iter_266_2.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_3), (Mathf.Lerp(iter_266_2.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_3)))
							else
								local var_266_4 = Mathf.Lerp(iter_266_2.color.r, 1, (arg_263_1.time_ - 0) / var_266_3)

								iter_266_2.color = Color.New(var_266_4, var_266_4, var_266_4)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_3 and arg_263_1.time_ < 0 + var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps1060 then
				for iter_266_3, iter_266_4 in pairs(arg_263_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_266_4 then
						iter_266_4.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps1060 = nil
			end

			local var_266_5 = arg_263_1.actors_["1012"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.actorSpriteComps1012 == nil then
				arg_263_1.var_.actorSpriteComps1012 = var_266_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_6 = 0.034

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_6 and not isNil(var_266_5) then
				if arg_263_1.var_.actorSpriteComps1012 then
					for iter_266_5, iter_266_6 in pairs(arg_263_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_266_6 then
							if arg_263_1.isInRecall_ then
								iter_266_6.color = Color.New(Mathf.Lerp(iter_266_6.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_6), Mathf.Lerp(iter_266_6.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_6), (Mathf.Lerp(iter_266_6.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_6)))
							else
								local var_266_7 = Mathf.Lerp(iter_266_6.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_6)

								iter_266_6.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_6 and arg_263_1.time_ < 0 + var_266_6 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.actorSpriteComps1012 then
				for iter_266_7, iter_266_8 in pairs(arg_263_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_266_8 then
						iter_266_8.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps1012 = nil
			end

			local var_266_8 = 0
			local var_266_9 = 0.3

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:GetWordFromCfg(410101063)
				local var_266_11 = arg_263_1:FormatText(var_266_10.content)

				arg_263_1.text_.text = var_266_11

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 12 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_11) / 12)

				if (12 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_11) / 12)) > 0 and var_266_9 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_11
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101063", "story_v_out_410101.awb") ~= 0 then
					local var_266_14 = manager.audio:GetVoiceLength("story_v_out_410101", "410101063", "story_v_out_410101.awb") / 1000

					if var_266_14 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_14 + var_266_8
					end

					if var_266_10.prefab_name ~= "" and arg_263_1.actors_[var_266_10.prefab_name] ~= nil then
						local var_266_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_10.prefab_name].transform, "story_v_out_410101", "410101063", "story_v_out_410101.awb")

						arg_263_1:RecordAudio("410101063", var_266_15)
						arg_263_1:RecordAudio("410101063", var_266_15)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_410101", "410101063", "story_v_out_410101.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_410101", "410101063", "story_v_out_410101.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_16 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_16 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_16

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_16 and arg_263_1.time_ < var_266_8 + var_266_16 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play410101064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 410101064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play410101065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1012 = arg_267_1.actors_["1012"].transform.localPosition
				arg_267_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1012", 7)

				for iter_270_0 = 0, arg_267_1.actors_["1012"].transform.childCount - 1 do
					local var_270_0 = arg_267_1.actors_["1012"].transform:GetChild(iter_270_0)

					if var_270_0.name == "" or not string.find(var_270_0.name, "split") then
						var_270_0.gameObject:SetActive(true)
					else
						var_270_0.gameObject:SetActive(false)
					end
				end
			end

			local var_270_1 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 then
				arg_267_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_267_1.time_ - 0) / var_270_1)
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 then
				arg_267_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_270_2 = arg_267_1.actors_["1060"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1060 = var_270_2.localPosition
				var_270_2.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1060", 7)

				for iter_270_1 = 0, var_270_2.childCount - 1 do
					local var_270_3 = var_270_2:GetChild(iter_270_1)

					if var_270_3.name == "" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_2.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_267_1.time_ - 0) / var_270_4)
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_270_5 = 0
			local var_270_6 = 1.175

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(410101064).content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 47 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 47)

				if (47 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 47)) > 0 and var_270_6 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_10 and arg_267_1.time_ < var_270_5 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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

		arg_267_1:InitPlayNodeList()
	end,
	Play410101065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 410101065
		arg_271_1.duration_ = 4.67

		local var_271_0 = {
			zh = 4.666,
			ja = 3.666
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
				arg_271_0:Play410101066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1012 = arg_271_1.actors_["1012"].transform.localPosition
				arg_271_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1012", 3)

				for iter_274_0 = 0, arg_271_1.actors_["1012"].transform.childCount - 1 do
					local var_274_0 = arg_271_1.actors_["1012"].transform:GetChild(iter_274_0)

					if var_274_0.name == "" or not string.find(var_274_0.name, "split") then
						var_274_0.gameObject:SetActive(true)
					else
						var_274_0.gameObject:SetActive(false)
					end
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_271_1.time_ - 0) / var_274_1)
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["1012"].transform.localPosition = Vector3.New(0, -465, 300)
			end

			local var_274_2 = arg_271_1.actors_["1012"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1012 == nil then
				arg_271_1.var_.actorSpriteComps1012 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.034

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps1012 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								iter_274_2.color = Color.New(Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_3), Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_3), (Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_3)))
							else
								local var_274_4 = Mathf.Lerp(iter_274_2.color.r, 1, (arg_271_1.time_ - 0) / var_274_3)

								iter_274_2.color = Color.New(var_274_4, var_274_4, var_274_4)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1012 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_274_4 then
						iter_274_4.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps1012 = nil
			end

			local var_274_5 = 0
			local var_274_6 = 0.6

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(410101065)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 24 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 24)

				if (24 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 24)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101065", "story_v_out_410101.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101065", "story_v_out_410101.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_410101", "410101065", "story_v_out_410101.awb")

						arg_271_1:RecordAudio("410101065", var_274_12)
						arg_271_1:RecordAudio("410101065", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_410101", "410101065", "story_v_out_410101.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_410101", "410101065", "story_v_out_410101.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410101066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 410101066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play410101067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1012"]) and arg_275_1.var_.actorSpriteComps1012 == nil then
				arg_275_1.var_.actorSpriteComps1012 = arg_275_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.034

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1012"]) then
				if arg_275_1.var_.actorSpriteComps1012 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1012"]) and arg_275_1.var_.actorSpriteComps1012 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps1012 = nil
			end

			local var_278_2 = 0
			local var_278_3 = 1.05

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(410101066).content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 42 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 42)

				if (42 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 42)) > 0 and var_278_3 < var_278_6 then
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
	Play410101067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 410101067
		arg_279_1.duration_ = 8.5

		local var_279_0 = {
			zh = 3.066,
			ja = 8.5
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
			arg_279_1.auto_ = false
		end

		function arg_279_1.playNext_(arg_281_0)
			arg_279_1.onStoryFinished_()
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1012 = arg_279_1.actors_["1012"].transform.localPosition
				arg_279_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1012", 3)

				for iter_282_0 = 0, arg_279_1.actors_["1012"].transform.childCount - 1 do
					local var_282_0 = arg_279_1.actors_["1012"].transform:GetChild(iter_282_0)

					if var_282_0.name == "split_3" or not string.find(var_282_0.name, "split") then
						var_282_0.gameObject:SetActive(true)
					else
						var_282_0.gameObject:SetActive(false)
					end
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_279_1.time_ - 0) / var_282_1)
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["1012"].transform.localPosition = Vector3.New(0, -465, 300)
			end

			local var_282_2 = arg_279_1.actors_["1012"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps1012 == nil then
				arg_279_1.var_.actorSpriteComps1012 = var_282_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_3 = 0.034

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 and not isNil(var_282_2) then
				if arg_279_1.var_.actorSpriteComps1012 then
					for iter_282_1, iter_282_2 in pairs(arg_279_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_282_2 then
							if arg_279_1.isInRecall_ then
								iter_282_2.color = Color.New(Mathf.Lerp(iter_282_2.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_3), Mathf.Lerp(iter_282_2.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_3), (Mathf.Lerp(iter_282_2.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_3)))
							else
								local var_282_4 = Mathf.Lerp(iter_282_2.color.r, 1, (arg_279_1.time_ - 0) / var_282_3)

								iter_282_2.color = Color.New(var_282_4, var_282_4, var_282_4)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps1012 then
				for iter_282_3, iter_282_4 in pairs(arg_279_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_282_4 then
						iter_282_4.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps1012 = nil
			end

			local var_282_5 = 0
			local var_282_6 = 0.25

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(410101067)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 10 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 10)

				if (10 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 10)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101067", "story_v_out_410101.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_410101", "410101067", "story_v_out_410101.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_410101", "410101067", "story_v_out_410101.awb")

						arg_279_1:RecordAudio("410101067", var_282_12)
						arg_279_1:RecordAudio("410101067", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_410101", "410101067", "story_v_out_410101.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_410101", "410101067", "story_v_out_410101.awb")
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
				actorName = "1012",
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
	assets = {
		"TextureConfig/Background/J02c",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST31a",
		"TextureConfig/Background/L02g"
	},
	voices = {
		"story_v_out_410101.awb"
	}
}
