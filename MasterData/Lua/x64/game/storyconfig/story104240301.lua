return {
	Play424031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424031001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			zh = 4.8,
			ja = 5.4
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
				arg_1_0:Play424031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I18a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I18a")
				var_4_0.name = "I18a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I18a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I18a

				arg_1_1.bgs_.I18a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I18a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.025

			if 2.025 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_valley", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(424031001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 13 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 13)

				if (13 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 13)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031001", "story_v_out_424031.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_424031", "424031001", "story_v_out_424031.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_424031", "424031001", "story_v_out_424031.awb")

						arg_1_1:RecordAudio("424031001", var_4_24)
						arg_1_1:RecordAudio("424031001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_424031", "424031001", "story_v_out_424031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_424031", "424031001", "story_v_out_424031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424031002
		arg_9_1.duration_ = 1

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1094"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "1094"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["1094"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["1094"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1094 == nil then
				arg_9_1.var_.actorSpriteComps1094 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps1094 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1094 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1094 = nil
			end

			local var_12_5 = arg_9_1.actors_["1094"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1094 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1094", 3)

				for iter_12_6 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_6)

					if var_12_6.name == "split_1" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -335, -230)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue1094 = var_12_8.alpha
					arg_9_1.var_.characterEffect1094 = var_12_8
				end

				arg_9_1.var_.alphaOldValue1094 = 0
			end

			local var_12_9 = 0.05

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect1094 then
					arg_9_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue1094, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect1094 then
				arg_9_1.var_.characterEffect1094.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 0.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(424031002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 2 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 2)

				if (2 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 2)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031002", "story_v_out_424031.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_424031", "424031002", "story_v_out_424031.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_424031", "424031002", "story_v_out_424031.awb")

						arg_9_1:RecordAudio("424031002", var_12_17)
						arg_9_1:RecordAudio("424031002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424031", "424031002", "story_v_out_424031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424031", "424031002", "story_v_out_424031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1094"]) and arg_13_1.var_.actorSpriteComps1094 == nil then
				arg_13_1.var_.actorSpriteComps1094 = arg_13_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1094"]) then
				if arg_13_1.var_.actorSpriteComps1094 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1094"]) and arg_13_1.var_.actorSpriteComps1094 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps1094 = nil
			end

			local var_16_2 = arg_13_1.actors_["1094"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1094 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1094", 7)

				for iter_16_4 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_4)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_5 = 0
			local var_16_6 = 0.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(424031003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 31 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 31)

				if (31 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 31)) > 0 and var_16_6 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_10 and arg_13_1.time_ < var_16_5 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424031004
		arg_17_1.duration_ = 9.8

		local var_17_0 = {
			zh = 5.5,
			ja = 9.8
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
				arg_17_0:Play424031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(424031004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)

				if (28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031004", "story_v_out_424031.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031004", "story_v_out_424031.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_424031", "424031004", "story_v_out_424031.awb")

						arg_17_1:RecordAudio("424031004", var_20_6)
						arg_17_1:RecordAudio("424031004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_424031", "424031004", "story_v_out_424031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_424031", "424031004", "story_v_out_424031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play424031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play424031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(424031005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 25 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 25)

				if (25 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 25)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play424031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424031006
		arg_25_1.duration_ = 11.47

		local var_25_0 = {
			zh = 7.466,
			ja = 11.466
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
				arg_25_0:Play424031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.925

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(424031006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 37 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 37)

				if (37 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 37)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031006", "story_v_out_424031.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031006", "story_v_out_424031.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_424031", "424031006", "story_v_out_424031.awb")

						arg_25_1:RecordAudio("424031006", var_28_6)
						arg_25_1:RecordAudio("424031006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_424031", "424031006", "story_v_out_424031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_424031", "424031006", "story_v_out_424031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play424031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424031007
		arg_29_1.duration_ = 5.3

		local var_29_0 = {
			zh = 4.866,
			ja = 5.3
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
				arg_29_0:Play424031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(424031007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 23 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 23)

				if (23 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 23)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031007", "story_v_out_424031.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031007", "story_v_out_424031.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_424031", "424031007", "story_v_out_424031.awb")

						arg_29_1:RecordAudio("424031007", var_32_6)
						arg_29_1:RecordAudio("424031007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_424031", "424031007", "story_v_out_424031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_424031", "424031007", "story_v_out_424031.awb")
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
	Play424031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424031008
		arg_33_1.duration_ = 7.13

		local var_33_0 = {
			zh = 5.3,
			ja = 7.133
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
				arg_33_0:Play424031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1094"]) and arg_33_1.var_.actorSpriteComps1094 == nil then
				arg_33_1.var_.actorSpriteComps1094 = arg_33_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1094"]) then
				if arg_33_1.var_.actorSpriteComps1094 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1094"]) and arg_33_1.var_.actorSpriteComps1094 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1094 = nil
			end

			local var_36_2 = arg_33_1.actors_["1094"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1094 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1094", 3)

				for iter_36_4 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_4)

					if var_36_3.name == "split_1" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_36_5 = 0
			local var_36_6 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(424031008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 20 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 20)

				if (20 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 20)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031008", "story_v_out_424031.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031008", "story_v_out_424031.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_424031", "424031008", "story_v_out_424031.awb")

						arg_33_1:RecordAudio("424031008", var_36_12)
						arg_33_1:RecordAudio("424031008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_424031", "424031008", "story_v_out_424031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_424031", "424031008", "story_v_out_424031.awb")
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
				actorName = "1094",
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
	Play424031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424031009
		arg_37_1.duration_ = 4.33

		local var_37_0 = {
			zh = 3.8,
			ja = 4.333
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
				arg_37_0:Play424031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1094"]) and arg_37_1.var_.actorSpriteComps1094 == nil then
				arg_37_1.var_.actorSpriteComps1094 = arg_37_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1094"]) then
				if arg_37_1.var_.actorSpriteComps1094 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1094"]) and arg_37_1.var_.actorSpriteComps1094 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1094 = nil
			end

			local var_40_2 = 0
			local var_40_3 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_4 = arg_37_1:GetWordFromCfg(424031009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 21 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 21)

				if (21 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 21)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031009", "story_v_out_424031.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031009", "story_v_out_424031.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_424031", "424031009", "story_v_out_424031.awb")

						arg_37_1:RecordAudio("424031009", var_40_9)
						arg_37_1:RecordAudio("424031009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_424031", "424031009", "story_v_out_424031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_424031", "424031009", "story_v_out_424031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play424031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424031010
		arg_41_1.duration_ = 3.57

		local var_41_0 = {
			zh = 3.333,
			ja = 3.566
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
				arg_41_0:Play424031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1094"]) and arg_41_1.var_.actorSpriteComps1094 == nil then
				arg_41_1.var_.actorSpriteComps1094 = arg_41_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1094"]) then
				if arg_41_1.var_.actorSpriteComps1094 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1094"]) and arg_41_1.var_.actorSpriteComps1094 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1094 = nil
			end

			local var_44_2 = 0
			local var_44_3 = 0.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(424031010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 11 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 11)

				if (11 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 11)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031010", "story_v_out_424031.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031010", "story_v_out_424031.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_424031", "424031010", "story_v_out_424031.awb")

						arg_41_1:RecordAudio("424031010", var_44_9)
						arg_41_1:RecordAudio("424031010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_424031", "424031010", "story_v_out_424031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_424031", "424031010", "story_v_out_424031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play424031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424031011
		arg_45_1.duration_ = 9.13

		local var_45_0 = {
			zh = 6.533,
			ja = 9.133
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
				arg_45_0:Play424031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1094"]) and arg_45_1.var_.actorSpriteComps1094 == nil then
				arg_45_1.var_.actorSpriteComps1094 = arg_45_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1094"]) then
				if arg_45_1.var_.actorSpriteComps1094 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1094"]) and arg_45_1.var_.actorSpriteComps1094 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1094 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.725

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:GetWordFromCfg(424031011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 29 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 29)

				if (29 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 29)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031011", "story_v_out_424031.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031011", "story_v_out_424031.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_424031", "424031011", "story_v_out_424031.awb")

						arg_45_1:RecordAudio("424031011", var_48_9)
						arg_45_1:RecordAudio("424031011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424031", "424031011", "story_v_out_424031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424031", "424031011", "story_v_out_424031.awb")
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
	Play424031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424031012
		arg_49_1.duration_ = 1.3

		local var_49_0 = {
			zh = 1.133,
			ja = 1.3
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
				arg_49_0:Play424031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1094"]) and arg_49_1.var_.actorSpriteComps1094 == nil then
				arg_49_1.var_.actorSpriteComps1094 = arg_49_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1094"]) then
				if arg_49_1.var_.actorSpriteComps1094 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1094"]) and arg_49_1.var_.actorSpriteComps1094 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1094 = nil
			end

			local var_52_2 = arg_49_1.actors_["1094"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1094 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1094", 3)

				for iter_52_4 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_4)

					if var_52_3.name == "split_4" then
						var_52_3:SetAsLastSibling()
						var_52_3.gameObject:SetActive(true)

						arg_49_1.var_.actorSpriteSplit1094 = var_52_3.gameObject:GetComponent(typeof(Image))

						arg_49_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_52_4 = 0.5

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_49_1.time_ - 0) / var_52_4)

				if arg_49_1.var_.actorSpriteSplit1094 ~= nil then
					arg_49_1.var_.actorSpriteSplit1094:SetAlpha((arg_49_1.time_ - 0) / var_52_4)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -335, -230)

				if arg_49_1.var_.actorSpriteSplit1094 ~= nil then
					arg_49_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_52_5 = 0
			local var_52_6 = 0.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(424031012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 2 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 2)

				if (2 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 2)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031012", "story_v_out_424031.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031012", "story_v_out_424031.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_424031", "424031012", "story_v_out_424031.awb")

						arg_49_1:RecordAudio("424031012", var_52_12)
						arg_49_1:RecordAudio("424031012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_424031", "424031012", "story_v_out_424031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_424031", "424031012", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play424031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424031013
		arg_53_1.duration_ = 9.1

		local var_53_0 = {
			zh = 7.533,
			ja = 9.1
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
				arg_53_0:Play424031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1094"]) and arg_53_1.var_.actorSpriteComps1094 == nil then
				arg_53_1.var_.actorSpriteComps1094 = arg_53_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1094"]) then
				if arg_53_1.var_.actorSpriteComps1094 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1094"]) and arg_53_1.var_.actorSpriteComps1094 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1094 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.9

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(424031013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 36 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 36)

				if (36 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 36)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031013", "story_v_out_424031.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031013", "story_v_out_424031.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_424031", "424031013", "story_v_out_424031.awb")

						arg_53_1:RecordAudio("424031013", var_56_9)
						arg_53_1:RecordAudio("424031013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_424031", "424031013", "story_v_out_424031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_424031", "424031013", "story_v_out_424031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play424031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424031014
		arg_57_1.duration_ = 5.3

		local var_57_0 = {
			zh = 5.2,
			ja = 5.3
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
				arg_57_0:Play424031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1094"]) and arg_57_1.var_.actorSpriteComps1094 == nil then
				arg_57_1.var_.actorSpriteComps1094 = arg_57_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1094"]) then
				if arg_57_1.var_.actorSpriteComps1094 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1094"]) and arg_57_1.var_.actorSpriteComps1094 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1094 = nil
			end

			local var_60_2 = arg_57_1.actors_["1094"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1094 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1094", 3)

				for iter_60_4 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_4)

					if var_60_3.name == "split_1" then
						var_60_3:SetAsLastSibling()
						var_60_3.gameObject:SetActive(true)

						arg_57_1.var_.actorSpriteSplit1094 = var_60_3.gameObject:GetComponent(typeof(Image))

						arg_57_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_60_4 = 0.5

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_57_1.time_ - 0) / var_60_4)

				if arg_57_1.var_.actorSpriteSplit1094 ~= nil then
					arg_57_1.var_.actorSpriteSplit1094:SetAlpha((arg_57_1.time_ - 0) / var_60_4)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -335, -230)

				if arg_57_1.var_.actorSpriteSplit1094 ~= nil then
					arg_57_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_60_5 = 0
			local var_60_6 = 0.525

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(424031014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 21 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 21)

				if (21 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 21)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031014", "story_v_out_424031.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031014", "story_v_out_424031.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_424031", "424031014", "story_v_out_424031.awb")

						arg_57_1:RecordAudio("424031014", var_60_12)
						arg_57_1:RecordAudio("424031014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_424031", "424031014", "story_v_out_424031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_424031", "424031014", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play424031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424031015
		arg_61_1.duration_ = 9.97

		local var_61_0 = {
			zh = 9.966,
			ja = 9.733
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
				arg_61_0:Play424031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1094"]) and arg_61_1.var_.actorSpriteComps1094 == nil then
				arg_61_1.var_.actorSpriteComps1094 = arg_61_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1094"]) then
				if arg_61_1.var_.actorSpriteComps1094 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1094"]) and arg_61_1.var_.actorSpriteComps1094 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1094 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 1.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:GetWordFromCfg(424031015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 44 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 44)

				if (44 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 44)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031015", "story_v_out_424031.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031015", "story_v_out_424031.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_424031", "424031015", "story_v_out_424031.awb")

						arg_61_1:RecordAudio("424031015", var_64_9)
						arg_61_1:RecordAudio("424031015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_424031", "424031015", "story_v_out_424031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_424031", "424031015", "story_v_out_424031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play424031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424031016
		arg_65_1.duration_ = 8.7

		local var_65_0 = {
			zh = 6.3,
			ja = 8.7
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
				arg_65_0:Play424031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1094"]) and arg_65_1.var_.actorSpriteComps1094 == nil then
				arg_65_1.var_.actorSpriteComps1094 = arg_65_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1094"]) then
				if arg_65_1.var_.actorSpriteComps1094 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1094"]) and arg_65_1.var_.actorSpriteComps1094 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1094 = nil
			end

			local var_68_2 = arg_65_1.actors_["1094"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1094 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1094", 3)

				for iter_68_4 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_4)

					if var_68_3.name == "split_3" then
						var_68_3:SetAsLastSibling()
						var_68_3.gameObject:SetActive(true)

						arg_65_1.var_.actorSpriteSplit1094 = var_68_3.gameObject:GetComponent(typeof(Image))

						arg_65_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_68_4 = 0.5

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_65_1.time_ - 0) / var_68_4)

				if arg_65_1.var_.actorSpriteSplit1094 ~= nil then
					arg_65_1.var_.actorSpriteSplit1094:SetAlpha((arg_65_1.time_ - 0) / var_68_4)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -335, -230)

				if arg_65_1.var_.actorSpriteSplit1094 ~= nil then
					arg_65_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_68_5 = 0
			local var_68_6 = 0.65

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(424031016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 26 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 26)

				if (26 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 26)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031016", "story_v_out_424031.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031016", "story_v_out_424031.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_424031", "424031016", "story_v_out_424031.awb")

						arg_65_1:RecordAudio("424031016", var_68_12)
						arg_65_1:RecordAudio("424031016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_424031", "424031016", "story_v_out_424031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_424031", "424031016", "story_v_out_424031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play424031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424031017
		arg_69_1.duration_ = 9.4

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play424031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1094"]) and arg_69_1.var_.actorSpriteComps1094 == nil then
				arg_69_1.var_.actorSpriteComps1094 = arg_69_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1094"]) then
				if arg_69_1.var_.actorSpriteComps1094 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1094"]) and arg_69_1.var_.actorSpriteComps1094 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1094 = nil
			end

			local var_72_2 = 0
			local var_72_3 = 1.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_4 = arg_69_1:GetWordFromCfg(424031017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 46 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 46)

				if (46 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 46)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031017", "story_v_out_424031.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031017", "story_v_out_424031.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_424031", "424031017", "story_v_out_424031.awb")

						arg_69_1:RecordAudio("424031017", var_72_9)
						arg_69_1:RecordAudio("424031017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_424031", "424031017", "story_v_out_424031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_424031", "424031017", "story_v_out_424031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play424031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424031018
		arg_73_1.duration_ = 2.83

		local var_73_0 = {
			zh = 2.7,
			ja = 2.833
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
				arg_73_0:Play424031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1094"]) and arg_73_1.var_.actorSpriteComps1094 == nil then
				arg_73_1.var_.actorSpriteComps1094 = arg_73_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1094"]) then
				if arg_73_1.var_.actorSpriteComps1094 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1094"]) and arg_73_1.var_.actorSpriteComps1094 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1094 = nil
			end

			local var_76_2 = arg_73_1.actors_["1094"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1094 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1094", 3)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "split_1" then
						var_76_3:SetAsLastSibling()
						var_76_3.gameObject:SetActive(true)

						arg_73_1.var_.actorSpriteSplit1094 = var_76_3.gameObject:GetComponent(typeof(Image))

						arg_73_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_76_4 = 0.5

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_73_1.time_ - 0) / var_76_4)

				if arg_73_1.var_.actorSpriteSplit1094 ~= nil then
					arg_73_1.var_.actorSpriteSplit1094:SetAlpha((arg_73_1.time_ - 0) / var_76_4)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -335, -230)

				if arg_73_1.var_.actorSpriteSplit1094 ~= nil then
					arg_73_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_76_5 = 0
			local var_76_6 = 0.225

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(424031018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 9 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 9)

				if (9 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 9)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031018", "story_v_out_424031.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031018", "story_v_out_424031.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_424031", "424031018", "story_v_out_424031.awb")

						arg_73_1:RecordAudio("424031018", var_76_12)
						arg_73_1:RecordAudio("424031018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_424031", "424031018", "story_v_out_424031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_424031", "424031018", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play424031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424031019
		arg_77_1.duration_ = 7.97

		local var_77_0 = {
			zh = 7.966,
			ja = 7.366
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
				arg_77_0:Play424031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1094"]) and arg_77_1.var_.actorSpriteComps1094 == nil then
				arg_77_1.var_.actorSpriteComps1094 = arg_77_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1094"]) then
				if arg_77_1.var_.actorSpriteComps1094 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1094"]) and arg_77_1.var_.actorSpriteComps1094 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1094 = nil
			end

			local var_80_2 = 0
			local var_80_3 = 0.925

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_4 = arg_77_1:GetWordFromCfg(424031019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 37 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 37)

				if (37 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 37)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031019", "story_v_out_424031.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031019", "story_v_out_424031.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_424031", "424031019", "story_v_out_424031.awb")

						arg_77_1:RecordAudio("424031019", var_80_9)
						arg_77_1:RecordAudio("424031019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_424031", "424031019", "story_v_out_424031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_424031", "424031019", "story_v_out_424031.awb")
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
	Play424031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424031020
		arg_81_1.duration_ = 3.33

		local var_81_0 = {
			zh = 1.766,
			ja = 3.333
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
				arg_81_0:Play424031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1094"]) and arg_81_1.var_.actorSpriteComps1094 == nil then
				arg_81_1.var_.actorSpriteComps1094 = arg_81_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1094"]) then
				if arg_81_1.var_.actorSpriteComps1094 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1094"]) and arg_81_1.var_.actorSpriteComps1094 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1094 = nil
			end

			local var_84_2 = arg_81_1.actors_["1094"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1094 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1094", 3)

				for iter_84_4 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_4)

					if var_84_3.name == "split_4" then
						var_84_3:SetAsLastSibling()
						var_84_3.gameObject:SetActive(true)

						arg_81_1.var_.actorSpriteSplit1094 = var_84_3.gameObject:GetComponent(typeof(Image))

						arg_81_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_84_4 = 0.5

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_81_1.time_ - 0) / var_84_4)

				if arg_81_1.var_.actorSpriteSplit1094 ~= nil then
					arg_81_1.var_.actorSpriteSplit1094:SetAlpha((arg_81_1.time_ - 0) / var_84_4)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(0, -335, -230)

				if arg_81_1.var_.actorSpriteSplit1094 ~= nil then
					arg_81_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_84_5 = 0
			local var_84_6 = 0.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(424031020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 7 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 7)

				if (7 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 7)) > 0 and var_84_6 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031020", "story_v_out_424031.awb") ~= 0 then
					local var_84_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031020", "story_v_out_424031.awb") / 1000

					if var_84_11 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_5
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_424031", "424031020", "story_v_out_424031.awb")

						arg_81_1:RecordAudio("424031020", var_84_12)
						arg_81_1:RecordAudio("424031020", var_84_12)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_424031", "424031020", "story_v_out_424031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_424031", "424031020", "story_v_out_424031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_13 and arg_81_1.time_ < var_84_5 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play424031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424031021
		arg_85_1.duration_ = 3.23

		local var_85_0 = {
			zh = 2.9,
			ja = 3.233
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
				arg_85_0:Play424031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1094"]) and arg_85_1.var_.actorSpriteComps1094 == nil then
				arg_85_1.var_.actorSpriteComps1094 = arg_85_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1094"]) then
				if arg_85_1.var_.actorSpriteComps1094 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1094"]) and arg_85_1.var_.actorSpriteComps1094 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1094 = nil
			end

			local var_88_2 = 0
			local var_88_3 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_4 = arg_85_1:GetWordFromCfg(424031021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 16 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 16)

				if (16 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 16)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031021", "story_v_out_424031.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031021", "story_v_out_424031.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_424031", "424031021", "story_v_out_424031.awb")

						arg_85_1:RecordAudio("424031021", var_88_9)
						arg_85_1:RecordAudio("424031021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_424031", "424031021", "story_v_out_424031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_424031", "424031021", "story_v_out_424031.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play424031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424031022
		arg_89_1.duration_ = 8.7

		local var_89_0 = {
			zh = 7.2,
			ja = 8.7
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
				arg_89_0:Play424031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1094"]) and arg_89_1.var_.actorSpriteComps1094 == nil then
				arg_89_1.var_.actorSpriteComps1094 = arg_89_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1094"]) then
				if arg_89_1.var_.actorSpriteComps1094 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1094"]) and arg_89_1.var_.actorSpriteComps1094 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1094 = nil
			end

			local var_92_2 = arg_89_1.actors_["1094"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1094 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1094", 3)

				for iter_92_4 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_4)

					if var_92_3.name == "split_1" then
						var_92_3:SetAsLastSibling()
						var_92_3.gameObject:SetActive(true)

						arg_89_1.var_.actorSpriteSplit1094 = var_92_3.gameObject:GetComponent(typeof(Image))

						arg_89_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_92_4 = 0.5

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_89_1.time_ - 0) / var_92_4)

				if arg_89_1.var_.actorSpriteSplit1094 ~= nil then
					arg_89_1.var_.actorSpriteSplit1094:SetAlpha((arg_89_1.time_ - 0) / var_92_4)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -335, -230)

				if arg_89_1.var_.actorSpriteSplit1094 ~= nil then
					arg_89_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_92_5 = 0
			local var_92_6 = 0.625

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(424031022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 25 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 25)

				if (25 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 25)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031022", "story_v_out_424031.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031022", "story_v_out_424031.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_424031", "424031022", "story_v_out_424031.awb")

						arg_89_1:RecordAudio("424031022", var_92_12)
						arg_89_1:RecordAudio("424031022", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424031", "424031022", "story_v_out_424031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424031", "424031022", "story_v_out_424031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play424031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424031023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play424031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 == nil then
				arg_93_1.var_.actorSpriteComps1094 = arg_93_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1094"]) then
				if arg_93_1.var_.actorSpriteComps1094 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1094 = nil
			end

			local var_96_2 = arg_93_1.actors_["1094"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1094 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1094", 7)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.6 < arg_93_1.time_ and arg_93_1.time_ <= 0.6 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_beep", "")
			end

			local var_96_6 = 0
			local var_96_7 = 0.975

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(424031023).content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 39 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_8) / 39)

				if (39 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_8) / 39)) > 0 and var_96_7 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_11 and arg_93_1.time_ < var_96_6 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424031024
		arg_97_1.duration_ = 3.93

		local var_97_0 = {
			zh = 3.933,
			ja = 3.866
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
				arg_97_0:Play424031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1094"]) and arg_97_1.var_.actorSpriteComps1094 == nil then
				arg_97_1.var_.actorSpriteComps1094 = arg_97_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1094"]) then
				if arg_97_1.var_.actorSpriteComps1094 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 1, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1094"]) and arg_97_1.var_.actorSpriteComps1094 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps1094 = nil
			end

			local var_100_2 = arg_97_1.actors_["1094"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 3)

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
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_100_5 = 0
			local var_100_6 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(424031024)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 13 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 13)

				if (13 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 13)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031024", "story_v_out_424031.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031024", "story_v_out_424031.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_424031", "424031024", "story_v_out_424031.awb")

						arg_97_1:RecordAudio("424031024", var_100_12)
						arg_97_1:RecordAudio("424031024", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_424031", "424031024", "story_v_out_424031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_424031", "424031024", "story_v_out_424031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 424031025
		arg_101_1.duration_ = 9

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play424031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.bgs_.ST0115 == nil then
				local var_104_0 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115")
				var_104_0.name = "ST0115"
				var_104_0.transform.parent = arg_101_1.stage_.transform
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_.ST0115 = var_104_0
			end

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				local var_104_1 = arg_101_1.bgs_.ST0115

				arg_101_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_2 = var_104_1:GetComponent("SpriteRenderer")

				if var_104_2 and var_104_2.sprite then
					local var_104_3 = 2 * (var_104_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_1.transform.localScale = Vector3.New(var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST0115" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_4 = 3.999999999999

			if 3.999999999999 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_4 + 0.3 and arg_101_1.time_ < var_104_4 + 0.3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_5 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_6 = 2

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 then
				local var_104_7 = Color.New(0, 0, 0)

				var_104_7.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_5) / var_104_6)
				arg_101_1.mask_.color = var_104_7
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 then
				local var_104_8 = Color.New(0, 0, 0)

				var_104_8.a = 1
				arg_101_1.mask_.color = var_104_8
			end

			local var_104_9 = 2

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_10 = 2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 then
				local var_104_11 = Color.New(0, 0, 0)

				var_104_11.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_9) / var_104_10)
				arg_101_1.mask_.color = var_104_11
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 then
				local var_104_12 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_12.a = 0
				arg_101_1.mask_.color = var_104_12
			end

			local var_104_13 = arg_101_1.actors_["1094"]

			if 1.966 < arg_101_1.time_ and arg_101_1.time_ <= 1.966 + arg_104_0 and not isNil(var_104_13) and arg_101_1.var_.actorSpriteComps1094 == nil then
				arg_101_1.var_.actorSpriteComps1094 = var_104_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_14 = 0.034

			if 1.966 <= arg_101_1.time_ and arg_101_1.time_ < 1.966 + var_104_14 and not isNil(var_104_13) then
				if arg_101_1.var_.actorSpriteComps1094 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								iter_104_3.color = Color.New(Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 1.966) / var_104_14), Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 1.966) / var_104_14), (Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 1.966) / var_104_14)))
							else
								local var_104_15 = Mathf.Lerp(iter_104_3.color.r, 0.5, (arg_101_1.time_ - 1.966) / var_104_14)

								iter_104_3.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 1.966 + var_104_14 and arg_101_1.time_ < 1.966 + var_104_14 + arg_104_0 and not isNil(var_104_13) and arg_101_1.var_.actorSpriteComps1094 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_104_5 then
						iter_104_5.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps1094 = nil
			end

			local var_104_16 = arg_101_1.actors_["1094"].transform

			if 1.966 < arg_101_1.time_ and arg_101_1.time_ <= 1.966 + arg_104_0 then
				arg_101_1.var_.moveOldPos1094 = var_104_16.localPosition
				var_104_16.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1094", 7)

				for iter_104_6 = 0, var_104_16.childCount - 1 do
					local var_104_17 = var_104_16:GetChild(iter_104_6)

					if var_104_17.name == "" or not string.find(var_104_17.name, "split") then
						var_104_17.gameObject:SetActive(true)
					else
						var_104_17.gameObject:SetActive(false)
					end
				end
			end

			local var_104_18 = 0.001

			if 1.966 <= arg_101_1.time_ and arg_101_1.time_ < 1.966 + var_104_18 then
				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_101_1.time_ - 1.966) / var_104_18)
			end

			if arg_101_1.time_ >= 1.966 + var_104_18 and arg_101_1.time_ < 1.966 + var_104_18 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_101_1.time_ and arg_101_1.time_ <= 0.2 + arg_104_0 then
				arg_101_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_valley", "")
			end

			if 1.66666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 1.66666666666667 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_21 = 4
			local var_104_22 = 1.25

			if 4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_23 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_23:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(424031025).content)

				arg_101_1.text_.text = var_104_24

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_26 = 50 <= 0 and var_104_22 or var_104_22 * (utf8.len(var_104_24) / 50)

				if (50 <= 0 and var_104_22 or var_104_22 * (utf8.len(var_104_24) / 50)) > 0 and var_104_22 < var_104_26 then
					arg_101_1.talkMaxDuration = var_104_26
					var_104_21 = var_104_21 + 0.3

					if var_104_26 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_26 + var_104_21
					end
				end

				arg_101_1.text_.text = var_104_24
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_27 = var_104_21 + 0.3
			local var_104_28 = math.max(var_104_22, arg_101_1.talkMaxDuration)

			if var_104_21 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_27 + var_104_28 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_27) / var_104_28

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_27 + var_104_28 and arg_101_1.time_ < var_104_27 + var_104_28 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play424031026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424031026
		arg_107_1.duration_ = 6.83

		local var_107_0 = {
			zh = 4.133,
			ja = 6.833
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
				arg_107_0:Play424031027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.475

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_3")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(424031026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 19 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 19)

				if (19 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 19)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031026", "story_v_out_424031.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031026", "story_v_out_424031.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_424031", "424031026", "story_v_out_424031.awb")

						arg_107_1:RecordAudio("424031026", var_110_6)
						arg_107_1:RecordAudio("424031026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_424031", "424031026", "story_v_out_424031.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_424031", "424031026", "story_v_out_424031.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play424031027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424031027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play424031028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0.666666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.666666666666667 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_page", "")
			end

			local var_114_1 = 0
			local var_114_2 = 0.825

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(424031027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 33 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 33)

				if (33 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 33)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play424031028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424031028
		arg_115_1.duration_ = 2.73

		local var_115_0 = {
			zh = 2.733,
			ja = 2.6
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
				arg_115_0:Play424031029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(424031028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 13 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 13)

				if (13 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 13)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031028", "story_v_out_424031.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031028", "story_v_out_424031.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_424031", "424031028", "story_v_out_424031.awb")

						arg_115_1:RecordAudio("424031028", var_118_6)
						arg_115_1:RecordAudio("424031028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_424031", "424031028", "story_v_out_424031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_424031", "424031028", "story_v_out_424031.awb")
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
	Play424031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424031029
		arg_119_1.duration_ = 5.23

		local var_119_0 = {
			zh = 4.6,
			ja = 5.233
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
				arg_119_0:Play424031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.425

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1390].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(424031029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 17 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 17)

				if (17 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 17)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031029", "story_v_out_424031.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031029", "story_v_out_424031.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_424031", "424031029", "story_v_out_424031.awb")

						arg_119_1:RecordAudio("424031029", var_122_6)
						arg_119_1:RecordAudio("424031029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_424031", "424031029", "story_v_out_424031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_424031", "424031029", "story_v_out_424031.awb")
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
	Play424031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424031030
		arg_123_1.duration_ = 3.9

		local var_123_0 = {
			zh = 3.9,
			ja = 3.733
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
				arg_123_0:Play424031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["10155"] == nil then
				local var_126_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

				if not isNil(var_126_0) then
					local var_126_1 = Object.Instantiate(var_126_0, arg_123_1.canvasGo_.transform)

					var_126_1.transform:SetSiblingIndex(1)

					var_126_1.name = "10155"
					var_126_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_123_1.actors_["10155"] = var_126_1

					if arg_123_1.isInRecall_ then
						for iter_126_0, iter_126_1 in ipairs((var_126_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_126_1.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_126_2 = arg_123_1.actors_["10155"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10155 == nil then
				arg_123_1.var_.actorSpriteComps10155 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10155 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								iter_126_3.color = Color.New(Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_3.color.r, 1, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_3.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10155 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_126_5 then
						iter_126_5.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10155 = nil
			end

			local var_126_5 = arg_123_1.actors_["10155"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10155 = var_126_5.localPosition
				var_126_5.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10155", 3)

				for iter_126_6 = 0, var_126_5.childCount - 1 do
					local var_126_6 = var_126_5:GetChild(iter_126_6)

					if var_126_6.name == "split_1" or not string.find(var_126_6.name, "split") then
						var_126_6.gameObject:SetActive(true)
					else
						var_126_6.gameObject:SetActive(false)
					end
				end
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_123_1.time_ - 0) / var_126_7)
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(-40, -390, -250)
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_8 = arg_123_1.actors_["10155"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_8 then
					arg_123_1.var_.alphaOldValue10155 = var_126_8.alpha
					arg_123_1.var_.characterEffect10155 = var_126_8
				end

				arg_123_1.var_.alphaOldValue10155 = 0
			end

			local var_126_9 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 then
				if arg_123_1.var_.characterEffect10155 then
					arg_123_1.var_.characterEffect10155.alpha = Mathf.Lerp(arg_123_1.var_.alphaOldValue10155, 1, (arg_123_1.time_ - 0) / var_126_9)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and arg_123_1.var_.characterEffect10155 then
				arg_123_1.var_.characterEffect10155.alpha = 1
			end

			local var_126_10 = 0
			local var_126_11 = 0.45

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_12 = arg_123_1:GetWordFromCfg(424031030)
				local var_126_13 = arg_123_1:FormatText(var_126_12.content)

				arg_123_1.text_.text = var_126_13

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 18 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 18)

				if (18 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 18)) > 0 and var_126_11 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_13
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031030", "story_v_out_424031.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_424031", "424031030", "story_v_out_424031.awb") / 1000

					if var_126_16 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_10
					end

					if var_126_12.prefab_name ~= "" and arg_123_1.actors_[var_126_12.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_12.prefab_name].transform, "story_v_out_424031", "424031030", "story_v_out_424031.awb")

						arg_123_1:RecordAudio("424031030", var_126_17)
						arg_123_1:RecordAudio("424031030", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_424031", "424031030", "story_v_out_424031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_424031", "424031030", "story_v_out_424031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_10) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_10 + var_126_18 and arg_123_1.time_ < var_126_10 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424031031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10155"]) and arg_127_1.var_.actorSpriteComps10155 == nil then
				arg_127_1.var_.actorSpriteComps10155 = arg_127_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10155"]) then
				if arg_127_1.var_.actorSpriteComps10155 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10155"]) and arg_127_1.var_.actorSpriteComps10155 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10155 = nil
			end

			local var_130_2 = arg_127_1.actors_["10155"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10155 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10155", 7)

				for iter_130_4 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_4)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_5 = 0
			local var_130_6 = 1.125

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(424031031).content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 45 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_7) / 45)

				if (45 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_7) / 45)) > 0 and var_130_6 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_10 and arg_127_1.time_ < var_130_5 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424031032
		arg_131_1.duration_ = 8.53

		local var_131_0 = {
			zh = 7.4,
			ja = 8.533
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
				arg_131_0:Play424031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.actors_["10154"] == nil then
				local var_134_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_134_0) then
					local var_134_1 = Object.Instantiate(var_134_0, arg_131_1.canvasGo_.transform)

					var_134_1.transform:SetSiblingIndex(1)

					var_134_1.name = "10154"
					var_134_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_131_1.actors_["10154"] = var_134_1

					if arg_131_1.isInRecall_ then
						for iter_134_0, iter_134_1 in ipairs((var_134_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_134_1.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_134_2 = arg_131_1.actors_["10154"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10154 == nil then
				arg_131_1.var_.actorSpriteComps10154 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps10154 then
					for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_134_3 then
							if arg_131_1.isInRecall_ then
								iter_134_3.color = Color.New(Mathf.Lerp(iter_134_3.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_3.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_3.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_3.color.r, 1, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_3.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10154 then
				for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_134_5 then
						iter_134_5.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10154 = nil
			end

			local var_134_5 = arg_131_1.actors_["10154"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10154 = var_134_5.localPosition
				var_134_5.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10154", 3)

				for iter_134_6 = 0, var_134_5.childCount - 1 do
					local var_134_6 = var_134_5:GetChild(iter_134_6)

					if var_134_6.name == "split_5" or not string.find(var_134_6.name, "split") then
						var_134_6.gameObject:SetActive(true)
					else
						var_134_6.gameObject:SetActive(false)
					end
				end
			end

			local var_134_7 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_131_1.time_ - 0) / var_134_7)
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_134_8 = 0
			local var_134_9 = 0.875

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(424031032)
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

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031032", "story_v_out_424031.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031032", "story_v_out_424031.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_424031", "424031032", "story_v_out_424031.awb")

						arg_131_1:RecordAudio("424031032", var_134_15)
						arg_131_1:RecordAudio("424031032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424031", "424031032", "story_v_out_424031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424031", "424031032", "story_v_out_424031.awb")
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
				actorName = "10154",
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
	Play424031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424031033
		arg_135_1.duration_ = 9.5

		local var_135_0 = {
			zh = 5.6,
			ja = 9.5
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
				arg_135_0:Play424031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10155"]) and arg_135_1.var_.actorSpriteComps10155 == nil then
				arg_135_1.var_.actorSpriteComps10155 = arg_135_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10155"]) then
				if arg_135_1.var_.actorSpriteComps10155 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 1, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10155"]) and arg_135_1.var_.actorSpriteComps10155 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10155 = nil
			end

			local var_138_2 = arg_135_1.actors_["10154"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10154 == nil then
				arg_135_1.var_.actorSpriteComps10154 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10154 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_138_5 then
							if arg_135_1.isInRecall_ then
								iter_138_5.color = Color.New(Mathf.Lerp(iter_138_5.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_5.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_5.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_5.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_5.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10154 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_138_7 then
						iter_138_7.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10154 = nil
			end

			local var_138_5 = arg_135_1.actors_["10155"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10155 = var_138_5.localPosition
				var_138_5.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10155", 3)

				for iter_138_8 = 0, var_138_5.childCount - 1 do
					local var_138_6 = var_138_5:GetChild(iter_138_8)

					if var_138_6.name == "split_2" then
						var_138_6:SetAsLastSibling()
						var_138_6.gameObject:SetActive(true)

						arg_135_1.var_.actorSpriteSplit10155 = var_138_6.gameObject:GetComponent(typeof(Image))

						arg_135_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_138_7 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_135_1.time_ - 0) / var_138_7)

				if arg_135_1.var_.actorSpriteSplit10155 ~= nil then
					arg_135_1.var_.actorSpriteSplit10155:SetAlpha((arg_135_1.time_ - 0) / var_138_7)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(-40, -390, -250)

				if arg_135_1.var_.actorSpriteSplit10155 ~= nil then
					arg_135_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_138_8 = 0
			local var_138_9 = 0.575

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(424031033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 23 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 23)

				if (23 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 23)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031033", "story_v_out_424031.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031033", "story_v_out_424031.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_424031", "424031033", "story_v_out_424031.awb")

						arg_135_1:RecordAudio("424031033", var_138_15)
						arg_135_1:RecordAudio("424031033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424031", "424031033", "story_v_out_424031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424031", "424031033", "story_v_out_424031.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play424031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424031034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play424031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10155"]) and arg_139_1.var_.actorSpriteComps10155 == nil then
				arg_139_1.var_.actorSpriteComps10155 = arg_139_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10155"]) then
				if arg_139_1.var_.actorSpriteComps10155 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10155"]) and arg_139_1.var_.actorSpriteComps10155 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10155 = nil
			end

			local var_142_2 = arg_139_1.actors_["10155"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10155 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10155", 7)

				for iter_142_4 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_4)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_5 = 0
			local var_142_6 = 1.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(424031034).content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 48 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_7) / 48)

				if (48 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_7) / 48)) > 0 and var_142_6 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_10 and arg_139_1.time_ < var_142_5 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424031035
		arg_143_1.duration_ = 3.53

		local var_143_0 = {
			zh = 3.233,
			ja = 3.533
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
				arg_143_0:Play424031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.4

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(424031035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 16 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 16)

				if (16 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 16)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031035", "story_v_out_424031.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031035", "story_v_out_424031.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_424031", "424031035", "story_v_out_424031.awb")

						arg_143_1:RecordAudio("424031035", var_146_6)
						arg_143_1:RecordAudio("424031035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_424031", "424031035", "story_v_out_424031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_424031", "424031035", "story_v_out_424031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424031036
		arg_147_1.duration_ = 6.4

		local var_147_0 = {
			zh = 5.2,
			ja = 6.4
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
				arg_147_0:Play424031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10154"]) and arg_147_1.var_.actorSpriteComps10154 == nil then
				arg_147_1.var_.actorSpriteComps10154 = arg_147_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10154"]) then
				if arg_147_1.var_.actorSpriteComps10154 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 1, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10154"]) and arg_147_1.var_.actorSpriteComps10154 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10154 = nil
			end

			local var_150_2 = arg_147_1.actors_["10154"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10154 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10154", 2)

				for iter_150_4 = 0, var_150_2.childCount - 1 do
					local var_150_3 = var_150_2:GetChild(iter_150_4)

					if var_150_3.name == "split_1" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_147_1.time_ - 0) / var_150_4)
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_150_5 = 0
			local var_150_6 = 0.65

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(424031036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 26 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 26)

				if (26 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 26)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031036", "story_v_out_424031.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031036", "story_v_out_424031.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_424031", "424031036", "story_v_out_424031.awb")

						arg_147_1:RecordAudio("424031036", var_150_12)
						arg_147_1:RecordAudio("424031036", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_424031", "424031036", "story_v_out_424031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_424031", "424031036", "story_v_out_424031.awb")
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
				actorName = "10154",
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
	Play424031037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424031037
		arg_151_1.duration_ = 2.73

		local var_151_0 = {
			zh = 2.1,
			ja = 2.733
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
				arg_151_0:Play424031038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10155"]) and arg_151_1.var_.actorSpriteComps10155 == nil then
				arg_151_1.var_.actorSpriteComps10155 = arg_151_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10155"]) then
				if arg_151_1.var_.actorSpriteComps10155 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10155"]) and arg_151_1.var_.actorSpriteComps10155 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10155 = nil
			end

			local var_154_2 = arg_151_1.actors_["10154"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10154 == nil then
				arg_151_1.var_.actorSpriteComps10154 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps10154 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10154 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10154 = nil
			end

			local var_154_5 = arg_151_1.actors_["10155"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10155 = var_154_5.localPosition
				var_154_5.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10155", 4)

				for iter_154_8 = 0, var_154_5.childCount - 1 do
					local var_154_6 = var_154_5:GetChild(iter_154_8)

					if var_154_6.name == "split_2" then
						var_154_6:SetAsLastSibling()
						var_154_6.gameObject:SetActive(true)

						arg_151_1.var_.actorSpriteSplit10155 = var_154_6.gameObject:GetComponent(typeof(Image))

						arg_151_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_154_7 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				var_154_5.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_151_1.time_ - 0) / var_154_7)

				if arg_151_1.var_.actorSpriteSplit10155 ~= nil then
					arg_151_1.var_.actorSpriteSplit10155:SetAlpha((arg_151_1.time_ - 0) / var_154_7)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				var_154_5.localPosition = Vector3.New(440, -390, -250)

				if arg_151_1.var_.actorSpriteSplit10155 ~= nil then
					arg_151_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_154_8 = 0
			local var_154_9 = 0.275

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(424031037)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 11 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 11)

				if (11 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 11)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031037", "story_v_out_424031.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031037", "story_v_out_424031.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_424031", "424031037", "story_v_out_424031.awb")

						arg_151_1:RecordAudio("424031037", var_154_15)
						arg_151_1:RecordAudio("424031037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424031", "424031037", "story_v_out_424031.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424031", "424031037", "story_v_out_424031.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play424031038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424031038
		arg_155_1.duration_ = 4.03

		local var_155_0 = {
			zh = 3.066,
			ja = 4.033
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
				arg_155_0:Play424031039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10155"]) and arg_155_1.var_.actorSpriteComps10155 == nil then
				arg_155_1.var_.actorSpriteComps10155 = arg_155_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10155"]) then
				if arg_155_1.var_.actorSpriteComps10155 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10155"]) and arg_155_1.var_.actorSpriteComps10155 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10155 = nil
			end

			local var_158_2 = 0
			local var_158_3 = 0.375

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_4 = arg_155_1:GetWordFromCfg(424031038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 15 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 15)

				if (15 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 15)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031038", "story_v_out_424031.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031038", "story_v_out_424031.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_424031", "424031038", "story_v_out_424031.awb")

						arg_155_1:RecordAudio("424031038", var_158_9)
						arg_155_1:RecordAudio("424031038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424031", "424031038", "story_v_out_424031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424031", "424031038", "story_v_out_424031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play424031039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424031039
		arg_159_1.duration_ = 2.63

		local var_159_0 = {
			zh = 2.6,
			ja = 2.633
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
				arg_159_0:Play424031040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.225

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1390].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(424031039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 9 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 9)

				if (9 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 9)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031039", "story_v_out_424031.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031039", "story_v_out_424031.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_424031", "424031039", "story_v_out_424031.awb")

						arg_159_1:RecordAudio("424031039", var_162_6)
						arg_159_1:RecordAudio("424031039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_424031", "424031039", "story_v_out_424031.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_424031", "424031039", "story_v_out_424031.awb")
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
	Play424031040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424031040
		arg_163_1.duration_ = 2.27

		local var_163_0 = {
			zh = 1.866,
			ja = 2.266
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
				arg_163_0:Play424031041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10154"]) and arg_163_1.var_.actorSpriteComps10154 == nil then
				arg_163_1.var_.actorSpriteComps10154 = arg_163_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10154"]) then
				if arg_163_1.var_.actorSpriteComps10154 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10154"]) and arg_163_1.var_.actorSpriteComps10154 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10154 = nil
			end

			local var_166_2 = arg_163_1.actors_["10154"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10154 = var_166_2.localPosition
				var_166_2.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10154", 2)

				for iter_166_4 = 0, var_166_2.childCount - 1 do
					local var_166_3 = var_166_2:GetChild(iter_166_4)

					if var_166_3.name == "split_5" then
						var_166_3:SetAsLastSibling()
						var_166_3.gameObject:SetActive(true)

						arg_163_1.var_.actorSpriteSplit10154 = var_166_3.gameObject:GetComponent(typeof(Image))

						arg_163_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_166_4 = 0.5

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_2.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_163_1.time_ - 0) / var_166_4)

				if arg_163_1.var_.actorSpriteSplit10154 ~= nil then
					arg_163_1.var_.actorSpriteSplit10154:SetAlpha((arg_163_1.time_ - 0) / var_166_4)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_2.localPosition = Vector3.New(-375, -338, -538)

				if arg_163_1.var_.actorSpriteSplit10154 ~= nil then
					arg_163_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_166_5 = 0
			local var_166_6 = 0.225

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(424031040)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 9 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 9)

				if (9 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 9)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031040", "story_v_out_424031.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031040", "story_v_out_424031.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_424031", "424031040", "story_v_out_424031.awb")

						arg_163_1:RecordAudio("424031040", var_166_12)
						arg_163_1:RecordAudio("424031040", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_424031", "424031040", "story_v_out_424031.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_424031", "424031040", "story_v_out_424031.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_13 and arg_163_1.time_ < var_166_5 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play424031041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424031041
		arg_167_1.duration_ = 3.9

		local var_167_0 = {
			zh = 2.2,
			ja = 3.9
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
				arg_167_0:Play424031042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10155"]) and arg_167_1.var_.actorSpriteComps10155 == nil then
				arg_167_1.var_.actorSpriteComps10155 = arg_167_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10155"]) then
				if arg_167_1.var_.actorSpriteComps10155 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10155"]) and arg_167_1.var_.actorSpriteComps10155 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10155 = nil
			end

			local var_170_2 = arg_167_1.actors_["10154"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10154 == nil then
				arg_167_1.var_.actorSpriteComps10154 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10154 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								iter_170_5.color = Color.New(Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_5.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_5.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10154 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10154 = nil
			end

			local var_170_5 = arg_167_1.actors_["10155"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10155 = var_170_5.localPosition
				var_170_5.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10155", 4)

				for iter_170_8 = 0, var_170_5.childCount - 1 do
					local var_170_6 = var_170_5:GetChild(iter_170_8)

					if var_170_6.name == "split_1" then
						var_170_6:SetAsLastSibling()
						var_170_6.gameObject:SetActive(true)

						arg_167_1.var_.actorSpriteSplit10155 = var_170_6.gameObject:GetComponent(typeof(Image))

						arg_167_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_170_7 = 0.5

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_167_1.time_ - 0) / var_170_7)

				if arg_167_1.var_.actorSpriteSplit10155 ~= nil then
					arg_167_1.var_.actorSpriteSplit10155:SetAlpha((arg_167_1.time_ - 0) / var_170_7)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(440, -390, -250)

				if arg_167_1.var_.actorSpriteSplit10155 ~= nil then
					arg_167_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_170_8 = 0
			local var_170_9 = 0.275

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(424031041)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 11 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 11)

				if (11 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 11)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031041", "story_v_out_424031.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031041", "story_v_out_424031.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_424031", "424031041", "story_v_out_424031.awb")

						arg_167_1:RecordAudio("424031041", var_170_15)
						arg_167_1:RecordAudio("424031041", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_424031", "424031041", "story_v_out_424031.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_424031", "424031041", "story_v_out_424031.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play424031042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424031042
		arg_171_1.duration_ = 13.37

		local var_171_0 = {
			zh = 12.466,
			ja = 13.366
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
				arg_171_0:Play424031043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10154"]) and arg_171_1.var_.actorSpriteComps10154 == nil then
				arg_171_1.var_.actorSpriteComps10154 = arg_171_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10154"]) then
				if arg_171_1.var_.actorSpriteComps10154 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10154"]) and arg_171_1.var_.actorSpriteComps10154 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10154 = nil
			end

			local var_174_2 = arg_171_1.actors_["10155"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10155 == nil then
				arg_171_1.var_.actorSpriteComps10155 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10155 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_5.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_5.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10155 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10155 = nil
			end

			local var_174_5 = arg_171_1.actors_["10154"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10154 = var_174_5.localPosition
				var_174_5.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10154", 2)

				for iter_174_8 = 0, var_174_5.childCount - 1 do
					local var_174_6 = var_174_5:GetChild(iter_174_8)

					if var_174_6.name == "split_2" then
						var_174_6:SetAsLastSibling()
						var_174_6.gameObject:SetActive(true)

						arg_171_1.var_.actorSpriteSplit10154 = var_174_6.gameObject:GetComponent(typeof(Image))

						arg_171_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_174_7 = 0.5

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				var_174_5.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_171_1.time_ - 0) / var_174_7)

				if arg_171_1.var_.actorSpriteSplit10154 ~= nil then
					arg_171_1.var_.actorSpriteSplit10154:SetAlpha((arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				var_174_5.localPosition = Vector3.New(-375, -338, -538)

				if arg_171_1.var_.actorSpriteSplit10154 ~= nil then
					arg_171_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_174_8 = 0
			local var_174_9 = 1.45

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(424031042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 58 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 58)

				if (58 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 58)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031042", "story_v_out_424031.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031042", "story_v_out_424031.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_424031", "424031042", "story_v_out_424031.awb")

						arg_171_1:RecordAudio("424031042", var_174_15)
						arg_171_1:RecordAudio("424031042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_424031", "424031042", "story_v_out_424031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_424031", "424031042", "story_v_out_424031.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play424031043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424031043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play424031044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10154"]) and arg_175_1.var_.actorSpriteComps10154 == nil then
				arg_175_1.var_.actorSpriteComps10154 = arg_175_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10154"]) then
				if arg_175_1.var_.actorSpriteComps10154 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10154"]) and arg_175_1.var_.actorSpriteComps10154 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10154 = nil
			end

			local var_178_2 = arg_175_1.actors_["10154"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10154 = var_178_2.localPosition
				var_178_2.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10154", 7)

				for iter_178_4 = 0, var_178_2.childCount - 1 do
					local var_178_3 = var_178_2:GetChild(iter_178_4)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_2.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_175_1.time_ - 0) / var_178_4)
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_178_5 = arg_175_1.actors_["10155"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10155 = var_178_5.localPosition
				var_178_5.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10155", 7)

				for iter_178_5 = 0, var_178_5.childCount - 1 do
					local var_178_6 = var_178_5:GetChild(iter_178_5)

					if var_178_6.name == "" or not string.find(var_178_6.name, "split") then
						var_178_6.gameObject:SetActive(true)
					else
						var_178_6.gameObject:SetActive(false)
					end
				end
			end

			local var_178_7 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_175_1.time_ - 0) / var_178_7)
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_178_8 = 0
			local var_178_9 = 0.575

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(424031043).content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_12 = 23 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_10) / 23)

				if (23 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_10) / 23)) > 0 and var_178_9 < var_178_12 then
					arg_175_1.talkMaxDuration = var_178_12

					if var_178_12 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_13 and arg_175_1.time_ < var_178_8 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
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
	Play424031044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424031044
		arg_179_1.duration_ = 4.13

		local var_179_0 = {
			zh = 3.566,
			ja = 4.133
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
				arg_179_0:Play424031045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10154"]) and arg_179_1.var_.actorSpriteComps10154 == nil then
				arg_179_1.var_.actorSpriteComps10154 = arg_179_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10154"]) then
				if arg_179_1.var_.actorSpriteComps10154 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10154"]) and arg_179_1.var_.actorSpriteComps10154 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10154 = nil
			end

			local var_182_2 = arg_179_1.actors_["10154"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10154 = var_182_2.localPosition
				var_182_2.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10154", 2)

				for iter_182_4 = 0, var_182_2.childCount - 1 do
					local var_182_3 = var_182_2:GetChild(iter_182_4)

					if var_182_3.name == "split_2" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_2.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_179_1.time_ - 0) / var_182_4)
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_182_5 = 0
			local var_182_6 = 0.4

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(424031044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 16 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 16)

				if (16 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 16)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031044", "story_v_out_424031.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031044", "story_v_out_424031.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_424031", "424031044", "story_v_out_424031.awb")

						arg_179_1:RecordAudio("424031044", var_182_12)
						arg_179_1:RecordAudio("424031044", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_424031", "424031044", "story_v_out_424031.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_424031", "424031044", "story_v_out_424031.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_13 and arg_179_1.time_ < var_182_5 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424031045
		arg_183_1.duration_ = 3.67

		local var_183_0 = {
			zh = 2.966,
			ja = 3.666
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
				arg_183_0:Play424031046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10155"]) and arg_183_1.var_.actorSpriteComps10155 == nil then
				arg_183_1.var_.actorSpriteComps10155 = arg_183_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10155"]) then
				if arg_183_1.var_.actorSpriteComps10155 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10155"]) and arg_183_1.var_.actorSpriteComps10155 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10155 = nil
			end

			local var_186_2 = arg_183_1.actors_["10154"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps10154 == nil then
				arg_183_1.var_.actorSpriteComps10154 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps10154 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								iter_186_5.color = Color.New(Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_5.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_5.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps10154 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_186_7 then
						iter_186_7.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10154 = nil
			end

			local var_186_5 = arg_183_1.actors_["10155"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10155 = var_186_5.localPosition
				var_186_5.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10155", 4)

				for iter_186_8 = 0, var_186_5.childCount - 1 do
					local var_186_6 = var_186_5:GetChild(iter_186_8)

					if var_186_6.name == "split_5" then
						var_186_6:SetAsLastSibling()
						var_186_6.gameObject:SetActive(true)

						arg_183_1.var_.actorSpriteSplit10155 = var_186_6.gameObject:GetComponent(typeof(Image))

						arg_183_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_186_7 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_183_1.time_ - 0) / var_186_7)

				if arg_183_1.var_.actorSpriteSplit10155 ~= nil then
					arg_183_1.var_.actorSpriteSplit10155:SetAlpha((arg_183_1.time_ - 0) / var_186_7)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(440, -390, -250)

				if arg_183_1.var_.actorSpriteSplit10155 ~= nil then
					arg_183_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_186_8 = 0
			local var_186_9 = 0.25

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(424031045)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 10 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 10)

				if (10 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 10)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031045", "story_v_out_424031.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031045", "story_v_out_424031.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_424031", "424031045", "story_v_out_424031.awb")

						arg_183_1:RecordAudio("424031045", var_186_15)
						arg_183_1:RecordAudio("424031045", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_424031", "424031045", "story_v_out_424031.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_424031", "424031045", "story_v_out_424031.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_16 and arg_183_1.time_ < var_186_8 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play424031046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424031046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play424031047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10155"]) and arg_187_1.var_.actorSpriteComps10155 == nil then
				arg_187_1.var_.actorSpriteComps10155 = arg_187_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10155"]) then
				if arg_187_1.var_.actorSpriteComps10155 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								iter_190_1.color = Color.New(Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_0), Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_0), (Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_0)))
							else
								local var_190_1 = Mathf.Lerp(iter_190_1.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_0)

								iter_190_1.color = Color.New(var_190_1, var_190_1, var_190_1)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10155"]) and arg_187_1.var_.actorSpriteComps10155 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_190_3 then
						iter_190_3.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10155 = nil
			end

			local var_190_2 = arg_187_1.actors_["10154"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10154 = var_190_2.localPosition
				var_190_2.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10154", 7)

				for iter_190_4 = 0, var_190_2.childCount - 1 do
					local var_190_3 = var_190_2:GetChild(iter_190_4)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_4)
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_5 = arg_187_1.actors_["10155"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10155 = var_190_5.localPosition
				var_190_5.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10155", 7)

				for iter_190_5 = 0, var_190_5.childCount - 1 do
					local var_190_6 = var_190_5:GetChild(iter_190_5)

					if var_190_6.name == "" or not string.find(var_190_6.name, "split") then
						var_190_6.gameObject:SetActive(true)
					else
						var_190_6.gameObject:SetActive(false)
					end
				end
			end

			local var_190_7 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_7)
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_8 = 0
			local var_190_9 = 0.625

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(424031046).content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_12 = 25 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_10) / 25)

				if (25 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_10) / 25)) > 0 and var_190_9 < var_190_12 then
					arg_187_1.talkMaxDuration = var_190_12

					if var_190_12 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_13 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_13 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_13

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_13 and arg_187_1.time_ < var_190_8 + var_190_13 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
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
	Play424031047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424031047
		arg_191_1.duration_ = 5.93

		local var_191_0 = {
			zh = 3.3,
			ja = 5.933
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
				arg_191_0:Play424031048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10154"]) and arg_191_1.var_.actorSpriteComps10154 == nil then
				arg_191_1.var_.actorSpriteComps10154 = arg_191_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10154"]) then
				if arg_191_1.var_.actorSpriteComps10154 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 1, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10154"]) and arg_191_1.var_.actorSpriteComps10154 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10154 = nil
			end

			local var_194_2 = arg_191_1.actors_["10154"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10154 = var_194_2.localPosition
				var_194_2.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10154", 3)

				for iter_194_4 = 0, var_194_2.childCount - 1 do
					local var_194_3 = var_194_2:GetChild(iter_194_4)

					if var_194_3.name == "split_2" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_2.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_191_1.time_ - 0) / var_194_4)
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_194_5 = 0
			local var_194_6 = 0.425

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(424031047)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 17 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 17)

				if (17 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 17)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031047", "story_v_out_424031.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031047", "story_v_out_424031.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_424031", "424031047", "story_v_out_424031.awb")

						arg_191_1:RecordAudio("424031047", var_194_12)
						arg_191_1:RecordAudio("424031047", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_424031", "424031047", "story_v_out_424031.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_424031", "424031047", "story_v_out_424031.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_13 and arg_191_1.time_ < var_194_5 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424031048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play424031049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10154"]) and arg_195_1.var_.actorSpriteComps10154 == nil then
				arg_195_1.var_.actorSpriteComps10154 = arg_195_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10154"]) then
				if arg_195_1.var_.actorSpriteComps10154 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10154"]) and arg_195_1.var_.actorSpriteComps10154 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10154 = nil
			end

			local var_198_2 = arg_195_1.actors_["10154"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10154 = var_198_2.localPosition
				var_198_2.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10154", 7)

				for iter_198_4 = 0, var_198_2.childCount - 1 do
					local var_198_3 = var_198_2:GetChild(iter_198_4)

					if var_198_3.name == "" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.175 < arg_195_1.time_ and arg_195_1.time_ <= 0.175 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_146", "se_story_146_bag", "")
			end

			local var_198_6 = 0
			local var_198_7 = 1.175

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(424031048).content)

				arg_195_1.text_.text = var_198_8

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_10 = 47 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_8) / 47)

				if (47 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_8) / 47)) > 0 and var_198_7 < var_198_10 then
					arg_195_1.talkMaxDuration = var_198_10

					if var_198_10 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_8
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_11 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_11 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_11

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_11 and arg_195_1.time_ < var_198_6 + var_198_11 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424031049
		arg_199_1.duration_ = 4.23

		local var_199_0 = {
			zh = 2.266,
			ja = 4.233
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
				arg_199_0:Play424031050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10155"]) and arg_199_1.var_.actorSpriteComps10155 == nil then
				arg_199_1.var_.actorSpriteComps10155 = arg_199_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10155"]) then
				if arg_199_1.var_.actorSpriteComps10155 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 1, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10155"]) and arg_199_1.var_.actorSpriteComps10155 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10155 = nil
			end

			local var_202_2 = arg_199_1.actors_["10155"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10155 = var_202_2.localPosition
				var_202_2.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10155", 3)

				for iter_202_4 = 0, var_202_2.childCount - 1 do
					local var_202_3 = var_202_2:GetChild(iter_202_4)

					if var_202_3.name == "split_2" then
						var_202_3:SetAsLastSibling()
						var_202_3.gameObject:SetActive(true)

						arg_199_1.var_.actorSpriteSplit10155 = var_202_3.gameObject:GetComponent(typeof(Image))

						arg_199_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_199_1.time_ - 0) / var_202_4)

				if arg_199_1.var_.actorSpriteSplit10155 ~= nil then
					arg_199_1.var_.actorSpriteSplit10155:SetAlpha((arg_199_1.time_ - 0) / var_202_4)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(-40, -390, -250)

				if arg_199_1.var_.actorSpriteSplit10155 ~= nil then
					arg_199_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_202_5 = 0
			local var_202_6 = 0.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(424031049)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 6 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 6)

				if (6 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 6)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031049", "story_v_out_424031.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031049", "story_v_out_424031.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_424031", "424031049", "story_v_out_424031.awb")

						arg_199_1:RecordAudio("424031049", var_202_12)
						arg_199_1:RecordAudio("424031049", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_424031", "424031049", "story_v_out_424031.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_424031", "424031049", "story_v_out_424031.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play424031050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 424031050
		arg_203_1.duration_ = 10.7

		local var_203_0 = {
			zh = 8.5,
			ja = 10.7
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
				arg_203_0:Play424031051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10155"]) and arg_203_1.var_.actorSpriteComps10155 == nil then
				arg_203_1.var_.actorSpriteComps10155 = arg_203_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10155"]) then
				if arg_203_1.var_.actorSpriteComps10155 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10155"]) and arg_203_1.var_.actorSpriteComps10155 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps10155 = nil
			end

			local var_206_2 = 0
			local var_206_3 = 0.95

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_4 = arg_203_1:GetWordFromCfg(424031050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 40 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 40)

				if (40 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 40)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031050", "story_v_out_424031.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031050", "story_v_out_424031.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_424031", "424031050", "story_v_out_424031.awb")

						arg_203_1:RecordAudio("424031050", var_206_9)
						arg_203_1:RecordAudio("424031050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_424031", "424031050", "story_v_out_424031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_424031", "424031050", "story_v_out_424031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play424031051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424031051
		arg_207_1.duration_ = 2.83

		local var_207_0 = {
			zh = 2.133,
			ja = 2.833
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
				arg_207_0:Play424031052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.175

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(424031051)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 7 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 7)

				if (7 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 7)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031051", "story_v_out_424031.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031051", "story_v_out_424031.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_424031", "424031051", "story_v_out_424031.awb")

						arg_207_1:RecordAudio("424031051", var_210_6)
						arg_207_1:RecordAudio("424031051", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_424031", "424031051", "story_v_out_424031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_424031", "424031051", "story_v_out_424031.awb")
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
	Play424031052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424031052
		arg_211_1.duration_ = 5

		local var_211_0 = {
			zh = 3,
			ja = 5
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
				arg_211_0:Play424031053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10155"]) and arg_211_1.var_.actorSpriteComps10155 == nil then
				arg_211_1.var_.actorSpriteComps10155 = arg_211_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10155"]) then
				if arg_211_1.var_.actorSpriteComps10155 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 1, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10155"]) and arg_211_1.var_.actorSpriteComps10155 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps10155 = nil
			end

			local var_214_2 = arg_211_1.actors_["10155"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10155 = var_214_2.localPosition
				var_214_2.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10155", 3)

				for iter_214_4 = 0, var_214_2.childCount - 1 do
					local var_214_3 = var_214_2:GetChild(iter_214_4)

					if var_214_3.name == "split_1" then
						var_214_3:SetAsLastSibling()
						var_214_3.gameObject:SetActive(true)

						arg_211_1.var_.actorSpriteSplit10155 = var_214_3.gameObject:GetComponent(typeof(Image))

						arg_211_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_214_4 = 0.5

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_2.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_211_1.time_ - 0) / var_214_4)

				if arg_211_1.var_.actorSpriteSplit10155 ~= nil then
					arg_211_1.var_.actorSpriteSplit10155:SetAlpha((arg_211_1.time_ - 0) / var_214_4)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_2.localPosition = Vector3.New(-40, -390, -250)

				if arg_211_1.var_.actorSpriteSplit10155 ~= nil then
					arg_211_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_214_5 = 0
			local var_214_6 = 0.2

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:GetWordFromCfg(424031052)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 8 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 8)

				if (8 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 8)) > 0 and var_214_6 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031052", "story_v_out_424031.awb") ~= 0 then
					local var_214_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031052", "story_v_out_424031.awb") / 1000

					if var_214_11 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_5
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_424031", "424031052", "story_v_out_424031.awb")

						arg_211_1:RecordAudio("424031052", var_214_12)
						arg_211_1:RecordAudio("424031052", var_214_12)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_424031", "424031052", "story_v_out_424031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_424031", "424031052", "story_v_out_424031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_13 and arg_211_1.time_ < var_214_5 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play424031053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424031053
		arg_215_1.duration_ = 7.43

		local var_215_0 = {
			zh = 5.8,
			ja = 7.433
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
				arg_215_0:Play424031054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10154"]) and arg_215_1.var_.actorSpriteComps10154 == nil then
				arg_215_1.var_.actorSpriteComps10154 = arg_215_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10154"]) then
				if arg_215_1.var_.actorSpriteComps10154 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 1, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10154"]) and arg_215_1.var_.actorSpriteComps10154 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps10154 = nil
			end

			local var_218_2 = arg_215_1.actors_["10155"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps10155 == nil then
				arg_215_1.var_.actorSpriteComps10155 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps10155 then
					for iter_218_4, iter_218_5 in pairs(arg_215_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_218_5 then
							if arg_215_1.isInRecall_ then
								iter_218_5.color = Color.New(Mathf.Lerp(iter_218_5.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_3), Mathf.Lerp(iter_218_5.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_3), (Mathf.Lerp(iter_218_5.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_3)))
							else
								local var_218_4 = Mathf.Lerp(iter_218_5.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_3)

								iter_218_5.color = Color.New(var_218_4, var_218_4, var_218_4)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps10155 then
				for iter_218_6, iter_218_7 in pairs(arg_215_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_218_7 then
						iter_218_7.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps10155 = nil
			end

			local var_218_5 = arg_215_1.actors_["10155"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10155 = var_218_5.localPosition
				var_218_5.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10155", 4)

				for iter_218_8 = 0, var_218_5.childCount - 1 do
					local var_218_6 = var_218_5:GetChild(iter_218_8)

					if var_218_6.name == "" or not string.find(var_218_6.name, "split") then
						var_218_6.gameObject:SetActive(true)
					else
						var_218_6.gameObject:SetActive(false)
					end
				end
			end

			local var_218_7 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				var_218_5.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_215_1.time_ - 0) / var_218_7)
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				var_218_5.localPosition = Vector3.New(440, -390, -250)
			end

			local var_218_8 = arg_215_1.actors_["10154"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10154 = var_218_8.localPosition
				var_218_8.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10154", 2)

				for iter_218_9 = 0, var_218_8.childCount - 1 do
					local var_218_9 = var_218_8:GetChild(iter_218_9)

					if var_218_9.name == "split_2" or not string.find(var_218_9.name, "split") then
						var_218_9.gameObject:SetActive(true)
					else
						var_218_9.gameObject:SetActive(false)
					end
				end
			end

			local var_218_10 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_10 then
				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_215_1.time_ - 0) / var_218_10)
			end

			if arg_215_1.time_ >= 0 + var_218_10 and arg_215_1.time_ < 0 + var_218_10 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_218_11 = 0
			local var_218_12 = 0.725

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_13 = arg_215_1:GetWordFromCfg(424031053)
				local var_218_14 = arg_215_1:FormatText(var_218_13.content)

				arg_215_1.text_.text = var_218_14

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_16 = 29 <= 0 and var_218_12 or var_218_12 * (utf8.len(var_218_14) / 29)

				if (29 <= 0 and var_218_12 or var_218_12 * (utf8.len(var_218_14) / 29)) > 0 and var_218_12 < var_218_16 then
					arg_215_1.talkMaxDuration = var_218_16

					if var_218_16 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_16 + var_218_11
					end
				end

				arg_215_1.text_.text = var_218_14
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031053", "story_v_out_424031.awb") ~= 0 then
					local var_218_17 = manager.audio:GetVoiceLength("story_v_out_424031", "424031053", "story_v_out_424031.awb") / 1000

					if var_218_17 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_17 + var_218_11
					end

					if var_218_13.prefab_name ~= "" and arg_215_1.actors_[var_218_13.prefab_name] ~= nil then
						local var_218_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_13.prefab_name].transform, "story_v_out_424031", "424031053", "story_v_out_424031.awb")

						arg_215_1:RecordAudio("424031053", var_218_18)
						arg_215_1:RecordAudio("424031053", var_218_18)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_424031", "424031053", "story_v_out_424031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_424031", "424031053", "story_v_out_424031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_19 = math.max(var_218_12, arg_215_1.talkMaxDuration)

			if var_218_11 <= arg_215_1.time_ and arg_215_1.time_ < var_218_11 + var_218_19 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_11) / var_218_19

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_11 + var_218_19 and arg_215_1.time_ < var_218_11 + var_218_19 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424031054
		arg_219_1.duration_ = 3.97

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play424031055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10154"]) and arg_219_1.var_.actorSpriteComps10154 == nil then
				arg_219_1.var_.actorSpriteComps10154 = arg_219_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["10154"]) then
				if arg_219_1.var_.actorSpriteComps10154 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								iter_222_1.color = Color.New(Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor2.r, (arg_219_1.time_ - 0) / var_222_0), Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor2.g, (arg_219_1.time_ - 0) / var_222_0), (Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor2.b, (arg_219_1.time_ - 0) / var_222_0)))
							else
								local var_222_1 = Mathf.Lerp(iter_222_1.color.r, 0.5, (arg_219_1.time_ - 0) / var_222_0)

								iter_222_1.color = Color.New(var_222_1, var_222_1, var_222_1)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["10154"]) and arg_219_1.var_.actorSpriteComps10154 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps10154 = nil
			end

			local var_222_2 = 0
			local var_222_3 = 0.475

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_4 = arg_219_1:GetWordFromCfg(424031054)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 19 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 19)

				if (19 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 19)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031054", "story_v_out_424031.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031054", "story_v_out_424031.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_424031", "424031054", "story_v_out_424031.awb")

						arg_219_1:RecordAudio("424031054", var_222_9)
						arg_219_1:RecordAudio("424031054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_424031", "424031054", "story_v_out_424031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_424031", "424031054", "story_v_out_424031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play424031055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424031055
		arg_223_1.duration_ = 1.83

		local var_223_0 = {
			zh = 1.6,
			ja = 1.833
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
				arg_223_0:Play424031056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10154"]) and arg_223_1.var_.actorSpriteComps10154 == nil then
				arg_223_1.var_.actorSpriteComps10154 = arg_223_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10154"]) then
				if arg_223_1.var_.actorSpriteComps10154 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 1, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10154"]) and arg_223_1.var_.actorSpriteComps10154 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10154 = nil
			end

			local var_226_2 = arg_223_1.actors_["10154"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10154 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10154", 2)

				for iter_226_4 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_4)

					if var_226_3.name == "split_1" then
						var_226_3:SetAsLastSibling()
						var_226_3.gameObject:SetActive(true)

						arg_223_1.var_.actorSpriteSplit10154 = var_226_3.gameObject:GetComponent(typeof(Image))

						arg_223_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_226_4 = 0.5

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_223_1.time_ - 0) / var_226_4)

				if arg_223_1.var_.actorSpriteSplit10154 ~= nil then
					arg_223_1.var_.actorSpriteSplit10154:SetAlpha((arg_223_1.time_ - 0) / var_226_4)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(-375, -338, -538)

				if arg_223_1.var_.actorSpriteSplit10154 ~= nil then
					arg_223_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_226_5 = 0
			local var_226_6 = 0.25

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(424031055)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 10 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 10)

				if (10 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 10)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031055", "story_v_out_424031.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031055", "story_v_out_424031.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_424031", "424031055", "story_v_out_424031.awb")

						arg_223_1:RecordAudio("424031055", var_226_12)
						arg_223_1:RecordAudio("424031055", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_424031", "424031055", "story_v_out_424031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_424031", "424031055", "story_v_out_424031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_13 and arg_223_1.time_ < var_226_5 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play424031056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 424031056
		arg_227_1.duration_ = 6.79

		local var_227_0 = {
			zh = 6.691,
			ja = 6.791
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
				arg_227_0:Play424031057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.bgs_.I11i == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_230_0.name = "I11i"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.I11i = var_230_0
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.I11i

				arg_227_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "I11i" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 4

			if 4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			if arg_227_1.time_ >= var_230_4 + 0.3 and arg_227_1.time_ < var_230_4 + 0.3 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end

			local var_230_5 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_6 = 2

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 then
				local var_230_7 = Color.New(0, 0, 0)

				var_230_7.a = Mathf.Lerp(0, 1, (arg_227_1.time_ - var_230_5) / var_230_6)
				arg_227_1.mask_.color = var_230_7
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 then
				local var_230_8 = Color.New(0, 0, 0)

				var_230_8.a = 1
				arg_227_1.mask_.color = var_230_8
			end

			local var_230_9 = 2

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_10 = 2

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_10 then
				local var_230_11 = Color.New(0, 0, 0)

				var_230_11.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_9) / var_230_10)
				arg_227_1.mask_.color = var_230_11
			end

			if arg_227_1.time_ >= var_230_9 + var_230_10 and arg_227_1.time_ < var_230_9 + var_230_10 + arg_230_0 then
				local var_230_12 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_12.a = 0
				arg_227_1.mask_.color = var_230_12
			end

			local var_230_13 = arg_227_1.actors_["10154"]

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 and not isNil(var_230_13) and arg_227_1.var_.actorSpriteComps10154 == nil then
				arg_227_1.var_.actorSpriteComps10154 = var_230_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_14 = 0.2

			if 2 <= arg_227_1.time_ and arg_227_1.time_ < 2 + var_230_14 and not isNil(var_230_13) then
				if arg_227_1.var_.actorSpriteComps10154 then
					for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_230_3 then
							if arg_227_1.isInRecall_ then
								iter_230_3.color = Color.New(Mathf.Lerp(iter_230_3.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 2) / var_230_14), Mathf.Lerp(iter_230_3.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 2) / var_230_14), (Mathf.Lerp(iter_230_3.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 2) / var_230_14)))
							else
								local var_230_15 = Mathf.Lerp(iter_230_3.color.r, 0.5, (arg_227_1.time_ - 2) / var_230_14)

								iter_230_3.color = Color.New(var_230_15, var_230_15, var_230_15)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 2 + var_230_14 and arg_227_1.time_ < 2 + var_230_14 + arg_230_0 and not isNil(var_230_13) and arg_227_1.var_.actorSpriteComps10154 then
				for iter_230_4, iter_230_5 in pairs(arg_227_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_230_5 then
						iter_230_5.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps10154 = nil
			end

			local var_230_16 = arg_227_1.actors_["10154"].transform

			if 1.966 < arg_227_1.time_ and arg_227_1.time_ <= 1.966 + arg_230_0 then
				arg_227_1.var_.moveOldPos10154 = var_230_16.localPosition
				var_230_16.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10154", 7)

				for iter_230_6 = 0, var_230_16.childCount - 1 do
					local var_230_17 = var_230_16:GetChild(iter_230_6)

					if var_230_17.name == "" or not string.find(var_230_17.name, "split") then
						var_230_17.gameObject:SetActive(true)
					else
						var_230_17.gameObject:SetActive(false)
					end
				end
			end

			local var_230_18 = 0.001

			if 1.966 <= arg_227_1.time_ and arg_227_1.time_ < 1.966 + var_230_18 then
				var_230_16.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_227_1.time_ - 1.966) / var_230_18)
			end

			if arg_227_1.time_ >= 1.966 + var_230_18 and arg_227_1.time_ < 1.966 + var_230_18 + arg_230_0 then
				var_230_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_230_19 = arg_227_1.actors_["10155"].transform

			if 1.966 < arg_227_1.time_ and arg_227_1.time_ <= 1.966 + arg_230_0 then
				arg_227_1.var_.moveOldPos10155 = var_230_19.localPosition
				var_230_19.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10155", 7)

				for iter_230_7 = 0, var_230_19.childCount - 1 do
					local var_230_20 = var_230_19:GetChild(iter_230_7)

					if var_230_20.name == "" or not string.find(var_230_20.name, "split") then
						var_230_20.gameObject:SetActive(true)
					else
						var_230_20.gameObject:SetActive(false)
					end
				end
			end

			local var_230_21 = 0.001

			if 1.966 <= arg_227_1.time_ and arg_227_1.time_ < 1.966 + var_230_21 then
				var_230_19.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_227_1.time_ - 1.966) / var_230_21)
			end

			if arg_227_1.time_ >= 1.966 + var_230_21 and arg_227_1.time_ < 1.966 + var_230_21 + arg_230_0 then
				var_230_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.266666666666667 < arg_227_1.time_ and arg_227_1.time_ <= 0.266666666666667 + arg_230_0 then
				arg_227_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 1.66666666666667 < arg_227_1.time_ and arg_227_1.time_ <= 1.66666666666667 + arg_230_0 then
				arg_227_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_24 = 4.025
			local var_230_25 = 0.275

			if 4.025 < arg_227_1.time_ and arg_227_1.time_ <= var_230_24 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_26 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_26:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_27 = arg_227_1:GetWordFromCfg(424031056)
				local var_230_28 = arg_227_1:FormatText(var_230_27.content)

				arg_227_1.text_.text = var_230_28

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_30 = 11 <= 0 and var_230_25 or var_230_25 * (utf8.len(var_230_28) / 11)

				if (11 <= 0 and var_230_25 or var_230_25 * (utf8.len(var_230_28) / 11)) > 0 and var_230_25 < var_230_30 then
					arg_227_1.talkMaxDuration = var_230_30
					var_230_24 = var_230_24 + 0.3

					if var_230_30 + var_230_24 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_24
					end
				end

				arg_227_1.text_.text = var_230_28
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031056", "story_v_out_424031.awb") ~= 0 then
					local var_230_31 = manager.audio:GetVoiceLength("story_v_out_424031", "424031056", "story_v_out_424031.awb") / 1000

					if var_230_31 + var_230_24 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_31 + var_230_24
					end

					if var_230_27.prefab_name ~= "" and arg_227_1.actors_[var_230_27.prefab_name] ~= nil then
						local var_230_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_27.prefab_name].transform, "story_v_out_424031", "424031056", "story_v_out_424031.awb")

						arg_227_1:RecordAudio("424031056", var_230_32)
						arg_227_1:RecordAudio("424031056", var_230_32)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_424031", "424031056", "story_v_out_424031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_424031", "424031056", "story_v_out_424031.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = var_230_24 + 0.3
			local var_230_34 = math.max(var_230_25, arg_227_1.talkMaxDuration)

			if var_230_24 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_33 + var_230_34 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_33) / var_230_34

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_33 + var_230_34 and arg_227_1.time_ < var_230_33 + var_230_34 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play424031057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 424031057
		arg_233_1.duration_ = 1.4

		local var_233_0 = {
			zh = 1.4,
			ja = 1.266
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
				arg_233_0:Play424031058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1094"]) and arg_233_1.var_.actorSpriteComps1094 == nil then
				arg_233_1.var_.actorSpriteComps1094 = arg_233_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1094"]) then
				if arg_233_1.var_.actorSpriteComps1094 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 1, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1094"]) and arg_233_1.var_.actorSpriteComps1094 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps1094 = nil
			end

			local var_236_2 = arg_233_1.actors_["1094"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1094 = var_236_2.localPosition
				var_236_2.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1094", 3)

				for iter_236_4 = 0, var_236_2.childCount - 1 do
					local var_236_3 = var_236_2:GetChild(iter_236_4)

					if var_236_3.name == "split_2" then
						var_236_3:SetAsLastSibling()
						var_236_3.gameObject:SetActive(true)

						arg_233_1.var_.actorSpriteSplit1094 = var_236_3.gameObject:GetComponent(typeof(Image))

						arg_233_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_2.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_233_1.time_ - 0) / var_236_4)

				if arg_233_1.var_.actorSpriteSplit1094 ~= nil then
					arg_233_1.var_.actorSpriteSplit1094:SetAlpha((arg_233_1.time_ - 0) / var_236_4)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_2.localPosition = Vector3.New(0, -335, -230)

				if arg_233_1.var_.actorSpriteSplit1094 ~= nil then
					arg_233_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_236_5 = 0
			local var_236_6 = 0.1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_7 = arg_233_1:GetWordFromCfg(424031057)
				local var_236_8 = arg_233_1:FormatText(var_236_7.content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 4 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 4)

				if (4 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 4)) > 0 and var_236_6 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031057", "story_v_out_424031.awb") ~= 0 then
					local var_236_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031057", "story_v_out_424031.awb") / 1000

					if var_236_11 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_5
					end

					if var_236_7.prefab_name ~= "" and arg_233_1.actors_[var_236_7.prefab_name] ~= nil then
						local var_236_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_7.prefab_name].transform, "story_v_out_424031", "424031057", "story_v_out_424031.awb")

						arg_233_1:RecordAudio("424031057", var_236_12)
						arg_233_1:RecordAudio("424031057", var_236_12)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_424031", "424031057", "story_v_out_424031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_424031", "424031057", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play424031058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 424031058
		arg_237_1.duration_ = 3.1

		local var_237_0 = {
			zh = 2.4,
			ja = 3.1
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
				arg_237_0:Play424031059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1094"]) and arg_237_1.var_.actorSpriteComps1094 == nil then
				arg_237_1.var_.actorSpriteComps1094 = arg_237_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1094"]) then
				if arg_237_1.var_.actorSpriteComps1094 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								iter_240_1.color = Color.New(Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_0), Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_0), (Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_0)))
							else
								local var_240_1 = Mathf.Lerp(iter_240_1.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_0)

								iter_240_1.color = Color.New(var_240_1, var_240_1, var_240_1)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1094"]) and arg_237_1.var_.actorSpriteComps1094 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps1094 = nil
			end

			local var_240_2 = 0
			local var_240_3 = 0.225

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_4 = arg_237_1:GetWordFromCfg(424031058)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 9 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 9)

				if (9 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 9)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031058", "story_v_out_424031.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031058", "story_v_out_424031.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_out_424031", "424031058", "story_v_out_424031.awb")

						arg_237_1:RecordAudio("424031058", var_240_9)
						arg_237_1:RecordAudio("424031058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_424031", "424031058", "story_v_out_424031.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_424031", "424031058", "story_v_out_424031.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_10 and arg_237_1.time_ < var_240_2 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play424031059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 424031059
		arg_241_1.duration_ = 6.17

		local var_241_0 = {
			zh = 5.4,
			ja = 6.166
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
				arg_241_0:Play424031060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.725

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:GetWordFromCfg(424031059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 29 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 29)

				if (29 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 29)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031059", "story_v_out_424031.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031059", "story_v_out_424031.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_424031", "424031059", "story_v_out_424031.awb")

						arg_241_1:RecordAudio("424031059", var_244_6)
						arg_241_1:RecordAudio("424031059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_424031", "424031059", "story_v_out_424031.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_424031", "424031059", "story_v_out_424031.awb")
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
	Play424031060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 424031060
		arg_245_1.duration_ = 3.7

		local var_245_0 = {
			zh = 3.7,
			ja = 3.466
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
				arg_245_0:Play424031061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.275

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(424031060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 11 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 11)

				if (11 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 11)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031060", "story_v_out_424031.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031060", "story_v_out_424031.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_424031", "424031060", "story_v_out_424031.awb")

						arg_245_1:RecordAudio("424031060", var_248_6)
						arg_245_1:RecordAudio("424031060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_424031", "424031060", "story_v_out_424031.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_424031", "424031060", "story_v_out_424031.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play424031061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 424031061
		arg_249_1.duration_ = 3.63

		local var_249_0 = {
			zh = 3.3,
			ja = 3.633
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
				arg_249_0:Play424031062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1094"]) and arg_249_1.var_.actorSpriteComps1094 == nil then
				arg_249_1.var_.actorSpriteComps1094 = arg_249_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1094"]) then
				if arg_249_1.var_.actorSpriteComps1094 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1094"]) and arg_249_1.var_.actorSpriteComps1094 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1094 = nil
			end

			local var_252_2 = arg_249_1.actors_["1094"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1094 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1094", 3)

				for iter_252_4 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_4)

					if var_252_3.name == "split_1" then
						var_252_3:SetAsLastSibling()
						var_252_3.gameObject:SetActive(true)

						arg_249_1.var_.actorSpriteSplit1094 = var_252_3.gameObject:GetComponent(typeof(Image))

						arg_249_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_252_4 = 0.5

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_249_1.time_ - 0) / var_252_4)

				if arg_249_1.var_.actorSpriteSplit1094 ~= nil then
					arg_249_1.var_.actorSpriteSplit1094:SetAlpha((arg_249_1.time_ - 0) / var_252_4)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -335, -230)

				if arg_249_1.var_.actorSpriteSplit1094 ~= nil then
					arg_249_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_252_5 = 0
			local var_252_6 = 0.275

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(424031061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 11 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 11)

				if (11 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 11)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031061", "story_v_out_424031.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031061", "story_v_out_424031.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_424031", "424031061", "story_v_out_424031.awb")

						arg_249_1:RecordAudio("424031061", var_252_12)
						arg_249_1:RecordAudio("424031061", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_424031", "424031061", "story_v_out_424031.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_424031", "424031061", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play424031062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 424031062
		arg_253_1.duration_ = 6.2

		local var_253_0 = {
			zh = 5.566,
			ja = 6.2
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
				arg_253_0:Play424031063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1094"]) and arg_253_1.var_.actorSpriteComps1094 == nil then
				arg_253_1.var_.actorSpriteComps1094 = arg_253_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1094"]) then
				if arg_253_1.var_.actorSpriteComps1094 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1094"]) and arg_253_1.var_.actorSpriteComps1094 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1094 = nil
			end

			local var_256_2 = 0
			local var_256_3 = 0.45

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_4 = arg_253_1:GetWordFromCfg(424031062)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 18 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 18)

				if (18 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 18)) > 0 and var_256_3 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031062", "story_v_out_424031.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031062", "story_v_out_424031.awb") / 1000

					if var_256_8 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_2
					end

					if var_256_4.prefab_name ~= "" and arg_253_1.actors_[var_256_4.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_4.prefab_name].transform, "story_v_out_424031", "424031062", "story_v_out_424031.awb")

						arg_253_1:RecordAudio("424031062", var_256_9)
						arg_253_1:RecordAudio("424031062", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_424031", "424031062", "story_v_out_424031.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_424031", "424031062", "story_v_out_424031.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_10 and arg_253_1.time_ < var_256_2 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play424031063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 424031063
		arg_257_1.duration_ = 4.77

		local var_257_0 = {
			zh = 4.2,
			ja = 4.766
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
				arg_257_0:Play424031064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.45

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(424031063)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 18 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 18)

				if (18 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 18)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031063", "story_v_out_424031.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031063", "story_v_out_424031.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_424031", "424031063", "story_v_out_424031.awb")

						arg_257_1:RecordAudio("424031063", var_260_6)
						arg_257_1:RecordAudio("424031063", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_424031", "424031063", "story_v_out_424031.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_424031", "424031063", "story_v_out_424031.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play424031064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 424031064
		arg_261_1.duration_ = 3.67

		local var_261_0 = {
			zh = 3.066,
			ja = 3.666
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
				arg_261_0:Play424031065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.375

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(424031064)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 15 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 15)

				if (15 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 15)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031064", "story_v_out_424031.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031064", "story_v_out_424031.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_424031", "424031064", "story_v_out_424031.awb")

						arg_261_1:RecordAudio("424031064", var_264_6)
						arg_261_1:RecordAudio("424031064", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_424031", "424031064", "story_v_out_424031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_424031", "424031064", "story_v_out_424031.awb")
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
	Play424031065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 424031065
		arg_265_1.duration_ = 3.07

		local var_265_0 = {
			zh = 2.166,
			ja = 3.066
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
				arg_265_0:Play424031066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1094"]) and arg_265_1.var_.actorSpriteComps1094 == nil then
				arg_265_1.var_.actorSpriteComps1094 = arg_265_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1094"]) then
				if arg_265_1.var_.actorSpriteComps1094 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 1, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1094"]) and arg_265_1.var_.actorSpriteComps1094 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1094 = nil
			end

			local var_268_2 = 0
			local var_268_3 = 0.25

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(424031065)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 10 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 10)

				if (10 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 10)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031065", "story_v_out_424031.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031065", "story_v_out_424031.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_424031", "424031065", "story_v_out_424031.awb")

						arg_265_1:RecordAudio("424031065", var_268_9)
						arg_265_1:RecordAudio("424031065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_424031", "424031065", "story_v_out_424031.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_424031", "424031065", "story_v_out_424031.awb")
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

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play424031066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 424031066
		arg_269_1.duration_ = 7.4

		local var_269_0 = {
			zh = 6.533,
			ja = 7.4
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
				arg_269_0:Play424031067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1094"]) and arg_269_1.var_.actorSpriteComps1094 == nil then
				arg_269_1.var_.actorSpriteComps1094 = arg_269_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1094"]) then
				if arg_269_1.var_.actorSpriteComps1094 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1094"]) and arg_269_1.var_.actorSpriteComps1094 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1094 = nil
			end

			local var_272_2 = 0
			local var_272_3 = 0.575

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_4 = arg_269_1:GetWordFromCfg(424031066)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 23 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 23)

				if (23 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 23)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031066", "story_v_out_424031.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031066", "story_v_out_424031.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_out_424031", "424031066", "story_v_out_424031.awb")

						arg_269_1:RecordAudio("424031066", var_272_9)
						arg_269_1:RecordAudio("424031066", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_424031", "424031066", "story_v_out_424031.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_424031", "424031066", "story_v_out_424031.awb")
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
	Play424031067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 424031067
		arg_273_1.duration_ = 4.6

		local var_273_0 = {
			zh = 3.666,
			ja = 4.6
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
				arg_273_0:Play424031068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.45

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:GetWordFromCfg(424031067)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 18 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 18)

				if (18 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 18)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031067", "story_v_out_424031.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031067", "story_v_out_424031.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_424031", "424031067", "story_v_out_424031.awb")

						arg_273_1:RecordAudio("424031067", var_276_6)
						arg_273_1:RecordAudio("424031067", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_424031", "424031067", "story_v_out_424031.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_424031", "424031067", "story_v_out_424031.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play424031068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 424031068
		arg_277_1.duration_ = 3.23

		local var_277_0 = {
			zh = 3.233,
			ja = 3.033
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
				arg_277_0:Play424031069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.2

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(424031068)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 8 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 8)

				if (8 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 8)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031068", "story_v_out_424031.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031068", "story_v_out_424031.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_424031", "424031068", "story_v_out_424031.awb")

						arg_277_1:RecordAudio("424031068", var_280_6)
						arg_277_1:RecordAudio("424031068", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_424031", "424031068", "story_v_out_424031.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_424031", "424031068", "story_v_out_424031.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play424031069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 424031069
		arg_281_1.duration_ = 7.07

		local var_281_0 = {
			zh = 5,
			ja = 7.066
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
				arg_281_0:Play424031070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.625

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(424031069)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 25 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 25)

				if (25 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 25)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031069", "story_v_out_424031.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031069", "story_v_out_424031.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_424031", "424031069", "story_v_out_424031.awb")

						arg_281_1:RecordAudio("424031069", var_284_6)
						arg_281_1:RecordAudio("424031069", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_424031", "424031069", "story_v_out_424031.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_424031", "424031069", "story_v_out_424031.awb")
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
	Play424031070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 424031070
		arg_285_1.duration_ = 5

		local var_285_0 = {
			zh = 5,
			ja = 4.266
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
				arg_285_0:Play424031071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1094"]) and arg_285_1.var_.actorSpriteComps1094 == nil then
				arg_285_1.var_.actorSpriteComps1094 = arg_285_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1094"]) then
				if arg_285_1.var_.actorSpriteComps1094 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1094"]) and arg_285_1.var_.actorSpriteComps1094 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1094 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 0.525

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(424031070)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 21 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 21)

				if (21 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 21)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031070", "story_v_out_424031.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031070", "story_v_out_424031.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_424031", "424031070", "story_v_out_424031.awb")

						arg_285_1:RecordAudio("424031070", var_288_9)
						arg_285_1:RecordAudio("424031070", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_424031", "424031070", "story_v_out_424031.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_424031", "424031070", "story_v_out_424031.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play424031071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 424031071
		arg_289_1.duration_ = 8.5

		local var_289_0 = {
			zh = 7.533,
			ja = 8.5
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
				arg_289_0:Play424031072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1094"]) and arg_289_1.var_.actorSpriteComps1094 == nil then
				arg_289_1.var_.actorSpriteComps1094 = arg_289_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1094"]) then
				if arg_289_1.var_.actorSpriteComps1094 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1094"]) and arg_289_1.var_.actorSpriteComps1094 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps1094 = nil
			end

			local var_292_2 = 0
			local var_292_3 = 0.65

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_4 = arg_289_1:GetWordFromCfg(424031071)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 26 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 26)

				if (26 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 26)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031071", "story_v_out_424031.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031071", "story_v_out_424031.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_424031", "424031071", "story_v_out_424031.awb")

						arg_289_1:RecordAudio("424031071", var_292_9)
						arg_289_1:RecordAudio("424031071", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_424031", "424031071", "story_v_out_424031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_424031", "424031071", "story_v_out_424031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play424031072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 424031072
		arg_293_1.duration_ = 1.27

		local var_293_0 = {
			zh = 1.266,
			ja = 1.233
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
				arg_293_0:Play424031073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1094"]) and arg_293_1.var_.actorSpriteComps1094 == nil then
				arg_293_1.var_.actorSpriteComps1094 = arg_293_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1094"]) then
				if arg_293_1.var_.actorSpriteComps1094 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1094"]) and arg_293_1.var_.actorSpriteComps1094 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1094 = nil
			end

			local var_296_2 = arg_293_1.actors_["1094"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1094 = var_296_2.localPosition
				var_296_2.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1094", 3)

				for iter_296_4 = 0, var_296_2.childCount - 1 do
					local var_296_3 = var_296_2:GetChild(iter_296_4)

					if var_296_3.name == "split_5" then
						var_296_3:SetAsLastSibling()
						var_296_3.gameObject:SetActive(true)

						arg_293_1.var_.actorSpriteSplit1094 = var_296_3.gameObject:GetComponent(typeof(Image))

						arg_293_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_296_4 = 0.5

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				var_296_2.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_293_1.time_ - 0) / var_296_4)

				if arg_293_1.var_.actorSpriteSplit1094 ~= nil then
					arg_293_1.var_.actorSpriteSplit1094:SetAlpha((arg_293_1.time_ - 0) / var_296_4)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				var_296_2.localPosition = Vector3.New(0, -335, -230)

				if arg_293_1.var_.actorSpriteSplit1094 ~= nil then
					arg_293_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_296_5 = 0
			local var_296_6 = 0.1

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(424031072)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 4 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 4)

				if (4 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 4)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031072", "story_v_out_424031.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031072", "story_v_out_424031.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_424031", "424031072", "story_v_out_424031.awb")

						arg_293_1:RecordAudio("424031072", var_296_12)
						arg_293_1:RecordAudio("424031072", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_424031", "424031072", "story_v_out_424031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_424031", "424031072", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play424031073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 424031073
		arg_297_1.duration_ = 7.97

		local var_297_0 = {
			zh = 6.933,
			ja = 7.966
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
				arg_297_0:Play424031074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1094"]) and arg_297_1.var_.actorSpriteComps1094 == nil then
				arg_297_1.var_.actorSpriteComps1094 = arg_297_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1094"]) then
				if arg_297_1.var_.actorSpriteComps1094 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1094"]) and arg_297_1.var_.actorSpriteComps1094 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps1094 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.6

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_4 = arg_297_1:GetWordFromCfg(424031073)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 24 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 24)

				if (24 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 24)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031073", "story_v_out_424031.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031073", "story_v_out_424031.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_424031", "424031073", "story_v_out_424031.awb")

						arg_297_1:RecordAudio("424031073", var_300_9)
						arg_297_1:RecordAudio("424031073", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_424031", "424031073", "story_v_out_424031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_424031", "424031073", "story_v_out_424031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play424031074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 424031074
		arg_301_1.duration_ = 6.53

		local var_301_0 = {
			zh = 5.2,
			ja = 6.533
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
				arg_301_0:Play424031075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.6

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:GetWordFromCfg(424031074)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 24 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 24)

				if (24 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 24)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031074", "story_v_out_424031.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031074", "story_v_out_424031.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_424031", "424031074", "story_v_out_424031.awb")

						arg_301_1:RecordAudio("424031074", var_304_6)
						arg_301_1:RecordAudio("424031074", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_424031", "424031074", "story_v_out_424031.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_424031", "424031074", "story_v_out_424031.awb")
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
	Play424031075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 424031075
		arg_305_1.duration_ = 6.83

		local var_305_0 = {
			zh = 6.833,
			ja = 6.533
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
				arg_305_0:Play424031076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.6

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(424031075)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 24 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 24)

				if (24 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 24)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031075", "story_v_out_424031.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031075", "story_v_out_424031.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_424031", "424031075", "story_v_out_424031.awb")

						arg_305_1:RecordAudio("424031075", var_308_6)
						arg_305_1:RecordAudio("424031075", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_424031", "424031075", "story_v_out_424031.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_424031", "424031075", "story_v_out_424031.awb")
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
	Play424031076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 424031076
		arg_309_1.duration_ = 4.07

		local var_309_0 = {
			zh = 2,
			ja = 4.066
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
				arg_309_0:Play424031077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1094"]) and arg_309_1.var_.actorSpriteComps1094 == nil then
				arg_309_1.var_.actorSpriteComps1094 = arg_309_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1094"]) then
				if arg_309_1.var_.actorSpriteComps1094 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1094"]) and arg_309_1.var_.actorSpriteComps1094 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps1094 = nil
			end

			local var_312_2 = arg_309_1.actors_["1094"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1094 = var_312_2.localPosition
				var_312_2.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1094", 3)

				for iter_312_4 = 0, var_312_2.childCount - 1 do
					local var_312_3 = var_312_2:GetChild(iter_312_4)

					if var_312_3.name == "split_1" then
						var_312_3:SetAsLastSibling()
						var_312_3.gameObject:SetActive(true)

						arg_309_1.var_.actorSpriteSplit1094 = var_312_3.gameObject:GetComponent(typeof(Image))

						arg_309_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_312_4 = 0.5

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				var_312_2.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_309_1.time_ - 0) / var_312_4)

				if arg_309_1.var_.actorSpriteSplit1094 ~= nil then
					arg_309_1.var_.actorSpriteSplit1094:SetAlpha((arg_309_1.time_ - 0) / var_312_4)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				var_312_2.localPosition = Vector3.New(0, -335, -230)

				if arg_309_1.var_.actorSpriteSplit1094 ~= nil then
					arg_309_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_312_5 = 0
			local var_312_6 = 0.275

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(424031076)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 11 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 11)

				if (11 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 11)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031076", "story_v_out_424031.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031076", "story_v_out_424031.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_424031", "424031076", "story_v_out_424031.awb")

						arg_309_1:RecordAudio("424031076", var_312_12)
						arg_309_1:RecordAudio("424031076", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_424031", "424031076", "story_v_out_424031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_424031", "424031076", "story_v_out_424031.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play424031077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 424031077
		arg_313_1.duration_ = 5.5

		local var_313_0 = {
			zh = 3.3,
			ja = 5.5
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
				arg_313_0:Play424031078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1094"]) and arg_313_1.var_.actorSpriteComps1094 == nil then
				arg_313_1.var_.actorSpriteComps1094 = arg_313_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1094"]) then
				if arg_313_1.var_.actorSpriteComps1094 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1094"]) and arg_313_1.var_.actorSpriteComps1094 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1094 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 0.4

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_4 = arg_313_1:GetWordFromCfg(424031077)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 16 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 16)

				if (16 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 16)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031077", "story_v_out_424031.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031077", "story_v_out_424031.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_424031", "424031077", "story_v_out_424031.awb")

						arg_313_1:RecordAudio("424031077", var_316_9)
						arg_313_1:RecordAudio("424031077", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_424031", "424031077", "story_v_out_424031.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_424031", "424031077", "story_v_out_424031.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play424031078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 424031078
		arg_317_1.duration_ = 3.83

		local var_317_0 = {
			zh = 1.733,
			ja = 3.833
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
				arg_317_0:Play424031079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1094"]) and arg_317_1.var_.actorSpriteComps1094 == nil then
				arg_317_1.var_.actorSpriteComps1094 = arg_317_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1094"]) then
				if arg_317_1.var_.actorSpriteComps1094 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1094"]) and arg_317_1.var_.actorSpriteComps1094 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps1094 = nil
			end

			local var_320_2 = 0
			local var_320_3 = 0.2

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:GetWordFromCfg(424031078)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 8 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 8)

				if (8 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 8)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031078", "story_v_out_424031.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031078", "story_v_out_424031.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_out_424031", "424031078", "story_v_out_424031.awb")

						arg_317_1:RecordAudio("424031078", var_320_9)
						arg_317_1:RecordAudio("424031078", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_424031", "424031078", "story_v_out_424031.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_424031", "424031078", "story_v_out_424031.awb")
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
	Play424031079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 424031079
		arg_321_1.duration_ = 7.2

		local var_321_0 = {
			zh = 5.766,
			ja = 7.2
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
				arg_321_0:Play424031080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if arg_321_1.bgs_.I11o == nil then
				local var_324_0 = Object.Instantiate(arg_321_1.paintGo_)

				var_324_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_324_0.name = "I11o"
				var_324_0.transform.parent = arg_321_1.stage_.transform
				var_324_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.bgs_.I11o = var_324_0
			end

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= 2 + arg_324_0 then
				local var_324_1 = arg_321_1.bgs_.I11o

				arg_321_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_324_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_324_2 = var_324_1:GetComponent("SpriteRenderer")

				if var_324_2 and var_324_2.sprite then
					local var_324_3 = 2 * (var_324_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_324_1.transform.localScale = Vector3.New(var_324_3 / var_324_2.sprite.bounds.size.y < var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x and var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x or var_324_3 / var_324_2.sprite.bounds.size.y, var_324_3 / var_324_2.sprite.bounds.size.y < var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x and var_324_3 * manager.ui.mainCameraCom_.aspect / var_324_2.sprite.bounds.size.x or var_324_3 / var_324_2.sprite.bounds.size.y, 0)
				end

				for iter_324_0, iter_324_1 in pairs(arg_321_1.bgs_) do
					if iter_324_0 ~= "I11o" then
						iter_324_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_324_4 = 4

			if 4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= var_324_4 + 0.3 and arg_321_1.time_ < var_324_4 + 0.3 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			local var_324_5 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_6 = 2

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_6 then
				local var_324_7 = Color.New(0, 0, 0)

				var_324_7.a = Mathf.Lerp(0, 1, (arg_321_1.time_ - var_324_5) / var_324_6)
				arg_321_1.mask_.color = var_324_7
			end

			if arg_321_1.time_ >= var_324_5 + var_324_6 and arg_321_1.time_ < var_324_5 + var_324_6 + arg_324_0 then
				local var_324_8 = Color.New(0, 0, 0)

				var_324_8.a = 1
				arg_321_1.mask_.color = var_324_8
			end

			local var_324_9 = 2

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_10 = 2

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_10 then
				local var_324_11 = Color.New(0, 0, 0)

				var_324_11.a = Mathf.Lerp(1, 0, (arg_321_1.time_ - var_324_9) / var_324_10)
				arg_321_1.mask_.color = var_324_11
			end

			if arg_321_1.time_ >= var_324_9 + var_324_10 and arg_321_1.time_ < var_324_9 + var_324_10 + arg_324_0 then
				local var_324_12 = Color.New(0, 0, 0)

				arg_321_1.mask_.enabled = false
				var_324_12.a = 0
				arg_321_1.mask_.color = var_324_12
			end

			local var_324_13 = arg_321_1.actors_["1094"]

			if 1.966 < arg_321_1.time_ and arg_321_1.time_ <= 1.966 + arg_324_0 and not isNil(var_324_13) and arg_321_1.var_.actorSpriteComps1094 == nil then
				arg_321_1.var_.actorSpriteComps1094 = var_324_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_14 = 0.034

			if 1.966 <= arg_321_1.time_ and arg_321_1.time_ < 1.966 + var_324_14 and not isNil(var_324_13) then
				if arg_321_1.var_.actorSpriteComps1094 then
					for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_324_3 then
							if arg_321_1.isInRecall_ then
								iter_324_3.color = Color.New(Mathf.Lerp(iter_324_3.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 1.966) / var_324_14), Mathf.Lerp(iter_324_3.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 1.966) / var_324_14), (Mathf.Lerp(iter_324_3.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 1.966) / var_324_14)))
							else
								local var_324_15 = Mathf.Lerp(iter_324_3.color.r, 0.5, (arg_321_1.time_ - 1.966) / var_324_14)

								iter_324_3.color = Color.New(var_324_15, var_324_15, var_324_15)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 1.966 + var_324_14 and arg_321_1.time_ < 1.966 + var_324_14 + arg_324_0 and not isNil(var_324_13) and arg_321_1.var_.actorSpriteComps1094 then
				for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_324_5 then
						iter_324_5.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps1094 = nil
			end

			local var_324_16 = arg_321_1.actors_["1094"].transform

			if 1.966 < arg_321_1.time_ and arg_321_1.time_ <= 1.966 + arg_324_0 then
				arg_321_1.var_.moveOldPos1094 = var_324_16.localPosition
				var_324_16.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1094", 7)

				for iter_324_6 = 0, var_324_16.childCount - 1 do
					local var_324_17 = var_324_16:GetChild(iter_324_6)

					if var_324_17.name == "" or not string.find(var_324_17.name, "split") then
						var_324_17.gameObject:SetActive(true)
					else
						var_324_17.gameObject:SetActive(false)
					end
				end
			end

			local var_324_18 = 0.001

			if 1.966 <= arg_321_1.time_ and arg_321_1.time_ < 1.966 + var_324_18 then
				var_324_16.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_321_1.time_ - 1.966) / var_324_18)
			end

			if arg_321_1.time_ >= 1.966 + var_324_18 and arg_321_1.time_ < 1.966 + var_324_18 + arg_324_0 then
				var_324_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.266666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 0.266666666666667 + arg_324_0 then
				arg_321_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 1.7 < arg_321_1.time_ and arg_321_1.time_ <= 1.7 + arg_324_0 then
				arg_321_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_21 = 4
			local var_324_22 = 0.2

			if 4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_21 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_23 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_23:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_24 = arg_321_1:GetWordFromCfg(424031079)
				local var_324_25 = arg_321_1:FormatText(var_324_24.content)

				arg_321_1.text_.text = var_324_25

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_27 = 8 <= 0 and var_324_22 or var_324_22 * (utf8.len(var_324_25) / 8)

				if (8 <= 0 and var_324_22 or var_324_22 * (utf8.len(var_324_25) / 8)) > 0 and var_324_22 < var_324_27 then
					arg_321_1.talkMaxDuration = var_324_27
					var_324_21 = var_324_21 + 0.3

					if var_324_27 + var_324_21 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_27 + var_324_21
					end
				end

				arg_321_1.text_.text = var_324_25
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031079", "story_v_out_424031.awb") ~= 0 then
					local var_324_28 = manager.audio:GetVoiceLength("story_v_out_424031", "424031079", "story_v_out_424031.awb") / 1000

					if var_324_28 + var_324_21 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_28 + var_324_21
					end

					if var_324_24.prefab_name ~= "" and arg_321_1.actors_[var_324_24.prefab_name] ~= nil then
						local var_324_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_24.prefab_name].transform, "story_v_out_424031", "424031079", "story_v_out_424031.awb")

						arg_321_1:RecordAudio("424031079", var_324_29)
						arg_321_1:RecordAudio("424031079", var_324_29)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_424031", "424031079", "story_v_out_424031.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_424031", "424031079", "story_v_out_424031.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_30 = var_324_21 + 0.3
			local var_324_31 = math.max(var_324_22, arg_321_1.talkMaxDuration)

			if var_324_21 + 0.3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_30 + var_324_31 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_30) / var_324_31

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_30 + var_324_31 and arg_321_1.time_ < var_324_30 + var_324_31 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play424031080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 424031080
		arg_327_1.duration_ = 1.1

		local var_327_0 = {
			zh = 0.999999999999,
			ja = 1.1
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play424031081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10154"]) and arg_327_1.var_.actorSpriteComps10154 == nil then
				arg_327_1.var_.actorSpriteComps10154 = arg_327_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10154"]) then
				if arg_327_1.var_.actorSpriteComps10154 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 1, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10154"]) and arg_327_1.var_.actorSpriteComps10154 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps10154 = nil
			end

			local var_330_2 = arg_327_1.actors_["10154"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10154 = var_330_2.localPosition
				var_330_2.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10154", 3)

				for iter_330_4 = 0, var_330_2.childCount - 1 do
					local var_330_3 = var_330_2:GetChild(iter_330_4)

					if var_330_3.name == "split_1" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				var_330_2.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_327_1.time_ - 0) / var_330_4)
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				var_330_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_330_5 = 0
			local var_330_6 = 0.075

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_7 = arg_327_1:GetWordFromCfg(424031080)
				local var_330_8 = arg_327_1:FormatText(var_330_7.content)

				arg_327_1.text_.text = var_330_8

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_10 = 3 <= 0 and var_330_6 or var_330_6 * (utf8.len(var_330_8) / 3)

				if (3 <= 0 and var_330_6 or var_330_6 * (utf8.len(var_330_8) / 3)) > 0 and var_330_6 < var_330_10 then
					arg_327_1.talkMaxDuration = var_330_10

					if var_330_10 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_5
					end
				end

				arg_327_1.text_.text = var_330_8
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031080", "story_v_out_424031.awb") ~= 0 then
					local var_330_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031080", "story_v_out_424031.awb") / 1000

					if var_330_11 + var_330_5 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_5
					end

					if var_330_7.prefab_name ~= "" and arg_327_1.actors_[var_330_7.prefab_name] ~= nil then
						local var_330_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_7.prefab_name].transform, "story_v_out_424031", "424031080", "story_v_out_424031.awb")

						arg_327_1:RecordAudio("424031080", var_330_12)
						arg_327_1:RecordAudio("424031080", var_330_12)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_424031", "424031080", "story_v_out_424031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_424031", "424031080", "story_v_out_424031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_13 = math.max(var_330_6, arg_327_1.talkMaxDuration)

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_13 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_5) / var_330_13

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_5 + var_330_13 and arg_327_1.time_ < var_330_5 + var_330_13 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play424031081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 424031081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play424031082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10154"]) and arg_331_1.var_.actorSpriteComps10154 == nil then
				arg_331_1.var_.actorSpriteComps10154 = arg_331_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10154"]) then
				if arg_331_1.var_.actorSpriteComps10154 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10154"]) and arg_331_1.var_.actorSpriteComps10154 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps10154 = nil
			end

			local var_334_2 = arg_331_1.actors_["10154"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10154 = var_334_2.localPosition
				var_334_2.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10154", 7)

				for iter_334_4 = 0, var_334_2.childCount - 1 do
					local var_334_3 = var_334_2:GetChild(iter_334_4)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_331_1.time_ - 0) / var_334_4)
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_5 = 0
			local var_334_6 = 0.475

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_7 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(424031081).content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 19 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_7) / 19)

				if (19 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_7) / 19)) > 0 and var_334_6 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_5 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_5
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_6, arg_331_1.talkMaxDuration)

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_5) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_5 + var_334_10 and arg_331_1.time_ < var_334_5 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play424031082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 424031082
		arg_335_1.duration_ = 5.07

		local var_335_0 = {
			zh = 4.266,
			ja = 5.066
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play424031083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["10154"]) and arg_335_1.var_.actorSpriteComps10154 == nil then
				arg_335_1.var_.actorSpriteComps10154 = arg_335_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["10154"]) then
				if arg_335_1.var_.actorSpriteComps10154 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								iter_338_1.color = Color.New(Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_0), Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_0), (Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_0)))
							else
								local var_338_1 = Mathf.Lerp(iter_338_1.color.r, 1, (arg_335_1.time_ - 0) / var_338_0)

								iter_338_1.color = Color.New(var_338_1, var_338_1, var_338_1)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["10154"]) and arg_335_1.var_.actorSpriteComps10154 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_338_3 then
						iter_338_3.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10154 = nil
			end

			local var_338_2 = arg_335_1.actors_["10154"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10154 = var_338_2.localPosition
				var_338_2.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10154", 3)

				for iter_338_4 = 0, var_338_2.childCount - 1 do
					local var_338_3 = var_338_2:GetChild(iter_338_4)

					if var_338_3.name == "split_1" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				var_338_2.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_335_1.time_ - 0) / var_338_4)
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				var_338_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_338_5 = 0
			local var_338_6 = 0.5

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:GetWordFromCfg(424031082)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 20 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 20)

				if (20 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 20)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031082", "story_v_out_424031.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031082", "story_v_out_424031.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_424031", "424031082", "story_v_out_424031.awb")

						arg_335_1:RecordAudio("424031082", var_338_12)
						arg_335_1:RecordAudio("424031082", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_424031", "424031082", "story_v_out_424031.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_424031", "424031082", "story_v_out_424031.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play424031083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 424031083
		arg_339_1.duration_ = 3.07

		local var_339_0 = {
			zh = 1.8,
			ja = 3.066
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play424031084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10154"]) and arg_339_1.var_.actorSpriteComps10154 == nil then
				arg_339_1.var_.actorSpriteComps10154 = arg_339_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10154"]) then
				if arg_339_1.var_.actorSpriteComps10154 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10154"]) and arg_339_1.var_.actorSpriteComps10154 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps10154 = nil
			end

			local var_342_2 = 0
			local var_342_3 = 0.175

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_4 = arg_339_1:GetWordFromCfg(424031083)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 7 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 7)

				if (7 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 7)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031083", "story_v_out_424031.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031083", "story_v_out_424031.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_out_424031", "424031083", "story_v_out_424031.awb")

						arg_339_1:RecordAudio("424031083", var_342_9)
						arg_339_1:RecordAudio("424031083", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_424031", "424031083", "story_v_out_424031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_424031", "424031083", "story_v_out_424031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play424031084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 424031084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play424031085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10154 = arg_343_1.actors_["10154"].transform.localPosition
				arg_343_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10154", 7)

				for iter_346_0 = 0, arg_343_1.actors_["10154"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["10154"].transform:GetChild(iter_346_0)

					if var_346_0.name == "" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["10154"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_2 = 0
			local var_346_3 = 0.825

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(424031084).content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 33 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 33)

				if (33 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 33)) > 0 and var_346_3 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_7 and arg_343_1.time_ < var_346_2 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play424031085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 424031085
		arg_347_1.duration_ = 5.57

		local var_347_0 = {
			zh = 5.566,
			ja = 5.333
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play424031086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.575

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(424031085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 23 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 23)

				if (23 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 23)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031085", "story_v_out_424031.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031085", "story_v_out_424031.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_424031", "424031085", "story_v_out_424031.awb")

						arg_347_1:RecordAudio("424031085", var_350_6)
						arg_347_1:RecordAudio("424031085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_424031", "424031085", "story_v_out_424031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_424031", "424031085", "story_v_out_424031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play424031086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 424031086
		arg_351_1.duration_ = 11.07

		local var_351_0 = {
			zh = 8.766,
			ja = 11.066
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play424031087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10154"]) and arg_351_1.var_.actorSpriteComps10154 == nil then
				arg_351_1.var_.actorSpriteComps10154 = arg_351_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10154"]) then
				if arg_351_1.var_.actorSpriteComps10154 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 1, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10154"]) and arg_351_1.var_.actorSpriteComps10154 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps10154 = nil
			end

			local var_354_2 = arg_351_1.actors_["10154"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos10154 = var_354_2.localPosition
				var_354_2.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10154", 3)

				for iter_354_4 = 0, var_354_2.childCount - 1 do
					local var_354_3 = var_354_2:GetChild(iter_354_4)

					if var_354_3.name == "split_1" or not string.find(var_354_3.name, "split") then
						var_354_3.gameObject:SetActive(true)
					else
						var_354_3.gameObject:SetActive(false)
					end
				end
			end

			local var_354_4 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				var_354_2.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_351_1.time_ - 0) / var_354_4)
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				var_354_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_354_5 = 0
			local var_354_6 = 1.1

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:GetWordFromCfg(424031086)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 44 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 44)

				if (44 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 44)) > 0 and var_354_6 < var_354_10 then
					arg_351_1.talkMaxDuration = var_354_10

					if var_354_10 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031086", "story_v_out_424031.awb") ~= 0 then
					local var_354_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031086", "story_v_out_424031.awb") / 1000

					if var_354_11 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_5
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_out_424031", "424031086", "story_v_out_424031.awb")

						arg_351_1:RecordAudio("424031086", var_354_12)
						arg_351_1:RecordAudio("424031086", var_354_12)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_424031", "424031086", "story_v_out_424031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_424031", "424031086", "story_v_out_424031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_13 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_13 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_13

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_13 and arg_351_1.time_ < var_354_5 + var_354_13 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play424031087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 424031087
		arg_355_1.duration_ = 7.9

		local var_355_0 = {
			zh = 5.8,
			ja = 7.9
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
				arg_355_0:Play424031088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["10154"]) and arg_355_1.var_.actorSpriteComps10154 == nil then
				arg_355_1.var_.actorSpriteComps10154 = arg_355_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["10154"]) then
				if arg_355_1.var_.actorSpriteComps10154 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								iter_358_1.color = Color.New(Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_0), Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_0), (Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_0)))
							else
								local var_358_1 = Mathf.Lerp(iter_358_1.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_0)

								iter_358_1.color = Color.New(var_358_1, var_358_1, var_358_1)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["10154"]) and arg_355_1.var_.actorSpriteComps10154 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_358_3 then
						iter_358_3.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps10154 = nil
			end

			local var_358_2 = 0
			local var_358_3 = 0.775

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_4 = arg_355_1:GetWordFromCfg(424031087)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_7 = 31 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_5) / 31)

				if (31 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_5) / 31)) > 0 and var_358_3 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_2
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031087", "story_v_out_424031.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031087", "story_v_out_424031.awb") / 1000

					if var_358_8 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_2
					end

					if var_358_4.prefab_name ~= "" and arg_355_1.actors_[var_358_4.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_4.prefab_name].transform, "story_v_out_424031", "424031087", "story_v_out_424031.awb")

						arg_355_1:RecordAudio("424031087", var_358_9)
						arg_355_1:RecordAudio("424031087", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_424031", "424031087", "story_v_out_424031.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_424031", "424031087", "story_v_out_424031.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_3, arg_355_1.talkMaxDuration)

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_2) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_2 + var_358_10 and arg_355_1.time_ < var_358_2 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play424031088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 424031088
		arg_359_1.duration_ = 3.2

		local var_359_0 = {
			zh = 3.2,
			ja = 2.666
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play424031089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10154"]) and arg_359_1.var_.actorSpriteComps10154 == nil then
				arg_359_1.var_.actorSpriteComps10154 = arg_359_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_0 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10154"]) then
				if arg_359_1.var_.actorSpriteComps10154 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								iter_362_1.color = Color.New(Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, (arg_359_1.time_ - 0) / var_362_0), Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, (arg_359_1.time_ - 0) / var_362_0), (Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, (arg_359_1.time_ - 0) / var_362_0)))
							else
								local var_362_1 = Mathf.Lerp(iter_362_1.color.r, 1, (arg_359_1.time_ - 0) / var_362_0)

								iter_362_1.color = Color.New(var_362_1, var_362_1, var_362_1)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10154"]) and arg_359_1.var_.actorSpriteComps10154 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_362_3 then
						iter_362_3.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_359_1.var_.actorSpriteComps10154 = nil
			end

			local var_362_2 = arg_359_1.actors_["10154"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10154 = var_362_2.localPosition
				var_362_2.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10154", 3)

				for iter_362_4 = 0, var_362_2.childCount - 1 do
					local var_362_3 = var_362_2:GetChild(iter_362_4)

					if var_362_3.name == "split_5" then
						var_362_3:SetAsLastSibling()
						var_362_3.gameObject:SetActive(true)

						arg_359_1.var_.actorSpriteSplit10154 = var_362_3.gameObject:GetComponent(typeof(Image))

						arg_359_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_362_4 = 0.5

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_2.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_359_1.time_ - 0) / var_362_4)

				if arg_359_1.var_.actorSpriteSplit10154 ~= nil then
					arg_359_1.var_.actorSpriteSplit10154:SetAlpha((arg_359_1.time_ - 0) / var_362_4)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_359_1.var_.actorSpriteSplit10154 ~= nil then
					arg_359_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_362_5 = 0
			local var_362_6 = 0.25

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_7 = arg_359_1:GetWordFromCfg(424031088)
				local var_362_8 = arg_359_1:FormatText(var_362_7.content)

				arg_359_1.text_.text = var_362_8

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 10 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 10)

				if (10 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 10)) > 0 and var_362_6 < var_362_10 then
					arg_359_1.talkMaxDuration = var_362_10

					if var_362_10 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_8
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031088", "story_v_out_424031.awb") ~= 0 then
					local var_362_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031088", "story_v_out_424031.awb") / 1000

					if var_362_11 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_5
					end

					if var_362_7.prefab_name ~= "" and arg_359_1.actors_[var_362_7.prefab_name] ~= nil then
						local var_362_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_7.prefab_name].transform, "story_v_out_424031", "424031088", "story_v_out_424031.awb")

						arg_359_1:RecordAudio("424031088", var_362_12)
						arg_359_1:RecordAudio("424031088", var_362_12)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_424031", "424031088", "story_v_out_424031.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_424031", "424031088", "story_v_out_424031.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_13 = math.max(var_362_6, arg_359_1.talkMaxDuration)

			if var_362_5 <= arg_359_1.time_ and arg_359_1.time_ < var_362_5 + var_362_13 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_5) / var_362_13

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_5 + var_362_13 and arg_359_1.time_ < var_362_5 + var_362_13 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play424031089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 424031089
		arg_363_1.duration_ = 6.17

		local var_363_0 = {
			zh = 4.833,
			ja = 6.166
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play424031090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["10154"]) and arg_363_1.var_.actorSpriteComps10154 == nil then
				arg_363_1.var_.actorSpriteComps10154 = arg_363_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["10154"]) then
				if arg_363_1.var_.actorSpriteComps10154 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								iter_366_1.color = Color.New(Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor2.r, (arg_363_1.time_ - 0) / var_366_0), Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor2.g, (arg_363_1.time_ - 0) / var_366_0), (Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor2.b, (arg_363_1.time_ - 0) / var_366_0)))
							else
								local var_366_1 = Mathf.Lerp(iter_366_1.color.r, 0.5, (arg_363_1.time_ - 0) / var_366_0)

								iter_366_1.color = Color.New(var_366_1, var_366_1, var_366_1)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["10154"]) and arg_363_1.var_.actorSpriteComps10154 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps10154 = nil
			end

			local var_366_2 = 0
			local var_366_3 = 0.55

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_4 = arg_363_1:GetWordFromCfg(424031089)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 22 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 22)

				if (22 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 22)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031089", "story_v_out_424031.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031089", "story_v_out_424031.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_out_424031", "424031089", "story_v_out_424031.awb")

						arg_363_1:RecordAudio("424031089", var_366_9)
						arg_363_1:RecordAudio("424031089", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_424031", "424031089", "story_v_out_424031.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_424031", "424031089", "story_v_out_424031.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play424031090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 424031090
		arg_367_1.duration_ = 3.77

		local var_367_0 = {
			zh = 2.166,
			ja = 3.766
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
				arg_367_0:Play424031091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["10154"]) and arg_367_1.var_.actorSpriteComps10154 == nil then
				arg_367_1.var_.actorSpriteComps10154 = arg_367_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["10154"]) then
				if arg_367_1.var_.actorSpriteComps10154 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								iter_370_1.color = Color.New(Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_0), Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_0), (Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_0)))
							else
								local var_370_1 = Mathf.Lerp(iter_370_1.color.r, 1, (arg_367_1.time_ - 0) / var_370_0)

								iter_370_1.color = Color.New(var_370_1, var_370_1, var_370_1)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["10154"]) and arg_367_1.var_.actorSpriteComps10154 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_370_3 then
						iter_370_3.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps10154 = nil
			end

			local var_370_2 = arg_367_1.actors_["10154"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10154 = var_370_2.localPosition
				var_370_2.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10154", 3)

				for iter_370_4 = 0, var_370_2.childCount - 1 do
					local var_370_3 = var_370_2:GetChild(iter_370_4)

					if var_370_3.name == "split_1" then
						var_370_3:SetAsLastSibling()
						var_370_3.gameObject:SetActive(true)

						arg_367_1.var_.actorSpriteSplit10154 = var_370_3.gameObject:GetComponent(typeof(Image))

						arg_367_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_370_4 = 0.5

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_2.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_367_1.time_ - 0) / var_370_4)

				if arg_367_1.var_.actorSpriteSplit10154 ~= nil then
					arg_367_1.var_.actorSpriteSplit10154:SetAlpha((arg_367_1.time_ - 0) / var_370_4)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_367_1.var_.actorSpriteSplit10154 ~= nil then
					arg_367_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_370_5 = 0
			local var_370_6 = 0.3

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:GetWordFromCfg(424031090)
				local var_370_8 = arg_367_1:FormatText(var_370_7.content)

				arg_367_1.text_.text = var_370_8

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 12 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 12)

				if (12 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 12)) > 0 and var_370_6 < var_370_10 then
					arg_367_1.talkMaxDuration = var_370_10

					if var_370_10 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_8
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031090", "story_v_out_424031.awb") ~= 0 then
					local var_370_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031090", "story_v_out_424031.awb") / 1000

					if var_370_11 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_5
					end

					if var_370_7.prefab_name ~= "" and arg_367_1.actors_[var_370_7.prefab_name] ~= nil then
						local var_370_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_7.prefab_name].transform, "story_v_out_424031", "424031090", "story_v_out_424031.awb")

						arg_367_1:RecordAudio("424031090", var_370_12)
						arg_367_1:RecordAudio("424031090", var_370_12)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_424031", "424031090", "story_v_out_424031.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_424031", "424031090", "story_v_out_424031.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play424031091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 424031091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play424031092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["10154"]) and arg_371_1.var_.actorSpriteComps10154 == nil then
				arg_371_1.var_.actorSpriteComps10154 = arg_371_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_0 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["10154"]) then
				if arg_371_1.var_.actorSpriteComps10154 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								iter_374_1.color = Color.New(Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_0), Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_0), (Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_0)))
							else
								local var_374_1 = Mathf.Lerp(iter_374_1.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_0)

								iter_374_1.color = Color.New(var_374_1, var_374_1, var_374_1)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["10154"]) and arg_371_1.var_.actorSpriteComps10154 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_374_3 then
						iter_374_3.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps10154 = nil
			end

			local var_374_2 = arg_371_1.actors_["10154"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos10154 = var_374_2.localPosition
				var_374_2.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10154", 7)

				for iter_374_4 = 0, var_374_2.childCount - 1 do
					local var_374_3 = var_374_2:GetChild(iter_374_4)

					if var_374_3.name == "" or not string.find(var_374_3.name, "split") then
						var_374_3.gameObject:SetActive(true)
					else
						var_374_3.gameObject:SetActive(false)
					end
				end
			end

			local var_374_4 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				var_374_2.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_371_1.time_ - 0) / var_374_4)
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				var_374_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_374_5 = 0
			local var_374_6 = 1.125

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_7 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(424031091).content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 45 <= 0 and var_374_6 or var_374_6 * (utf8.len(var_374_7) / 45)

				if (45 <= 0 and var_374_6 or var_374_6 * (utf8.len(var_374_7) / 45)) > 0 and var_374_6 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_5
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_6, arg_371_1.talkMaxDuration)

			if var_374_5 <= arg_371_1.time_ and arg_371_1.time_ < var_374_5 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_5) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_5 + var_374_10 and arg_371_1.time_ < var_374_5 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play424031092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 424031092
		arg_375_1.duration_ = 6.9

		local var_375_0 = {
			zh = 5.533,
			ja = 6.9
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
				arg_375_0:Play424031093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["10154"]) and arg_375_1.var_.actorSpriteComps10154 == nil then
				arg_375_1.var_.actorSpriteComps10154 = arg_375_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_0 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["10154"]) then
				if arg_375_1.var_.actorSpriteComps10154 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								iter_378_1.color = Color.New(Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_0), Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_0), (Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_0)))
							else
								local var_378_1 = Mathf.Lerp(iter_378_1.color.r, 1, (arg_375_1.time_ - 0) / var_378_0)

								iter_378_1.color = Color.New(var_378_1, var_378_1, var_378_1)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["10154"]) and arg_375_1.var_.actorSpriteComps10154 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_378_3 then
						iter_378_3.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps10154 = nil
			end

			local var_378_2 = arg_375_1.actors_["10154"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10154 = var_378_2.localPosition
				var_378_2.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10154", 3)

				for iter_378_4 = 0, var_378_2.childCount - 1 do
					local var_378_3 = var_378_2:GetChild(iter_378_4)

					if var_378_3.name == "split_5" then
						var_378_3:SetAsLastSibling()
						var_378_3.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit10154 = var_378_3.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_378_4 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_2.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_375_1.time_ - 0) / var_378_4)

				if arg_375_1.var_.actorSpriteSplit10154 ~= nil then
					arg_375_1.var_.actorSpriteSplit10154:SetAlpha((arg_375_1.time_ - 0) / var_378_4)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_375_1.var_.actorSpriteSplit10154 ~= nil then
					arg_375_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_378_5 = 0
			local var_378_6 = 0.5

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(424031092)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 20 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 20)

				if (20 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 20)) > 0 and var_378_6 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10

					if var_378_10 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031092", "story_v_out_424031.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031092", "story_v_out_424031.awb") / 1000

					if var_378_11 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_5
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_424031", "424031092", "story_v_out_424031.awb")

						arg_375_1:RecordAudio("424031092", var_378_12)
						arg_375_1:RecordAudio("424031092", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_424031", "424031092", "story_v_out_424031.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_424031", "424031092", "story_v_out_424031.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play424031093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 424031093
		arg_379_1.duration_ = 6.7

		local var_379_0 = {
			zh = 5.433,
			ja = 6.7
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play424031094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["10154"]) and arg_379_1.var_.actorSpriteComps10154 == nil then
				arg_379_1.var_.actorSpriteComps10154 = arg_379_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["10154"]) then
				if arg_379_1.var_.actorSpriteComps10154 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								iter_382_1.color = Color.New(Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor2.r, (arg_379_1.time_ - 0) / var_382_0), Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor2.g, (arg_379_1.time_ - 0) / var_382_0), (Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor2.b, (arg_379_1.time_ - 0) / var_382_0)))
							else
								local var_382_1 = Mathf.Lerp(iter_382_1.color.r, 0.5, (arg_379_1.time_ - 0) / var_382_0)

								iter_382_1.color = Color.New(var_382_1, var_382_1, var_382_1)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["10154"]) and arg_379_1.var_.actorSpriteComps10154 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_382_3 then
						iter_382_3.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_379_1.var_.actorSpriteComps10154 = nil
			end

			local var_382_2 = 0
			local var_382_3 = 0.625

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_4 = arg_379_1:GetWordFromCfg(424031093)
				local var_382_5 = arg_379_1:FormatText(var_382_4.content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 25 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 25)

				if (25 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 25)) > 0 and var_382_3 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031093", "story_v_out_424031.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031093", "story_v_out_424031.awb") / 1000

					if var_382_8 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_2
					end

					if var_382_4.prefab_name ~= "" and arg_379_1.actors_[var_382_4.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_4.prefab_name].transform, "story_v_out_424031", "424031093", "story_v_out_424031.awb")

						arg_379_1:RecordAudio("424031093", var_382_9)
						arg_379_1:RecordAudio("424031093", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_424031", "424031093", "story_v_out_424031.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_424031", "424031093", "story_v_out_424031.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_10 and arg_379_1.time_ < var_382_2 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play424031094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 424031094
		arg_383_1.duration_ = 4.3

		local var_383_0 = {
			zh = 3.133,
			ja = 4.3
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
				arg_383_0:Play424031095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1094"]) and arg_383_1.var_.actorSpriteComps1094 == nil then
				arg_383_1.var_.actorSpriteComps1094 = arg_383_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1094"]) then
				if arg_383_1.var_.actorSpriteComps1094 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								iter_386_1.color = Color.New(Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_0), Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_0), (Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_0)))
							else
								local var_386_1 = Mathf.Lerp(iter_386_1.color.r, 1, (arg_383_1.time_ - 0) / var_386_0)

								iter_386_1.color = Color.New(var_386_1, var_386_1, var_386_1)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1094"]) and arg_383_1.var_.actorSpriteComps1094 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_386_3 then
						iter_386_3.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps1094 = nil
			end

			local var_386_2 = arg_383_1.actors_["1094"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1094 = var_386_2.localPosition
				var_386_2.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1094", 4)

				for iter_386_4 = 0, var_386_2.childCount - 1 do
					local var_386_3 = var_386_2:GetChild(iter_386_4)

					if var_386_3.name == "split_1" or not string.find(var_386_3.name, "split") then
						var_386_3.gameObject:SetActive(true)
					else
						var_386_3.gameObject:SetActive(false)
					end
				end
			end

			local var_386_4 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				var_386_2.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_383_1.time_ - 0) / var_386_4)
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				var_386_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_386_5 = arg_383_1.actors_["10154"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10154 = var_386_5.localPosition
				var_386_5.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10154", 2)

				for iter_386_5 = 0, var_386_5.childCount - 1 do
					local var_386_6 = var_386_5:GetChild(iter_386_5)

					if var_386_6.name == "split_1" or not string.find(var_386_6.name, "split") then
						var_386_6.gameObject:SetActive(true)
					else
						var_386_6.gameObject:SetActive(false)
					end
				end
			end

			local var_386_7 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				var_386_5.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_383_1.time_ - 0) / var_386_7)
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				var_386_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_386_8 = 0
			local var_386_9 = 0.3

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_10 = arg_383_1:GetWordFromCfg(424031094)
				local var_386_11 = arg_383_1:FormatText(var_386_10.content)

				arg_383_1.text_.text = var_386_11

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_13 = 12 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 12)

				if (12 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 12)) > 0 and var_386_9 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_8
					end
				end

				arg_383_1.text_.text = var_386_11
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031094", "story_v_out_424031.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031094", "story_v_out_424031.awb") / 1000

					if var_386_14 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_8
					end

					if var_386_10.prefab_name ~= "" and arg_383_1.actors_[var_386_10.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_10.prefab_name].transform, "story_v_out_424031", "424031094", "story_v_out_424031.awb")

						arg_383_1:RecordAudio("424031094", var_386_15)
						arg_383_1:RecordAudio("424031094", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_424031", "424031094", "story_v_out_424031.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_424031", "424031094", "story_v_out_424031.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_9, arg_383_1.talkMaxDuration)

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_8) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_8 + var_386_16 and arg_383_1.time_ < var_386_8 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play424031095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 424031095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play424031096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1094"]) and arg_387_1.var_.actorSpriteComps1094 == nil then
				arg_387_1.var_.actorSpriteComps1094 = arg_387_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_0 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1094"]) then
				if arg_387_1.var_.actorSpriteComps1094 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_390_1 then
							if arg_387_1.isInRecall_ then
								iter_390_1.color = Color.New(Mathf.Lerp(iter_390_1.color.r, arg_387_1.hightColor2.r, (arg_387_1.time_ - 0) / var_390_0), Mathf.Lerp(iter_390_1.color.g, arg_387_1.hightColor2.g, (arg_387_1.time_ - 0) / var_390_0), (Mathf.Lerp(iter_390_1.color.b, arg_387_1.hightColor2.b, (arg_387_1.time_ - 0) / var_390_0)))
							else
								local var_390_1 = Mathf.Lerp(iter_390_1.color.r, 0.5, (arg_387_1.time_ - 0) / var_390_0)

								iter_390_1.color = Color.New(var_390_1, var_390_1, var_390_1)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1094"]) and arg_387_1.var_.actorSpriteComps1094 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_390_3 then
						iter_390_3.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_387_1.var_.actorSpriteComps1094 = nil
			end

			local var_390_2 = 0
			local var_390_3 = 0.825

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(424031095).content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_6 = 33 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_4) / 33)

				if (33 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_4) / 33)) > 0 and var_390_3 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_7 and arg_387_1.time_ < var_390_2 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play424031096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 424031096
		arg_391_1.duration_ = 5.57

		local var_391_0 = {
			zh = 5.266,
			ja = 5.566
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play424031097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["10154"]) and arg_391_1.var_.actorSpriteComps10154 == nil then
				arg_391_1.var_.actorSpriteComps10154 = arg_391_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["10154"]) then
				if arg_391_1.var_.actorSpriteComps10154 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								iter_394_1.color = Color.New(Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor1.r, (arg_391_1.time_ - 0) / var_394_0), Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor1.g, (arg_391_1.time_ - 0) / var_394_0), (Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor1.b, (arg_391_1.time_ - 0) / var_394_0)))
							else
								local var_394_1 = Mathf.Lerp(iter_394_1.color.r, 1, (arg_391_1.time_ - 0) / var_394_0)

								iter_394_1.color = Color.New(var_394_1, var_394_1, var_394_1)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["10154"]) and arg_391_1.var_.actorSpriteComps10154 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_394_3 then
						iter_394_3.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_391_1.var_.actorSpriteComps10154 = nil
			end

			local var_394_2 = arg_391_1.actors_["10154"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10154 = var_394_2.localPosition
				var_394_2.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("10154", 2)

				for iter_394_4 = 0, var_394_2.childCount - 1 do
					local var_394_3 = var_394_2:GetChild(iter_394_4)

					if var_394_3.name == "split_1" or not string.find(var_394_3.name, "split") then
						var_394_3.gameObject:SetActive(true)
					else
						var_394_3.gameObject:SetActive(false)
					end
				end
			end

			local var_394_4 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				var_394_2.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_391_1.time_ - 0) / var_394_4)
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				var_394_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_394_5 = 0
			local var_394_6 = 0.625

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_7 = arg_391_1:GetWordFromCfg(424031096)
				local var_394_8 = arg_391_1:FormatText(var_394_7.content)

				arg_391_1.text_.text = var_394_8

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_10 = 25 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 25)

				if (25 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 25)) > 0 and var_394_6 < var_394_10 then
					arg_391_1.talkMaxDuration = var_394_10

					if var_394_10 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_5
					end
				end

				arg_391_1.text_.text = var_394_8
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031096", "story_v_out_424031.awb") ~= 0 then
					local var_394_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031096", "story_v_out_424031.awb") / 1000

					if var_394_11 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_11 + var_394_5
					end

					if var_394_7.prefab_name ~= "" and arg_391_1.actors_[var_394_7.prefab_name] ~= nil then
						local var_394_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_7.prefab_name].transform, "story_v_out_424031", "424031096", "story_v_out_424031.awb")

						arg_391_1:RecordAudio("424031096", var_394_12)
						arg_391_1:RecordAudio("424031096", var_394_12)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_424031", "424031096", "story_v_out_424031.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_424031", "424031096", "story_v_out_424031.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_13 = math.max(var_394_6, arg_391_1.talkMaxDuration)

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_13 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_5) / var_394_13

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_5 + var_394_13 and arg_391_1.time_ < var_394_5 + var_394_13 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play424031097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 424031097
		arg_395_1.duration_ = 10.83

		local var_395_0 = {
			zh = 9.933,
			ja = 10.833
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play424031098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["10154"]) and arg_395_1.var_.actorSpriteComps10154 == nil then
				arg_395_1.var_.actorSpriteComps10154 = arg_395_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["10154"]) then
				if arg_395_1.var_.actorSpriteComps10154 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								iter_398_1.color = Color.New(Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, (arg_395_1.time_ - 0) / var_398_0), Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, (arg_395_1.time_ - 0) / var_398_0), (Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, (arg_395_1.time_ - 0) / var_398_0)))
							else
								local var_398_1 = Mathf.Lerp(iter_398_1.color.r, 0.5, (arg_395_1.time_ - 0) / var_398_0)

								iter_398_1.color = Color.New(var_398_1, var_398_1, var_398_1)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["10154"]) and arg_395_1.var_.actorSpriteComps10154 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_398_3 then
						iter_398_3.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_395_1.var_.actorSpriteComps10154 = nil
			end

			local var_398_2 = 0
			local var_398_3 = 1.3

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_4 = arg_395_1:GetWordFromCfg(424031097)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 52 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 52)

				if (52 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 52)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031097", "story_v_out_424031.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031097", "story_v_out_424031.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_out_424031", "424031097", "story_v_out_424031.awb")

						arg_395_1:RecordAudio("424031097", var_398_9)
						arg_395_1:RecordAudio("424031097", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_424031", "424031097", "story_v_out_424031.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_424031", "424031097", "story_v_out_424031.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play424031098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 424031098
		arg_399_1.duration_ = 13.97

		local var_399_0 = {
			zh = 9.2,
			ja = 13.966
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
				arg_399_0:Play424031099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 1.275

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:GetWordFromCfg(424031098)
				local var_402_2 = arg_399_1:FormatText(var_402_1.content)

				arg_399_1.text_.text = var_402_2

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 51 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 51)

				if (51 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 51)) > 0 and var_402_0 < var_402_4 then
					arg_399_1.talkMaxDuration = var_402_4

					if var_402_4 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_4 + 0
					end
				end

				arg_399_1.text_.text = var_402_2
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031098", "story_v_out_424031.awb") ~= 0 then
					local var_402_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031098", "story_v_out_424031.awb") / 1000

					if var_402_5 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + 0
					end

					if var_402_1.prefab_name ~= "" and arg_399_1.actors_[var_402_1.prefab_name] ~= nil then
						local var_402_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_1.prefab_name].transform, "story_v_out_424031", "424031098", "story_v_out_424031.awb")

						arg_399_1:RecordAudio("424031098", var_402_6)
						arg_399_1:RecordAudio("424031098", var_402_6)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_424031", "424031098", "story_v_out_424031.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_424031", "424031098", "story_v_out_424031.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_7 and arg_399_1.time_ < 0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play424031099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 424031099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play424031100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 1.325

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(424031099).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 53 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 53)

				if (53 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 53)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play424031100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 424031100
		arg_407_1.duration_ = 2.07

		local var_407_0 = {
			zh = 1.566,
			ja = 2.066
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
				arg_407_0:Play424031101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1094"]) and arg_407_1.var_.actorSpriteComps1094 == nil then
				arg_407_1.var_.actorSpriteComps1094 = arg_407_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_0 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1094"]) then
				if arg_407_1.var_.actorSpriteComps1094 then
					for iter_410_0, iter_410_1 in pairs(arg_407_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_410_1 then
							if arg_407_1.isInRecall_ then
								iter_410_1.color = Color.New(Mathf.Lerp(iter_410_1.color.r, arg_407_1.hightColor1.r, (arg_407_1.time_ - 0) / var_410_0), Mathf.Lerp(iter_410_1.color.g, arg_407_1.hightColor1.g, (arg_407_1.time_ - 0) / var_410_0), (Mathf.Lerp(iter_410_1.color.b, arg_407_1.hightColor1.b, (arg_407_1.time_ - 0) / var_410_0)))
							else
								local var_410_1 = Mathf.Lerp(iter_410_1.color.r, 1, (arg_407_1.time_ - 0) / var_410_0)

								iter_410_1.color = Color.New(var_410_1, var_410_1, var_410_1)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1094"]) and arg_407_1.var_.actorSpriteComps1094 then
				for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_410_3 then
						iter_410_3.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_407_1.var_.actorSpriteComps1094 = nil
			end

			local var_410_2 = arg_407_1.actors_["1094"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1094 = var_410_2.localPosition
				var_410_2.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1094", 4)

				for iter_410_4 = 0, var_410_2.childCount - 1 do
					local var_410_3 = var_410_2:GetChild(iter_410_4)

					if var_410_3.name == "split_1" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				var_410_2.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_407_1.time_ - 0) / var_410_4)
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				var_410_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_410_5 = 0
			local var_410_6 = 0.175

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_7 = arg_407_1:GetWordFromCfg(424031100)
				local var_410_8 = arg_407_1:FormatText(var_410_7.content)

				arg_407_1.text_.text = var_410_8

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_10 = 7 <= 0 and var_410_6 or var_410_6 * (utf8.len(var_410_8) / 7)

				if (7 <= 0 and var_410_6 or var_410_6 * (utf8.len(var_410_8) / 7)) > 0 and var_410_6 < var_410_10 then
					arg_407_1.talkMaxDuration = var_410_10

					if var_410_10 + var_410_5 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_5
					end
				end

				arg_407_1.text_.text = var_410_8
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031100", "story_v_out_424031.awb") ~= 0 then
					local var_410_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031100", "story_v_out_424031.awb") / 1000

					if var_410_11 + var_410_5 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_11 + var_410_5
					end

					if var_410_7.prefab_name ~= "" and arg_407_1.actors_[var_410_7.prefab_name] ~= nil then
						local var_410_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_7.prefab_name].transform, "story_v_out_424031", "424031100", "story_v_out_424031.awb")

						arg_407_1:RecordAudio("424031100", var_410_12)
						arg_407_1:RecordAudio("424031100", var_410_12)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_424031", "424031100", "story_v_out_424031.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_424031", "424031100", "story_v_out_424031.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_13 = math.max(var_410_6, arg_407_1.talkMaxDuration)

			if var_410_5 <= arg_407_1.time_ and arg_407_1.time_ < var_410_5 + var_410_13 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_5) / var_410_13

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_5 + var_410_13 and arg_407_1.time_ < var_410_5 + var_410_13 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 424031101
		arg_411_1.duration_ = 6.83

		local var_411_0 = {
			zh = 4.933,
			ja = 6.833
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
				arg_411_0:Play424031102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["10154"]) and arg_411_1.var_.actorSpriteComps10154 == nil then
				arg_411_1.var_.actorSpriteComps10154 = arg_411_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_0 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["10154"]) then
				if arg_411_1.var_.actorSpriteComps10154 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								iter_414_1.color = Color.New(Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_0), Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_0), (Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_0)))
							else
								local var_414_1 = Mathf.Lerp(iter_414_1.color.r, 1, (arg_411_1.time_ - 0) / var_414_0)

								iter_414_1.color = Color.New(var_414_1, var_414_1, var_414_1)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["10154"]) and arg_411_1.var_.actorSpriteComps10154 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_414_3 then
						iter_414_3.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps10154 = nil
			end

			local var_414_2 = arg_411_1.actors_["1094"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps1094 == nil then
				arg_411_1.var_.actorSpriteComps1094 = var_414_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_3 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 and not isNil(var_414_2) then
				if arg_411_1.var_.actorSpriteComps1094 then
					for iter_414_4, iter_414_5 in pairs(arg_411_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_414_5 then
							if arg_411_1.isInRecall_ then
								iter_414_5.color = Color.New(Mathf.Lerp(iter_414_5.color.r, arg_411_1.hightColor2.r, (arg_411_1.time_ - 0) / var_414_3), Mathf.Lerp(iter_414_5.color.g, arg_411_1.hightColor2.g, (arg_411_1.time_ - 0) / var_414_3), (Mathf.Lerp(iter_414_5.color.b, arg_411_1.hightColor2.b, (arg_411_1.time_ - 0) / var_414_3)))
							else
								local var_414_4 = Mathf.Lerp(iter_414_5.color.r, 0.5, (arg_411_1.time_ - 0) / var_414_3)

								iter_414_5.color = Color.New(var_414_4, var_414_4, var_414_4)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps1094 then
				for iter_414_6, iter_414_7 in pairs(arg_411_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_414_7 then
						iter_414_7.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_411_1.var_.actorSpriteComps1094 = nil
			end

			local var_414_5 = arg_411_1.actors_["10154"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10154 = var_414_5.localPosition
				var_414_5.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10154", 2)

				for iter_414_8 = 0, var_414_5.childCount - 1 do
					local var_414_6 = var_414_5:GetChild(iter_414_8)

					if var_414_6.name == "" or not string.find(var_414_6.name, "split") then
						var_414_6.gameObject:SetActive(true)
					else
						var_414_6.gameObject:SetActive(false)
					end
				end
			end

			local var_414_7 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 then
				var_414_5.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_411_1.time_ - 0) / var_414_7)
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 then
				var_414_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_414_8 = 0
			local var_414_9 = 0.725

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(424031101)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 29 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 29)

				if (29 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 29)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031101", "story_v_out_424031.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031101", "story_v_out_424031.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_424031", "424031101", "story_v_out_424031.awb")

						arg_411_1:RecordAudio("424031101", var_414_15)
						arg_411_1:RecordAudio("424031101", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_424031", "424031101", "story_v_out_424031.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_424031", "424031101", "story_v_out_424031.awb")
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
				actorName = "10154",
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
	Play424031102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 424031102
		arg_415_1.duration_ = 3.37

		local var_415_0 = {
			zh = 3.2,
			ja = 3.366
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
				arg_415_0:Play424031103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1094"]) and arg_415_1.var_.actorSpriteComps1094 == nil then
				arg_415_1.var_.actorSpriteComps1094 = arg_415_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_0 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1094"]) then
				if arg_415_1.var_.actorSpriteComps1094 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								iter_418_1.color = Color.New(Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor1.r, (arg_415_1.time_ - 0) / var_418_0), Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor1.g, (arg_415_1.time_ - 0) / var_418_0), (Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor1.b, (arg_415_1.time_ - 0) / var_418_0)))
							else
								local var_418_1 = Mathf.Lerp(iter_418_1.color.r, 1, (arg_415_1.time_ - 0) / var_418_0)

								iter_418_1.color = Color.New(var_418_1, var_418_1, var_418_1)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1094"]) and arg_415_1.var_.actorSpriteComps1094 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_418_3 then
						iter_418_3.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_415_1.var_.actorSpriteComps1094 = nil
			end

			local var_418_2 = arg_415_1.actors_["10154"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps10154 == nil then
				arg_415_1.var_.actorSpriteComps10154 = var_418_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_3 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_3 and not isNil(var_418_2) then
				if arg_415_1.var_.actorSpriteComps10154 then
					for iter_418_4, iter_418_5 in pairs(arg_415_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_418_5 then
							if arg_415_1.isInRecall_ then
								iter_418_5.color = Color.New(Mathf.Lerp(iter_418_5.color.r, arg_415_1.hightColor2.r, (arg_415_1.time_ - 0) / var_418_3), Mathf.Lerp(iter_418_5.color.g, arg_415_1.hightColor2.g, (arg_415_1.time_ - 0) / var_418_3), (Mathf.Lerp(iter_418_5.color.b, arg_415_1.hightColor2.b, (arg_415_1.time_ - 0) / var_418_3)))
							else
								local var_418_4 = Mathf.Lerp(iter_418_5.color.r, 0.5, (arg_415_1.time_ - 0) / var_418_3)

								iter_418_5.color = Color.New(var_418_4, var_418_4, var_418_4)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_3 and arg_415_1.time_ < 0 + var_418_3 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps10154 then
				for iter_418_6, iter_418_7 in pairs(arg_415_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_418_7 then
						iter_418_7.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_415_1.var_.actorSpriteComps10154 = nil
			end

			local var_418_5 = 0
			local var_418_6 = 0.25

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_7 = arg_415_1:GetWordFromCfg(424031102)
				local var_418_8 = arg_415_1:FormatText(var_418_7.content)

				arg_415_1.text_.text = var_418_8

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_10 = 10 <= 0 and var_418_6 or var_418_6 * (utf8.len(var_418_8) / 10)

				if (10 <= 0 and var_418_6 or var_418_6 * (utf8.len(var_418_8) / 10)) > 0 and var_418_6 < var_418_10 then
					arg_415_1.talkMaxDuration = var_418_10

					if var_418_10 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_5
					end
				end

				arg_415_1.text_.text = var_418_8
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031102", "story_v_out_424031.awb") ~= 0 then
					local var_418_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031102", "story_v_out_424031.awb") / 1000

					if var_418_11 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_11 + var_418_5
					end

					if var_418_7.prefab_name ~= "" and arg_415_1.actors_[var_418_7.prefab_name] ~= nil then
						local var_418_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_7.prefab_name].transform, "story_v_out_424031", "424031102", "story_v_out_424031.awb")

						arg_415_1:RecordAudio("424031102", var_418_12)
						arg_415_1:RecordAudio("424031102", var_418_12)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_424031", "424031102", "story_v_out_424031.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_424031", "424031102", "story_v_out_424031.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_13 = math.max(var_418_6, arg_415_1.talkMaxDuration)

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_13 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_5) / var_418_13

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_5 + var_418_13 and arg_415_1.time_ < var_418_5 + var_418_13 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play424031103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 424031103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play424031104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1094"]) and arg_419_1.var_.actorSpriteComps1094 == nil then
				arg_419_1.var_.actorSpriteComps1094 = arg_419_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_0 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1094"]) then
				if arg_419_1.var_.actorSpriteComps1094 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								iter_422_1.color = Color.New(Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor2.r, (arg_419_1.time_ - 0) / var_422_0), Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor2.g, (arg_419_1.time_ - 0) / var_422_0), (Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor2.b, (arg_419_1.time_ - 0) / var_422_0)))
							else
								local var_422_1 = Mathf.Lerp(iter_422_1.color.r, 0.5, (arg_419_1.time_ - 0) / var_422_0)

								iter_422_1.color = Color.New(var_422_1, var_422_1, var_422_1)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1094"]) and arg_419_1.var_.actorSpriteComps1094 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_422_3 then
						iter_422_3.color = arg_419_1.isInRecall_ and (arg_419_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_419_1.var_.actorSpriteComps1094 = nil
			end

			local var_422_2 = 0
			local var_422_3 = 0.75

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(424031103).content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_6 = 30 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_4) / 30)

				if (30 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_4) / 30)) > 0 and var_422_3 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_7 and arg_419_1.time_ < var_422_2 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play424031104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 424031104
		arg_423_1.duration_ = 9

		local var_423_0 = {
			zh = 6.733,
			ja = 9
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
				arg_423_0:Play424031105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["10154"]) and arg_423_1.var_.actorSpriteComps10154 == nil then
				arg_423_1.var_.actorSpriteComps10154 = arg_423_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["10154"]) then
				if arg_423_1.var_.actorSpriteComps10154 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								iter_426_1.color = Color.New(Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor1.r, (arg_423_1.time_ - 0) / var_426_0), Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor1.g, (arg_423_1.time_ - 0) / var_426_0), (Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor1.b, (arg_423_1.time_ - 0) / var_426_0)))
							else
								local var_426_1 = Mathf.Lerp(iter_426_1.color.r, 1, (arg_423_1.time_ - 0) / var_426_0)

								iter_426_1.color = Color.New(var_426_1, var_426_1, var_426_1)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["10154"]) and arg_423_1.var_.actorSpriteComps10154 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_426_3 then
						iter_426_3.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_423_1.var_.actorSpriteComps10154 = nil
			end

			local var_426_2 = arg_423_1.actors_["10154"].transform

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos10154 = var_426_2.localPosition
				var_426_2.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("10154", 2)

				for iter_426_4 = 0, var_426_2.childCount - 1 do
					local var_426_3 = var_426_2:GetChild(iter_426_4)

					if var_426_3.name == "split_1" or not string.find(var_426_3.name, "split") then
						var_426_3.gameObject:SetActive(true)
					else
						var_426_3.gameObject:SetActive(false)
					end
				end
			end

			local var_426_4 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				var_426_2.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_423_1.time_ - 0) / var_426_4)
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				var_426_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_426_5 = arg_423_1.actors_["1094"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_5) and arg_423_1.var_.actorSpriteComps1094 == nil then
				arg_423_1.var_.actorSpriteComps1094 = var_426_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_6 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_6 and not isNil(var_426_5) then
				if arg_423_1.var_.actorSpriteComps1094 then
					for iter_426_5, iter_426_6 in pairs(arg_423_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_426_6 then
							if arg_423_1.isInRecall_ then
								iter_426_6.color = Color.New(Mathf.Lerp(iter_426_6.color.r, arg_423_1.hightColor2.r, (arg_423_1.time_ - 0) / var_426_6), Mathf.Lerp(iter_426_6.color.g, arg_423_1.hightColor2.g, (arg_423_1.time_ - 0) / var_426_6), (Mathf.Lerp(iter_426_6.color.b, arg_423_1.hightColor2.b, (arg_423_1.time_ - 0) / var_426_6)))
							else
								local var_426_7 = Mathf.Lerp(iter_426_6.color.r, 0.5, (arg_423_1.time_ - 0) / var_426_6)

								iter_426_6.color = Color.New(var_426_7, var_426_7, var_426_7)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_6 and arg_423_1.time_ < 0 + var_426_6 + arg_426_0 and not isNil(var_426_5) and arg_423_1.var_.actorSpriteComps1094 then
				for iter_426_7, iter_426_8 in pairs(arg_423_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_426_8 then
						iter_426_8.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_423_1.var_.actorSpriteComps1094 = nil
			end

			local var_426_8 = 0
			local var_426_9 = 1.025

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_10 = arg_423_1:GetWordFromCfg(424031104)
				local var_426_11 = arg_423_1:FormatText(var_426_10.content)

				arg_423_1.text_.text = var_426_11

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_13 = 41 <= 0 and var_426_9 or var_426_9 * (utf8.len(var_426_11) / 41)

				if (41 <= 0 and var_426_9 or var_426_9 * (utf8.len(var_426_11) / 41)) > 0 and var_426_9 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_8
					end
				end

				arg_423_1.text_.text = var_426_11
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031104", "story_v_out_424031.awb") ~= 0 then
					local var_426_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031104", "story_v_out_424031.awb") / 1000

					if var_426_14 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_14 + var_426_8
					end

					if var_426_10.prefab_name ~= "" and arg_423_1.actors_[var_426_10.prefab_name] ~= nil then
						local var_426_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_10.prefab_name].transform, "story_v_out_424031", "424031104", "story_v_out_424031.awb")

						arg_423_1:RecordAudio("424031104", var_426_15)
						arg_423_1:RecordAudio("424031104", var_426_15)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_424031", "424031104", "story_v_out_424031.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_424031", "424031104", "story_v_out_424031.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_16 = math.max(var_426_9, arg_423_1.talkMaxDuration)

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_16 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_8) / var_426_16

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_8 + var_426_16 and arg_423_1.time_ < var_426_8 + var_426_16 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 424031105
		arg_427_1.duration_ = 5.83

		local var_427_0 = {
			zh = 5.1,
			ja = 5.833
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
				arg_427_0:Play424031106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1094"]) and arg_427_1.var_.actorSpriteComps1094 == nil then
				arg_427_1.var_.actorSpriteComps1094 = arg_427_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_0 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1094"]) then
				if arg_427_1.var_.actorSpriteComps1094 then
					for iter_430_0, iter_430_1 in pairs(arg_427_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_430_1 then
							if arg_427_1.isInRecall_ then
								iter_430_1.color = Color.New(Mathf.Lerp(iter_430_1.color.r, arg_427_1.hightColor1.r, (arg_427_1.time_ - 0) / var_430_0), Mathf.Lerp(iter_430_1.color.g, arg_427_1.hightColor1.g, (arg_427_1.time_ - 0) / var_430_0), (Mathf.Lerp(iter_430_1.color.b, arg_427_1.hightColor1.b, (arg_427_1.time_ - 0) / var_430_0)))
							else
								local var_430_1 = Mathf.Lerp(iter_430_1.color.r, 1, (arg_427_1.time_ - 0) / var_430_0)

								iter_430_1.color = Color.New(var_430_1, var_430_1, var_430_1)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1094"]) and arg_427_1.var_.actorSpriteComps1094 then
				for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_430_3 then
						iter_430_3.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_427_1.var_.actorSpriteComps1094 = nil
			end

			local var_430_2 = arg_427_1.actors_["10154"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.actorSpriteComps10154 == nil then
				arg_427_1.var_.actorSpriteComps10154 = var_430_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_3 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_3 and not isNil(var_430_2) then
				if arg_427_1.var_.actorSpriteComps10154 then
					for iter_430_4, iter_430_5 in pairs(arg_427_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_430_5 then
							if arg_427_1.isInRecall_ then
								iter_430_5.color = Color.New(Mathf.Lerp(iter_430_5.color.r, arg_427_1.hightColor2.r, (arg_427_1.time_ - 0) / var_430_3), Mathf.Lerp(iter_430_5.color.g, arg_427_1.hightColor2.g, (arg_427_1.time_ - 0) / var_430_3), (Mathf.Lerp(iter_430_5.color.b, arg_427_1.hightColor2.b, (arg_427_1.time_ - 0) / var_430_3)))
							else
								local var_430_4 = Mathf.Lerp(iter_430_5.color.r, 0.5, (arg_427_1.time_ - 0) / var_430_3)

								iter_430_5.color = Color.New(var_430_4, var_430_4, var_430_4)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_3 and arg_427_1.time_ < 0 + var_430_3 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.actorSpriteComps10154 then
				for iter_430_6, iter_430_7 in pairs(arg_427_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_430_7 then
						iter_430_7.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_427_1.var_.actorSpriteComps10154 = nil
			end

			local var_430_5 = arg_427_1.actors_["1094"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1094 = var_430_5.localPosition
				var_430_5.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("1094", 4)

				for iter_430_8 = 0, var_430_5.childCount - 1 do
					local var_430_6 = var_430_5:GetChild(iter_430_8)

					if var_430_6.name == "split_3" then
						var_430_6:SetAsLastSibling()
						var_430_6.gameObject:SetActive(true)

						arg_427_1.var_.actorSpriteSplit1094 = var_430_6.gameObject:GetComponent(typeof(Image))

						arg_427_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_430_7 = 0.5

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				var_430_5.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_427_1.time_ - 0) / var_430_7)

				if arg_427_1.var_.actorSpriteSplit1094 ~= nil then
					arg_427_1.var_.actorSpriteSplit1094:SetAlpha((arg_427_1.time_ - 0) / var_430_7)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				var_430_5.localPosition = Vector3.New(470, -335, -230)

				if arg_427_1.var_.actorSpriteSplit1094 ~= nil then
					arg_427_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_430_8 = 0
			local var_430_9 = 0.4

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_8 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_10 = arg_427_1:GetWordFromCfg(424031105)
				local var_430_11 = arg_427_1:FormatText(var_430_10.content)

				arg_427_1.text_.text = var_430_11

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_13 = 16 <= 0 and var_430_9 or var_430_9 * (utf8.len(var_430_11) / 16)

				if (16 <= 0 and var_430_9 or var_430_9 * (utf8.len(var_430_11) / 16)) > 0 and var_430_9 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_8 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_8
					end
				end

				arg_427_1.text_.text = var_430_11
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031105", "story_v_out_424031.awb") ~= 0 then
					local var_430_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031105", "story_v_out_424031.awb") / 1000

					if var_430_14 + var_430_8 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_8
					end

					if var_430_10.prefab_name ~= "" and arg_427_1.actors_[var_430_10.prefab_name] ~= nil then
						local var_430_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_10.prefab_name].transform, "story_v_out_424031", "424031105", "story_v_out_424031.awb")

						arg_427_1:RecordAudio("424031105", var_430_15)
						arg_427_1:RecordAudio("424031105", var_430_15)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_424031", "424031105", "story_v_out_424031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_424031", "424031105", "story_v_out_424031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_16 = math.max(var_430_9, arg_427_1.talkMaxDuration)

			if var_430_8 <= arg_427_1.time_ and arg_427_1.time_ < var_430_8 + var_430_16 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_8) / var_430_16

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_8 + var_430_16 and arg_427_1.time_ < var_430_8 + var_430_16 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play424031106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 424031106
		arg_431_1.duration_ = 2.3

		local var_431_0 = {
			zh = 2.066,
			ja = 2.3
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
				arg_431_0:Play424031107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["10154"]) and arg_431_1.var_.actorSpriteComps10154 == nil then
				arg_431_1.var_.actorSpriteComps10154 = arg_431_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["10154"]) then
				if arg_431_1.var_.actorSpriteComps10154 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["10154"]) and arg_431_1.var_.actorSpriteComps10154 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_434_3 then
						iter_434_3.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_431_1.var_.actorSpriteComps10154 = nil
			end

			local var_434_2 = arg_431_1.actors_["1094"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.actorSpriteComps1094 == nil then
				arg_431_1.var_.actorSpriteComps1094 = var_434_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_3 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_3 and not isNil(var_434_2) then
				if arg_431_1.var_.actorSpriteComps1094 then
					for iter_434_4, iter_434_5 in pairs(arg_431_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_434_5 then
							if arg_431_1.isInRecall_ then
								iter_434_5.color = Color.New(Mathf.Lerp(iter_434_5.color.r, arg_431_1.hightColor2.r, (arg_431_1.time_ - 0) / var_434_3), Mathf.Lerp(iter_434_5.color.g, arg_431_1.hightColor2.g, (arg_431_1.time_ - 0) / var_434_3), (Mathf.Lerp(iter_434_5.color.b, arg_431_1.hightColor2.b, (arg_431_1.time_ - 0) / var_434_3)))
							else
								local var_434_4 = Mathf.Lerp(iter_434_5.color.r, 0.5, (arg_431_1.time_ - 0) / var_434_3)

								iter_434_5.color = Color.New(var_434_4, var_434_4, var_434_4)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_3 and arg_431_1.time_ < 0 + var_434_3 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.actorSpriteComps1094 then
				for iter_434_6, iter_434_7 in pairs(arg_431_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_434_7 then
						iter_434_7.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_431_1.var_.actorSpriteComps1094 = nil
			end

			local var_434_5 = 0
			local var_434_6 = 0.325

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_5 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_7 = arg_431_1:GetWordFromCfg(424031106)
				local var_434_8 = arg_431_1:FormatText(var_434_7.content)

				arg_431_1.text_.text = var_434_8

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_10 = 13 <= 0 and var_434_6 or var_434_6 * (utf8.len(var_434_8) / 13)

				if (13 <= 0 and var_434_6 or var_434_6 * (utf8.len(var_434_8) / 13)) > 0 and var_434_6 < var_434_10 then
					arg_431_1.talkMaxDuration = var_434_10

					if var_434_10 + var_434_5 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_5
					end
				end

				arg_431_1.text_.text = var_434_8
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031106", "story_v_out_424031.awb") ~= 0 then
					local var_434_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031106", "story_v_out_424031.awb") / 1000

					if var_434_11 + var_434_5 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_11 + var_434_5
					end

					if var_434_7.prefab_name ~= "" and arg_431_1.actors_[var_434_7.prefab_name] ~= nil then
						local var_434_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_7.prefab_name].transform, "story_v_out_424031", "424031106", "story_v_out_424031.awb")

						arg_431_1:RecordAudio("424031106", var_434_12)
						arg_431_1:RecordAudio("424031106", var_434_12)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_424031", "424031106", "story_v_out_424031.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_424031", "424031106", "story_v_out_424031.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_13 = math.max(var_434_6, arg_431_1.talkMaxDuration)

			if var_434_5 <= arg_431_1.time_ and arg_431_1.time_ < var_434_5 + var_434_13 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_5) / var_434_13

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_5 + var_434_13 and arg_431_1.time_ < var_434_5 + var_434_13 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play424031107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 424031107
		arg_435_1.duration_ = 9.4

		local var_435_0 = {
			zh = 6.2,
			ja = 9.4
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play424031108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["10154"]) and arg_435_1.var_.actorSpriteComps10154 == nil then
				arg_435_1.var_.actorSpriteComps10154 = arg_435_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["10154"]) then
				if arg_435_1.var_.actorSpriteComps10154 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["10154"]) and arg_435_1.var_.actorSpriteComps10154 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_435_1.var_.actorSpriteComps10154 = nil
			end

			local var_438_2 = 0
			local var_438_3 = 0.925

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_4 = arg_435_1:GetWordFromCfg(424031107)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 37 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 37)

				if (37 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 37)) > 0 and var_438_3 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031107", "story_v_out_424031.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031107", "story_v_out_424031.awb") / 1000

					if var_438_8 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_2
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_out_424031", "424031107", "story_v_out_424031.awb")

						arg_435_1:RecordAudio("424031107", var_438_9)
						arg_435_1:RecordAudio("424031107", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_424031", "424031107", "story_v_out_424031.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_424031", "424031107", "story_v_out_424031.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_10 and arg_435_1.time_ < var_438_2 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play424031108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 424031108
		arg_439_1.duration_ = 1.5

		local var_439_0 = {
			zh = 1.466,
			ja = 1.5
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
				arg_439_0:Play424031109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["10154"]) and arg_439_1.var_.actorSpriteComps10154 == nil then
				arg_439_1.var_.actorSpriteComps10154 = arg_439_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_0 = 0.2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["10154"]) then
				if arg_439_1.var_.actorSpriteComps10154 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["10154"]) and arg_439_1.var_.actorSpriteComps10154 then
				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_442_3 then
						iter_442_3.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_439_1.var_.actorSpriteComps10154 = nil
			end

			local var_442_2 = arg_439_1.actors_["10154"].transform

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos10154 = var_442_2.localPosition
				var_442_2.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("10154", 2)

				for iter_442_4 = 0, var_442_2.childCount - 1 do
					local var_442_3 = var_442_2:GetChild(iter_442_4)

					if var_442_3.name == "split_1" or not string.find(var_442_3.name, "split") then
						var_442_3.gameObject:SetActive(true)
					else
						var_442_3.gameObject:SetActive(false)
					end
				end
			end

			local var_442_4 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				var_442_2.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_439_1.time_ - 0) / var_442_4)
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				var_442_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_442_5 = 0
			local var_442_6 = 0.15

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_5 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_7 = arg_439_1:GetWordFromCfg(424031108)
				local var_442_8 = arg_439_1:FormatText(var_442_7.content)

				arg_439_1.text_.text = var_442_8

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_10 = 6 <= 0 and var_442_6 or var_442_6 * (utf8.len(var_442_8) / 6)

				if (6 <= 0 and var_442_6 or var_442_6 * (utf8.len(var_442_8) / 6)) > 0 and var_442_6 < var_442_10 then
					arg_439_1.talkMaxDuration = var_442_10

					if var_442_10 + var_442_5 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_5
					end
				end

				arg_439_1.text_.text = var_442_8
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031108", "story_v_out_424031.awb") ~= 0 then
					local var_442_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031108", "story_v_out_424031.awb") / 1000

					if var_442_11 + var_442_5 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_11 + var_442_5
					end

					if var_442_7.prefab_name ~= "" and arg_439_1.actors_[var_442_7.prefab_name] ~= nil then
						local var_442_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_7.prefab_name].transform, "story_v_out_424031", "424031108", "story_v_out_424031.awb")

						arg_439_1:RecordAudio("424031108", var_442_12)
						arg_439_1:RecordAudio("424031108", var_442_12)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_424031", "424031108", "story_v_out_424031.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_424031", "424031108", "story_v_out_424031.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_13 = math.max(var_442_6, arg_439_1.talkMaxDuration)

			if var_442_5 <= arg_439_1.time_ and arg_439_1.time_ < var_442_5 + var_442_13 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_5) / var_442_13

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_5 + var_442_13 and arg_439_1.time_ < var_442_5 + var_442_13 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 424031109
		arg_443_1.duration_ = 6.77

		local var_443_0 = {
			zh = 4.266,
			ja = 6.766
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
				arg_443_0:Play424031110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["10154"]) and arg_443_1.var_.actorSpriteComps10154 == nil then
				arg_443_1.var_.actorSpriteComps10154 = arg_443_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_0 = 0.2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["10154"]) then
				if arg_443_1.var_.actorSpriteComps10154 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								iter_446_1.color = Color.New(Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor2.r, (arg_443_1.time_ - 0) / var_446_0), Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor2.g, (arg_443_1.time_ - 0) / var_446_0), (Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor2.b, (arg_443_1.time_ - 0) / var_446_0)))
							else
								local var_446_1 = Mathf.Lerp(iter_446_1.color.r, 0.5, (arg_443_1.time_ - 0) / var_446_0)

								iter_446_1.color = Color.New(var_446_1, var_446_1, var_446_1)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["10154"]) and arg_443_1.var_.actorSpriteComps10154 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_446_3 then
						iter_446_3.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_443_1.var_.actorSpriteComps10154 = nil
			end

			local var_446_2 = 0
			local var_446_3 = 0.6

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_4 = arg_443_1:GetWordFromCfg(424031109)
				local var_446_5 = arg_443_1:FormatText(var_446_4.content)

				arg_443_1.text_.text = var_446_5

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 24 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_5) / 24)

				if (24 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_5) / 24)) > 0 and var_446_3 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_2
					end
				end

				arg_443_1.text_.text = var_446_5
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031109", "story_v_out_424031.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031109", "story_v_out_424031.awb") / 1000

					if var_446_8 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_2
					end

					if var_446_4.prefab_name ~= "" and arg_443_1.actors_[var_446_4.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_4.prefab_name].transform, "story_v_out_424031", "424031109", "story_v_out_424031.awb")

						arg_443_1:RecordAudio("424031109", var_446_9)
						arg_443_1:RecordAudio("424031109", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_424031", "424031109", "story_v_out_424031.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_424031", "424031109", "story_v_out_424031.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_3, arg_443_1.talkMaxDuration)

			if var_446_2 <= arg_443_1.time_ and arg_443_1.time_ < var_446_2 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_2) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_2 + var_446_10 and arg_443_1.time_ < var_446_2 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play424031110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 424031110
		arg_447_1.duration_ = 6.13

		local var_447_0 = {
			zh = 5.166,
			ja = 6.133
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
				arg_447_0:Play424031111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["10154"]) and arg_447_1.var_.actorSpriteComps10154 == nil then
				arg_447_1.var_.actorSpriteComps10154 = arg_447_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_0 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["10154"]) then
				if arg_447_1.var_.actorSpriteComps10154 then
					for iter_450_0, iter_450_1 in pairs(arg_447_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_450_1 then
							if arg_447_1.isInRecall_ then
								iter_450_1.color = Color.New(Mathf.Lerp(iter_450_1.color.r, arg_447_1.hightColor1.r, (arg_447_1.time_ - 0) / var_450_0), Mathf.Lerp(iter_450_1.color.g, arg_447_1.hightColor1.g, (arg_447_1.time_ - 0) / var_450_0), (Mathf.Lerp(iter_450_1.color.b, arg_447_1.hightColor1.b, (arg_447_1.time_ - 0) / var_450_0)))
							else
								local var_450_1 = Mathf.Lerp(iter_450_1.color.r, 1, (arg_447_1.time_ - 0) / var_450_0)

								iter_450_1.color = Color.New(var_450_1, var_450_1, var_450_1)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["10154"]) and arg_447_1.var_.actorSpriteComps10154 then
				for iter_450_2, iter_450_3 in pairs(arg_447_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_450_3 then
						iter_450_3.color = arg_447_1.isInRecall_ and (arg_447_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_447_1.var_.actorSpriteComps10154 = nil
			end

			local var_450_2 = arg_447_1.actors_["10154"].transform

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos10154 = var_450_2.localPosition
				var_450_2.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10154", 2)

				for iter_450_4 = 0, var_450_2.childCount - 1 do
					local var_450_3 = var_450_2:GetChild(iter_450_4)

					if var_450_3.name == "" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				var_450_2.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_447_1.time_ - 0) / var_450_4)
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				var_450_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_450_5 = 0
			local var_450_6 = 0.75

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_7 = arg_447_1:GetWordFromCfg(424031110)
				local var_450_8 = arg_447_1:FormatText(var_450_7.content)

				arg_447_1.text_.text = var_450_8

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_10 = 30 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_8) / 30)

				if (30 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_8) / 30)) > 0 and var_450_6 < var_450_10 then
					arg_447_1.talkMaxDuration = var_450_10

					if var_450_10 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_5
					end
				end

				arg_447_1.text_.text = var_450_8
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031110", "story_v_out_424031.awb") ~= 0 then
					local var_450_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031110", "story_v_out_424031.awb") / 1000

					if var_450_11 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_11 + var_450_5
					end

					if var_450_7.prefab_name ~= "" and arg_447_1.actors_[var_450_7.prefab_name] ~= nil then
						local var_450_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_7.prefab_name].transform, "story_v_out_424031", "424031110", "story_v_out_424031.awb")

						arg_447_1:RecordAudio("424031110", var_450_12)
						arg_447_1:RecordAudio("424031110", var_450_12)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_424031", "424031110", "story_v_out_424031.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_424031", "424031110", "story_v_out_424031.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_13 = math.max(var_450_6, arg_447_1.talkMaxDuration)

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_13 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_5) / var_450_13

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_5 + var_450_13 and arg_447_1.time_ < var_450_5 + var_450_13 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424031111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 424031111
		arg_451_1.duration_ = 4.7

		local var_451_0 = {
			zh = 2.9,
			ja = 4.7
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
				arg_451_0:Play424031112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["10154"]) and arg_451_1.var_.actorSpriteComps10154 == nil then
				arg_451_1.var_.actorSpriteComps10154 = arg_451_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_0 = 0.2

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["10154"]) then
				if arg_451_1.var_.actorSpriteComps10154 then
					for iter_454_0, iter_454_1 in pairs(arg_451_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_454_1 then
							if arg_451_1.isInRecall_ then
								iter_454_1.color = Color.New(Mathf.Lerp(iter_454_1.color.r, arg_451_1.hightColor2.r, (arg_451_1.time_ - 0) / var_454_0), Mathf.Lerp(iter_454_1.color.g, arg_451_1.hightColor2.g, (arg_451_1.time_ - 0) / var_454_0), (Mathf.Lerp(iter_454_1.color.b, arg_451_1.hightColor2.b, (arg_451_1.time_ - 0) / var_454_0)))
							else
								local var_454_1 = Mathf.Lerp(iter_454_1.color.r, 0.5, (arg_451_1.time_ - 0) / var_454_0)

								iter_454_1.color = Color.New(var_454_1, var_454_1, var_454_1)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["10154"]) and arg_451_1.var_.actorSpriteComps10154 then
				for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_454_3 then
						iter_454_3.color = arg_451_1.isInRecall_ and (arg_451_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_451_1.var_.actorSpriteComps10154 = nil
			end

			local var_454_2 = 0
			local var_454_3 = 0.3

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_4")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_4 = arg_451_1:GetWordFromCfg(424031111)
				local var_454_5 = arg_451_1:FormatText(var_454_4.content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_7 = 12 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 12)

				if (12 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 12)) > 0 and var_454_3 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031111", "story_v_out_424031.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031111", "story_v_out_424031.awb") / 1000

					if var_454_8 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_2
					end

					if var_454_4.prefab_name ~= "" and arg_451_1.actors_[var_454_4.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_4.prefab_name].transform, "story_v_out_424031", "424031111", "story_v_out_424031.awb")

						arg_451_1:RecordAudio("424031111", var_454_9)
						arg_451_1:RecordAudio("424031111", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_424031", "424031111", "story_v_out_424031.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_424031", "424031111", "story_v_out_424031.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_10 and arg_451_1.time_ < var_454_2 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play424031112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 424031112
		arg_455_1.duration_ = 2.9

		local var_455_0 = {
			zh = 2.533,
			ja = 2.9
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
				arg_455_0:Play424031113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["10154"]) and arg_455_1.var_.actorSpriteComps10154 == nil then
				arg_455_1.var_.actorSpriteComps10154 = arg_455_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_0 = 0.2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["10154"]) then
				if arg_455_1.var_.actorSpriteComps10154 then
					for iter_458_0, iter_458_1 in pairs(arg_455_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_458_1 then
							if arg_455_1.isInRecall_ then
								iter_458_1.color = Color.New(Mathf.Lerp(iter_458_1.color.r, arg_455_1.hightColor1.r, (arg_455_1.time_ - 0) / var_458_0), Mathf.Lerp(iter_458_1.color.g, arg_455_1.hightColor1.g, (arg_455_1.time_ - 0) / var_458_0), (Mathf.Lerp(iter_458_1.color.b, arg_455_1.hightColor1.b, (arg_455_1.time_ - 0) / var_458_0)))
							else
								local var_458_1 = Mathf.Lerp(iter_458_1.color.r, 1, (arg_455_1.time_ - 0) / var_458_0)

								iter_458_1.color = Color.New(var_458_1, var_458_1, var_458_1)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["10154"]) and arg_455_1.var_.actorSpriteComps10154 then
				for iter_458_2, iter_458_3 in pairs(arg_455_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_458_3 then
						iter_458_3.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_455_1.var_.actorSpriteComps10154 = nil
			end

			local var_458_2 = arg_455_1.actors_["10154"].transform

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10154 = var_458_2.localPosition
				var_458_2.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10154", 2)

				for iter_458_4 = 0, var_458_2.childCount - 1 do
					local var_458_3 = var_458_2:GetChild(iter_458_4)

					if var_458_3.name == "split_5" then
						var_458_3:SetAsLastSibling()
						var_458_3.gameObject:SetActive(true)

						arg_455_1.var_.actorSpriteSplit10154 = var_458_3.gameObject:GetComponent(typeof(Image))

						arg_455_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_458_4 = 0.5

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				var_458_2.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_455_1.time_ - 0) / var_458_4)

				if arg_455_1.var_.actorSpriteSplit10154 ~= nil then
					arg_455_1.var_.actorSpriteSplit10154:SetAlpha((arg_455_1.time_ - 0) / var_458_4)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				var_458_2.localPosition = Vector3.New(-375, -338, -538)

				if arg_455_1.var_.actorSpriteSplit10154 ~= nil then
					arg_455_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_458_5 = 0
			local var_458_6 = 0.425

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_7 = arg_455_1:GetWordFromCfg(424031112)
				local var_458_8 = arg_455_1:FormatText(var_458_7.content)

				arg_455_1.text_.text = var_458_8

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_10 = 17 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_8) / 17)

				if (17 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_8) / 17)) > 0 and var_458_6 < var_458_10 then
					arg_455_1.talkMaxDuration = var_458_10

					if var_458_10 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_5
					end
				end

				arg_455_1.text_.text = var_458_8
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031112", "story_v_out_424031.awb") ~= 0 then
					local var_458_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031112", "story_v_out_424031.awb") / 1000

					if var_458_11 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_11 + var_458_5
					end

					if var_458_7.prefab_name ~= "" and arg_455_1.actors_[var_458_7.prefab_name] ~= nil then
						local var_458_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_7.prefab_name].transform, "story_v_out_424031", "424031112", "story_v_out_424031.awb")

						arg_455_1:RecordAudio("424031112", var_458_12)
						arg_455_1:RecordAudio("424031112", var_458_12)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_424031", "424031112", "story_v_out_424031.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_424031", "424031112", "story_v_out_424031.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_13 = math.max(var_458_6, arg_455_1.talkMaxDuration)

			if var_458_5 <= arg_455_1.time_ and arg_455_1.time_ < var_458_5 + var_458_13 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_5) / var_458_13

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_5 + var_458_13 and arg_455_1.time_ < var_458_5 + var_458_13 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play424031113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 424031113
		arg_459_1.duration_ = 5.53

		local var_459_0 = {
			zh = 2.7,
			ja = 5.533
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
				arg_459_0:Play424031114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["10155"]) and arg_459_1.var_.actorSpriteComps10155 == nil then
				arg_459_1.var_.actorSpriteComps10155 = arg_459_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_0 = 0.2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["10155"]) then
				if arg_459_1.var_.actorSpriteComps10155 then
					for iter_462_0, iter_462_1 in pairs(arg_459_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_462_1 then
							if arg_459_1.isInRecall_ then
								iter_462_1.color = Color.New(Mathf.Lerp(iter_462_1.color.r, arg_459_1.hightColor1.r, (arg_459_1.time_ - 0) / var_462_0), Mathf.Lerp(iter_462_1.color.g, arg_459_1.hightColor1.g, (arg_459_1.time_ - 0) / var_462_0), (Mathf.Lerp(iter_462_1.color.b, arg_459_1.hightColor1.b, (arg_459_1.time_ - 0) / var_462_0)))
							else
								local var_462_1 = Mathf.Lerp(iter_462_1.color.r, 1, (arg_459_1.time_ - 0) / var_462_0)

								iter_462_1.color = Color.New(var_462_1, var_462_1, var_462_1)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["10155"]) and arg_459_1.var_.actorSpriteComps10155 then
				for iter_462_2, iter_462_3 in pairs(arg_459_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_462_3 then
						iter_462_3.color = arg_459_1.isInRecall_ and (arg_459_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_459_1.var_.actorSpriteComps10155 = nil
			end

			local var_462_2 = arg_459_1.actors_["10154"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.actorSpriteComps10154 == nil then
				arg_459_1.var_.actorSpriteComps10154 = var_462_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_3 = 0.2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_3 and not isNil(var_462_2) then
				if arg_459_1.var_.actorSpriteComps10154 then
					for iter_462_4, iter_462_5 in pairs(arg_459_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_462_5 then
							if arg_459_1.isInRecall_ then
								iter_462_5.color = Color.New(Mathf.Lerp(iter_462_5.color.r, arg_459_1.hightColor2.r, (arg_459_1.time_ - 0) / var_462_3), Mathf.Lerp(iter_462_5.color.g, arg_459_1.hightColor2.g, (arg_459_1.time_ - 0) / var_462_3), (Mathf.Lerp(iter_462_5.color.b, arg_459_1.hightColor2.b, (arg_459_1.time_ - 0) / var_462_3)))
							else
								local var_462_4 = Mathf.Lerp(iter_462_5.color.r, 0.5, (arg_459_1.time_ - 0) / var_462_3)

								iter_462_5.color = Color.New(var_462_4, var_462_4, var_462_4)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= 0 + var_462_3 and arg_459_1.time_ < 0 + var_462_3 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.actorSpriteComps10154 then
				for iter_462_6, iter_462_7 in pairs(arg_459_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_462_7 then
						iter_462_7.color = arg_459_1.isInRecall_ and (arg_459_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_459_1.var_.actorSpriteComps10154 = nil
			end

			local var_462_5 = arg_459_1.actors_["10155"].transform

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos10155 = var_462_5.localPosition
				var_462_5.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10155", 4)

				for iter_462_8 = 0, var_462_5.childCount - 1 do
					local var_462_6 = var_462_5:GetChild(iter_462_8)

					if var_462_6.name == "split_5" then
						var_462_6:SetAsLastSibling()
						var_462_6.gameObject:SetActive(true)

						arg_459_1.var_.actorSpriteSplit10155 = var_462_6.gameObject:GetComponent(typeof(Image))

						arg_459_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_462_7 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_7 then
				var_462_5.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_459_1.time_ - 0) / var_462_7)

				if arg_459_1.var_.actorSpriteSplit10155 ~= nil then
					arg_459_1.var_.actorSpriteSplit10155:SetAlpha((arg_459_1.time_ - 0) / var_462_7)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_7 and arg_459_1.time_ < 0 + var_462_7 + arg_462_0 then
				var_462_5.localPosition = Vector3.New(440, -390, -250)

				if arg_459_1.var_.actorSpriteSplit10155 ~= nil then
					arg_459_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_462_8 = arg_459_1.actors_["1094"].transform

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos1094 = var_462_8.localPosition
				var_462_8.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("1094", 7)

				for iter_462_9 = 0, var_462_8.childCount - 1 do
					local var_462_9 = var_462_8:GetChild(iter_462_9)

					if var_462_9.name == "" or not string.find(var_462_9.name, "split") then
						var_462_9.gameObject:SetActive(true)
					else
						var_462_9.gameObject:SetActive(false)
					end
				end
			end

			local var_462_10 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_10 then
				var_462_8.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_459_1.time_ - 0) / var_462_10)
			end

			if arg_459_1.time_ >= 0 + var_462_10 and arg_459_1.time_ < 0 + var_462_10 + arg_462_0 then
				var_462_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_462_11 = 0
			local var_462_12 = 0.225

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_11 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_13 = arg_459_1:GetWordFromCfg(424031113)
				local var_462_14 = arg_459_1:FormatText(var_462_13.content)

				arg_459_1.text_.text = var_462_14

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_16 = 9 <= 0 and var_462_12 or var_462_12 * (utf8.len(var_462_14) / 9)

				if (9 <= 0 and var_462_12 or var_462_12 * (utf8.len(var_462_14) / 9)) > 0 and var_462_12 < var_462_16 then
					arg_459_1.talkMaxDuration = var_462_16

					if var_462_16 + var_462_11 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_16 + var_462_11
					end
				end

				arg_459_1.text_.text = var_462_14
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031113", "story_v_out_424031.awb") ~= 0 then
					local var_462_17 = manager.audio:GetVoiceLength("story_v_out_424031", "424031113", "story_v_out_424031.awb") / 1000

					if var_462_17 + var_462_11 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_17 + var_462_11
					end

					if var_462_13.prefab_name ~= "" and arg_459_1.actors_[var_462_13.prefab_name] ~= nil then
						local var_462_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_13.prefab_name].transform, "story_v_out_424031", "424031113", "story_v_out_424031.awb")

						arg_459_1:RecordAudio("424031113", var_462_18)
						arg_459_1:RecordAudio("424031113", var_462_18)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_424031", "424031113", "story_v_out_424031.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_424031", "424031113", "story_v_out_424031.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_19 = math.max(var_462_12, arg_459_1.talkMaxDuration)

			if var_462_11 <= arg_459_1.time_ and arg_459_1.time_ < var_462_11 + var_462_19 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_11) / var_462_19

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_11 + var_462_19 and arg_459_1.time_ < var_462_11 + var_462_19 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play424031114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 424031114
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play424031115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["10155"]) and arg_463_1.var_.actorSpriteComps10155 == nil then
				arg_463_1.var_.actorSpriteComps10155 = arg_463_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_0 = 0.2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["10155"]) then
				if arg_463_1.var_.actorSpriteComps10155 then
					for iter_466_0, iter_466_1 in pairs(arg_463_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_466_1 then
							if arg_463_1.isInRecall_ then
								iter_466_1.color = Color.New(Mathf.Lerp(iter_466_1.color.r, arg_463_1.hightColor2.r, (arg_463_1.time_ - 0) / var_466_0), Mathf.Lerp(iter_466_1.color.g, arg_463_1.hightColor2.g, (arg_463_1.time_ - 0) / var_466_0), (Mathf.Lerp(iter_466_1.color.b, arg_463_1.hightColor2.b, (arg_463_1.time_ - 0) / var_466_0)))
							else
								local var_466_1 = Mathf.Lerp(iter_466_1.color.r, 0.5, (arg_463_1.time_ - 0) / var_466_0)

								iter_466_1.color = Color.New(var_466_1, var_466_1, var_466_1)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["10155"]) and arg_463_1.var_.actorSpriteComps10155 then
				for iter_466_2, iter_466_3 in pairs(arg_463_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_466_3 then
						iter_466_3.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_463_1.var_.actorSpriteComps10155 = nil
			end

			local var_466_2 = arg_463_1.actors_["10155"].transform

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos10155 = var_466_2.localPosition
				var_466_2.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10155", 7)

				for iter_466_4 = 0, var_466_2.childCount - 1 do
					local var_466_3 = var_466_2:GetChild(iter_466_4)

					if var_466_3.name == "" or not string.find(var_466_3.name, "split") then
						var_466_3.gameObject:SetActive(true)
					else
						var_466_3.gameObject:SetActive(false)
					end
				end
			end

			local var_466_4 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				var_466_2.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_463_1.time_ - 0) / var_466_4)
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				var_466_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_466_5 = arg_463_1.actors_["10154"].transform

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos10154 = var_466_5.localPosition
				var_466_5.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10154", 7)

				for iter_466_5 = 0, var_466_5.childCount - 1 do
					local var_466_6 = var_466_5:GetChild(iter_466_5)

					if var_466_6.name == "" or not string.find(var_466_6.name, "split") then
						var_466_6.gameObject:SetActive(true)
					else
						var_466_6.gameObject:SetActive(false)
					end
				end
			end

			local var_466_7 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 then
				var_466_5.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_463_1.time_ - 0) / var_466_7)
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 then
				var_466_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_466_8 = 0
			local var_466_9 = 0.725

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_8 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_10 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(424031114).content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_12 = 29 <= 0 and var_466_9 or var_466_9 * (utf8.len(var_466_10) / 29)

				if (29 <= 0 and var_466_9 or var_466_9 * (utf8.len(var_466_10) / 29)) > 0 and var_466_9 < var_466_12 then
					arg_463_1.talkMaxDuration = var_466_12

					if var_466_12 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_12 + var_466_8
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_13 = math.max(var_466_9, arg_463_1.talkMaxDuration)

			if var_466_8 <= arg_463_1.time_ and arg_463_1.time_ < var_466_8 + var_466_13 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_8) / var_466_13

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_8 + var_466_13 and arg_463_1.time_ < var_466_8 + var_466_13 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play424031115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 424031115
		arg_467_1.duration_ = 3.73

		local var_467_0 = {
			zh = 3.166,
			ja = 3.733
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
				arg_467_0:Play424031116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["10154"]) and arg_467_1.var_.actorSpriteComps10154 == nil then
				arg_467_1.var_.actorSpriteComps10154 = arg_467_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_0 = 0.2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["10154"]) then
				if arg_467_1.var_.actorSpriteComps10154 then
					for iter_470_0, iter_470_1 in pairs(arg_467_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_470_1 then
							if arg_467_1.isInRecall_ then
								iter_470_1.color = Color.New(Mathf.Lerp(iter_470_1.color.r, arg_467_1.hightColor1.r, (arg_467_1.time_ - 0) / var_470_0), Mathf.Lerp(iter_470_1.color.g, arg_467_1.hightColor1.g, (arg_467_1.time_ - 0) / var_470_0), (Mathf.Lerp(iter_470_1.color.b, arg_467_1.hightColor1.b, (arg_467_1.time_ - 0) / var_470_0)))
							else
								local var_470_1 = Mathf.Lerp(iter_470_1.color.r, 1, (arg_467_1.time_ - 0) / var_470_0)

								iter_470_1.color = Color.New(var_470_1, var_470_1, var_470_1)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["10154"]) and arg_467_1.var_.actorSpriteComps10154 then
				for iter_470_2, iter_470_3 in pairs(arg_467_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_470_3 then
						iter_470_3.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_467_1.var_.actorSpriteComps10154 = nil
			end

			local var_470_2 = arg_467_1.actors_["10154"].transform

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos10154 = var_470_2.localPosition
				var_470_2.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("10154", 2)

				for iter_470_4 = 0, var_470_2.childCount - 1 do
					local var_470_3 = var_470_2:GetChild(iter_470_4)

					if var_470_3.name == "split_1" or not string.find(var_470_3.name, "split") then
						var_470_3.gameObject:SetActive(true)
					else
						var_470_3.gameObject:SetActive(false)
					end
				end
			end

			local var_470_4 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				var_470_2.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_467_1.time_ - 0) / var_470_4)
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				var_470_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_470_5 = 0
			local var_470_6 = 0.35

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_5 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_7 = arg_467_1:GetWordFromCfg(424031115)
				local var_470_8 = arg_467_1:FormatText(var_470_7.content)

				arg_467_1.text_.text = var_470_8

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_10 = 14 <= 0 and var_470_6 or var_470_6 * (utf8.len(var_470_8) / 14)

				if (14 <= 0 and var_470_6 or var_470_6 * (utf8.len(var_470_8) / 14)) > 0 and var_470_6 < var_470_10 then
					arg_467_1.talkMaxDuration = var_470_10

					if var_470_10 + var_470_5 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_5
					end
				end

				arg_467_1.text_.text = var_470_8
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031115", "story_v_out_424031.awb") ~= 0 then
					local var_470_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031115", "story_v_out_424031.awb") / 1000

					if var_470_11 + var_470_5 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_11 + var_470_5
					end

					if var_470_7.prefab_name ~= "" and arg_467_1.actors_[var_470_7.prefab_name] ~= nil then
						local var_470_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_7.prefab_name].transform, "story_v_out_424031", "424031115", "story_v_out_424031.awb")

						arg_467_1:RecordAudio("424031115", var_470_12)
						arg_467_1:RecordAudio("424031115", var_470_12)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_424031", "424031115", "story_v_out_424031.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_424031", "424031115", "story_v_out_424031.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_13 = math.max(var_470_6, arg_467_1.talkMaxDuration)

			if var_470_5 <= arg_467_1.time_ and arg_467_1.time_ < var_470_5 + var_470_13 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_5) / var_470_13

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_5 + var_470_13 and arg_467_1.time_ < var_470_5 + var_470_13 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play424031116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 424031116
		arg_471_1.duration_ = 3.27

		local var_471_0 = {
			zh = 2.766,
			ja = 3.266
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
				arg_471_0:Play424031117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["10155"]) and arg_471_1.var_.actorSpriteComps10155 == nil then
				arg_471_1.var_.actorSpriteComps10155 = arg_471_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_0 = 0.2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["10155"]) then
				if arg_471_1.var_.actorSpriteComps10155 then
					for iter_474_0, iter_474_1 in pairs(arg_471_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_474_1 then
							if arg_471_1.isInRecall_ then
								iter_474_1.color = Color.New(Mathf.Lerp(iter_474_1.color.r, arg_471_1.hightColor1.r, (arg_471_1.time_ - 0) / var_474_0), Mathf.Lerp(iter_474_1.color.g, arg_471_1.hightColor1.g, (arg_471_1.time_ - 0) / var_474_0), (Mathf.Lerp(iter_474_1.color.b, arg_471_1.hightColor1.b, (arg_471_1.time_ - 0) / var_474_0)))
							else
								local var_474_1 = Mathf.Lerp(iter_474_1.color.r, 1, (arg_471_1.time_ - 0) / var_474_0)

								iter_474_1.color = Color.New(var_474_1, var_474_1, var_474_1)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["10155"]) and arg_471_1.var_.actorSpriteComps10155 then
				for iter_474_2, iter_474_3 in pairs(arg_471_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_474_3 then
						iter_474_3.color = arg_471_1.isInRecall_ and (arg_471_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_471_1.var_.actorSpriteComps10155 = nil
			end

			local var_474_2 = arg_471_1.actors_["10154"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_2) and arg_471_1.var_.actorSpriteComps10154 == nil then
				arg_471_1.var_.actorSpriteComps10154 = var_474_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_3 = 0.2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_3 and not isNil(var_474_2) then
				if arg_471_1.var_.actorSpriteComps10154 then
					for iter_474_4, iter_474_5 in pairs(arg_471_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_474_5 then
							if arg_471_1.isInRecall_ then
								iter_474_5.color = Color.New(Mathf.Lerp(iter_474_5.color.r, arg_471_1.hightColor2.r, (arg_471_1.time_ - 0) / var_474_3), Mathf.Lerp(iter_474_5.color.g, arg_471_1.hightColor2.g, (arg_471_1.time_ - 0) / var_474_3), (Mathf.Lerp(iter_474_5.color.b, arg_471_1.hightColor2.b, (arg_471_1.time_ - 0) / var_474_3)))
							else
								local var_474_4 = Mathf.Lerp(iter_474_5.color.r, 0.5, (arg_471_1.time_ - 0) / var_474_3)

								iter_474_5.color = Color.New(var_474_4, var_474_4, var_474_4)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= 0 + var_474_3 and arg_471_1.time_ < 0 + var_474_3 + arg_474_0 and not isNil(var_474_2) and arg_471_1.var_.actorSpriteComps10154 then
				for iter_474_6, iter_474_7 in pairs(arg_471_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_474_7 then
						iter_474_7.color = arg_471_1.isInRecall_ and (arg_471_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_471_1.var_.actorSpriteComps10154 = nil
			end

			local var_474_5 = arg_471_1.actors_["10155"].transform

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos10155 = var_474_5.localPosition
				var_474_5.localScale = Vector3.New(1, 1, 1)

				arg_471_1:CheckSpriteTmpPos("10155", 4)

				for iter_474_8 = 0, var_474_5.childCount - 1 do
					local var_474_6 = var_474_5:GetChild(iter_474_8)

					if var_474_6.name == "" or not string.find(var_474_6.name, "split") then
						var_474_6.gameObject:SetActive(true)
					else
						var_474_6.gameObject:SetActive(false)
					end
				end
			end

			local var_474_7 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				var_474_5.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_471_1.time_ - 0) / var_474_7)
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				var_474_5.localPosition = Vector3.New(440, -390, -250)
			end

			local var_474_8 = 0
			local var_474_9 = 0.175

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_8 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_10 = arg_471_1:GetWordFromCfg(424031116)
				local var_474_11 = arg_471_1:FormatText(var_474_10.content)

				arg_471_1.text_.text = var_474_11

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_13 = 7 <= 0 and var_474_9 or var_474_9 * (utf8.len(var_474_11) / 7)

				if (7 <= 0 and var_474_9 or var_474_9 * (utf8.len(var_474_11) / 7)) > 0 and var_474_9 < var_474_13 then
					arg_471_1.talkMaxDuration = var_474_13

					if var_474_13 + var_474_8 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_8
					end
				end

				arg_471_1.text_.text = var_474_11
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031116", "story_v_out_424031.awb") ~= 0 then
					local var_474_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031116", "story_v_out_424031.awb") / 1000

					if var_474_14 + var_474_8 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_14 + var_474_8
					end

					if var_474_10.prefab_name ~= "" and arg_471_1.actors_[var_474_10.prefab_name] ~= nil then
						local var_474_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_10.prefab_name].transform, "story_v_out_424031", "424031116", "story_v_out_424031.awb")

						arg_471_1:RecordAudio("424031116", var_474_15)
						arg_471_1:RecordAudio("424031116", var_474_15)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_424031", "424031116", "story_v_out_424031.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_424031", "424031116", "story_v_out_424031.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_16 = math.max(var_474_9, arg_471_1.talkMaxDuration)

			if var_474_8 <= arg_471_1.time_ and arg_471_1.time_ < var_474_8 + var_474_16 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_8) / var_474_16

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_8 + var_474_16 and arg_471_1.time_ < var_474_8 + var_474_16 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play424031117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 424031117
		arg_475_1.duration_ = 6.87

		local var_475_0 = {
			zh = 5.833,
			ja = 6.866
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
				arg_475_0:Play424031118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1094"]) and arg_475_1.var_.actorSpriteComps1094 == nil then
				arg_475_1.var_.actorSpriteComps1094 = arg_475_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_0 = 0.2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1094"]) then
				if arg_475_1.var_.actorSpriteComps1094 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								iter_478_1.color = Color.New(Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, (arg_475_1.time_ - 0) / var_478_0), Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, (arg_475_1.time_ - 0) / var_478_0), (Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, (arg_475_1.time_ - 0) / var_478_0)))
							else
								local var_478_1 = Mathf.Lerp(iter_478_1.color.r, 1, (arg_475_1.time_ - 0) / var_478_0)

								iter_478_1.color = Color.New(var_478_1, var_478_1, var_478_1)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1094"]) and arg_475_1.var_.actorSpriteComps1094 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_478_3 then
						iter_478_3.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps1094 = nil
			end

			local var_478_2 = arg_475_1.actors_["10155"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_2) and arg_475_1.var_.actorSpriteComps10155 == nil then
				arg_475_1.var_.actorSpriteComps10155 = var_478_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_3 = 0.2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_3 and not isNil(var_478_2) then
				if arg_475_1.var_.actorSpriteComps10155 then
					for iter_478_4, iter_478_5 in pairs(arg_475_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_478_5 then
							if arg_475_1.isInRecall_ then
								iter_478_5.color = Color.New(Mathf.Lerp(iter_478_5.color.r, arg_475_1.hightColor2.r, (arg_475_1.time_ - 0) / var_478_3), Mathf.Lerp(iter_478_5.color.g, arg_475_1.hightColor2.g, (arg_475_1.time_ - 0) / var_478_3), (Mathf.Lerp(iter_478_5.color.b, arg_475_1.hightColor2.b, (arg_475_1.time_ - 0) / var_478_3)))
							else
								local var_478_4 = Mathf.Lerp(iter_478_5.color.r, 0.5, (arg_475_1.time_ - 0) / var_478_3)

								iter_478_5.color = Color.New(var_478_4, var_478_4, var_478_4)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_3 and arg_475_1.time_ < 0 + var_478_3 + arg_478_0 and not isNil(var_478_2) and arg_475_1.var_.actorSpriteComps10155 then
				for iter_478_6, iter_478_7 in pairs(arg_475_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_478_7 then
						iter_478_7.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_475_1.var_.actorSpriteComps10155 = nil
			end

			local var_478_5 = arg_475_1.actors_["1094"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1094 = var_478_5.localPosition
				var_478_5.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("1094", 3)

				for iter_478_8 = 0, var_478_5.childCount - 1 do
					local var_478_6 = var_478_5:GetChild(iter_478_8)

					if var_478_6.name == "split_1" or not string.find(var_478_6.name, "split") then
						var_478_6.gameObject:SetActive(true)
					else
						var_478_6.gameObject:SetActive(false)
					end
				end
			end

			local var_478_7 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_7 then
				var_478_5.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_475_1.time_ - 0) / var_478_7)
			end

			if arg_475_1.time_ >= 0 + var_478_7 and arg_475_1.time_ < 0 + var_478_7 + arg_478_0 then
				var_478_5.localPosition = Vector3.New(0, -335, -230)
			end

			local var_478_8 = arg_475_1.actors_["10155"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10155 = var_478_8.localPosition
				var_478_8.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10155", 7)

				for iter_478_9 = 0, var_478_8.childCount - 1 do
					local var_478_9 = var_478_8:GetChild(iter_478_9)

					if var_478_9.name == "" or not string.find(var_478_9.name, "split") then
						var_478_9.gameObject:SetActive(true)
					else
						var_478_9.gameObject:SetActive(false)
					end
				end
			end

			local var_478_10 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_10 then
				var_478_8.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_475_1.time_ - 0) / var_478_10)
			end

			if arg_475_1.time_ >= 0 + var_478_10 and arg_475_1.time_ < 0 + var_478_10 + arg_478_0 then
				var_478_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_478_11 = arg_475_1.actors_["10154"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10154 = var_478_11.localPosition
				var_478_11.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10154", 7)

				for iter_478_10 = 0, var_478_11.childCount - 1 do
					local var_478_12 = var_478_11:GetChild(iter_478_10)

					if var_478_12.name == "" or not string.find(var_478_12.name, "split") then
						var_478_12.gameObject:SetActive(true)
					else
						var_478_12.gameObject:SetActive(false)
					end
				end
			end

			local var_478_13 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_13 then
				var_478_11.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_475_1.time_ - 0) / var_478_13)
			end

			if arg_475_1.time_ >= 0 + var_478_13 and arg_475_1.time_ < 0 + var_478_13 + arg_478_0 then
				var_478_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_478_14 = 0
			local var_478_15 = 0.6

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_14 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_16 = arg_475_1:GetWordFromCfg(424031117)
				local var_478_17 = arg_475_1:FormatText(var_478_16.content)

				arg_475_1.text_.text = var_478_17

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_19 = 24 <= 0 and var_478_15 or var_478_15 * (utf8.len(var_478_17) / 24)

				if (24 <= 0 and var_478_15 or var_478_15 * (utf8.len(var_478_17) / 24)) > 0 and var_478_15 < var_478_19 then
					arg_475_1.talkMaxDuration = var_478_19

					if var_478_19 + var_478_14 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_19 + var_478_14
					end
				end

				arg_475_1.text_.text = var_478_17
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031117", "story_v_out_424031.awb") ~= 0 then
					local var_478_20 = manager.audio:GetVoiceLength("story_v_out_424031", "424031117", "story_v_out_424031.awb") / 1000

					if var_478_20 + var_478_14 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_20 + var_478_14
					end

					if var_478_16.prefab_name ~= "" and arg_475_1.actors_[var_478_16.prefab_name] ~= nil then
						local var_478_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_16.prefab_name].transform, "story_v_out_424031", "424031117", "story_v_out_424031.awb")

						arg_475_1:RecordAudio("424031117", var_478_21)
						arg_475_1:RecordAudio("424031117", var_478_21)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_424031", "424031117", "story_v_out_424031.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_424031", "424031117", "story_v_out_424031.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_22 = math.max(var_478_15, arg_475_1.talkMaxDuration)

			if var_478_14 <= arg_475_1.time_ and arg_475_1.time_ < var_478_14 + var_478_22 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_14) / var_478_22

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_14 + var_478_22 and arg_475_1.time_ < var_478_14 + var_478_22 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play424031118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 424031118
		arg_479_1.duration_ = 4.53

		local var_479_0 = {
			zh = 3.2,
			ja = 4.533
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
				arg_479_0:Play424031119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1094"]) and arg_479_1.var_.actorSpriteComps1094 == nil then
				arg_479_1.var_.actorSpriteComps1094 = arg_479_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_0 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1094"]) then
				if arg_479_1.var_.actorSpriteComps1094 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								iter_482_1.color = Color.New(Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor2.r, (arg_479_1.time_ - 0) / var_482_0), Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor2.g, (arg_479_1.time_ - 0) / var_482_0), (Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor2.b, (arg_479_1.time_ - 0) / var_482_0)))
							else
								local var_482_1 = Mathf.Lerp(iter_482_1.color.r, 0.5, (arg_479_1.time_ - 0) / var_482_0)

								iter_482_1.color = Color.New(var_482_1, var_482_1, var_482_1)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1094"]) and arg_479_1.var_.actorSpriteComps1094 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_482_3 then
						iter_482_3.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_479_1.var_.actorSpriteComps1094 = nil
			end

			local var_482_2 = 0
			local var_482_3 = 0.4

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_2 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_4 = arg_479_1:GetWordFromCfg(424031118)
				local var_482_5 = arg_479_1:FormatText(var_482_4.content)

				arg_479_1.text_.text = var_482_5

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_7 = 16 <= 0 and var_482_3 or var_482_3 * (utf8.len(var_482_5) / 16)

				if (16 <= 0 and var_482_3 or var_482_3 * (utf8.len(var_482_5) / 16)) > 0 and var_482_3 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_2 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_2
					end
				end

				arg_479_1.text_.text = var_482_5
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031118", "story_v_out_424031.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031118", "story_v_out_424031.awb") / 1000

					if var_482_8 + var_482_2 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_2
					end

					if var_482_4.prefab_name ~= "" and arg_479_1.actors_[var_482_4.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_4.prefab_name].transform, "story_v_out_424031", "424031118", "story_v_out_424031.awb")

						arg_479_1:RecordAudio("424031118", var_482_9)
						arg_479_1:RecordAudio("424031118", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_424031", "424031118", "story_v_out_424031.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_424031", "424031118", "story_v_out_424031.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_3, arg_479_1.talkMaxDuration)

			if var_482_2 <= arg_479_1.time_ and arg_479_1.time_ < var_482_2 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_2) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_2 + var_482_10 and arg_479_1.time_ < var_482_2 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play424031119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 424031119
		arg_483_1.duration_ = 3.03

		local var_483_0 = {
			zh = 2.733,
			ja = 3.033
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play424031120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1094"]) and arg_483_1.var_.actorSpriteComps1094 == nil then
				arg_483_1.var_.actorSpriteComps1094 = arg_483_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_0 = 0.2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1094"]) then
				if arg_483_1.var_.actorSpriteComps1094 then
					for iter_486_0, iter_486_1 in pairs(arg_483_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_486_1 then
							if arg_483_1.isInRecall_ then
								iter_486_1.color = Color.New(Mathf.Lerp(iter_486_1.color.r, arg_483_1.hightColor1.r, (arg_483_1.time_ - 0) / var_486_0), Mathf.Lerp(iter_486_1.color.g, arg_483_1.hightColor1.g, (arg_483_1.time_ - 0) / var_486_0), (Mathf.Lerp(iter_486_1.color.b, arg_483_1.hightColor1.b, (arg_483_1.time_ - 0) / var_486_0)))
							else
								local var_486_1 = Mathf.Lerp(iter_486_1.color.r, 1, (arg_483_1.time_ - 0) / var_486_0)

								iter_486_1.color = Color.New(var_486_1, var_486_1, var_486_1)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1094"]) and arg_483_1.var_.actorSpriteComps1094 then
				for iter_486_2, iter_486_3 in pairs(arg_483_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_486_3 then
						iter_486_3.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_483_1.var_.actorSpriteComps1094 = nil
			end

			local var_486_2 = 0
			local var_486_3 = 0.225

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_4 = arg_483_1:GetWordFromCfg(424031119)
				local var_486_5 = arg_483_1:FormatText(var_486_4.content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 9 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 9)

				if (9 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 9)) > 0 and var_486_3 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_2
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031119", "story_v_out_424031.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031119", "story_v_out_424031.awb") / 1000

					if var_486_8 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_2
					end

					if var_486_4.prefab_name ~= "" and arg_483_1.actors_[var_486_4.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_4.prefab_name].transform, "story_v_out_424031", "424031119", "story_v_out_424031.awb")

						arg_483_1:RecordAudio("424031119", var_486_9)
						arg_483_1:RecordAudio("424031119", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_424031", "424031119", "story_v_out_424031.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_424031", "424031119", "story_v_out_424031.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_3, arg_483_1.talkMaxDuration)

			if var_486_2 <= arg_483_1.time_ and arg_483_1.time_ < var_486_2 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_2) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_2 + var_486_10 and arg_483_1.time_ < var_486_2 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play424031120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 424031120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play424031121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1094"]) and arg_487_1.var_.actorSpriteComps1094 == nil then
				arg_487_1.var_.actorSpriteComps1094 = arg_487_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_0 = 0.2

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1094"]) then
				if arg_487_1.var_.actorSpriteComps1094 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_490_1 then
							if arg_487_1.isInRecall_ then
								iter_490_1.color = Color.New(Mathf.Lerp(iter_490_1.color.r, arg_487_1.hightColor2.r, (arg_487_1.time_ - 0) / var_490_0), Mathf.Lerp(iter_490_1.color.g, arg_487_1.hightColor2.g, (arg_487_1.time_ - 0) / var_490_0), (Mathf.Lerp(iter_490_1.color.b, arg_487_1.hightColor2.b, (arg_487_1.time_ - 0) / var_490_0)))
							else
								local var_490_1 = Mathf.Lerp(iter_490_1.color.r, 0.5, (arg_487_1.time_ - 0) / var_490_0)

								iter_490_1.color = Color.New(var_490_1, var_490_1, var_490_1)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1094"]) and arg_487_1.var_.actorSpriteComps1094 then
				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_490_3 then
						iter_490_3.color = arg_487_1.isInRecall_ and (arg_487_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_487_1.var_.actorSpriteComps1094 = nil
			end

			local var_490_2 = 0
			local var_490_3 = 0.8

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_2 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_4 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(424031120).content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_6 = 32 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_4) / 32)

				if (32 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_4) / 32)) > 0 and var_490_3 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_2
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_3, arg_487_1.talkMaxDuration)

			if var_490_2 <= arg_487_1.time_ and arg_487_1.time_ < var_490_2 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_2) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_2 + var_490_7 and arg_487_1.time_ < var_490_2 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play424031121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 424031121
		arg_491_1.duration_ = 14

		local var_491_0 = {
			zh = 7.6,
			ja = 14
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
				arg_491_0:Play424031122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["10155"]) and arg_491_1.var_.actorSpriteComps10155 == nil then
				arg_491_1.var_.actorSpriteComps10155 = arg_491_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_0 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["10155"]) then
				if arg_491_1.var_.actorSpriteComps10155 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["10155"]) and arg_491_1.var_.actorSpriteComps10155 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_494_3 then
						iter_494_3.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps10155 = nil
			end

			local var_494_2 = arg_491_1.actors_["10155"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10155 = var_494_2.localPosition
				var_494_2.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10155", 4)

				for iter_494_4 = 0, var_494_2.childCount - 1 do
					local var_494_3 = var_494_2:GetChild(iter_494_4)

					if var_494_3.name == "split_1" or not string.find(var_494_3.name, "split") then
						var_494_3.gameObject:SetActive(true)
					else
						var_494_3.gameObject:SetActive(false)
					end
				end
			end

			local var_494_4 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				var_494_2.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_491_1.time_ - 0) / var_494_4)
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				var_494_2.localPosition = Vector3.New(440, -390, -250)
			end

			local var_494_5 = arg_491_1.actors_["1094"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1094 = var_494_5.localPosition
				var_494_5.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("1094", 2)

				for iter_494_5 = 0, var_494_5.childCount - 1 do
					local var_494_6 = var_494_5:GetChild(iter_494_5)

					if var_494_6.name == "" or not string.find(var_494_6.name, "split") then
						var_494_6.gameObject:SetActive(true)
					else
						var_494_6.gameObject:SetActive(false)
					end
				end
			end

			local var_494_7 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				var_494_5.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_491_1.time_ - 0) / var_494_7)
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				var_494_5.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_494_8 = 0
			local var_494_9 = 0.925

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_10 = arg_491_1:GetWordFromCfg(424031121)
				local var_494_11 = arg_491_1:FormatText(var_494_10.content)

				arg_491_1.text_.text = var_494_11

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_13 = 37 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 37)

				if (37 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 37)) > 0 and var_494_9 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_8
					end
				end

				arg_491_1.text_.text = var_494_11
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031121", "story_v_out_424031.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031121", "story_v_out_424031.awb") / 1000

					if var_494_14 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_8
					end

					if var_494_10.prefab_name ~= "" and arg_491_1.actors_[var_494_10.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_10.prefab_name].transform, "story_v_out_424031", "424031121", "story_v_out_424031.awb")

						arg_491_1:RecordAudio("424031121", var_494_15)
						arg_491_1:RecordAudio("424031121", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_424031", "424031121", "story_v_out_424031.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_424031", "424031121", "story_v_out_424031.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_16 = math.max(var_494_9, arg_491_1.talkMaxDuration)

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_16 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_8) / var_494_16

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_8 + var_494_16 and arg_491_1.time_ < var_494_8 + var_494_16 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 424031122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play424031123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["10155"]) and arg_495_1.var_.actorSpriteComps10155 == nil then
				arg_495_1.var_.actorSpriteComps10155 = arg_495_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_0 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["10155"]) then
				if arg_495_1.var_.actorSpriteComps10155 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								iter_498_1.color = Color.New(Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_0), Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_0), (Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_0)))
							else
								local var_498_1 = Mathf.Lerp(iter_498_1.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_0)

								iter_498_1.color = Color.New(var_498_1, var_498_1, var_498_1)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["10155"]) and arg_495_1.var_.actorSpriteComps10155 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps10155 = nil
			end

			local var_498_2 = 0
			local var_498_3 = 0.55

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_4 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(424031122).content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_6 = 22 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_4) / 22)

				if (22 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_4) / 22)) > 0 and var_498_3 < var_498_6 then
					arg_495_1.talkMaxDuration = var_498_6

					if var_498_6 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_6 + var_498_2
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_3, arg_495_1.talkMaxDuration)

			if var_498_2 <= arg_495_1.time_ and arg_495_1.time_ < var_498_2 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_2) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_2 + var_498_7 and arg_495_1.time_ < var_498_2 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play424031123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 424031123
		arg_499_1.duration_ = 2.3

		local var_499_0 = {
			zh = 2.233,
			ja = 2.3
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
				arg_499_0:Play424031124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.3

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_1 = arg_499_1:GetWordFromCfg(424031123)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 12 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 12)

				if (12 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 12)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031123", "story_v_out_424031.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031123", "story_v_out_424031.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_424031", "424031123", "story_v_out_424031.awb")

						arg_499_1:RecordAudio("424031123", var_502_6)
						arg_499_1:RecordAudio("424031123", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_424031", "424031123", "story_v_out_424031.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_424031", "424031123", "story_v_out_424031.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play424031124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 424031124
		arg_503_1.duration_ = 7.03

		local var_503_0 = {
			zh = 4.9,
			ja = 7.033
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play424031125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["10154"]) and arg_503_1.var_.actorSpriteComps10154 == nil then
				arg_503_1.var_.actorSpriteComps10154 = arg_503_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_0 = 0.2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["10154"]) then
				if arg_503_1.var_.actorSpriteComps10154 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								iter_506_1.color = Color.New(Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor1.r, (arg_503_1.time_ - 0) / var_506_0), Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor1.g, (arg_503_1.time_ - 0) / var_506_0), (Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor1.b, (arg_503_1.time_ - 0) / var_506_0)))
							else
								local var_506_1 = Mathf.Lerp(iter_506_1.color.r, 1, (arg_503_1.time_ - 0) / var_506_0)

								iter_506_1.color = Color.New(var_506_1, var_506_1, var_506_1)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["10154"]) and arg_503_1.var_.actorSpriteComps10154 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_506_3 then
						iter_506_3.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_503_1.var_.actorSpriteComps10154 = nil
			end

			local var_506_2 = arg_503_1.actors_["10154"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10154 = var_506_2.localPosition
				var_506_2.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10154", 2)

				for iter_506_4 = 0, var_506_2.childCount - 1 do
					local var_506_3 = var_506_2:GetChild(iter_506_4)

					if var_506_3.name == "split_1" or not string.find(var_506_3.name, "split") then
						var_506_3.gameObject:SetActive(true)
					else
						var_506_3.gameObject:SetActive(false)
					end
				end
			end

			local var_506_4 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				var_506_2.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_503_1.time_ - 0) / var_506_4)
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				var_506_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_506_5 = arg_503_1.actors_["1094"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos1094 = var_506_5.localPosition
				var_506_5.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("1094", 7)

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
				var_506_5.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_503_1.time_ - 0) / var_506_7)
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				var_506_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_506_8 = 0
			local var_506_9 = 0.75

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_8 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_10 = arg_503_1:GetWordFromCfg(424031124)
				local var_506_11 = arg_503_1:FormatText(var_506_10.content)

				arg_503_1.text_.text = var_506_11

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_13 = 30 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_11) / 30)

				if (30 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_11) / 30)) > 0 and var_506_9 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_8
					end
				end

				arg_503_1.text_.text = var_506_11
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031124", "story_v_out_424031.awb") ~= 0 then
					local var_506_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031124", "story_v_out_424031.awb") / 1000

					if var_506_14 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_14 + var_506_8
					end

					if var_506_10.prefab_name ~= "" and arg_503_1.actors_[var_506_10.prefab_name] ~= nil then
						local var_506_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_10.prefab_name].transform, "story_v_out_424031", "424031124", "story_v_out_424031.awb")

						arg_503_1:RecordAudio("424031124", var_506_15)
						arg_503_1:RecordAudio("424031124", var_506_15)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_424031", "424031124", "story_v_out_424031.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_424031", "424031124", "story_v_out_424031.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_16 = math.max(var_506_9, arg_503_1.talkMaxDuration)

			if var_506_8 <= arg_503_1.time_ and arg_503_1.time_ < var_506_8 + var_506_16 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_8) / var_506_16

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_8 + var_506_16 and arg_503_1.time_ < var_506_8 + var_506_16 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
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
	Play424031125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 424031125
		arg_507_1.duration_ = 9.17

		local var_507_0 = {
			zh = 6.066,
			ja = 9.166
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
				arg_507_0:Play424031126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["10155"]) and arg_507_1.var_.actorSpriteComps10155 == nil then
				arg_507_1.var_.actorSpriteComps10155 = arg_507_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_0 = 0.2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["10155"]) then
				if arg_507_1.var_.actorSpriteComps10155 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["10155"]) and arg_507_1.var_.actorSpriteComps10155 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_510_3 then
						iter_510_3.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_507_1.var_.actorSpriteComps10155 = nil
			end

			local var_510_2 = arg_507_1.actors_["10154"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_2) and arg_507_1.var_.actorSpriteComps10154 == nil then
				arg_507_1.var_.actorSpriteComps10154 = var_510_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_3 = 0.2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_3 and not isNil(var_510_2) then
				if arg_507_1.var_.actorSpriteComps10154 then
					for iter_510_4, iter_510_5 in pairs(arg_507_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_510_5 then
							if arg_507_1.isInRecall_ then
								iter_510_5.color = Color.New(Mathf.Lerp(iter_510_5.color.r, arg_507_1.hightColor2.r, (arg_507_1.time_ - 0) / var_510_3), Mathf.Lerp(iter_510_5.color.g, arg_507_1.hightColor2.g, (arg_507_1.time_ - 0) / var_510_3), (Mathf.Lerp(iter_510_5.color.b, arg_507_1.hightColor2.b, (arg_507_1.time_ - 0) / var_510_3)))
							else
								local var_510_4 = Mathf.Lerp(iter_510_5.color.r, 0.5, (arg_507_1.time_ - 0) / var_510_3)

								iter_510_5.color = Color.New(var_510_4, var_510_4, var_510_4)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_3 and arg_507_1.time_ < 0 + var_510_3 + arg_510_0 and not isNil(var_510_2) and arg_507_1.var_.actorSpriteComps10154 then
				for iter_510_6, iter_510_7 in pairs(arg_507_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_510_7 then
						iter_510_7.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_507_1.var_.actorSpriteComps10154 = nil
			end

			local var_510_5 = arg_507_1.actors_["10155"].transform

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10155 = var_510_5.localPosition
				var_510_5.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10155", 4)

				for iter_510_8 = 0, var_510_5.childCount - 1 do
					local var_510_6 = var_510_5:GetChild(iter_510_8)

					if var_510_6.name == "split_5" then
						var_510_6:SetAsLastSibling()
						var_510_6.gameObject:SetActive(true)

						arg_507_1.var_.actorSpriteSplit10155 = var_510_6.gameObject:GetComponent(typeof(Image))

						arg_507_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_510_7 = 0.5

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				var_510_5.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10155, Vector3.New(440, -390, -250), (arg_507_1.time_ - 0) / var_510_7)

				if arg_507_1.var_.actorSpriteSplit10155 ~= nil then
					arg_507_1.var_.actorSpriteSplit10155:SetAlpha((arg_507_1.time_ - 0) / var_510_7)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				var_510_5.localPosition = Vector3.New(440, -390, -250)

				if arg_507_1.var_.actorSpriteSplit10155 ~= nil then
					arg_507_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_510_8 = 0
			local var_510_9 = 0.7

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_8 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_10 = arg_507_1:GetWordFromCfg(424031125)
				local var_510_11 = arg_507_1:FormatText(var_510_10.content)

				arg_507_1.text_.text = var_510_11

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_13 = 28 <= 0 and var_510_9 or var_510_9 * (utf8.len(var_510_11) / 28)

				if (28 <= 0 and var_510_9 or var_510_9 * (utf8.len(var_510_11) / 28)) > 0 and var_510_9 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_8
					end
				end

				arg_507_1.text_.text = var_510_11
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031125", "story_v_out_424031.awb") ~= 0 then
					local var_510_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031125", "story_v_out_424031.awb") / 1000

					if var_510_14 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_14 + var_510_8
					end

					if var_510_10.prefab_name ~= "" and arg_507_1.actors_[var_510_10.prefab_name] ~= nil then
						local var_510_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_10.prefab_name].transform, "story_v_out_424031", "424031125", "story_v_out_424031.awb")

						arg_507_1:RecordAudio("424031125", var_510_15)
						arg_507_1:RecordAudio("424031125", var_510_15)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_424031", "424031125", "story_v_out_424031.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_424031", "424031125", "story_v_out_424031.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_16 = math.max(var_510_9, arg_507_1.talkMaxDuration)

			if var_510_8 <= arg_507_1.time_ and arg_507_1.time_ < var_510_8 + var_510_16 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_8) / var_510_16

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_8 + var_510_16 and arg_507_1.time_ < var_510_8 + var_510_16 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play424031126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 424031126
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play424031127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["10155"]) and arg_511_1.var_.actorSpriteComps10155 == nil then
				arg_511_1.var_.actorSpriteComps10155 = arg_511_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_0 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["10155"]) then
				if arg_511_1.var_.actorSpriteComps10155 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								iter_514_1.color = Color.New(Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor2.r, (arg_511_1.time_ - 0) / var_514_0), Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor2.g, (arg_511_1.time_ - 0) / var_514_0), (Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor2.b, (arg_511_1.time_ - 0) / var_514_0)))
							else
								local var_514_1 = Mathf.Lerp(iter_514_1.color.r, 0.5, (arg_511_1.time_ - 0) / var_514_0)

								iter_514_1.color = Color.New(var_514_1, var_514_1, var_514_1)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["10155"]) and arg_511_1.var_.actorSpriteComps10155 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_514_3 then
						iter_514_3.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_511_1.var_.actorSpriteComps10155 = nil
			end

			local var_514_2 = arg_511_1.actors_["10155"].transform

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10155 = var_514_2.localPosition
				var_514_2.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10155", 7)

				for iter_514_4 = 0, var_514_2.childCount - 1 do
					local var_514_3 = var_514_2:GetChild(iter_514_4)

					if var_514_3.name == "split_5" then
						var_514_3:SetAsLastSibling()
						var_514_3.gameObject:SetActive(true)

						arg_511_1.var_.actorSpriteSplit10155 = var_514_3.gameObject:GetComponent(typeof(Image))

						arg_511_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_514_4 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				var_514_2.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_511_1.time_ - 0) / var_514_4)

				if arg_511_1.var_.actorSpriteSplit10155 ~= nil then
					arg_511_1.var_.actorSpriteSplit10155:SetAlpha((arg_511_1.time_ - 0) / var_514_4)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				var_514_2.localPosition = Vector3.New(0, -2000, 0)

				if arg_511_1.var_.actorSpriteSplit10155 ~= nil then
					arg_511_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			if 0.2 < arg_511_1.time_ and arg_511_1.time_ <= 0.2 + arg_514_0 then
				arg_511_1:AudioAction("play", "effect", "se_story_144", "se_story_144_clap", "")
			end

			local var_514_6 = 0
			local var_514_7 = 1.1

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_8 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(424031126).content)

				arg_511_1.text_.text = var_514_8

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_10 = 44 <= 0 and var_514_7 or var_514_7 * (utf8.len(var_514_8) / 44)

				if (44 <= 0 and var_514_7 or var_514_7 * (utf8.len(var_514_8) / 44)) > 0 and var_514_7 < var_514_10 then
					arg_511_1.talkMaxDuration = var_514_10

					if var_514_10 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_10 + var_514_6
					end
				end

				arg_511_1.text_.text = var_514_8
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_11 = math.max(var_514_7, arg_511_1.talkMaxDuration)

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_11 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_6) / var_514_11

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_6 + var_514_11 and arg_511_1.time_ < var_514_6 + var_514_11 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play424031127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 424031127
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play424031128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.75

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_1 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(424031127).content)

				arg_515_1.text_.text = var_518_1

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_3 = 30 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 30)

				if (30 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 30)) > 0 and var_518_0 < var_518_3 then
					arg_515_1.talkMaxDuration = var_518_3

					if var_518_3 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_3 + 0
					end
				end

				arg_515_1.text_.text = var_518_1
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_4 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_4

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play424031128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 424031128
		arg_519_1.duration_ = 5.9

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play424031129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["10154"]) and arg_519_1.var_.actorSpriteComps10154 == nil then
				arg_519_1.var_.actorSpriteComps10154 = arg_519_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_0 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["10154"]) then
				if arg_519_1.var_.actorSpriteComps10154 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["10154"]) and arg_519_1.var_.actorSpriteComps10154 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_522_3 then
						iter_522_3.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_519_1.var_.actorSpriteComps10154 = nil
			end

			local var_522_2 = arg_519_1.actors_["10154"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10154 = var_522_2.localPosition
				var_522_2.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10154", 3)

				for iter_522_4 = 0, var_522_2.childCount - 1 do
					local var_522_3 = var_522_2:GetChild(iter_522_4)

					if var_522_3.name == "split_1" or not string.find(var_522_3.name, "split") then
						var_522_3.gameObject:SetActive(true)
					else
						var_522_3.gameObject:SetActive(false)
					end
				end
			end

			local var_522_4 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				var_522_2.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_519_1.time_ - 0) / var_522_4)
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				var_522_2.localPosition = Vector3.New(-20, -338, -538)
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				local var_522_5 = arg_519_1.actors_["10154"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_522_5 then
					arg_519_1.var_.alphaOldValue10154 = var_522_5.alpha
					arg_519_1.var_.characterEffect10154 = var_522_5
				end

				arg_519_1.var_.alphaOldValue10154 = 0
			end

			local var_522_6 = 0.5

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_6 then
				if arg_519_1.var_.characterEffect10154 then
					arg_519_1.var_.characterEffect10154.alpha = Mathf.Lerp(arg_519_1.var_.alphaOldValue10154, 1, (arg_519_1.time_ - 0) / var_522_6)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_6 and arg_519_1.time_ < 0 + var_522_6 + arg_522_0 and arg_519_1.var_.characterEffect10154 then
				arg_519_1.var_.characterEffect10154.alpha = 1
			end

			local var_522_7 = 0
			local var_522_8 = 0.625

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_7 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_9 = arg_519_1:GetWordFromCfg(424031128)
				local var_522_10 = arg_519_1:FormatText(var_522_9.content)

				arg_519_1.text_.text = var_522_10

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_12 = 25 <= 0 and var_522_8 or var_522_8 * (utf8.len(var_522_10) / 25)

				if (25 <= 0 and var_522_8 or var_522_8 * (utf8.len(var_522_10) / 25)) > 0 and var_522_8 < var_522_12 then
					arg_519_1.talkMaxDuration = var_522_12

					if var_522_12 + var_522_7 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_12 + var_522_7
					end
				end

				arg_519_1.text_.text = var_522_10
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031128", "story_v_out_424031.awb") ~= 0 then
					local var_522_13 = manager.audio:GetVoiceLength("story_v_out_424031", "424031128", "story_v_out_424031.awb") / 1000

					if var_522_13 + var_522_7 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_7
					end

					if var_522_9.prefab_name ~= "" and arg_519_1.actors_[var_522_9.prefab_name] ~= nil then
						local var_522_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_9.prefab_name].transform, "story_v_out_424031", "424031128", "story_v_out_424031.awb")

						arg_519_1:RecordAudio("424031128", var_522_14)
						arg_519_1:RecordAudio("424031128", var_522_14)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_424031", "424031128", "story_v_out_424031.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_424031", "424031128", "story_v_out_424031.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_15 = math.max(var_522_8, arg_519_1.talkMaxDuration)

			if var_522_7 <= arg_519_1.time_ and arg_519_1.time_ < var_522_7 + var_522_15 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_7) / var_522_15

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_7 + var_522_15 and arg_519_1.time_ < var_522_7 + var_522_15 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play424031129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 424031129
		arg_523_1.duration_ = 9.43

		local var_523_0 = {
			zh = 6.9,
			ja = 9.433
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
				arg_523_0:Play424031130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 2.01562179997463 < arg_523_1.time_ and arg_523_1.time_ <= 2.01562179997463 + arg_526_0 then
				local var_526_0 = arg_523_1.bgs_.ST0115

				arg_523_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_526_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_526_1 = var_526_0:GetComponent("SpriteRenderer")

				if var_526_1 and var_526_1.sprite then
					local var_526_2 = 2 * (var_526_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_526_0.transform.localScale = Vector3.New(var_526_2 / var_526_1.sprite.bounds.size.y < var_526_2 * manager.ui.mainCameraCom_.aspect / var_526_1.sprite.bounds.size.x and var_526_2 * manager.ui.mainCameraCom_.aspect / var_526_1.sprite.bounds.size.x or var_526_2 / var_526_1.sprite.bounds.size.y, var_526_2 / var_526_1.sprite.bounds.size.y < var_526_2 * manager.ui.mainCameraCom_.aspect / var_526_1.sprite.bounds.size.x and var_526_2 * manager.ui.mainCameraCom_.aspect / var_526_1.sprite.bounds.size.x or var_526_2 / var_526_1.sprite.bounds.size.y, 0)
				end

				for iter_526_0, iter_526_1 in pairs(arg_523_1.bgs_) do
					if iter_526_0 ~= "ST0115" then
						iter_526_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_526_3 = 4

			if 4 < arg_523_1.time_ and arg_523_1.time_ <= var_526_3 + arg_526_0 then
				arg_523_1.allBtn_.enabled = false
			end

			if arg_523_1.time_ >= var_526_3 + 0.3 and arg_523_1.time_ < var_526_3 + 0.3 + arg_526_0 then
				arg_523_1.allBtn_.enabled = true
			end

			local var_526_4 = 0

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_4 + arg_526_0 then
				arg_523_1.mask_.enabled = true
				arg_523_1.mask_.raycastTarget = true

				arg_523_1:SetGaussion(false)
			end

			local var_526_5 = 2

			if var_526_4 <= arg_523_1.time_ and arg_523_1.time_ < var_526_4 + var_526_5 then
				local var_526_6 = Color.New(0, 0, 0)

				var_526_6.a = Mathf.Lerp(0, 1, (arg_523_1.time_ - var_526_4) / var_526_5)
				arg_523_1.mask_.color = var_526_6
			end

			if arg_523_1.time_ >= var_526_4 + var_526_5 and arg_523_1.time_ < var_526_4 + var_526_5 + arg_526_0 then
				local var_526_7 = Color.New(0, 0, 0)

				var_526_7.a = 1
				arg_523_1.mask_.color = var_526_7
			end

			local var_526_8 = 2

			if 2 < arg_523_1.time_ and arg_523_1.time_ <= var_526_8 + arg_526_0 then
				arg_523_1.mask_.enabled = true
				arg_523_1.mask_.raycastTarget = true

				arg_523_1:SetGaussion(false)
			end

			local var_526_9 = 2

			if var_526_8 <= arg_523_1.time_ and arg_523_1.time_ < var_526_8 + var_526_9 then
				local var_526_10 = Color.New(0, 0, 0)

				var_526_10.a = Mathf.Lerp(1, 0, (arg_523_1.time_ - var_526_8) / var_526_9)
				arg_523_1.mask_.color = var_526_10
			end

			if arg_523_1.time_ >= var_526_8 + var_526_9 and arg_523_1.time_ < var_526_8 + var_526_9 + arg_526_0 then
				local var_526_11 = Color.New(0, 0, 0)

				arg_523_1.mask_.enabled = false
				var_526_11.a = 0
				arg_523_1.mask_.color = var_526_11
			end

			local var_526_12 = arg_523_1.actors_["10155"]

			if 3.8 < arg_523_1.time_ and arg_523_1.time_ <= 3.8 + arg_526_0 and not isNil(var_526_12) and arg_523_1.var_.actorSpriteComps10155 == nil then
				arg_523_1.var_.actorSpriteComps10155 = var_526_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_13 = 0.2

			if 3.8 <= arg_523_1.time_ and arg_523_1.time_ < 3.8 + var_526_13 and not isNil(var_526_12) then
				if arg_523_1.var_.actorSpriteComps10155 then
					for iter_526_2, iter_526_3 in pairs(arg_523_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_526_3 then
							if arg_523_1.isInRecall_ then
								iter_526_3.color = Color.New(Mathf.Lerp(iter_526_3.color.r, arg_523_1.hightColor1.r, (arg_523_1.time_ - 3.8) / var_526_13), Mathf.Lerp(iter_526_3.color.g, arg_523_1.hightColor1.g, (arg_523_1.time_ - 3.8) / var_526_13), (Mathf.Lerp(iter_526_3.color.b, arg_523_1.hightColor1.b, (arg_523_1.time_ - 3.8) / var_526_13)))
							else
								local var_526_14 = Mathf.Lerp(iter_526_3.color.r, 1, (arg_523_1.time_ - 3.8) / var_526_13)

								iter_526_3.color = Color.New(var_526_14, var_526_14, var_526_14)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= 3.8 + var_526_13 and arg_523_1.time_ < 3.8 + var_526_13 + arg_526_0 and not isNil(var_526_12) and arg_523_1.var_.actorSpriteComps10155 then
				for iter_526_4, iter_526_5 in pairs(arg_523_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_526_5 then
						iter_526_5.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_523_1.var_.actorSpriteComps10155 = nil
			end

			local var_526_15 = arg_523_1.actors_["10154"]

			if 1.8 < arg_523_1.time_ and arg_523_1.time_ <= 1.8 + arg_526_0 and not isNil(var_526_15) and arg_523_1.var_.actorSpriteComps10154 == nil then
				arg_523_1.var_.actorSpriteComps10154 = var_526_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_16 = 0.2

			if 1.8 <= arg_523_1.time_ and arg_523_1.time_ < 1.8 + var_526_16 and not isNil(var_526_15) then
				if arg_523_1.var_.actorSpriteComps10154 then
					for iter_526_6, iter_526_7 in pairs(arg_523_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_526_7 then
							if arg_523_1.isInRecall_ then
								iter_526_7.color = Color.New(Mathf.Lerp(iter_526_7.color.r, arg_523_1.hightColor2.r, (arg_523_1.time_ - 1.8) / var_526_16), Mathf.Lerp(iter_526_7.color.g, arg_523_1.hightColor2.g, (arg_523_1.time_ - 1.8) / var_526_16), (Mathf.Lerp(iter_526_7.color.b, arg_523_1.hightColor2.b, (arg_523_1.time_ - 1.8) / var_526_16)))
							else
								local var_526_17 = Mathf.Lerp(iter_526_7.color.r, 0.5, (arg_523_1.time_ - 1.8) / var_526_16)

								iter_526_7.color = Color.New(var_526_17, var_526_17, var_526_17)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= 1.8 + var_526_16 and arg_523_1.time_ < 1.8 + var_526_16 + arg_526_0 and not isNil(var_526_15) and arg_523_1.var_.actorSpriteComps10154 then
				for iter_526_8, iter_526_9 in pairs(arg_523_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_526_9 then
						iter_526_9.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_523_1.var_.actorSpriteComps10154 = nil
			end

			local var_526_18 = arg_523_1.actors_["10154"].transform

			if 1.966 < arg_523_1.time_ and arg_523_1.time_ <= 1.966 + arg_526_0 then
				arg_523_1.var_.moveOldPos10154 = var_526_18.localPosition
				var_526_18.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10154", 7)

				for iter_526_10 = 0, var_526_18.childCount - 1 do
					local var_526_19 = var_526_18:GetChild(iter_526_10)

					if var_526_19.name == "" or not string.find(var_526_19.name, "split") then
						var_526_19.gameObject:SetActive(true)
					else
						var_526_19.gameObject:SetActive(false)
					end
				end
			end

			local var_526_20 = 0.001

			if 1.966 <= arg_523_1.time_ and arg_523_1.time_ < 1.966 + var_526_20 then
				var_526_18.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_523_1.time_ - 1.966) / var_526_20)
			end

			if arg_523_1.time_ >= 1.966 + var_526_20 and arg_523_1.time_ < 1.966 + var_526_20 + arg_526_0 then
				var_526_18.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_526_21 = arg_523_1.actors_["10155"].transform

			if 3.8 < arg_523_1.time_ and arg_523_1.time_ <= 3.8 + arg_526_0 then
				arg_523_1.var_.moveOldPos10155 = var_526_21.localPosition
				var_526_21.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10155", 3)

				for iter_526_11 = 0, var_526_21.childCount - 1 do
					local var_526_22 = var_526_21:GetChild(iter_526_11)

					if var_526_22.name == "" or not string.find(var_526_22.name, "split") then
						var_526_22.gameObject:SetActive(true)
					else
						var_526_22.gameObject:SetActive(false)
					end
				end
			end

			local var_526_23 = 0.001

			if 3.8 <= arg_523_1.time_ and arg_523_1.time_ < 3.8 + var_526_23 then
				var_526_21.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_523_1.time_ - 3.8) / var_526_23)
			end

			if arg_523_1.time_ >= 3.8 + var_526_23 and arg_523_1.time_ < 3.8 + var_526_23 + arg_526_0 then
				var_526_21.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_526_24 = arg_523_1.actors_["10155"].transform

			if 1.966 < arg_523_1.time_ and arg_523_1.time_ <= 1.966 + arg_526_0 then
				arg_523_1.var_.moveOldPos10155 = var_526_24.localPosition
				var_526_24.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10155", 7)

				for iter_526_12 = 0, var_526_24.childCount - 1 do
					local var_526_25 = var_526_24:GetChild(iter_526_12)

					if var_526_25.name == "" or not string.find(var_526_25.name, "split") then
						var_526_25.gameObject:SetActive(true)
					else
						var_526_25.gameObject:SetActive(false)
					end
				end
			end

			local var_526_26 = 0.001

			if 1.966 <= arg_523_1.time_ and arg_523_1.time_ < 1.966 + var_526_26 then
				var_526_24.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_523_1.time_ - 1.966) / var_526_26)
			end

			if arg_523_1.time_ >= 1.966 + var_526_26 and arg_523_1.time_ < 1.966 + var_526_26 + arg_526_0 then
				var_526_24.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_526_27 = arg_523_1.actors_["1094"].transform

			if 1.966 < arg_523_1.time_ and arg_523_1.time_ <= 1.966 + arg_526_0 then
				arg_523_1.var_.moveOldPos1094 = var_526_27.localPosition
				var_526_27.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("1094", 7)

				for iter_526_13 = 0, var_526_27.childCount - 1 do
					local var_526_28 = var_526_27:GetChild(iter_526_13)

					if var_526_28.name == "" or not string.find(var_526_28.name, "split") then
						var_526_28.gameObject:SetActive(true)
					else
						var_526_28.gameObject:SetActive(false)
					end
				end
			end

			local var_526_29 = 0.001

			if 1.966 <= arg_523_1.time_ and arg_523_1.time_ < 1.966 + var_526_29 then
				var_526_27.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_523_1.time_ - 1.966) / var_526_29)
			end

			if arg_523_1.time_ >= 1.966 + var_526_29 and arg_523_1.time_ < 1.966 + var_526_29 + arg_526_0 then
				var_526_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if 3.8 < arg_523_1.time_ and arg_523_1.time_ <= 3.8 + arg_526_0 then
				local var_526_30 = arg_523_1.actors_["10155"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_526_30 then
					arg_523_1.var_.alphaOldValue10155 = var_526_30.alpha
					arg_523_1.var_.characterEffect10155 = var_526_30
				end

				arg_523_1.var_.alphaOldValue10155 = 0
			end

			local var_526_31 = 0.5

			if 3.8 <= arg_523_1.time_ and arg_523_1.time_ < 3.8 + var_526_31 then
				if arg_523_1.var_.characterEffect10155 then
					arg_523_1.var_.characterEffect10155.alpha = Mathf.Lerp(arg_523_1.var_.alphaOldValue10155, 1, (arg_523_1.time_ - 3.8) / var_526_31)
				end
			end

			if arg_523_1.time_ >= 3.8 + var_526_31 and arg_523_1.time_ < 3.8 + var_526_31 + arg_526_0 and arg_523_1.var_.characterEffect10155 then
				arg_523_1.var_.characterEffect10155.alpha = 1
			end

			if 0.333333333333333 < arg_523_1.time_ and arg_523_1.time_ <= 0.333333333333333 + arg_526_0 then
				arg_523_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1.66666666666667 < arg_523_1.time_ and arg_523_1.time_ <= 1.66666666666667 + arg_526_0 then
				arg_523_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_523_1.frameCnt_ <= 1 then
				arg_523_1.dialog_:SetActive(false)
			end

			local var_526_34 = 4
			local var_526_35 = 0.325

			if 4 < arg_523_1.time_ and arg_523_1.time_ <= var_526_34 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0

				arg_523_1.dialog_:SetActive(true)

				arg_523_1.dialogCg_.alpha = 0

				local var_526_36 = LeanTween.value(arg_523_1.dialog_, 0, 1, 0.3)

				var_526_36:setOnUpdate(LuaHelper.FloatAction(function(arg_527_0)
					arg_523_1.dialogCg_.alpha = arg_527_0
				end))
				var_526_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_523_1.dialog_)
					var_526_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_523_1.duration_ = arg_523_1.duration_ + 0.3

				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_37 = arg_523_1:GetWordFromCfg(424031129)
				local var_526_38 = arg_523_1:FormatText(var_526_37.content)

				arg_523_1.text_.text = var_526_38

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_40 = 13 <= 0 and var_526_35 or var_526_35 * (utf8.len(var_526_38) / 13)

				if (13 <= 0 and var_526_35 or var_526_35 * (utf8.len(var_526_38) / 13)) > 0 and var_526_35 < var_526_40 then
					arg_523_1.talkMaxDuration = var_526_40
					var_526_34 = var_526_34 + 0.3

					if var_526_40 + var_526_34 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_40 + var_526_34
					end
				end

				arg_523_1.text_.text = var_526_38
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031129", "story_v_out_424031.awb") ~= 0 then
					local var_526_41 = manager.audio:GetVoiceLength("story_v_out_424031", "424031129", "story_v_out_424031.awb") / 1000

					if var_526_41 + var_526_34 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_41 + var_526_34
					end

					if var_526_37.prefab_name ~= "" and arg_523_1.actors_[var_526_37.prefab_name] ~= nil then
						local var_526_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_37.prefab_name].transform, "story_v_out_424031", "424031129", "story_v_out_424031.awb")

						arg_523_1:RecordAudio("424031129", var_526_42)
						arg_523_1:RecordAudio("424031129", var_526_42)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_424031", "424031129", "story_v_out_424031.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_424031", "424031129", "story_v_out_424031.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_43 = var_526_34 + 0.3
			local var_526_44 = math.max(var_526_35, arg_523_1.talkMaxDuration)

			if var_526_34 + 0.3 <= arg_523_1.time_ and arg_523_1.time_ < var_526_43 + var_526_44 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_43) / var_526_44

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_43 + var_526_44 and arg_523_1.time_ < var_526_43 + var_526_44 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play424031130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 424031130
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play424031131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["10155"]) and arg_529_1.var_.actorSpriteComps10155 == nil then
				arg_529_1.var_.actorSpriteComps10155 = arg_529_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_0 = 0.2

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["10155"]) then
				if arg_529_1.var_.actorSpriteComps10155 then
					for iter_532_0, iter_532_1 in pairs(arg_529_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_532_1 then
							if arg_529_1.isInRecall_ then
								iter_532_1.color = Color.New(Mathf.Lerp(iter_532_1.color.r, arg_529_1.hightColor2.r, (arg_529_1.time_ - 0) / var_532_0), Mathf.Lerp(iter_532_1.color.g, arg_529_1.hightColor2.g, (arg_529_1.time_ - 0) / var_532_0), (Mathf.Lerp(iter_532_1.color.b, arg_529_1.hightColor2.b, (arg_529_1.time_ - 0) / var_532_0)))
							else
								local var_532_1 = Mathf.Lerp(iter_532_1.color.r, 0.5, (arg_529_1.time_ - 0) / var_532_0)

								iter_532_1.color = Color.New(var_532_1, var_532_1, var_532_1)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["10155"]) and arg_529_1.var_.actorSpriteComps10155 then
				for iter_532_2, iter_532_3 in pairs(arg_529_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_532_3 then
						iter_532_3.color = arg_529_1.isInRecall_ and (arg_529_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_529_1.var_.actorSpriteComps10155 = nil
			end

			local var_532_2 = arg_529_1.actors_["10155"].transform

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos10155 = var_532_2.localPosition
				var_532_2.localScale = Vector3.New(1, 1, 1)

				arg_529_1:CheckSpriteTmpPos("10155", 7)

				for iter_532_4 = 0, var_532_2.childCount - 1 do
					local var_532_3 = var_532_2:GetChild(iter_532_4)

					if var_532_3.name == "" or not string.find(var_532_3.name, "split") then
						var_532_3.gameObject:SetActive(true)
					else
						var_532_3.gameObject:SetActive(false)
					end
				end
			end

			local var_532_4 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_4 then
				var_532_2.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_529_1.time_ - 0) / var_532_4)
			end

			if arg_529_1.time_ >= 0 + var_532_4 and arg_529_1.time_ < 0 + var_532_4 + arg_532_0 then
				var_532_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_532_5 = 0
			local var_532_6 = 1

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_5 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_7 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(424031130).content)

				arg_529_1.text_.text = var_532_7

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_9 = 40 <= 0 and var_532_6 or var_532_6 * (utf8.len(var_532_7) / 40)

				if (40 <= 0 and var_532_6 or var_532_6 * (utf8.len(var_532_7) / 40)) > 0 and var_532_6 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_5 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_5
					end
				end

				arg_529_1.text_.text = var_532_7
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_6, arg_529_1.talkMaxDuration)

			if var_532_5 <= arg_529_1.time_ and arg_529_1.time_ < var_532_5 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_5) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_5 + var_532_10 and arg_529_1.time_ < var_532_5 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play424031131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 424031131
		arg_533_1.duration_ = 5.5

		local var_533_0 = {
			zh = 2.8,
			ja = 5.5
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
				arg_533_0:Play424031132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["10155"]) and arg_533_1.var_.actorSpriteComps10155 == nil then
				arg_533_1.var_.actorSpriteComps10155 = arg_533_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_0 = 0.2

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["10155"]) then
				if arg_533_1.var_.actorSpriteComps10155 then
					for iter_536_0, iter_536_1 in pairs(arg_533_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_536_1 then
							if arg_533_1.isInRecall_ then
								iter_536_1.color = Color.New(Mathf.Lerp(iter_536_1.color.r, arg_533_1.hightColor1.r, (arg_533_1.time_ - 0) / var_536_0), Mathf.Lerp(iter_536_1.color.g, arg_533_1.hightColor1.g, (arg_533_1.time_ - 0) / var_536_0), (Mathf.Lerp(iter_536_1.color.b, arg_533_1.hightColor1.b, (arg_533_1.time_ - 0) / var_536_0)))
							else
								local var_536_1 = Mathf.Lerp(iter_536_1.color.r, 1, (arg_533_1.time_ - 0) / var_536_0)

								iter_536_1.color = Color.New(var_536_1, var_536_1, var_536_1)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["10155"]) and arg_533_1.var_.actorSpriteComps10155 then
				for iter_536_2, iter_536_3 in pairs(arg_533_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_536_3 then
						iter_536_3.color = arg_533_1.isInRecall_ and (arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_533_1.var_.actorSpriteComps10155 = nil
			end

			local var_536_2 = arg_533_1.actors_["10155"].transform

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos10155 = var_536_2.localPosition
				var_536_2.localScale = Vector3.New(1, 1, 1)

				arg_533_1:CheckSpriteTmpPos("10155", 2)

				for iter_536_4 = 0, var_536_2.childCount - 1 do
					local var_536_3 = var_536_2:GetChild(iter_536_4)

					if var_536_3.name == "split_4" then
						var_536_3:SetAsLastSibling()
						var_536_3.gameObject:SetActive(true)

						arg_533_1.var_.actorSpriteSplit10155 = var_536_3.gameObject:GetComponent(typeof(Image))

						arg_533_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_536_4 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				var_536_2.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_533_1.time_ - 0) / var_536_4)

				if arg_533_1.var_.actorSpriteSplit10155 ~= nil then
					arg_533_1.var_.actorSpriteSplit10155:SetAlpha((arg_533_1.time_ - 0) / var_536_4)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				var_536_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_533_1.var_.actorSpriteSplit10155 ~= nil then
					arg_533_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_536_5 = 0
			local var_536_6 = 0.3

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_5 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_7 = arg_533_1:GetWordFromCfg(424031131)
				local var_536_8 = arg_533_1:FormatText(var_536_7.content)

				arg_533_1.text_.text = var_536_8

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_10 = 12 <= 0 and var_536_6 or var_536_6 * (utf8.len(var_536_8) / 12)

				if (12 <= 0 and var_536_6 or var_536_6 * (utf8.len(var_536_8) / 12)) > 0 and var_536_6 < var_536_10 then
					arg_533_1.talkMaxDuration = var_536_10

					if var_536_10 + var_536_5 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_10 + var_536_5
					end
				end

				arg_533_1.text_.text = var_536_8
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031131", "story_v_out_424031.awb") ~= 0 then
					local var_536_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031131", "story_v_out_424031.awb") / 1000

					if var_536_11 + var_536_5 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_11 + var_536_5
					end

					if var_536_7.prefab_name ~= "" and arg_533_1.actors_[var_536_7.prefab_name] ~= nil then
						local var_536_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_7.prefab_name].transform, "story_v_out_424031", "424031131", "story_v_out_424031.awb")

						arg_533_1:RecordAudio("424031131", var_536_12)
						arg_533_1:RecordAudio("424031131", var_536_12)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_424031", "424031131", "story_v_out_424031.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_424031", "424031131", "story_v_out_424031.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_13 = math.max(var_536_6, arg_533_1.talkMaxDuration)

			if var_536_5 <= arg_533_1.time_ and arg_533_1.time_ < var_536_5 + var_536_13 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_5) / var_536_13

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_5 + var_536_13 and arg_533_1.time_ < var_536_5 + var_536_13 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play424031132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 424031132
		arg_537_1.duration_ = 5.37

		local var_537_0 = {
			zh = 5.366,
			ja = 5.1
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
				arg_537_0:Play424031133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["10154"]) and arg_537_1.var_.actorSpriteComps10154 == nil then
				arg_537_1.var_.actorSpriteComps10154 = arg_537_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_0 = 0.2

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["10154"]) then
				if arg_537_1.var_.actorSpriteComps10154 then
					for iter_540_0, iter_540_1 in pairs(arg_537_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_540_1 then
							if arg_537_1.isInRecall_ then
								iter_540_1.color = Color.New(Mathf.Lerp(iter_540_1.color.r, arg_537_1.hightColor1.r, (arg_537_1.time_ - 0) / var_540_0), Mathf.Lerp(iter_540_1.color.g, arg_537_1.hightColor1.g, (arg_537_1.time_ - 0) / var_540_0), (Mathf.Lerp(iter_540_1.color.b, arg_537_1.hightColor1.b, (arg_537_1.time_ - 0) / var_540_0)))
							else
								local var_540_1 = Mathf.Lerp(iter_540_1.color.r, 1, (arg_537_1.time_ - 0) / var_540_0)

								iter_540_1.color = Color.New(var_540_1, var_540_1, var_540_1)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["10154"]) and arg_537_1.var_.actorSpriteComps10154 then
				for iter_540_2, iter_540_3 in pairs(arg_537_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_540_3 then
						iter_540_3.color = arg_537_1.isInRecall_ and (arg_537_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_537_1.var_.actorSpriteComps10154 = nil
			end

			local var_540_2 = arg_537_1.actors_["10155"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_2) and arg_537_1.var_.actorSpriteComps10155 == nil then
				arg_537_1.var_.actorSpriteComps10155 = var_540_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_3 = 0.2

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_3 and not isNil(var_540_2) then
				if arg_537_1.var_.actorSpriteComps10155 then
					for iter_540_4, iter_540_5 in pairs(arg_537_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_540_5 then
							if arg_537_1.isInRecall_ then
								iter_540_5.color = Color.New(Mathf.Lerp(iter_540_5.color.r, arg_537_1.hightColor2.r, (arg_537_1.time_ - 0) / var_540_3), Mathf.Lerp(iter_540_5.color.g, arg_537_1.hightColor2.g, (arg_537_1.time_ - 0) / var_540_3), (Mathf.Lerp(iter_540_5.color.b, arg_537_1.hightColor2.b, (arg_537_1.time_ - 0) / var_540_3)))
							else
								local var_540_4 = Mathf.Lerp(iter_540_5.color.r, 0.5, (arg_537_1.time_ - 0) / var_540_3)

								iter_540_5.color = Color.New(var_540_4, var_540_4, var_540_4)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= 0 + var_540_3 and arg_537_1.time_ < 0 + var_540_3 + arg_540_0 and not isNil(var_540_2) and arg_537_1.var_.actorSpriteComps10155 then
				for iter_540_6, iter_540_7 in pairs(arg_537_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_540_7 then
						iter_540_7.color = arg_537_1.isInRecall_ and (arg_537_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_537_1.var_.actorSpriteComps10155 = nil
			end

			local var_540_5 = arg_537_1.actors_["10154"].transform

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos10154 = var_540_5.localPosition
				var_540_5.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("10154", 4)

				for iter_540_8 = 0, var_540_5.childCount - 1 do
					local var_540_6 = var_540_5:GetChild(iter_540_8)

					if var_540_6.name == "split_1" or not string.find(var_540_6.name, "split") then
						var_540_6.gameObject:SetActive(true)
					else
						var_540_6.gameObject:SetActive(false)
					end
				end
			end

			local var_540_7 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_7 then
				var_540_5.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_537_1.time_ - 0) / var_540_7)
			end

			if arg_537_1.time_ >= 0 + var_540_7 and arg_537_1.time_ < 0 + var_540_7 + arg_540_0 then
				var_540_5.localPosition = Vector3.New(345, -338, -538)
			end

			local var_540_8 = 0
			local var_540_9 = 0.8

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_8 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_10 = arg_537_1:GetWordFromCfg(424031132)
				local var_540_11 = arg_537_1:FormatText(var_540_10.content)

				arg_537_1.text_.text = var_540_11

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_13 = 32 <= 0 and var_540_9 or var_540_9 * (utf8.len(var_540_11) / 32)

				if (32 <= 0 and var_540_9 or var_540_9 * (utf8.len(var_540_11) / 32)) > 0 and var_540_9 < var_540_13 then
					arg_537_1.talkMaxDuration = var_540_13

					if var_540_13 + var_540_8 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_13 + var_540_8
					end
				end

				arg_537_1.text_.text = var_540_11
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031132", "story_v_out_424031.awb") ~= 0 then
					local var_540_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031132", "story_v_out_424031.awb") / 1000

					if var_540_14 + var_540_8 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_14 + var_540_8
					end

					if var_540_10.prefab_name ~= "" and arg_537_1.actors_[var_540_10.prefab_name] ~= nil then
						local var_540_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_10.prefab_name].transform, "story_v_out_424031", "424031132", "story_v_out_424031.awb")

						arg_537_1:RecordAudio("424031132", var_540_15)
						arg_537_1:RecordAudio("424031132", var_540_15)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_424031", "424031132", "story_v_out_424031.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_424031", "424031132", "story_v_out_424031.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_16 = math.max(var_540_9, arg_537_1.talkMaxDuration)

			if var_540_8 <= arg_537_1.time_ and arg_537_1.time_ < var_540_8 + var_540_16 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_8) / var_540_16

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_8 + var_540_16 and arg_537_1.time_ < var_540_8 + var_540_16 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play424031133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 424031133
		arg_541_1.duration_ = 3.8

		local var_541_0 = {
			zh = 3.8,
			ja = 2.8
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
				arg_541_0:Play424031134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1094"]) and arg_541_1.var_.actorSpriteComps1094 == nil then
				arg_541_1.var_.actorSpriteComps1094 = arg_541_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_0 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1094"]) then
				if arg_541_1.var_.actorSpriteComps1094 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								iter_544_1.color = Color.New(Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor1.r, (arg_541_1.time_ - 0) / var_544_0), Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor1.g, (arg_541_1.time_ - 0) / var_544_0), (Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor1.b, (arg_541_1.time_ - 0) / var_544_0)))
							else
								local var_544_1 = Mathf.Lerp(iter_544_1.color.r, 1, (arg_541_1.time_ - 0) / var_544_0)

								iter_544_1.color = Color.New(var_544_1, var_544_1, var_544_1)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1094"]) and arg_541_1.var_.actorSpriteComps1094 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_544_3 then
						iter_544_3.color = arg_541_1.isInRecall_ and (arg_541_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_541_1.var_.actorSpriteComps1094 = nil
			end

			local var_544_2 = arg_541_1.actors_["10154"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_2) and arg_541_1.var_.actorSpriteComps10154 == nil then
				arg_541_1.var_.actorSpriteComps10154 = var_544_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_3 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_3 and not isNil(var_544_2) then
				if arg_541_1.var_.actorSpriteComps10154 then
					for iter_544_4, iter_544_5 in pairs(arg_541_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_544_5 then
							if arg_541_1.isInRecall_ then
								iter_544_5.color = Color.New(Mathf.Lerp(iter_544_5.color.r, arg_541_1.hightColor2.r, (arg_541_1.time_ - 0) / var_544_3), Mathf.Lerp(iter_544_5.color.g, arg_541_1.hightColor2.g, (arg_541_1.time_ - 0) / var_544_3), (Mathf.Lerp(iter_544_5.color.b, arg_541_1.hightColor2.b, (arg_541_1.time_ - 0) / var_544_3)))
							else
								local var_544_4 = Mathf.Lerp(iter_544_5.color.r, 0.5, (arg_541_1.time_ - 0) / var_544_3)

								iter_544_5.color = Color.New(var_544_4, var_544_4, var_544_4)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= 0 + var_544_3 and arg_541_1.time_ < 0 + var_544_3 + arg_544_0 and not isNil(var_544_2) and arg_541_1.var_.actorSpriteComps10154 then
				for iter_544_6, iter_544_7 in pairs(arg_541_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_544_7 then
						iter_544_7.color = arg_541_1.isInRecall_ and (arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_541_1.var_.actorSpriteComps10154 = nil
			end

			local var_544_5 = arg_541_1.actors_["1094"].transform

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1094 = var_544_5.localPosition
				var_544_5.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("1094", 4)

				for iter_544_8 = 0, var_544_5.childCount - 1 do
					local var_544_6 = var_544_5:GetChild(iter_544_8)

					if var_544_6.name == "split_1" or not string.find(var_544_6.name, "split") then
						var_544_6.gameObject:SetActive(true)
					else
						var_544_6.gameObject:SetActive(false)
					end
				end
			end

			local var_544_7 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				var_544_5.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_541_1.time_ - 0) / var_544_7)
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				var_544_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_544_8 = arg_541_1.actors_["10154"].transform

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos10154 = var_544_8.localPosition
				var_544_8.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("10154", 7)

				for iter_544_9 = 0, var_544_8.childCount - 1 do
					local var_544_9 = var_544_8:GetChild(iter_544_9)

					if var_544_9.name == "" or not string.find(var_544_9.name, "split") then
						var_544_9.gameObject:SetActive(true)
					else
						var_544_9.gameObject:SetActive(false)
					end
				end
			end

			local var_544_10 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_10 then
				var_544_8.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_541_1.time_ - 0) / var_544_10)
			end

			if arg_541_1.time_ >= 0 + var_544_10 and arg_541_1.time_ < 0 + var_544_10 + arg_544_0 then
				var_544_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_544_11 = 0
			local var_544_12 = 0.4

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_11 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_13 = arg_541_1:GetWordFromCfg(424031133)
				local var_544_14 = arg_541_1:FormatText(var_544_13.content)

				arg_541_1.text_.text = var_544_14

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_16 = 16 <= 0 and var_544_12 or var_544_12 * (utf8.len(var_544_14) / 16)

				if (16 <= 0 and var_544_12 or var_544_12 * (utf8.len(var_544_14) / 16)) > 0 and var_544_12 < var_544_16 then
					arg_541_1.talkMaxDuration = var_544_16

					if var_544_16 + var_544_11 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_16 + var_544_11
					end
				end

				arg_541_1.text_.text = var_544_14
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031133", "story_v_out_424031.awb") ~= 0 then
					local var_544_17 = manager.audio:GetVoiceLength("story_v_out_424031", "424031133", "story_v_out_424031.awb") / 1000

					if var_544_17 + var_544_11 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_17 + var_544_11
					end

					if var_544_13.prefab_name ~= "" and arg_541_1.actors_[var_544_13.prefab_name] ~= nil then
						local var_544_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_13.prefab_name].transform, "story_v_out_424031", "424031133", "story_v_out_424031.awb")

						arg_541_1:RecordAudio("424031133", var_544_18)
						arg_541_1:RecordAudio("424031133", var_544_18)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_424031", "424031133", "story_v_out_424031.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_424031", "424031133", "story_v_out_424031.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_19 = math.max(var_544_12, arg_541_1.talkMaxDuration)

			if var_544_11 <= arg_541_1.time_ and arg_541_1.time_ < var_544_11 + var_544_19 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_11) / var_544_19

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_11 + var_544_19 and arg_541_1.time_ < var_544_11 + var_544_19 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play424031134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 424031134
		arg_545_1.duration_ = 11.2

		local var_545_0 = {
			zh = 7.3,
			ja = 11.2
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play424031135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["10155"]) and arg_545_1.var_.actorSpriteComps10155 == nil then
				arg_545_1.var_.actorSpriteComps10155 = arg_545_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_0 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["10155"]) then
				if arg_545_1.var_.actorSpriteComps10155 then
					for iter_548_0, iter_548_1 in pairs(arg_545_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_548_1 then
							if arg_545_1.isInRecall_ then
								iter_548_1.color = Color.New(Mathf.Lerp(iter_548_1.color.r, arg_545_1.hightColor1.r, (arg_545_1.time_ - 0) / var_548_0), Mathf.Lerp(iter_548_1.color.g, arg_545_1.hightColor1.g, (arg_545_1.time_ - 0) / var_548_0), (Mathf.Lerp(iter_548_1.color.b, arg_545_1.hightColor1.b, (arg_545_1.time_ - 0) / var_548_0)))
							else
								local var_548_1 = Mathf.Lerp(iter_548_1.color.r, 1, (arg_545_1.time_ - 0) / var_548_0)

								iter_548_1.color = Color.New(var_548_1, var_548_1, var_548_1)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["10155"]) and arg_545_1.var_.actorSpriteComps10155 then
				for iter_548_2, iter_548_3 in pairs(arg_545_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_548_3 then
						iter_548_3.color = arg_545_1.isInRecall_ and (arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_545_1.var_.actorSpriteComps10155 = nil
			end

			local var_548_2 = arg_545_1.actors_["1094"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_2) and arg_545_1.var_.actorSpriteComps1094 == nil then
				arg_545_1.var_.actorSpriteComps1094 = var_548_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_3 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_3 and not isNil(var_548_2) then
				if arg_545_1.var_.actorSpriteComps1094 then
					for iter_548_4, iter_548_5 in pairs(arg_545_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_548_5 then
							if arg_545_1.isInRecall_ then
								iter_548_5.color = Color.New(Mathf.Lerp(iter_548_5.color.r, arg_545_1.hightColor2.r, (arg_545_1.time_ - 0) / var_548_3), Mathf.Lerp(iter_548_5.color.g, arg_545_1.hightColor2.g, (arg_545_1.time_ - 0) / var_548_3), (Mathf.Lerp(iter_548_5.color.b, arg_545_1.hightColor2.b, (arg_545_1.time_ - 0) / var_548_3)))
							else
								local var_548_4 = Mathf.Lerp(iter_548_5.color.r, 0.5, (arg_545_1.time_ - 0) / var_548_3)

								iter_548_5.color = Color.New(var_548_4, var_548_4, var_548_4)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= 0 + var_548_3 and arg_545_1.time_ < 0 + var_548_3 + arg_548_0 and not isNil(var_548_2) and arg_545_1.var_.actorSpriteComps1094 then
				for iter_548_6, iter_548_7 in pairs(arg_545_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_548_7 then
						iter_548_7.color = arg_545_1.isInRecall_ and (arg_545_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_545_1.var_.actorSpriteComps1094 = nil
			end

			local var_548_5 = arg_545_1.actors_["10155"].transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos10155 = var_548_5.localPosition
				var_548_5.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("10155", 2)

				for iter_548_8 = 0, var_548_5.childCount - 1 do
					local var_548_6 = var_548_5:GetChild(iter_548_8)

					if var_548_6.name == "split_1" then
						var_548_6:SetAsLastSibling()
						var_548_6.gameObject:SetActive(true)

						arg_545_1.var_.actorSpriteSplit10155 = var_548_6.gameObject:GetComponent(typeof(Image))

						arg_545_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_548_7 = 0.5

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_7 then
				var_548_5.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_545_1.time_ - 0) / var_548_7)

				if arg_545_1.var_.actorSpriteSplit10155 ~= nil then
					arg_545_1.var_.actorSpriteSplit10155:SetAlpha((arg_545_1.time_ - 0) / var_548_7)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_7 and arg_545_1.time_ < 0 + var_548_7 + arg_548_0 then
				var_548_5.localPosition = Vector3.New(-410, -390, -250)

				if arg_545_1.var_.actorSpriteSplit10155 ~= nil then
					arg_545_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_548_8 = 0
			local var_548_9 = 0.825

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_8 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_10 = arg_545_1:GetWordFromCfg(424031134)
				local var_548_11 = arg_545_1:FormatText(var_548_10.content)

				arg_545_1.text_.text = var_548_11

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_13 = 33 <= 0 and var_548_9 or var_548_9 * (utf8.len(var_548_11) / 33)

				if (33 <= 0 and var_548_9 or var_548_9 * (utf8.len(var_548_11) / 33)) > 0 and var_548_9 < var_548_13 then
					arg_545_1.talkMaxDuration = var_548_13

					if var_548_13 + var_548_8 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_13 + var_548_8
					end
				end

				arg_545_1.text_.text = var_548_11
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031134", "story_v_out_424031.awb") ~= 0 then
					local var_548_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031134", "story_v_out_424031.awb") / 1000

					if var_548_14 + var_548_8 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_14 + var_548_8
					end

					if var_548_10.prefab_name ~= "" and arg_545_1.actors_[var_548_10.prefab_name] ~= nil then
						local var_548_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_10.prefab_name].transform, "story_v_out_424031", "424031134", "story_v_out_424031.awb")

						arg_545_1:RecordAudio("424031134", var_548_15)
						arg_545_1:RecordAudio("424031134", var_548_15)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_424031", "424031134", "story_v_out_424031.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_424031", "424031134", "story_v_out_424031.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_16 = math.max(var_548_9, arg_545_1.talkMaxDuration)

			if var_548_8 <= arg_545_1.time_ and arg_545_1.time_ < var_548_8 + var_548_16 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_8) / var_548_16

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_8 + var_548_16 and arg_545_1.time_ < var_548_8 + var_548_16 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play424031135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 424031135
		arg_549_1.duration_ = 1.87

		local var_549_0 = {
			zh = 1.833,
			ja = 1.866
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play424031136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["10155"]) and arg_549_1.var_.actorSpriteComps10155 == nil then
				arg_549_1.var_.actorSpriteComps10155 = arg_549_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_0 = 0.2

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["10155"]) then
				if arg_549_1.var_.actorSpriteComps10155 then
					for iter_552_0, iter_552_1 in pairs(arg_549_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_552_1 then
							if arg_549_1.isInRecall_ then
								iter_552_1.color = Color.New(Mathf.Lerp(iter_552_1.color.r, arg_549_1.hightColor2.r, (arg_549_1.time_ - 0) / var_552_0), Mathf.Lerp(iter_552_1.color.g, arg_549_1.hightColor2.g, (arg_549_1.time_ - 0) / var_552_0), (Mathf.Lerp(iter_552_1.color.b, arg_549_1.hightColor2.b, (arg_549_1.time_ - 0) / var_552_0)))
							else
								local var_552_1 = Mathf.Lerp(iter_552_1.color.r, 0.5, (arg_549_1.time_ - 0) / var_552_0)

								iter_552_1.color = Color.New(var_552_1, var_552_1, var_552_1)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["10155"]) and arg_549_1.var_.actorSpriteComps10155 then
				for iter_552_2, iter_552_3 in pairs(arg_549_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_552_3 then
						iter_552_3.color = arg_549_1.isInRecall_ and (arg_549_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_549_1.var_.actorSpriteComps10155 = nil
			end

			local var_552_2 = 0
			local var_552_3 = 0.25

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_2 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_4 = arg_549_1:GetWordFromCfg(424031135)
				local var_552_5 = arg_549_1:FormatText(var_552_4.content)

				arg_549_1.text_.text = var_552_5

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_7 = 10 <= 0 and var_552_3 or var_552_3 * (utf8.len(var_552_5) / 10)

				if (10 <= 0 and var_552_3 or var_552_3 * (utf8.len(var_552_5) / 10)) > 0 and var_552_3 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_2 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_2
					end
				end

				arg_549_1.text_.text = var_552_5
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031135", "story_v_out_424031.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031135", "story_v_out_424031.awb") / 1000

					if var_552_8 + var_552_2 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_2
					end

					if var_552_4.prefab_name ~= "" and arg_549_1.actors_[var_552_4.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_4.prefab_name].transform, "story_v_out_424031", "424031135", "story_v_out_424031.awb")

						arg_549_1:RecordAudio("424031135", var_552_9)
						arg_549_1:RecordAudio("424031135", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_424031", "424031135", "story_v_out_424031.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_424031", "424031135", "story_v_out_424031.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_3, arg_549_1.talkMaxDuration)

			if var_552_2 <= arg_549_1.time_ and arg_549_1.time_ < var_552_2 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_2) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_2 + var_552_10 and arg_549_1.time_ < var_552_2 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play424031136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 424031136
		arg_553_1.duration_ = 13.03

		local var_553_0 = {
			zh = 10.933,
			ja = 13.033
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play424031137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["10155"]) and arg_553_1.var_.actorSpriteComps10155 == nil then
				arg_553_1.var_.actorSpriteComps10155 = arg_553_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["10155"]) then
				if arg_553_1.var_.actorSpriteComps10155 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								iter_556_1.color = Color.New(Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, (arg_553_1.time_ - 0) / var_556_0), Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, (arg_553_1.time_ - 0) / var_556_0), (Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, (arg_553_1.time_ - 0) / var_556_0)))
							else
								local var_556_1 = Mathf.Lerp(iter_556_1.color.r, 1, (arg_553_1.time_ - 0) / var_556_0)

								iter_556_1.color = Color.New(var_556_1, var_556_1, var_556_1)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["10155"]) and arg_553_1.var_.actorSpriteComps10155 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_556_3 then
						iter_556_3.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_553_1.var_.actorSpriteComps10155 = nil
			end

			local var_556_2 = arg_553_1.actors_["10155"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos10155 = var_556_2.localPosition
				var_556_2.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10155", 2)

				for iter_556_4 = 0, var_556_2.childCount - 1 do
					local var_556_3 = var_556_2:GetChild(iter_556_4)

					if var_556_3.name == "" or not string.find(var_556_3.name, "split") then
						var_556_3.gameObject:SetActive(true)
					else
						var_556_3.gameObject:SetActive(false)
					end
				end
			end

			local var_556_4 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				var_556_2.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_553_1.time_ - 0) / var_556_4)
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				var_556_2.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_556_5 = 0
			local var_556_6 = 1.125

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_7 = arg_553_1:GetWordFromCfg(424031136)
				local var_556_8 = arg_553_1:FormatText(var_556_7.content)

				arg_553_1.text_.text = var_556_8

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_10 = 45 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_8) / 45)

				if (45 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_8) / 45)) > 0 and var_556_6 < var_556_10 then
					arg_553_1.talkMaxDuration = var_556_10

					if var_556_10 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_5
					end
				end

				arg_553_1.text_.text = var_556_8
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031136", "story_v_out_424031.awb") ~= 0 then
					local var_556_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031136", "story_v_out_424031.awb") / 1000

					if var_556_11 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_11 + var_556_5
					end

					if var_556_7.prefab_name ~= "" and arg_553_1.actors_[var_556_7.prefab_name] ~= nil then
						local var_556_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_7.prefab_name].transform, "story_v_out_424031", "424031136", "story_v_out_424031.awb")

						arg_553_1:RecordAudio("424031136", var_556_12)
						arg_553_1:RecordAudio("424031136", var_556_12)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_424031", "424031136", "story_v_out_424031.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_424031", "424031136", "story_v_out_424031.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_13 = math.max(var_556_6, arg_553_1.talkMaxDuration)

			if var_556_5 <= arg_553_1.time_ and arg_553_1.time_ < var_556_5 + var_556_13 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_5) / var_556_13

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_5 + var_556_13 and arg_553_1.time_ < var_556_5 + var_556_13 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play424031137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 424031137
		arg_557_1.duration_ = 4.8

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play424031138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["10154"]) and arg_557_1.var_.actorSpriteComps10154 == nil then
				arg_557_1.var_.actorSpriteComps10154 = arg_557_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_0 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["10154"]) then
				if arg_557_1.var_.actorSpriteComps10154 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								iter_560_1.color = Color.New(Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor1.r, (arg_557_1.time_ - 0) / var_560_0), Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor1.g, (arg_557_1.time_ - 0) / var_560_0), (Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor1.b, (arg_557_1.time_ - 0) / var_560_0)))
							else
								local var_560_1 = Mathf.Lerp(iter_560_1.color.r, 1, (arg_557_1.time_ - 0) / var_560_0)

								iter_560_1.color = Color.New(var_560_1, var_560_1, var_560_1)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["10154"]) and arg_557_1.var_.actorSpriteComps10154 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_560_3 then
						iter_560_3.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_557_1.var_.actorSpriteComps10154 = nil
			end

			local var_560_2 = arg_557_1.actors_["10155"]

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(var_560_2) and arg_557_1.var_.actorSpriteComps10155 == nil then
				arg_557_1.var_.actorSpriteComps10155 = var_560_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_3 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_3 and not isNil(var_560_2) then
				if arg_557_1.var_.actorSpriteComps10155 then
					for iter_560_4, iter_560_5 in pairs(arg_557_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_560_5 then
							if arg_557_1.isInRecall_ then
								iter_560_5.color = Color.New(Mathf.Lerp(iter_560_5.color.r, arg_557_1.hightColor2.r, (arg_557_1.time_ - 0) / var_560_3), Mathf.Lerp(iter_560_5.color.g, arg_557_1.hightColor2.g, (arg_557_1.time_ - 0) / var_560_3), (Mathf.Lerp(iter_560_5.color.b, arg_557_1.hightColor2.b, (arg_557_1.time_ - 0) / var_560_3)))
							else
								local var_560_4 = Mathf.Lerp(iter_560_5.color.r, 0.5, (arg_557_1.time_ - 0) / var_560_3)

								iter_560_5.color = Color.New(var_560_4, var_560_4, var_560_4)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_3 and arg_557_1.time_ < 0 + var_560_3 + arg_560_0 and not isNil(var_560_2) and arg_557_1.var_.actorSpriteComps10155 then
				for iter_560_6, iter_560_7 in pairs(arg_557_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_560_7 then
						iter_560_7.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_557_1.var_.actorSpriteComps10155 = nil
			end

			local var_560_5 = arg_557_1.actors_["1094"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1094 = var_560_5.localPosition
				var_560_5.localScale = Vector3.New(1, 1, 1)

				arg_557_1:CheckSpriteTmpPos("1094", 7)

				for iter_560_8 = 0, var_560_5.childCount - 1 do
					local var_560_6 = var_560_5:GetChild(iter_560_8)

					if var_560_6.name == "" or not string.find(var_560_6.name, "split") then
						var_560_6.gameObject:SetActive(true)
					else
						var_560_6.gameObject:SetActive(false)
					end
				end
			end

			local var_560_7 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				var_560_5.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_557_1.time_ - 0) / var_560_7)
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				var_560_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_560_8 = arg_557_1.actors_["10154"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos10154 = var_560_8.localPosition
				var_560_8.localScale = Vector3.New(1, 1, 1)

				arg_557_1:CheckSpriteTmpPos("10154", 4)

				for iter_560_9 = 0, var_560_8.childCount - 1 do
					local var_560_9 = var_560_8:GetChild(iter_560_9)

					if var_560_9.name == "split_1" or not string.find(var_560_9.name, "split") then
						var_560_9.gameObject:SetActive(true)
					else
						var_560_9.gameObject:SetActive(false)
					end
				end
			end

			local var_560_10 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_10 then
				var_560_8.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_557_1.time_ - 0) / var_560_10)
			end

			if arg_557_1.time_ >= 0 + var_560_10 and arg_557_1.time_ < 0 + var_560_10 + arg_560_0 then
				var_560_8.localPosition = Vector3.New(345, -338, -538)
			end

			local var_560_11 = 0
			local var_560_12 = 0.75

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_11 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_13 = arg_557_1:GetWordFromCfg(424031137)
				local var_560_14 = arg_557_1:FormatText(var_560_13.content)

				arg_557_1.text_.text = var_560_14

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_16 = 30 <= 0 and var_560_12 or var_560_12 * (utf8.len(var_560_14) / 30)

				if (30 <= 0 and var_560_12 or var_560_12 * (utf8.len(var_560_14) / 30)) > 0 and var_560_12 < var_560_16 then
					arg_557_1.talkMaxDuration = var_560_16

					if var_560_16 + var_560_11 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_16 + var_560_11
					end
				end

				arg_557_1.text_.text = var_560_14
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031137", "story_v_out_424031.awb") ~= 0 then
					local var_560_17 = manager.audio:GetVoiceLength("story_v_out_424031", "424031137", "story_v_out_424031.awb") / 1000

					if var_560_17 + var_560_11 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_17 + var_560_11
					end

					if var_560_13.prefab_name ~= "" and arg_557_1.actors_[var_560_13.prefab_name] ~= nil then
						local var_560_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_13.prefab_name].transform, "story_v_out_424031", "424031137", "story_v_out_424031.awb")

						arg_557_1:RecordAudio("424031137", var_560_18)
						arg_557_1:RecordAudio("424031137", var_560_18)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_424031", "424031137", "story_v_out_424031.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_424031", "424031137", "story_v_out_424031.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_19 = math.max(var_560_12, arg_557_1.talkMaxDuration)

			if var_560_11 <= arg_557_1.time_ and arg_557_1.time_ < var_560_11 + var_560_19 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_11) / var_560_19

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_11 + var_560_19 and arg_557_1.time_ < var_560_11 + var_560_19 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play424031138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 424031138
		arg_561_1.duration_ = 1.53

		local var_561_0 = {
			zh = 1.233,
			ja = 1.533
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play424031139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["10154"]) and arg_561_1.var_.actorSpriteComps10154 == nil then
				arg_561_1.var_.actorSpriteComps10154 = arg_561_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_0 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["10154"]) then
				if arg_561_1.var_.actorSpriteComps10154 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								iter_564_1.color = Color.New(Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor2.r, (arg_561_1.time_ - 0) / var_564_0), Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor2.g, (arg_561_1.time_ - 0) / var_564_0), (Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor2.b, (arg_561_1.time_ - 0) / var_564_0)))
							else
								local var_564_1 = Mathf.Lerp(iter_564_1.color.r, 0.5, (arg_561_1.time_ - 0) / var_564_0)

								iter_564_1.color = Color.New(var_564_1, var_564_1, var_564_1)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["10154"]) and arg_561_1.var_.actorSpriteComps10154 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_564_3 then
						iter_564_3.color = arg_561_1.isInRecall_ and (arg_561_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_561_1.var_.actorSpriteComps10154 = nil
			end

			local var_564_2 = 0
			local var_564_3 = 0.1

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_2 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_4 = arg_561_1:GetWordFromCfg(424031138)
				local var_564_5 = arg_561_1:FormatText(var_564_4.content)

				arg_561_1.text_.text = var_564_5

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_7 = 4 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 4)

				if (4 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 4)) > 0 and var_564_3 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_2
					end
				end

				arg_561_1.text_.text = var_564_5
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031138", "story_v_out_424031.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031138", "story_v_out_424031.awb") / 1000

					if var_564_8 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_2
					end

					if var_564_4.prefab_name ~= "" and arg_561_1.actors_[var_564_4.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_4.prefab_name].transform, "story_v_out_424031", "424031138", "story_v_out_424031.awb")

						arg_561_1:RecordAudio("424031138", var_564_9)
						arg_561_1:RecordAudio("424031138", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_424031", "424031138", "story_v_out_424031.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_424031", "424031138", "story_v_out_424031.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_3, arg_561_1.talkMaxDuration)

			if var_564_2 <= arg_561_1.time_ and arg_561_1.time_ < var_564_2 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_2) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_2 + var_564_10 and arg_561_1.time_ < var_564_2 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play424031139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 424031139
		arg_565_1.duration_ = 3.1

		local var_565_0 = {
			zh = 2.6,
			ja = 3.1
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play424031140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["10154"]) and arg_565_1.var_.actorSpriteComps10154 == nil then
				arg_565_1.var_.actorSpriteComps10154 = arg_565_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_568_0 = 0.2

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["10154"]) then
				if arg_565_1.var_.actorSpriteComps10154 then
					for iter_568_0, iter_568_1 in pairs(arg_565_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_568_1 then
							if arg_565_1.isInRecall_ then
								iter_568_1.color = Color.New(Mathf.Lerp(iter_568_1.color.r, arg_565_1.hightColor1.r, (arg_565_1.time_ - 0) / var_568_0), Mathf.Lerp(iter_568_1.color.g, arg_565_1.hightColor1.g, (arg_565_1.time_ - 0) / var_568_0), (Mathf.Lerp(iter_568_1.color.b, arg_565_1.hightColor1.b, (arg_565_1.time_ - 0) / var_568_0)))
							else
								local var_568_1 = Mathf.Lerp(iter_568_1.color.r, 1, (arg_565_1.time_ - 0) / var_568_0)

								iter_568_1.color = Color.New(var_568_1, var_568_1, var_568_1)
							end
						end
					end
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["10154"]) and arg_565_1.var_.actorSpriteComps10154 then
				for iter_568_2, iter_568_3 in pairs(arg_565_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_568_3 then
						iter_568_3.color = arg_565_1.isInRecall_ and (arg_565_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_565_1.var_.actorSpriteComps10154 = nil
			end

			local var_568_2 = arg_565_1.actors_["10154"].transform

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos10154 = var_568_2.localPosition
				var_568_2.localScale = Vector3.New(1, 1, 1)

				arg_565_1:CheckSpriteTmpPos("10154", 4)

				for iter_568_4 = 0, var_568_2.childCount - 1 do
					local var_568_3 = var_568_2:GetChild(iter_568_4)

					if var_568_3.name == "" or not string.find(var_568_3.name, "split") then
						var_568_3.gameObject:SetActive(true)
					else
						var_568_3.gameObject:SetActive(false)
					end
				end
			end

			local var_568_4 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_4 then
				var_568_2.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_565_1.time_ - 0) / var_568_4)
			end

			if arg_565_1.time_ >= 0 + var_568_4 and arg_565_1.time_ < 0 + var_568_4 + arg_568_0 then
				var_568_2.localPosition = Vector3.New(345, -338, -538)
			end

			local var_568_5 = 0
			local var_568_6 = 0.375

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_7 = arg_565_1:GetWordFromCfg(424031139)
				local var_568_8 = arg_565_1:FormatText(var_568_7.content)

				arg_565_1.text_.text = var_568_8

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_10 = 15 <= 0 and var_568_6 or var_568_6 * (utf8.len(var_568_8) / 15)

				if (15 <= 0 and var_568_6 or var_568_6 * (utf8.len(var_568_8) / 15)) > 0 and var_568_6 < var_568_10 then
					arg_565_1.talkMaxDuration = var_568_10

					if var_568_10 + var_568_5 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_10 + var_568_5
					end
				end

				arg_565_1.text_.text = var_568_8
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031139", "story_v_out_424031.awb") ~= 0 then
					local var_568_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031139", "story_v_out_424031.awb") / 1000

					if var_568_11 + var_568_5 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_11 + var_568_5
					end

					if var_568_7.prefab_name ~= "" and arg_565_1.actors_[var_568_7.prefab_name] ~= nil then
						local var_568_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_7.prefab_name].transform, "story_v_out_424031", "424031139", "story_v_out_424031.awb")

						arg_565_1:RecordAudio("424031139", var_568_12)
						arg_565_1:RecordAudio("424031139", var_568_12)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_424031", "424031139", "story_v_out_424031.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_424031", "424031139", "story_v_out_424031.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_13 = math.max(var_568_6, arg_565_1.talkMaxDuration)

			if var_568_5 <= arg_565_1.time_ and arg_565_1.time_ < var_568_5 + var_568_13 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_5) / var_568_13

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_5 + var_568_13 and arg_565_1.time_ < var_568_5 + var_568_13 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play424031140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 424031140
		arg_569_1.duration_ = 5.8

		local var_569_0 = {
			zh = 3.433,
			ja = 5.8
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play424031141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["10155"]) and arg_569_1.var_.actorSpriteComps10155 == nil then
				arg_569_1.var_.actorSpriteComps10155 = arg_569_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_572_0 = 0.2

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["10155"]) then
				if arg_569_1.var_.actorSpriteComps10155 then
					for iter_572_0, iter_572_1 in pairs(arg_569_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_572_1 then
							if arg_569_1.isInRecall_ then
								iter_572_1.color = Color.New(Mathf.Lerp(iter_572_1.color.r, arg_569_1.hightColor1.r, (arg_569_1.time_ - 0) / var_572_0), Mathf.Lerp(iter_572_1.color.g, arg_569_1.hightColor1.g, (arg_569_1.time_ - 0) / var_572_0), (Mathf.Lerp(iter_572_1.color.b, arg_569_1.hightColor1.b, (arg_569_1.time_ - 0) / var_572_0)))
							else
								local var_572_1 = Mathf.Lerp(iter_572_1.color.r, 1, (arg_569_1.time_ - 0) / var_572_0)

								iter_572_1.color = Color.New(var_572_1, var_572_1, var_572_1)
							end
						end
					end
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["10155"]) and arg_569_1.var_.actorSpriteComps10155 then
				for iter_572_2, iter_572_3 in pairs(arg_569_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_572_3 then
						iter_572_3.color = arg_569_1.isInRecall_ and (arg_569_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_569_1.var_.actorSpriteComps10155 = nil
			end

			local var_572_2 = arg_569_1.actors_["10154"]

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(var_572_2) and arg_569_1.var_.actorSpriteComps10154 == nil then
				arg_569_1.var_.actorSpriteComps10154 = var_572_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_572_3 = 0.2

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_3 and not isNil(var_572_2) then
				if arg_569_1.var_.actorSpriteComps10154 then
					for iter_572_4, iter_572_5 in pairs(arg_569_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_572_5 then
							if arg_569_1.isInRecall_ then
								iter_572_5.color = Color.New(Mathf.Lerp(iter_572_5.color.r, arg_569_1.hightColor2.r, (arg_569_1.time_ - 0) / var_572_3), Mathf.Lerp(iter_572_5.color.g, arg_569_1.hightColor2.g, (arg_569_1.time_ - 0) / var_572_3), (Mathf.Lerp(iter_572_5.color.b, arg_569_1.hightColor2.b, (arg_569_1.time_ - 0) / var_572_3)))
							else
								local var_572_4 = Mathf.Lerp(iter_572_5.color.r, 0.5, (arg_569_1.time_ - 0) / var_572_3)

								iter_572_5.color = Color.New(var_572_4, var_572_4, var_572_4)
							end
						end
					end
				end
			end

			if arg_569_1.time_ >= 0 + var_572_3 and arg_569_1.time_ < 0 + var_572_3 + arg_572_0 and not isNil(var_572_2) and arg_569_1.var_.actorSpriteComps10154 then
				for iter_572_6, iter_572_7 in pairs(arg_569_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_572_7 then
						iter_572_7.color = arg_569_1.isInRecall_ and (arg_569_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_569_1.var_.actorSpriteComps10154 = nil
			end

			local var_572_5 = arg_569_1.actors_["10155"].transform

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.var_.moveOldPos10155 = var_572_5.localPosition
				var_572_5.localScale = Vector3.New(1, 1, 1)

				arg_569_1:CheckSpriteTmpPos("10155", 2)

				for iter_572_8 = 0, var_572_5.childCount - 1 do
					local var_572_6 = var_572_5:GetChild(iter_572_8)

					if var_572_6.name == "" or not string.find(var_572_6.name, "split") then
						var_572_6.gameObject:SetActive(true)
					else
						var_572_6.gameObject:SetActive(false)
					end
				end
			end

			local var_572_7 = 0.001

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				var_572_5.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_569_1.time_ - 0) / var_572_7)
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				var_572_5.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_572_8 = 0
			local var_572_9 = 0.45

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_8 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_10 = arg_569_1:GetWordFromCfg(424031140)
				local var_572_11 = arg_569_1:FormatText(var_572_10.content)

				arg_569_1.text_.text = var_572_11

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_13 = 18 <= 0 and var_572_9 or var_572_9 * (utf8.len(var_572_11) / 18)

				if (18 <= 0 and var_572_9 or var_572_9 * (utf8.len(var_572_11) / 18)) > 0 and var_572_9 < var_572_13 then
					arg_569_1.talkMaxDuration = var_572_13

					if var_572_13 + var_572_8 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_13 + var_572_8
					end
				end

				arg_569_1.text_.text = var_572_11
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031140", "story_v_out_424031.awb") ~= 0 then
					local var_572_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031140", "story_v_out_424031.awb") / 1000

					if var_572_14 + var_572_8 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_14 + var_572_8
					end

					if var_572_10.prefab_name ~= "" and arg_569_1.actors_[var_572_10.prefab_name] ~= nil then
						local var_572_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_10.prefab_name].transform, "story_v_out_424031", "424031140", "story_v_out_424031.awb")

						arg_569_1:RecordAudio("424031140", var_572_15)
						arg_569_1:RecordAudio("424031140", var_572_15)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_424031", "424031140", "story_v_out_424031.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_424031", "424031140", "story_v_out_424031.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_16 = math.max(var_572_9, arg_569_1.talkMaxDuration)

			if var_572_8 <= arg_569_1.time_ and arg_569_1.time_ < var_572_8 + var_572_16 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_8) / var_572_16

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_8 + var_572_16 and arg_569_1.time_ < var_572_8 + var_572_16 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play424031141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 424031141
		arg_573_1.duration_ = 2.77

		local var_573_0 = {
			zh = 2.766,
			ja = 1.933
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play424031142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["10154"]) and arg_573_1.var_.actorSpriteComps10154 == nil then
				arg_573_1.var_.actorSpriteComps10154 = arg_573_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_576_0 = 0.2

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["10154"]) then
				if arg_573_1.var_.actorSpriteComps10154 then
					for iter_576_0, iter_576_1 in pairs(arg_573_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_576_1 then
							if arg_573_1.isInRecall_ then
								iter_576_1.color = Color.New(Mathf.Lerp(iter_576_1.color.r, arg_573_1.hightColor1.r, (arg_573_1.time_ - 0) / var_576_0), Mathf.Lerp(iter_576_1.color.g, arg_573_1.hightColor1.g, (arg_573_1.time_ - 0) / var_576_0), (Mathf.Lerp(iter_576_1.color.b, arg_573_1.hightColor1.b, (arg_573_1.time_ - 0) / var_576_0)))
							else
								local var_576_1 = Mathf.Lerp(iter_576_1.color.r, 1, (arg_573_1.time_ - 0) / var_576_0)

								iter_576_1.color = Color.New(var_576_1, var_576_1, var_576_1)
							end
						end
					end
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["10154"]) and arg_573_1.var_.actorSpriteComps10154 then
				for iter_576_2, iter_576_3 in pairs(arg_573_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_576_3 then
						iter_576_3.color = arg_573_1.isInRecall_ and (arg_573_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_573_1.var_.actorSpriteComps10154 = nil
			end

			local var_576_2 = arg_573_1.actors_["10155"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_2) and arg_573_1.var_.actorSpriteComps10155 == nil then
				arg_573_1.var_.actorSpriteComps10155 = var_576_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_576_3 = 0.2

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_3 and not isNil(var_576_2) then
				if arg_573_1.var_.actorSpriteComps10155 then
					for iter_576_4, iter_576_5 in pairs(arg_573_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_576_5 then
							if arg_573_1.isInRecall_ then
								iter_576_5.color = Color.New(Mathf.Lerp(iter_576_5.color.r, arg_573_1.hightColor2.r, (arg_573_1.time_ - 0) / var_576_3), Mathf.Lerp(iter_576_5.color.g, arg_573_1.hightColor2.g, (arg_573_1.time_ - 0) / var_576_3), (Mathf.Lerp(iter_576_5.color.b, arg_573_1.hightColor2.b, (arg_573_1.time_ - 0) / var_576_3)))
							else
								local var_576_4 = Mathf.Lerp(iter_576_5.color.r, 0.5, (arg_573_1.time_ - 0) / var_576_3)

								iter_576_5.color = Color.New(var_576_4, var_576_4, var_576_4)
							end
						end
					end
				end
			end

			if arg_573_1.time_ >= 0 + var_576_3 and arg_573_1.time_ < 0 + var_576_3 + arg_576_0 and not isNil(var_576_2) and arg_573_1.var_.actorSpriteComps10155 then
				for iter_576_6, iter_576_7 in pairs(arg_573_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_576_7 then
						iter_576_7.color = arg_573_1.isInRecall_ and (arg_573_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_573_1.var_.actorSpriteComps10155 = nil
			end

			local var_576_5 = arg_573_1.actors_["10154"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos10154 = var_576_5.localPosition
				var_576_5.localScale = Vector3.New(1, 1, 1)

				arg_573_1:CheckSpriteTmpPos("10154", 4)

				for iter_576_8 = 0, var_576_5.childCount - 1 do
					local var_576_6 = var_576_5:GetChild(iter_576_8)

					if var_576_6.name == "split_1" or not string.find(var_576_6.name, "split") then
						var_576_6.gameObject:SetActive(true)
					else
						var_576_6.gameObject:SetActive(false)
					end
				end
			end

			local var_576_7 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_7 then
				var_576_5.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_573_1.time_ - 0) / var_576_7)
			end

			if arg_573_1.time_ >= 0 + var_576_7 and arg_573_1.time_ < 0 + var_576_7 + arg_576_0 then
				var_576_5.localPosition = Vector3.New(345, -338, -538)
			end

			local var_576_8 = 0
			local var_576_9 = 0.325

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_8 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_10 = arg_573_1:GetWordFromCfg(424031141)
				local var_576_11 = arg_573_1:FormatText(var_576_10.content)

				arg_573_1.text_.text = var_576_11

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_13 = 13 <= 0 and var_576_9 or var_576_9 * (utf8.len(var_576_11) / 13)

				if (13 <= 0 and var_576_9 or var_576_9 * (utf8.len(var_576_11) / 13)) > 0 and var_576_9 < var_576_13 then
					arg_573_1.talkMaxDuration = var_576_13

					if var_576_13 + var_576_8 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_13 + var_576_8
					end
				end

				arg_573_1.text_.text = var_576_11
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031141", "story_v_out_424031.awb") ~= 0 then
					local var_576_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031141", "story_v_out_424031.awb") / 1000

					if var_576_14 + var_576_8 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_14 + var_576_8
					end

					if var_576_10.prefab_name ~= "" and arg_573_1.actors_[var_576_10.prefab_name] ~= nil then
						local var_576_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_10.prefab_name].transform, "story_v_out_424031", "424031141", "story_v_out_424031.awb")

						arg_573_1:RecordAudio("424031141", var_576_15)
						arg_573_1:RecordAudio("424031141", var_576_15)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_424031", "424031141", "story_v_out_424031.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_424031", "424031141", "story_v_out_424031.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_16 = math.max(var_576_9, arg_573_1.talkMaxDuration)

			if var_576_8 <= arg_573_1.time_ and arg_573_1.time_ < var_576_8 + var_576_16 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_8) / var_576_16

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_8 + var_576_16 and arg_573_1.time_ < var_576_8 + var_576_16 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play424031142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 424031142
		arg_577_1.duration_ = 3.9

		local var_577_0 = {
			zh = 3.066,
			ja = 3.9
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play424031143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1094"]) and arg_577_1.var_.actorSpriteComps1094 == nil then
				arg_577_1.var_.actorSpriteComps1094 = arg_577_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_0 = 0.2

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1094"]) then
				if arg_577_1.var_.actorSpriteComps1094 then
					for iter_580_0, iter_580_1 in pairs(arg_577_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_580_1 then
							if arg_577_1.isInRecall_ then
								iter_580_1.color = Color.New(Mathf.Lerp(iter_580_1.color.r, arg_577_1.hightColor1.r, (arg_577_1.time_ - 0) / var_580_0), Mathf.Lerp(iter_580_1.color.g, arg_577_1.hightColor1.g, (arg_577_1.time_ - 0) / var_580_0), (Mathf.Lerp(iter_580_1.color.b, arg_577_1.hightColor1.b, (arg_577_1.time_ - 0) / var_580_0)))
							else
								local var_580_1 = Mathf.Lerp(iter_580_1.color.r, 1, (arg_577_1.time_ - 0) / var_580_0)

								iter_580_1.color = Color.New(var_580_1, var_580_1, var_580_1)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1094"]) and arg_577_1.var_.actorSpriteComps1094 then
				for iter_580_2, iter_580_3 in pairs(arg_577_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_580_3 then
						iter_580_3.color = arg_577_1.isInRecall_ and (arg_577_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_577_1.var_.actorSpriteComps1094 = nil
			end

			local var_580_2 = arg_577_1.actors_["10154"]

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(var_580_2) and arg_577_1.var_.actorSpriteComps10154 == nil then
				arg_577_1.var_.actorSpriteComps10154 = var_580_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_3 = 0.2

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_3 and not isNil(var_580_2) then
				if arg_577_1.var_.actorSpriteComps10154 then
					for iter_580_4, iter_580_5 in pairs(arg_577_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_580_5 then
							if arg_577_1.isInRecall_ then
								iter_580_5.color = Color.New(Mathf.Lerp(iter_580_5.color.r, arg_577_1.hightColor2.r, (arg_577_1.time_ - 0) / var_580_3), Mathf.Lerp(iter_580_5.color.g, arg_577_1.hightColor2.g, (arg_577_1.time_ - 0) / var_580_3), (Mathf.Lerp(iter_580_5.color.b, arg_577_1.hightColor2.b, (arg_577_1.time_ - 0) / var_580_3)))
							else
								local var_580_4 = Mathf.Lerp(iter_580_5.color.r, 0.5, (arg_577_1.time_ - 0) / var_580_3)

								iter_580_5.color = Color.New(var_580_4, var_580_4, var_580_4)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= 0 + var_580_3 and arg_577_1.time_ < 0 + var_580_3 + arg_580_0 and not isNil(var_580_2) and arg_577_1.var_.actorSpriteComps10154 then
				for iter_580_6, iter_580_7 in pairs(arg_577_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_580_7 then
						iter_580_7.color = arg_577_1.isInRecall_ and (arg_577_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_577_1.var_.actorSpriteComps10154 = nil
			end

			local var_580_5 = arg_577_1.actors_["1094"].transform

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos1094 = var_580_5.localPosition
				var_580_5.localScale = Vector3.New(1, 1, 1)

				arg_577_1:CheckSpriteTmpPos("1094", 4)

				for iter_580_8 = 0, var_580_5.childCount - 1 do
					local var_580_6 = var_580_5:GetChild(iter_580_8)

					if var_580_6.name == "split_1" or not string.find(var_580_6.name, "split") then
						var_580_6.gameObject:SetActive(true)
					else
						var_580_6.gameObject:SetActive(false)
					end
				end
			end

			local var_580_7 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_7 then
				var_580_5.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_577_1.time_ - 0) / var_580_7)
			end

			if arg_577_1.time_ >= 0 + var_580_7 and arg_577_1.time_ < 0 + var_580_7 + arg_580_0 then
				var_580_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_580_8 = arg_577_1.actors_["10154"].transform

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos10154 = var_580_8.localPosition
				var_580_8.localScale = Vector3.New(1, 1, 1)

				arg_577_1:CheckSpriteTmpPos("10154", 7)

				for iter_580_9 = 0, var_580_8.childCount - 1 do
					local var_580_9 = var_580_8:GetChild(iter_580_9)

					if var_580_9.name == "split_1" or not string.find(var_580_9.name, "split") then
						var_580_9.gameObject:SetActive(true)
					else
						var_580_9.gameObject:SetActive(false)
					end
				end
			end

			local var_580_10 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_10 then
				var_580_8.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_577_1.time_ - 0) / var_580_10)
			end

			if arg_577_1.time_ >= 0 + var_580_10 and arg_577_1.time_ < 0 + var_580_10 + arg_580_0 then
				var_580_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_580_11 = 0
			local var_580_12 = 0.325

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_11 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_13 = arg_577_1:GetWordFromCfg(424031142)
				local var_580_14 = arg_577_1:FormatText(var_580_13.content)

				arg_577_1.text_.text = var_580_14

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_16 = 13 <= 0 and var_580_12 or var_580_12 * (utf8.len(var_580_14) / 13)

				if (13 <= 0 and var_580_12 or var_580_12 * (utf8.len(var_580_14) / 13)) > 0 and var_580_12 < var_580_16 then
					arg_577_1.talkMaxDuration = var_580_16

					if var_580_16 + var_580_11 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_16 + var_580_11
					end
				end

				arg_577_1.text_.text = var_580_14
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031142", "story_v_out_424031.awb") ~= 0 then
					local var_580_17 = manager.audio:GetVoiceLength("story_v_out_424031", "424031142", "story_v_out_424031.awb") / 1000

					if var_580_17 + var_580_11 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_17 + var_580_11
					end

					if var_580_13.prefab_name ~= "" and arg_577_1.actors_[var_580_13.prefab_name] ~= nil then
						local var_580_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_13.prefab_name].transform, "story_v_out_424031", "424031142", "story_v_out_424031.awb")

						arg_577_1:RecordAudio("424031142", var_580_18)
						arg_577_1:RecordAudio("424031142", var_580_18)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_out_424031", "424031142", "story_v_out_424031.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_out_424031", "424031142", "story_v_out_424031.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_19 = math.max(var_580_12, arg_577_1.talkMaxDuration)

			if var_580_11 <= arg_577_1.time_ and arg_577_1.time_ < var_580_11 + var_580_19 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_11) / var_580_19

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_11 + var_580_19 and arg_577_1.time_ < var_580_11 + var_580_19 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play424031143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 424031143
		arg_581_1.duration_ = 17.07

		local var_581_0 = {
			zh = 13.033,
			ja = 17.066
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play424031144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["10155"]) and arg_581_1.var_.actorSpriteComps10155 == nil then
				arg_581_1.var_.actorSpriteComps10155 = arg_581_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_584_0 = 0.2

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["10155"]) then
				if arg_581_1.var_.actorSpriteComps10155 then
					for iter_584_0, iter_584_1 in pairs(arg_581_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_584_1 then
							if arg_581_1.isInRecall_ then
								iter_584_1.color = Color.New(Mathf.Lerp(iter_584_1.color.r, arg_581_1.hightColor1.r, (arg_581_1.time_ - 0) / var_584_0), Mathf.Lerp(iter_584_1.color.g, arg_581_1.hightColor1.g, (arg_581_1.time_ - 0) / var_584_0), (Mathf.Lerp(iter_584_1.color.b, arg_581_1.hightColor1.b, (arg_581_1.time_ - 0) / var_584_0)))
							else
								local var_584_1 = Mathf.Lerp(iter_584_1.color.r, 1, (arg_581_1.time_ - 0) / var_584_0)

								iter_584_1.color = Color.New(var_584_1, var_584_1, var_584_1)
							end
						end
					end
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["10155"]) and arg_581_1.var_.actorSpriteComps10155 then
				for iter_584_2, iter_584_3 in pairs(arg_581_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_584_3 then
						iter_584_3.color = arg_581_1.isInRecall_ and (arg_581_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_581_1.var_.actorSpriteComps10155 = nil
			end

			local var_584_2 = arg_581_1.actors_["1094"]

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(var_584_2) and arg_581_1.var_.actorSpriteComps1094 == nil then
				arg_581_1.var_.actorSpriteComps1094 = var_584_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_584_3 = 0.2

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_3 and not isNil(var_584_2) then
				if arg_581_1.var_.actorSpriteComps1094 then
					for iter_584_4, iter_584_5 in pairs(arg_581_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_584_5 then
							if arg_581_1.isInRecall_ then
								iter_584_5.color = Color.New(Mathf.Lerp(iter_584_5.color.r, arg_581_1.hightColor2.r, (arg_581_1.time_ - 0) / var_584_3), Mathf.Lerp(iter_584_5.color.g, arg_581_1.hightColor2.g, (arg_581_1.time_ - 0) / var_584_3), (Mathf.Lerp(iter_584_5.color.b, arg_581_1.hightColor2.b, (arg_581_1.time_ - 0) / var_584_3)))
							else
								local var_584_4 = Mathf.Lerp(iter_584_5.color.r, 0.5, (arg_581_1.time_ - 0) / var_584_3)

								iter_584_5.color = Color.New(var_584_4, var_584_4, var_584_4)
							end
						end
					end
				end
			end

			if arg_581_1.time_ >= 0 + var_584_3 and arg_581_1.time_ < 0 + var_584_3 + arg_584_0 and not isNil(var_584_2) and arg_581_1.var_.actorSpriteComps1094 then
				for iter_584_6, iter_584_7 in pairs(arg_581_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_584_7 then
						iter_584_7.color = arg_581_1.isInRecall_ and (arg_581_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_581_1.var_.actorSpriteComps1094 = nil
			end

			local var_584_5 = arg_581_1.actors_["10155"].transform

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos10155 = var_584_5.localPosition
				var_584_5.localScale = Vector3.New(1, 1, 1)

				arg_581_1:CheckSpriteTmpPos("10155", 2)

				for iter_584_8 = 0, var_584_5.childCount - 1 do
					local var_584_6 = var_584_5:GetChild(iter_584_8)

					if var_584_6.name == "" or not string.find(var_584_6.name, "split") then
						var_584_6.gameObject:SetActive(true)
					else
						var_584_6.gameObject:SetActive(false)
					end
				end
			end

			local var_584_7 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_7 then
				var_584_5.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_581_1.time_ - 0) / var_584_7)
			end

			if arg_581_1.time_ >= 0 + var_584_7 and arg_581_1.time_ < 0 + var_584_7 + arg_584_0 then
				var_584_5.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_584_8 = 0
			local var_584_9 = 1.3

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_8 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_10 = arg_581_1:GetWordFromCfg(424031143)
				local var_584_11 = arg_581_1:FormatText(var_584_10.content)

				arg_581_1.text_.text = var_584_11

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_13 = 52 <= 0 and var_584_9 or var_584_9 * (utf8.len(var_584_11) / 52)

				if (52 <= 0 and var_584_9 or var_584_9 * (utf8.len(var_584_11) / 52)) > 0 and var_584_9 < var_584_13 then
					arg_581_1.talkMaxDuration = var_584_13

					if var_584_13 + var_584_8 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_13 + var_584_8
					end
				end

				arg_581_1.text_.text = var_584_11
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031143", "story_v_out_424031.awb") ~= 0 then
					local var_584_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031143", "story_v_out_424031.awb") / 1000

					if var_584_14 + var_584_8 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_14 + var_584_8
					end

					if var_584_10.prefab_name ~= "" and arg_581_1.actors_[var_584_10.prefab_name] ~= nil then
						local var_584_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_10.prefab_name].transform, "story_v_out_424031", "424031143", "story_v_out_424031.awb")

						arg_581_1:RecordAudio("424031143", var_584_15)
						arg_581_1:RecordAudio("424031143", var_584_15)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_424031", "424031143", "story_v_out_424031.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_424031", "424031143", "story_v_out_424031.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_16 = math.max(var_584_9, arg_581_1.talkMaxDuration)

			if var_584_8 <= arg_581_1.time_ and arg_581_1.time_ < var_584_8 + var_584_16 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_8) / var_584_16

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_8 + var_584_16 and arg_581_1.time_ < var_584_8 + var_584_16 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play424031144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 424031144
		arg_585_1.duration_ = 1.23

		local var_585_0 = {
			zh = 0.999999999999,
			ja = 1.233
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play424031145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["1094"]) and arg_585_1.var_.actorSpriteComps1094 == nil then
				arg_585_1.var_.actorSpriteComps1094 = arg_585_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_588_0 = 0.2

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["1094"]) then
				if arg_585_1.var_.actorSpriteComps1094 then
					for iter_588_0, iter_588_1 in pairs(arg_585_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_588_1 then
							if arg_585_1.isInRecall_ then
								iter_588_1.color = Color.New(Mathf.Lerp(iter_588_1.color.r, arg_585_1.hightColor1.r, (arg_585_1.time_ - 0) / var_588_0), Mathf.Lerp(iter_588_1.color.g, arg_585_1.hightColor1.g, (arg_585_1.time_ - 0) / var_588_0), (Mathf.Lerp(iter_588_1.color.b, arg_585_1.hightColor1.b, (arg_585_1.time_ - 0) / var_588_0)))
							else
								local var_588_1 = Mathf.Lerp(iter_588_1.color.r, 1, (arg_585_1.time_ - 0) / var_588_0)

								iter_588_1.color = Color.New(var_588_1, var_588_1, var_588_1)
							end
						end
					end
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["1094"]) and arg_585_1.var_.actorSpriteComps1094 then
				for iter_588_2, iter_588_3 in pairs(arg_585_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_588_3 then
						iter_588_3.color = arg_585_1.isInRecall_ and (arg_585_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_585_1.var_.actorSpriteComps1094 = nil
			end

			local var_588_2 = arg_585_1.actors_["10155"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_2) and arg_585_1.var_.actorSpriteComps10155 == nil then
				arg_585_1.var_.actorSpriteComps10155 = var_588_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_588_3 = 0.2

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_3 and not isNil(var_588_2) then
				if arg_585_1.var_.actorSpriteComps10155 then
					for iter_588_4, iter_588_5 in pairs(arg_585_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_588_5 then
							if arg_585_1.isInRecall_ then
								iter_588_5.color = Color.New(Mathf.Lerp(iter_588_5.color.r, arg_585_1.hightColor2.r, (arg_585_1.time_ - 0) / var_588_3), Mathf.Lerp(iter_588_5.color.g, arg_585_1.hightColor2.g, (arg_585_1.time_ - 0) / var_588_3), (Mathf.Lerp(iter_588_5.color.b, arg_585_1.hightColor2.b, (arg_585_1.time_ - 0) / var_588_3)))
							else
								local var_588_4 = Mathf.Lerp(iter_588_5.color.r, 0.5, (arg_585_1.time_ - 0) / var_588_3)

								iter_588_5.color = Color.New(var_588_4, var_588_4, var_588_4)
							end
						end
					end
				end
			end

			if arg_585_1.time_ >= 0 + var_588_3 and arg_585_1.time_ < 0 + var_588_3 + arg_588_0 and not isNil(var_588_2) and arg_585_1.var_.actorSpriteComps10155 then
				for iter_588_6, iter_588_7 in pairs(arg_585_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_588_7 then
						iter_588_7.color = arg_585_1.isInRecall_ and (arg_585_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_585_1.var_.actorSpriteComps10155 = nil
			end

			local var_588_5 = arg_585_1.actors_["1094"].transform

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.var_.moveOldPos1094 = var_588_5.localPosition
				var_588_5.localScale = Vector3.New(1, 1, 1)

				arg_585_1:CheckSpriteTmpPos("1094", 4)

				for iter_588_8 = 0, var_588_5.childCount - 1 do
					local var_588_6 = var_588_5:GetChild(iter_588_8)

					if var_588_6.name == "split_4" then
						var_588_6:SetAsLastSibling()
						var_588_6.gameObject:SetActive(true)

						arg_585_1.var_.actorSpriteSplit1094 = var_588_6.gameObject:GetComponent(typeof(Image))

						arg_585_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_588_7 = 0.5

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_7 then
				var_588_5.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_585_1.time_ - 0) / var_588_7)

				if arg_585_1.var_.actorSpriteSplit1094 ~= nil then
					arg_585_1.var_.actorSpriteSplit1094:SetAlpha((arg_585_1.time_ - 0) / var_588_7)
				end
			end

			if arg_585_1.time_ >= 0 + var_588_7 and arg_585_1.time_ < 0 + var_588_7 + arg_588_0 then
				var_588_5.localPosition = Vector3.New(470, -335, -230)

				if arg_585_1.var_.actorSpriteSplit1094 ~= nil then
					arg_585_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_588_8 = 0
			local var_588_9 = 0.05

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_8 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_10 = arg_585_1:GetWordFromCfg(424031144)
				local var_588_11 = arg_585_1:FormatText(var_588_10.content)

				arg_585_1.text_.text = var_588_11

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_13 = 2 <= 0 and var_588_9 or var_588_9 * (utf8.len(var_588_11) / 2)

				if (2 <= 0 and var_588_9 or var_588_9 * (utf8.len(var_588_11) / 2)) > 0 and var_588_9 < var_588_13 then
					arg_585_1.talkMaxDuration = var_588_13

					if var_588_13 + var_588_8 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_13 + var_588_8
					end
				end

				arg_585_1.text_.text = var_588_11
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031144", "story_v_out_424031.awb") ~= 0 then
					local var_588_14 = manager.audio:GetVoiceLength("story_v_out_424031", "424031144", "story_v_out_424031.awb") / 1000

					if var_588_14 + var_588_8 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_14 + var_588_8
					end

					if var_588_10.prefab_name ~= "" and arg_585_1.actors_[var_588_10.prefab_name] ~= nil then
						local var_588_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_10.prefab_name].transform, "story_v_out_424031", "424031144", "story_v_out_424031.awb")

						arg_585_1:RecordAudio("424031144", var_588_15)
						arg_585_1:RecordAudio("424031144", var_588_15)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_424031", "424031144", "story_v_out_424031.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_424031", "424031144", "story_v_out_424031.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_16 = math.max(var_588_9, arg_585_1.talkMaxDuration)

			if var_588_8 <= arg_585_1.time_ and arg_585_1.time_ < var_588_8 + var_588_16 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_8) / var_588_16

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_8 + var_588_16 and arg_585_1.time_ < var_588_8 + var_588_16 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play424031145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 424031145
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play424031146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["1094"]) and arg_589_1.var_.actorSpriteComps1094 == nil then
				arg_589_1.var_.actorSpriteComps1094 = arg_589_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_592_0 = 0.2

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["1094"]) then
				if arg_589_1.var_.actorSpriteComps1094 then
					for iter_592_0, iter_592_1 in pairs(arg_589_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_592_1 then
							if arg_589_1.isInRecall_ then
								iter_592_1.color = Color.New(Mathf.Lerp(iter_592_1.color.r, arg_589_1.hightColor2.r, (arg_589_1.time_ - 0) / var_592_0), Mathf.Lerp(iter_592_1.color.g, arg_589_1.hightColor2.g, (arg_589_1.time_ - 0) / var_592_0), (Mathf.Lerp(iter_592_1.color.b, arg_589_1.hightColor2.b, (arg_589_1.time_ - 0) / var_592_0)))
							else
								local var_592_1 = Mathf.Lerp(iter_592_1.color.r, 0.5, (arg_589_1.time_ - 0) / var_592_0)

								iter_592_1.color = Color.New(var_592_1, var_592_1, var_592_1)
							end
						end
					end
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["1094"]) and arg_589_1.var_.actorSpriteComps1094 then
				for iter_592_2, iter_592_3 in pairs(arg_589_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_592_3 then
						iter_592_3.color = arg_589_1.isInRecall_ and (arg_589_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_589_1.var_.actorSpriteComps1094 = nil
			end

			local var_592_2 = arg_589_1.actors_["1094"].transform

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos1094 = var_592_2.localPosition
				var_592_2.localScale = Vector3.New(1, 1, 1)

				arg_589_1:CheckSpriteTmpPos("1094", 7)

				for iter_592_4 = 0, var_592_2.childCount - 1 do
					local var_592_3 = var_592_2:GetChild(iter_592_4)

					if var_592_3.name == "" or not string.find(var_592_3.name, "split") then
						var_592_3.gameObject:SetActive(true)
					else
						var_592_3.gameObject:SetActive(false)
					end
				end
			end

			local var_592_4 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				var_592_2.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_589_1.time_ - 0) / var_592_4)
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				var_592_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_592_5 = arg_589_1.actors_["10155"].transform

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos10155 = var_592_5.localPosition
				var_592_5.localScale = Vector3.New(1, 1, 1)

				arg_589_1:CheckSpriteTmpPos("10155", 7)

				for iter_592_5 = 0, var_592_5.childCount - 1 do
					local var_592_6 = var_592_5:GetChild(iter_592_5)

					if var_592_6.name == "" or not string.find(var_592_6.name, "split") then
						var_592_6.gameObject:SetActive(true)
					else
						var_592_6.gameObject:SetActive(false)
					end
				end
			end

			local var_592_7 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_7 then
				var_592_5.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_589_1.time_ - 0) / var_592_7)
			end

			if arg_589_1.time_ >= 0 + var_592_7 and arg_589_1.time_ < 0 + var_592_7 + arg_592_0 then
				var_592_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_592_8 = 0
			local var_592_9 = 1.35

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_8 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_10 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(424031145).content)

				arg_589_1.text_.text = var_592_10

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_12 = 54 <= 0 and var_592_9 or var_592_9 * (utf8.len(var_592_10) / 54)

				if (54 <= 0 and var_592_9 or var_592_9 * (utf8.len(var_592_10) / 54)) > 0 and var_592_9 < var_592_12 then
					arg_589_1.talkMaxDuration = var_592_12

					if var_592_12 + var_592_8 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_12 + var_592_8
					end
				end

				arg_589_1.text_.text = var_592_10
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_13 = math.max(var_592_9, arg_589_1.talkMaxDuration)

			if var_592_8 <= arg_589_1.time_ and arg_589_1.time_ < var_592_8 + var_592_13 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_8) / var_592_13

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_8 + var_592_13 and arg_589_1.time_ < var_592_8 + var_592_13 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play424031146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 424031146
		arg_593_1.duration_ = 3.57

		local var_593_0 = {
			zh = 2.666,
			ja = 3.566
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play424031147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.3

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_1 = arg_593_1:GetWordFromCfg(424031146)
				local var_596_2 = arg_593_1:FormatText(var_596_1.content)

				arg_593_1.text_.text = var_596_2

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_4 = 12 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 12)

				if (12 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 12)) > 0 and var_596_0 < var_596_4 then
					arg_593_1.talkMaxDuration = var_596_4

					if var_596_4 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_4 + 0
					end
				end

				arg_593_1.text_.text = var_596_2
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031146", "story_v_out_424031.awb") ~= 0 then
					local var_596_5 = manager.audio:GetVoiceLength("story_v_out_424031", "424031146", "story_v_out_424031.awb") / 1000

					if var_596_5 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_5 + 0
					end

					if var_596_1.prefab_name ~= "" and arg_593_1.actors_[var_596_1.prefab_name] ~= nil then
						local var_596_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_1.prefab_name].transform, "story_v_out_424031", "424031146", "story_v_out_424031.awb")

						arg_593_1:RecordAudio("424031146", var_596_6)
						arg_593_1:RecordAudio("424031146", var_596_6)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_424031", "424031146", "story_v_out_424031.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_424031", "424031146", "story_v_out_424031.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_7 and arg_593_1.time_ < 0 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play424031147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 424031147
		arg_597_1.duration_ = 1.4

		local var_597_0 = {
			zh = 1.2,
			ja = 1.4
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play424031148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1094"]) and arg_597_1.var_.actorSpriteComps1094 == nil then
				arg_597_1.var_.actorSpriteComps1094 = arg_597_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_600_0 = 0.2

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1094"]) then
				if arg_597_1.var_.actorSpriteComps1094 then
					for iter_600_0, iter_600_1 in pairs(arg_597_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_600_1 then
							if arg_597_1.isInRecall_ then
								iter_600_1.color = Color.New(Mathf.Lerp(iter_600_1.color.r, arg_597_1.hightColor1.r, (arg_597_1.time_ - 0) / var_600_0), Mathf.Lerp(iter_600_1.color.g, arg_597_1.hightColor1.g, (arg_597_1.time_ - 0) / var_600_0), (Mathf.Lerp(iter_600_1.color.b, arg_597_1.hightColor1.b, (arg_597_1.time_ - 0) / var_600_0)))
							else
								local var_600_1 = Mathf.Lerp(iter_600_1.color.r, 1, (arg_597_1.time_ - 0) / var_600_0)

								iter_600_1.color = Color.New(var_600_1, var_600_1, var_600_1)
							end
						end
					end
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1094"]) and arg_597_1.var_.actorSpriteComps1094 then
				for iter_600_2, iter_600_3 in pairs(arg_597_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_600_3 then
						iter_600_3.color = arg_597_1.isInRecall_ and (arg_597_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_597_1.var_.actorSpriteComps1094 = nil
			end

			local var_600_2 = arg_597_1.actors_["1094"].transform

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.var_.moveOldPos1094 = var_600_2.localPosition
				var_600_2.localScale = Vector3.New(1, 1, 1)

				arg_597_1:CheckSpriteTmpPos("1094", 3)

				for iter_600_4 = 0, var_600_2.childCount - 1 do
					local var_600_3 = var_600_2:GetChild(iter_600_4)

					if var_600_3.name == "split_1" then
						var_600_3:SetAsLastSibling()
						var_600_3.gameObject:SetActive(true)

						arg_597_1.var_.actorSpriteSplit1094 = var_600_3.gameObject:GetComponent(typeof(Image))

						arg_597_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_600_4 = 0.001

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				var_600_2.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_597_1.time_ - 0) / var_600_4)

				if arg_597_1.var_.actorSpriteSplit1094 ~= nil then
					arg_597_1.var_.actorSpriteSplit1094:SetAlpha((arg_597_1.time_ - 0) / var_600_4)
				end
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				var_600_2.localPosition = Vector3.New(0, -335, -230)

				if arg_597_1.var_.actorSpriteSplit1094 ~= nil then
					arg_597_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_600_5 = 0
			local var_600_6 = 0.1

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_5 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_7 = arg_597_1:GetWordFromCfg(424031147)
				local var_600_8 = arg_597_1:FormatText(var_600_7.content)

				arg_597_1.text_.text = var_600_8

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_10 = 4 <= 0 and var_600_6 or var_600_6 * (utf8.len(var_600_8) / 4)

				if (4 <= 0 and var_600_6 or var_600_6 * (utf8.len(var_600_8) / 4)) > 0 and var_600_6 < var_600_10 then
					arg_597_1.talkMaxDuration = var_600_10

					if var_600_10 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_10 + var_600_5
					end
				end

				arg_597_1.text_.text = var_600_8
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031147", "story_v_out_424031.awb") ~= 0 then
					local var_600_11 = manager.audio:GetVoiceLength("story_v_out_424031", "424031147", "story_v_out_424031.awb") / 1000

					if var_600_11 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_11 + var_600_5
					end

					if var_600_7.prefab_name ~= "" and arg_597_1.actors_[var_600_7.prefab_name] ~= nil then
						local var_600_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_7.prefab_name].transform, "story_v_out_424031", "424031147", "story_v_out_424031.awb")

						arg_597_1:RecordAudio("424031147", var_600_12)
						arg_597_1:RecordAudio("424031147", var_600_12)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_424031", "424031147", "story_v_out_424031.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_424031", "424031147", "story_v_out_424031.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_13 = math.max(var_600_6, arg_597_1.talkMaxDuration)

			if var_600_5 <= arg_597_1.time_ and arg_597_1.time_ < var_600_5 + var_600_13 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_5) / var_600_13

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_5 + var_600_13 and arg_597_1.time_ < var_600_5 + var_600_13 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_597_1:InitPlayNodeList()
	end,
	Play424031148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 424031148
		arg_601_1.duration_ = 1

		local var_601_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
			arg_601_1.auto_ = false
		end

		function arg_601_1.playNext_(arg_603_0)
			arg_601_1.onStoryFinished_()
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["1094"]) and arg_601_1.var_.actorSpriteComps1094 == nil then
				arg_601_1.var_.actorSpriteComps1094 = arg_601_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_604_0 = 0.2

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["1094"]) then
				if arg_601_1.var_.actorSpriteComps1094 then
					for iter_604_0, iter_604_1 in pairs(arg_601_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_604_1 then
							if arg_601_1.isInRecall_ then
								iter_604_1.color = Color.New(Mathf.Lerp(iter_604_1.color.r, arg_601_1.hightColor2.r, (arg_601_1.time_ - 0) / var_604_0), Mathf.Lerp(iter_604_1.color.g, arg_601_1.hightColor2.g, (arg_601_1.time_ - 0) / var_604_0), (Mathf.Lerp(iter_604_1.color.b, arg_601_1.hightColor2.b, (arg_601_1.time_ - 0) / var_604_0)))
							else
								local var_604_1 = Mathf.Lerp(iter_604_1.color.r, 0.5, (arg_601_1.time_ - 0) / var_604_0)

								iter_604_1.color = Color.New(var_604_1, var_604_1, var_604_1)
							end
						end
					end
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["1094"]) and arg_601_1.var_.actorSpriteComps1094 then
				for iter_604_2, iter_604_3 in pairs(arg_601_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_604_3 then
						iter_604_3.color = arg_601_1.isInRecall_ and (arg_601_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_601_1.var_.actorSpriteComps1094 = nil
			end

			local var_604_2 = 0
			local var_604_3 = 0.075

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_2 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_4 = arg_601_1:GetWordFromCfg(424031148)
				local var_604_5 = arg_601_1:FormatText(var_604_4.content)

				arg_601_1.text_.text = var_604_5

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_7 = 3 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_5) / 3)

				if (3 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_5) / 3)) > 0 and var_604_3 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_2 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_2
					end
				end

				arg_601_1.text_.text = var_604_5
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424031", "424031148", "story_v_out_424031.awb") ~= 0 then
					local var_604_8 = manager.audio:GetVoiceLength("story_v_out_424031", "424031148", "story_v_out_424031.awb") / 1000

					if var_604_8 + var_604_2 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_8 + var_604_2
					end

					if var_604_4.prefab_name ~= "" and arg_601_1.actors_[var_604_4.prefab_name] ~= nil then
						local var_604_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_4.prefab_name].transform, "story_v_out_424031", "424031148", "story_v_out_424031.awb")

						arg_601_1:RecordAudio("424031148", var_604_9)
						arg_601_1:RecordAudio("424031148", var_604_9)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_424031", "424031148", "story_v_out_424031.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_424031", "424031148", "story_v_out_424031.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_10 = math.max(var_604_3, arg_601_1.talkMaxDuration)

			if var_604_2 <= arg_601_1.time_ and arg_601_1.time_ < var_604_2 + var_604_10 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_2) / var_604_10

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_2 + var_604_10 and arg_601_1.time_ < var_604_2 + var_604_10 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I18a",
		"TextureConfig/Background/ST0115",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/I11o"
	},
	voices = {
		"story_v_out_424031.awb"
	}
}
