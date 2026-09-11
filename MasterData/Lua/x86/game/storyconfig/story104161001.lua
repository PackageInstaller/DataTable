return {
	Play416101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416101001
		arg_1_1.duration_ = 8.17

		local var_1_0 = {
			zh = 5.932999999999,
			ja = 8.165999999999
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
				arg_1_0:Play416101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 1.999999999999 + 0.3 and arg_1_1.time_ < 1.999999999999 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "I13f"

			if arg_1_1.bgs_.I13f == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.I13f

				arg_1_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I13f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_9 = "10108"

			if arg_1_1.actors_["10108"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

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

			local var_4_12 = arg_1_1.actors_["10108"]

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10108 == nil then
				arg_1_1.var_.actorSpriteComps10108 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.125

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10108 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.66666666666667) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.66666666666667) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.66666666666667) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_13 and arg_1_1.time_ < 1.66666666666667 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10108 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10108 = nil
			end

			local var_4_15 = arg_1_1.actors_["10108"].transform

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10108 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10108", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_1_1.time_ - 1.66666666666667) / var_4_17)
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_17 and arg_1_1.time_ < 1.66666666666667 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -399.6, -130)
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10108"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10108 = var_4_18.alpha
					arg_1_1.var_.characterEffect10108 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10108 = 0
			end

			local var_4_19 = 0.857666666666667

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_19 then
				if arg_1_1.var_.characterEffect10108 then
					arg_1_1.var_.characterEffect10108.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10108, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_19 and arg_1_1.time_ < 1.66666666666667 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10108 then
				arg_1_1.var_.characterEffect10108.alpha = 1
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2")

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

			local var_4_26 = 1.999999999999
			local var_4_27 = 0.425

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(416101001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 17 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 17)

				if (17 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 17)) > 0 and var_4_27 < var_4_32 then
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

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101001", "story_v_out_416101.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_416101", "416101001", "story_v_out_416101.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_416101", "416101001", "story_v_out_416101.awb")

						arg_1_1:RecordAudio("416101001", var_4_34)
						arg_1_1:RecordAudio("416101001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416101", "416101001", "story_v_out_416101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416101", "416101001", "story_v_out_416101.awb")
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
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10108 = arg_9_1.actors_["10108"].transform.localPosition
				arg_9_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10108", 7)

				for iter_12_0 = 0, arg_9_1.actors_["10108"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10108"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_2 = 0
			local var_12_3 = 1.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416101002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 67 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 67)

				if (67 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 67)) > 0 and var_12_3 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_7 and arg_9_1.time_ < var_12_2 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416101003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.775

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(416101003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 71 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 71)

				if (71 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 71)) > 0 and var_16_0 < var_16_3 then
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
	Play416101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416101004
		arg_17_1.duration_ = 3.47

		local var_17_0 = {
			zh = 3.466,
			ja = 2.066
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
				arg_17_0:Play416101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10108 = arg_17_1.actors_["10108"].transform.localPosition
				arg_17_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10108", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10108"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10108"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10108"].transform.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_20_2 = arg_17_1.actors_["10108"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10108 == nil then
				arg_17_1.var_.actorSpriteComps10108 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10108 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10108 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10108 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.3

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(416101004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 12 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 12)

				if (12 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 12)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101004", "story_v_out_416101.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101004", "story_v_out_416101.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_416101", "416101004", "story_v_out_416101.awb")

						arg_17_1:RecordAudio("416101004", var_20_12)
						arg_17_1:RecordAudio("416101004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416101", "416101004", "story_v_out_416101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416101", "416101004", "story_v_out_416101.awb")
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
				actorName = "10108",
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
	Play416101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416101005
		arg_21_1.duration_ = 6.5

		local var_21_0 = {
			zh = 6.5,
			ja = 2.7
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
				arg_21_0:Play416101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10108"]) and arg_21_1.var_.actorSpriteComps10108 == nil then
				arg_21_1.var_.actorSpriteComps10108 = arg_21_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10108"]) then
				if arg_21_1.var_.actorSpriteComps10108 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10108"]) and arg_21_1.var_.actorSpriteComps10108 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10108 = nil
			end

			local var_24_2 = arg_21_1.actors_["10108"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10108 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				for iter_24_4 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_4)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10108, Vector3.New(-390, -399.6, -110), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(-390, -399.6, -110)
			end

			local var_24_5 = "1148"

			if arg_21_1.actors_["1148"] == nil then
				local var_24_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_24_6) then
					local var_24_7 = Object.Instantiate(var_24_6, arg_21_1.canvasGo_.transform)

					var_24_7.transform:SetSiblingIndex(1)

					var_24_7.name = var_24_5
					var_24_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_5] = var_24_7

					if arg_21_1.isInRecall_ then
						for iter_24_5, iter_24_6 in ipairs((var_24_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_6.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_8 = arg_21_1.actors_["1148"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 4)

				for iter_24_7 = 0, var_24_8.childCount - 1 do
					local var_24_9 = var_24_8:GetChild(iter_24_7)

					if var_24_9.name == "split_6" or not string.find(var_24_9.name, "split") then
						var_24_9.gameObject:SetActive(true)
					else
						var_24_9.gameObject:SetActive(false)
					end
				end
			end

			local var_24_10 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_10 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_21_1.time_ - 0) / var_24_10)
			end

			if arg_21_1.time_ >= 0 + var_24_10 and arg_21_1.time_ < 0 + var_24_10 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_24_11 = arg_21_1.actors_["1148"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = var_24_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_12 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_12 and not isNil(var_24_11) then
				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_24_9 then
							if arg_21_1.isInRecall_ then
								iter_24_9.color = Color.New(Mathf.Lerp(iter_24_9.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_12), Mathf.Lerp(iter_24_9.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_12), (Mathf.Lerp(iter_24_9.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_12)))
							else
								local var_24_13 = Mathf.Lerp(iter_24_9.color.r, 1, (arg_21_1.time_ - 0) / var_24_12)

								iter_24_9.color = Color.New(var_24_13, var_24_13, var_24_13)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_12 and arg_21_1.time_ < 0 + var_24_12 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_10, iter_24_11 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_11 then
						iter_24_11.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_14 = 0
			local var_24_15 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_16 = arg_21_1:GetWordFromCfg(416101005)
				local var_24_17 = arg_21_1:FormatText(var_24_16.content)

				arg_21_1.text_.text = var_24_17

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 15 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 15)

				if (15 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 15)) > 0 and var_24_15 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_14
					end
				end

				arg_21_1.text_.text = var_24_17
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101005", "story_v_out_416101.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_416101", "416101005", "story_v_out_416101.awb") / 1000

					if var_24_20 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_14
					end

					if var_24_16.prefab_name ~= "" and arg_21_1.actors_[var_24_16.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_16.prefab_name].transform, "story_v_out_416101", "416101005", "story_v_out_416101.awb")

						arg_21_1:RecordAudio("416101005", var_24_21)
						arg_21_1:RecordAudio("416101005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416101", "416101005", "story_v_out_416101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416101", "416101005", "story_v_out_416101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_15, arg_21_1.talkMaxDuration)

			if var_24_14 <= arg_21_1.time_ and arg_21_1.time_ < var_24_14 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_14) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_14 + var_24_22 and arg_21_1.time_ < var_24_14 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416101006
		arg_25_1.duration_ = 6.77

		local var_25_0 = {
			zh = 4.2,
			ja = 6.766
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
				arg_25_0:Play416101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(416101006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)

				if (17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101006", "story_v_out_416101.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101006", "story_v_out_416101.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_416101", "416101006", "story_v_out_416101.awb")

						arg_25_1:RecordAudio("416101006", var_28_6)
						arg_25_1:RecordAudio("416101006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416101", "416101006", "story_v_out_416101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416101", "416101006", "story_v_out_416101.awb")
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
	Play416101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416101007
		arg_29_1.duration_ = 14.27

		local var_29_0 = {
			zh = 6.766,
			ja = 14.266
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
				arg_29_0:Play416101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10108"]) and arg_29_1.var_.actorSpriteComps10108 == nil then
				arg_29_1.var_.actorSpriteComps10108 = arg_29_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10108"]) then
				if arg_29_1.var_.actorSpriteComps10108 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 1, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10108"]) and arg_29_1.var_.actorSpriteComps10108 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10108 = nil
			end

			local var_32_2 = arg_29_1.actors_["1148"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1148 == nil then
				arg_29_1.var_.actorSpriteComps1148 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps1148 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_5.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_5.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1148 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1148 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.625

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(416101007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 25 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 25)

				if (25 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 25)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101007", "story_v_out_416101.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101007", "story_v_out_416101.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_416101", "416101007", "story_v_out_416101.awb")

						arg_29_1:RecordAudio("416101007", var_32_12)
						arg_29_1:RecordAudio("416101007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416101", "416101007", "story_v_out_416101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416101", "416101007", "story_v_out_416101.awb")
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

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416101008
		arg_33_1.duration_ = 5.77

		local var_33_0 = {
			zh = 5.766,
			ja = 4.266
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
				arg_33_0:Play416101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10108"]) and arg_33_1.var_.actorSpriteComps10108 == nil then
				arg_33_1.var_.actorSpriteComps10108 = arg_33_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10108"]) then
				if arg_33_1.var_.actorSpriteComps10108 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10108"]) and arg_33_1.var_.actorSpriteComps10108 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10108 = nil
			end

			local var_36_2 = arg_33_1.actors_["1148"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_5.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_5.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(416101008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 21 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 21)

				if (21 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 21)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101008", "story_v_out_416101.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101008", "story_v_out_416101.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_416101", "416101008", "story_v_out_416101.awb")

						arg_33_1:RecordAudio("416101008", var_36_12)
						arg_33_1:RecordAudio("416101008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416101", "416101008", "story_v_out_416101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416101", "416101008", "story_v_out_416101.awb")
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
	Play416101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416101009
		arg_37_1.duration_ = 19.17

		local var_37_0 = {
			zh = 12.466,
			ja = 19.166
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
				arg_37_0:Play416101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10108"]) and arg_37_1.var_.actorSpriteComps10108 == nil then
				arg_37_1.var_.actorSpriteComps10108 = arg_37_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10108"]) then
				if arg_37_1.var_.actorSpriteComps10108 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10108"]) and arg_37_1.var_.actorSpriteComps10108 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10108 = nil
			end

			local var_40_2 = arg_37_1.actors_["1148"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1148 == nil then
				arg_37_1.var_.actorSpriteComps1148 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1148 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 1.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(416101009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 45 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 45)

				if (45 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 45)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101009", "story_v_out_416101.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101009", "story_v_out_416101.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_416101", "416101009", "story_v_out_416101.awb")

						arg_37_1:RecordAudio("416101009", var_40_12)
						arg_37_1:RecordAudio("416101009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416101", "416101009", "story_v_out_416101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416101", "416101009", "story_v_out_416101.awb")
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play416101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416101010
		arg_41_1.duration_ = 8.63

		local var_41_0 = {
			zh = 6.933,
			ja = 8.633
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
				arg_41_0:Play416101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(416101010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 27 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 27)

				if (27 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 27)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101010", "story_v_out_416101.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101010", "story_v_out_416101.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_416101", "416101010", "story_v_out_416101.awb")

						arg_41_1:RecordAudio("416101010", var_44_6)
						arg_41_1:RecordAudio("416101010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416101", "416101010", "story_v_out_416101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416101", "416101010", "story_v_out_416101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416101011
		arg_45_1.duration_ = 10.2

		local var_45_0 = {
			zh = 5.633,
			ja = 10.2
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
				arg_45_0:Play416101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10108"]) and arg_45_1.var_.actorSpriteComps10108 == nil then
				arg_45_1.var_.actorSpriteComps10108 = arg_45_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10108"]) then
				if arg_45_1.var_.actorSpriteComps10108 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10108"]) and arg_45_1.var_.actorSpriteComps10108 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10108 = nil
			end

			local var_48_2 = arg_45_1.actors_["1148"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1148 == nil then
				arg_45_1.var_.actorSpriteComps1148 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps1148 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								iter_48_5.color = Color.New(Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_5.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_5.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1148 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_48_7 then
						iter_48_7.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1148 = nil
			end

			local var_48_5 = arg_45_1.actors_["1148"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1148 = var_48_5.localPosition
				var_48_5.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1148", 4)

				for iter_48_8 = 0, var_48_5.childCount - 1 do
					local var_48_6 = var_48_5:GetChild(iter_48_8)

					if var_48_6.name == "split_4" or not string.find(var_48_6.name, "split") then
						var_48_6.gameObject:SetActive(true)
					else
						var_48_6.gameObject:SetActive(false)
					end
				end
			end

			local var_48_7 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_45_1.time_ - 0) / var_48_7)
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_48_8 = 0
			local var_48_9 = 0.6

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(416101011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 24 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 24)

				if (24 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 24)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101011", "story_v_out_416101.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_416101", "416101011", "story_v_out_416101.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_416101", "416101011", "story_v_out_416101.awb")

						arg_45_1:RecordAudio("416101011", var_48_15)
						arg_45_1:RecordAudio("416101011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416101", "416101011", "story_v_out_416101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416101", "416101011", "story_v_out_416101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416101012
		arg_49_1.duration_ = 6.4

		local var_49_0 = {
			zh = 5.066,
			ja = 6.4
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
				arg_49_0:Play416101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(416101012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 24 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 24)

				if (24 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 24)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101012", "story_v_out_416101.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101012", "story_v_out_416101.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_416101", "416101012", "story_v_out_416101.awb")

						arg_49_1:RecordAudio("416101012", var_52_6)
						arg_49_1:RecordAudio("416101012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416101", "416101012", "story_v_out_416101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416101", "416101012", "story_v_out_416101.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play416101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416101013
		arg_53_1.duration_ = 3.97

		local var_53_0 = {
			zh = 3.966,
			ja = 2
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
				arg_53_0:Play416101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(416101013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 15 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 15)

				if (15 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 15)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101013", "story_v_out_416101.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101013", "story_v_out_416101.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_416101", "416101013", "story_v_out_416101.awb")

						arg_53_1:RecordAudio("416101013", var_56_6)
						arg_53_1:RecordAudio("416101013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416101", "416101013", "story_v_out_416101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416101", "416101013", "story_v_out_416101.awb")
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
	Play416101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416101014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play416101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10108"]) and arg_57_1.var_.actorSpriteComps10108 == nil then
				arg_57_1.var_.actorSpriteComps10108 = arg_57_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10108"]) then
				if arg_57_1.var_.actorSpriteComps10108 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10108"]) and arg_57_1.var_.actorSpriteComps10108 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10108 = nil
			end

			local var_60_2 = arg_57_1.actors_["1148"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1148 == nil then
				arg_57_1.var_.actorSpriteComps1148 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1148 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1148 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1148 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 1.225

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

				local var_60_7 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(416101014).content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 49 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 49)

				if (49 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 49)) > 0 and var_60_6 < var_60_9 then
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

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416101015
		arg_61_1.duration_ = 3.57

		local var_61_0 = {
			zh = 0.999999999999,
			ja = 3.566
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
				arg_61_0:Play416101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1148"]) and arg_61_1.var_.actorSpriteComps1148 == nil then
				arg_61_1.var_.actorSpriteComps1148 = arg_61_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.125

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1148"]) then
				if arg_61_1.var_.actorSpriteComps1148 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1148"]) and arg_61_1.var_.actorSpriteComps1148 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1148 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(416101015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 4 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 4)

				if (4 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 4)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101015", "story_v_out_416101.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101015", "story_v_out_416101.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_416101", "416101015", "story_v_out_416101.awb")

						arg_61_1:RecordAudio("416101015", var_64_9)
						arg_61_1:RecordAudio("416101015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416101", "416101015", "story_v_out_416101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416101", "416101015", "story_v_out_416101.awb")
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
	Play416101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416101016
		arg_65_1.duration_ = 10

		local var_65_0 = {
			zh = 5.8,
			ja = 10
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
				arg_65_0:Play416101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1148"]) and arg_65_1.var_.actorSpriteComps1148 == nil then
				arg_65_1.var_.actorSpriteComps1148 = arg_65_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.125

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1148"]) then
				if arg_65_1.var_.actorSpriteComps1148 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1148"]) and arg_65_1.var_.actorSpriteComps1148 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1148 = nil
			end

			local var_68_2 = arg_65_1.actors_["10108"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10108 == nil then
				arg_65_1.var_.actorSpriteComps10108 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.125

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10108 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10108 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10108 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.525

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(416101016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 21 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 21)

				if (21 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 21)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101016", "story_v_out_416101.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101016", "story_v_out_416101.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_416101", "416101016", "story_v_out_416101.awb")

						arg_65_1:RecordAudio("416101016", var_68_12)
						arg_65_1:RecordAudio("416101016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416101", "416101016", "story_v_out_416101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416101", "416101016", "story_v_out_416101.awb")
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play416101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416101017
		arg_69_1.duration_ = 4.17

		local var_69_0 = {
			zh = 3.6,
			ja = 4.166
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
				arg_69_0:Play416101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10108"]) and arg_69_1.var_.actorSpriteComps10108 == nil then
				arg_69_1.var_.actorSpriteComps10108 = arg_69_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.125

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10108"]) then
				if arg_69_1.var_.actorSpriteComps10108 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10108"]) and arg_69_1.var_.actorSpriteComps10108 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10108 = nil
			end

			local var_72_2 = arg_69_1.actors_["1148"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1148 == nil then
				arg_69_1.var_.actorSpriteComps1148 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.125

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1148 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_5.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_5.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1148 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1148 = nil
			end

			local var_72_5 = 0
			local var_72_6 = 0.325

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(416101017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 13 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 13)

				if (13 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 13)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101017", "story_v_out_416101.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101017", "story_v_out_416101.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_416101", "416101017", "story_v_out_416101.awb")

						arg_69_1:RecordAudio("416101017", var_72_12)
						arg_69_1:RecordAudio("416101017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416101", "416101017", "story_v_out_416101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416101", "416101017", "story_v_out_416101.awb")
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

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play416101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416101018
		arg_73_1.duration_ = 10.97

		local var_73_0 = {
			zh = 6.1,
			ja = 10.966
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
				arg_73_0:Play416101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10108"]) and arg_73_1.var_.actorSpriteComps10108 == nil then
				arg_73_1.var_.actorSpriteComps10108 = arg_73_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.125

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10108"]) then
				if arg_73_1.var_.actorSpriteComps10108 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10108"]) and arg_73_1.var_.actorSpriteComps10108 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10108 = nil
			end

			local var_76_2 = arg_73_1.actors_["1148"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1148 == nil then
				arg_73_1.var_.actorSpriteComps1148 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.125

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps1148 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								iter_76_5.color = Color.New(Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_5.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_5.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1148 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_76_7 then
						iter_76_7.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1148 = nil
			end

			local var_76_5 = 0
			local var_76_6 = 0.6

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(416101018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 24 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 24)

				if (24 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 24)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101018", "story_v_out_416101.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101018", "story_v_out_416101.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_416101", "416101018", "story_v_out_416101.awb")

						arg_73_1:RecordAudio("416101018", var_76_12)
						arg_73_1:RecordAudio("416101018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416101", "416101018", "story_v_out_416101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416101", "416101018", "story_v_out_416101.awb")
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

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play416101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416101019
		arg_77_1.duration_ = 9.73

		local var_77_0 = {
			zh = 8.9,
			ja = 9.733
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
				arg_77_0:Play416101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.7

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(416101019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 28 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 28)

				if (28 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 28)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101019", "story_v_out_416101.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101019", "story_v_out_416101.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_416101", "416101019", "story_v_out_416101.awb")

						arg_77_1:RecordAudio("416101019", var_80_6)
						arg_77_1:RecordAudio("416101019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416101", "416101019", "story_v_out_416101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416101", "416101019", "story_v_out_416101.awb")
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
	Play416101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416101020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play416101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148 = arg_81_1.actors_["1148"].transform.localPosition
				arg_81_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1148", 7)

				for iter_84_0 = 0, arg_81_1.actors_["1148"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["1148"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_2 = arg_81_1.actors_["10108"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10108 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10108", 7)

				for iter_84_1 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_1)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_5 = 0
			local var_84_6 = 1.025

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(416101020).content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 41 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 41)

				if (41 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 41)) > 0 and var_84_6 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_10 and arg_81_1.time_ < var_84_5 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416101021
		arg_85_1.duration_ = 7.23

		local var_85_0 = {
			zh = 4.2,
			ja = 7.233
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
				arg_85_0:Play416101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148 = arg_85_1.actors_["1148"].transform.localPosition
				arg_85_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1148", 3)

				for iter_88_0 = 0, arg_85_1.actors_["1148"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1148"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_4" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_88_2 = arg_85_1.actors_["1148"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1148 == nil then
				arg_85_1.var_.actorSpriteComps1148 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1148 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1148 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1148 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(416101021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 17 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 17)

				if (17 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 17)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101021", "story_v_out_416101.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101021", "story_v_out_416101.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416101", "416101021", "story_v_out_416101.awb")

						arg_85_1:RecordAudio("416101021", var_88_12)
						arg_85_1:RecordAudio("416101021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416101", "416101021", "story_v_out_416101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416101", "416101021", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416101022
		arg_89_1.duration_ = 6

		local var_89_0 = {
			zh = 3.6,
			ja = 6
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
				arg_89_0:Play416101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(416101022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 19 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 19)

				if (19 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 19)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101022", "story_v_out_416101.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101022", "story_v_out_416101.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_416101", "416101022", "story_v_out_416101.awb")

						arg_89_1:RecordAudio("416101022", var_92_6)
						arg_89_1:RecordAudio("416101022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416101", "416101022", "story_v_out_416101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416101", "416101022", "story_v_out_416101.awb")
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
	Play416101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416101023
		arg_93_1.duration_ = 4.3

		local var_93_0 = {
			zh = 2.966,
			ja = 4.3
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
				arg_93_0:Play416101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148 = arg_93_1.actors_["1148"].transform.localPosition
				arg_93_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1148", 3)

				for iter_96_0 = 0, arg_93_1.actors_["1148"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["1148"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_6" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_96_2 = 0
			local var_96_3 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(416101023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 12 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 12)

				if (12 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 12)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101023", "story_v_out_416101.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101023", "story_v_out_416101.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_416101", "416101023", "story_v_out_416101.awb")

						arg_93_1:RecordAudio("416101023", var_96_9)
						arg_93_1:RecordAudio("416101023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416101", "416101023", "story_v_out_416101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416101", "416101023", "story_v_out_416101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416101024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1148"]) and arg_97_1.var_.actorSpriteComps1148 == nil then
				arg_97_1.var_.actorSpriteComps1148 = arg_97_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.125

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1148"]) then
				if arg_97_1.var_.actorSpriteComps1148 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1148"]) and arg_97_1.var_.actorSpriteComps1148 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1148 = nil
			end

			local var_100_2 = arg_97_1.actors_["1148"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1148 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1148", 7)

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
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_5 = 0
			local var_100_6 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(416101024).content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 45 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 45)

				if (45 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 45)) > 0 and var_100_6 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_10 and arg_97_1.time_ < var_100_5 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416101025
		arg_101_1.duration_ = 10.23

		local var_101_0 = {
			zh = 7.3,
			ja = 10.233
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
				arg_101_0:Play416101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1148"]) and arg_101_1.var_.actorSpriteComps1148 == nil then
				arg_101_1.var_.actorSpriteComps1148 = arg_101_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.125

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1148"]) then
				if arg_101_1.var_.actorSpriteComps1148 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1148"]) and arg_101_1.var_.actorSpriteComps1148 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1148 = nil
			end

			local var_104_2 = arg_101_1.actors_["1148"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148 = var_104_2.localPosition
				var_104_2.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1148", 3)

				for iter_104_4 = 0, var_104_2.childCount - 1 do
					local var_104_3 = var_104_2:GetChild(iter_104_4)

					if var_104_3.name == "split_6" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_101_1.time_ - 0) / var_104_4)
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_104_5 = 0
			local var_104_6 = 0.775

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(416101025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 31 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 31)

				if (31 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 31)) > 0 and var_104_6 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101025", "story_v_out_416101.awb") ~= 0 then
					local var_104_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101025", "story_v_out_416101.awb") / 1000

					if var_104_11 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_5
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_416101", "416101025", "story_v_out_416101.awb")

						arg_101_1:RecordAudio("416101025", var_104_12)
						arg_101_1:RecordAudio("416101025", var_104_12)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416101", "416101025", "story_v_out_416101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416101", "416101025", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416101026
		arg_105_1.duration_ = 5.5

		local var_105_0 = {
			zh = 3.5,
			ja = 5.5
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
				arg_105_0:Play416101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(416101026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 16 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 16)

				if (16 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 16)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101026", "story_v_out_416101.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101026", "story_v_out_416101.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_416101", "416101026", "story_v_out_416101.awb")

						arg_105_1:RecordAudio("416101026", var_108_6)
						arg_105_1:RecordAudio("416101026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416101", "416101026", "story_v_out_416101.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416101", "416101026", "story_v_out_416101.awb")
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
	Play416101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416101027
		arg_109_1.duration_ = 3.4

		local var_109_0 = {
			zh = 3.4,
			ja = 3.2
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
				arg_109_0:Play416101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1148 = arg_109_1.actors_["1148"].transform.localPosition
				arg_109_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1148", 7)

				for iter_112_0 = 0, arg_109_1.actors_["1148"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["1148"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_2 = arg_109_1.actors_["10108"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10108 = var_112_2.localPosition
				var_112_2.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10108", 7)

				for iter_112_1 = 0, var_112_2.childCount - 1 do
					local var_112_3 = var_112_2:GetChild(iter_112_1)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_2.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_109_1.time_ - 0) / var_112_4)
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_5 = 0
			local var_112_6 = 0.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_7 = arg_109_1:GetWordFromCfg(416101027)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 16 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 16)

				if (16 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 16)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101027", "story_v_out_416101.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101027", "story_v_out_416101.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_416101", "416101027", "story_v_out_416101.awb")

						arg_109_1:RecordAudio("416101027", var_112_12)
						arg_109_1:RecordAudio("416101027", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416101", "416101027", "story_v_out_416101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416101", "416101027", "story_v_out_416101.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416101028
		arg_113_1.duration_ = 5.27

		local var_113_0 = {
			zh = 5.266,
			ja = 4.333
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
				arg_113_0:Play416101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1148 = arg_113_1.actors_["1148"].transform.localPosition
				arg_113_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1148", 3)

				for iter_116_0 = 0, arg_113_1.actors_["1148"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["1148"].transform:GetChild(iter_116_0)

					if var_116_0.name == "split_6" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_116_2 = arg_113_1.actors_["1148"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1148 == nil then
				arg_113_1.var_.actorSpriteComps1148 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.125

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps1148 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 1, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1148 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps1148 = nil
			end

			local var_116_5 = 0
			local var_116_6 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(416101028)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 21 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 21)

				if (21 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 21)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101028", "story_v_out_416101.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101028", "story_v_out_416101.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_416101", "416101028", "story_v_out_416101.awb")

						arg_113_1:RecordAudio("416101028", var_116_12)
						arg_113_1:RecordAudio("416101028", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416101", "416101028", "story_v_out_416101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416101", "416101028", "story_v_out_416101.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416101029
		arg_117_1.duration_ = 3.6

		local var_117_0 = {
			zh = 3.366,
			ja = 3.6
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
				arg_117_0:Play416101030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(416101029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 14 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 14)

				if (14 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 14)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101029", "story_v_out_416101.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101029", "story_v_out_416101.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_416101", "416101029", "story_v_out_416101.awb")

						arg_117_1:RecordAudio("416101029", var_120_6)
						arg_117_1:RecordAudio("416101029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416101", "416101029", "story_v_out_416101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416101", "416101029", "story_v_out_416101.awb")
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
	Play416101030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416101030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play416101031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1148 = arg_121_1.actors_["1148"].transform.localPosition
				arg_121_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1148", 7)

				for iter_124_0 = 0, arg_121_1.actors_["1148"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["1148"].transform:GetChild(iter_124_0)

					if var_124_0.name == "" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_2 = 0
			local var_124_3 = 1.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(416101030).content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 46 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 46)

				if (46 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 46)) > 0 and var_124_3 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_7 and arg_121_1.time_ < var_124_2 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416101031
		arg_125_1.duration_ = 3.33

		local var_125_0 = {
			zh = 2.066,
			ja = 3.333
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
				arg_125_0:Play416101032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1148 = arg_125_1.actors_["1148"].transform.localPosition
				arg_125_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1148", 3)

				for iter_128_0 = 0, arg_125_1.actors_["1148"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["1148"].transform:GetChild(iter_128_0)

					if var_128_0.name == "split_6" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_128_2 = arg_125_1.actors_["1148"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1148 == nil then
				arg_125_1.var_.actorSpriteComps1148 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps1148 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1148 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_128_4 then
						iter_128_4.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps1148 = nil
			end

			local var_128_5 = 0
			local var_128_6 = 0.225

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(416101031)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 9 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 9)

				if (9 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 9)) > 0 and var_128_6 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101031", "story_v_out_416101.awb") ~= 0 then
					local var_128_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101031", "story_v_out_416101.awb") / 1000

					if var_128_11 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_5
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_416101", "416101031", "story_v_out_416101.awb")

						arg_125_1:RecordAudio("416101031", var_128_12)
						arg_125_1:RecordAudio("416101031", var_128_12)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416101", "416101031", "story_v_out_416101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416101", "416101031", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416101032
		arg_129_1.duration_ = 5.83

		local var_129_0 = {
			zh = 5.833,
			ja = 3.733
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
				arg_129_0:Play416101033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148 = arg_129_1.actors_["1148"].transform.localPosition
				arg_129_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1148", 3)

				for iter_132_0 = 0, arg_129_1.actors_["1148"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["1148"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_1_1" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_132_2 = 0
			local var_132_3 = 0.675

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(416101032)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 27 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 27)

				if (27 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 27)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101032", "story_v_out_416101.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101032", "story_v_out_416101.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_416101", "416101032", "story_v_out_416101.awb")

						arg_129_1:RecordAudio("416101032", var_132_9)
						arg_129_1:RecordAudio("416101032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416101", "416101032", "story_v_out_416101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416101", "416101032", "story_v_out_416101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416101033
		arg_133_1.duration_ = 3.2

		local var_133_0 = {
			zh = 2.6,
			ja = 3.2
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
				arg_133_0:Play416101034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1148"]) and arg_133_1.var_.actorSpriteComps1148 == nil then
				arg_133_1.var_.actorSpriteComps1148 = arg_133_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.125

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1148"]) then
				if arg_133_1.var_.actorSpriteComps1148 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1148"]) and arg_133_1.var_.actorSpriteComps1148 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps1148 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 0.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_4 = arg_133_1:GetWordFromCfg(416101033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 11 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 11)

				if (11 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 11)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101033", "story_v_out_416101.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101033", "story_v_out_416101.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_416101", "416101033", "story_v_out_416101.awb")

						arg_133_1:RecordAudio("416101033", var_136_9)
						arg_133_1:RecordAudio("416101033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416101", "416101033", "story_v_out_416101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416101", "416101033", "story_v_out_416101.awb")
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
	Play416101034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416101034
		arg_137_1.duration_ = 7.27

		local var_137_0 = {
			zh = 4.666,
			ja = 7.266
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
				arg_137_0:Play416101035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1148"]) and arg_137_1.var_.actorSpriteComps1148 == nil then
				arg_137_1.var_.actorSpriteComps1148 = arg_137_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.125

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1148"]) then
				if arg_137_1.var_.actorSpriteComps1148 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 1, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1148"]) and arg_137_1.var_.actorSpriteComps1148 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps1148 = nil
			end

			local var_140_2 = arg_137_1.actors_["1148"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1148 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1148", 3)

				for iter_140_4 = 0, var_140_2.childCount - 1 do
					local var_140_3 = var_140_2:GetChild(iter_140_4)

					if var_140_3.name == "split_1_1" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_137_1.time_ - 0) / var_140_4)
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_140_5 = 0
			local var_140_6 = 0.475

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(416101034)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 19 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 19)

				if (19 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 19)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101034", "story_v_out_416101.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101034", "story_v_out_416101.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_416101", "416101034", "story_v_out_416101.awb")

						arg_137_1:RecordAudio("416101034", var_140_12)
						arg_137_1:RecordAudio("416101034", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416101", "416101034", "story_v_out_416101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416101", "416101034", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416101035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416101036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148 = arg_141_1.actors_["1148"].transform.localPosition
				arg_141_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1148", 7)

				for iter_144_0 = 0, arg_141_1.actors_["1148"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["1148"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:AudioAction("play", "effect", "se_story_16", "se_story_16_archery", "")
			end

			local var_144_3 = 0
			local var_144_4 = 1.8

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_5 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(416101035).content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 72 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_5) / 72)

				if (72 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_5) / 72)) > 0 and var_144_4 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_3 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_3
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_4, arg_141_1.talkMaxDuration)

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_3) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_3 + var_144_8 and arg_141_1.time_ < var_144_3 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416101036
		arg_145_1.duration_ = 7.27

		local var_145_0 = {
			zh = 4.766,
			ja = 7.266
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
				arg_145_0:Play416101037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1148 = arg_145_1.actors_["1148"].transform.localPosition
				arg_145_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1148", 3)

				for iter_148_0 = 0, arg_145_1.actors_["1148"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1148"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_6" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_148_2 = arg_145_1.actors_["1148"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1148 == nil then
				arg_145_1.var_.actorSpriteComps1148 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.125

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1148 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1148 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1148 = nil
			end

			local var_148_5 = 0
			local var_148_6 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:GetWordFromCfg(416101036)
				local var_148_8 = arg_145_1:FormatText(var_148_7.content)

				arg_145_1.text_.text = var_148_8

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 20 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 20)

				if (20 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 20)) > 0 and var_148_6 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_8
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101036", "story_v_out_416101.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101036", "story_v_out_416101.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_416101", "416101036", "story_v_out_416101.awb")

						arg_145_1:RecordAudio("416101036", var_148_12)
						arg_145_1:RecordAudio("416101036", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416101", "416101036", "story_v_out_416101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416101", "416101036", "story_v_out_416101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_13 and arg_145_1.time_ < var_148_5 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416101037
		arg_149_1.duration_ = 4.07

		local var_149_0 = {
			zh = 2.8,
			ja = 4.066
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
				arg_149_0:Play416101038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.3

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(416101037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 12 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 12)

				if (12 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 12)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101037", "story_v_out_416101.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101037", "story_v_out_416101.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_416101", "416101037", "story_v_out_416101.awb")

						arg_149_1:RecordAudio("416101037", var_152_6)
						arg_149_1:RecordAudio("416101037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416101", "416101037", "story_v_out_416101.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416101", "416101037", "story_v_out_416101.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416101038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416101038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play416101039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1148 = arg_153_1.actors_["1148"].transform.localPosition
				arg_153_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1148", 7)

				for iter_156_0 = 0, arg_153_1.actors_["1148"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1148"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_2 = 0
			local var_156_3 = 1.2

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(416101038).content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 48 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 48)

				if (48 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 48)) > 0 and var_156_3 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_7 and arg_153_1.time_ < var_156_2 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416101039
		arg_157_1.duration_ = 9

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416101040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 4 < arg_157_1.time_ and arg_157_1.time_ <= 4 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= 4 + 0.3 and arg_157_1.time_ < 4 + 0.3 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_0 = arg_157_1.bgs_.I13f

				arg_157_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_1 = var_160_0:GetComponent("SpriteRenderer")

				if var_160_1 and var_160_1.sprite then
					local var_160_2 = 2 * (var_160_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_0.transform.localScale = Vector3.New(var_160_2 / var_160_1.sprite.bounds.size.y < var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x and var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x or var_160_2 / var_160_1.sprite.bounds.size.y, var_160_2 / var_160_1.sprite.bounds.size.y < var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x and var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x or var_160_2 / var_160_1.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "I13f" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_3 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_4 = 2

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_4 then
				local var_160_5 = Color.New(0, 0, 0)

				var_160_5.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_3) / var_160_4)
				arg_157_1.mask_.color = var_160_5
			end

			if arg_157_1.time_ >= var_160_3 + var_160_4 and arg_157_1.time_ < var_160_3 + var_160_4 + arg_160_0 then
				local var_160_6 = Color.New(0, 0, 0)

				var_160_6.a = 1
				arg_157_1.mask_.color = var_160_6
			end

			local var_160_7 = 2

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_8 = 2

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 then
				local var_160_9 = Color.New(0, 0, 0)

				var_160_9.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_7) / var_160_8)
				arg_157_1.mask_.color = var_160_9
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 then
				local var_160_10 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_10.a = 0
				arg_157_1.mask_.color = var_160_10
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_11 = 4
			local var_160_12 = 1.625

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_13 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_13:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_14 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(416101039).content)

				arg_157_1.text_.text = var_160_14

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_16 = 65 <= 0 and var_160_12 or var_160_12 * (utf8.len(var_160_14) / 65)

				if (65 <= 0 and var_160_12 or var_160_12 * (utf8.len(var_160_14) / 65)) > 0 and var_160_12 < var_160_16 then
					arg_157_1.talkMaxDuration = var_160_16
					var_160_11 = var_160_11 + 0.3

					if var_160_16 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_16 + var_160_11
					end
				end

				arg_157_1.text_.text = var_160_14
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_17 = var_160_11 + 0.3
			local var_160_18 = math.max(var_160_12, arg_157_1.talkMaxDuration)

			if var_160_11 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_17 + var_160_18 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_17) / var_160_18

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_17 + var_160_18 and arg_157_1.time_ < var_160_17 + var_160_18 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416101040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416101040
		arg_163_1.duration_ = 4.9

		local var_163_0 = {
			zh = 4.333,
			ja = 4.9
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
				arg_163_0:Play416101041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148 = arg_163_1.actors_["1148"].transform.localPosition
				arg_163_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1148", 3)

				for iter_166_0 = 0, arg_163_1.actors_["1148"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1148"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_6" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_166_2 = arg_163_1.actors_["1148"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1148 == nil then
				arg_163_1.var_.actorSpriteComps1148 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.125

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps1148 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_2.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_2.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1148 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1148 = nil
			end

			local var_166_5 = 0
			local var_166_6 = 0.4

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(416101040)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 16 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 16)

				if (16 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 16)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101040", "story_v_out_416101.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101040", "story_v_out_416101.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_416101", "416101040", "story_v_out_416101.awb")

						arg_163_1:RecordAudio("416101040", var_166_12)
						arg_163_1:RecordAudio("416101040", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416101", "416101040", "story_v_out_416101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416101", "416101040", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416101041
		arg_167_1.duration_ = 6.33

		local var_167_0 = {
			zh = 6.333,
			ja = 4.366
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
				arg_167_0:Play416101042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.6

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(416101041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 24 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 24)

				if (24 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 24)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101041", "story_v_out_416101.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101041", "story_v_out_416101.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_416101", "416101041", "story_v_out_416101.awb")

						arg_167_1:RecordAudio("416101041", var_170_6)
						arg_167_1:RecordAudio("416101041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416101", "416101041", "story_v_out_416101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416101", "416101041", "story_v_out_416101.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play416101042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416101042
		arg_171_1.duration_ = 8.33

		local var_171_0 = {
			zh = 5.6,
			ja = 8.333
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
				arg_171_0:Play416101043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1148 = arg_171_1.actors_["1148"].transform.localPosition
				arg_171_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1148", 2)

				for iter_174_0 = 0, arg_171_1.actors_["1148"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["1148"].transform:GetChild(iter_174_0)

					if var_174_0.name == "split_6" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_174_2 = arg_171_1.actors_["1148"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1148 == nil then
				arg_171_1.var_.actorSpriteComps1148 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.125

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps1148 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1148 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_174_4 then
						iter_174_4.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps1148 = nil
			end

			local var_174_5 = arg_171_1.actors_["10108"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10108 = var_174_5.localPosition
				var_174_5.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10108", 4)

				for iter_174_5 = 0, var_174_5.childCount - 1 do
					local var_174_6 = var_174_5:GetChild(iter_174_5)

					if var_174_6.name == "" or not string.find(var_174_6.name, "split") then
						var_174_6.gameObject:SetActive(true)
					else
						var_174_6.gameObject:SetActive(false)
					end
				end
			end

			local var_174_7 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				var_174_5.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_171_1.time_ - 0) / var_174_7)
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				var_174_5.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_174_8 = arg_171_1.actors_["10108"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10108 == nil then
				arg_171_1.var_.actorSpriteComps10108 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 0.125

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_9 and not isNil(var_174_8) then
				if arg_171_1.var_.actorSpriteComps10108 then
					for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_174_7 then
							if arg_171_1.isInRecall_ then
								iter_174_7.color = Color.New(Mathf.Lerp(iter_174_7.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_9), Mathf.Lerp(iter_174_7.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_9), (Mathf.Lerp(iter_174_7.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_9)))
							else
								local var_174_10 = Mathf.Lerp(iter_174_7.color.r, 1, (arg_171_1.time_ - 0) / var_174_9)

								iter_174_7.color = Color.New(var_174_10, var_174_10, var_174_10)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_9 and arg_171_1.time_ < 0 + var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10108 then
				for iter_174_8, iter_174_9 in pairs(arg_171_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_174_9 then
						iter_174_9.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10108 = nil
			end

			local var_174_11 = 0
			local var_174_12 = 0.5

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:GetWordFromCfg(416101042)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_16 = 20 <= 0 and var_174_12 or var_174_12 * (utf8.len(var_174_14) / 20)

				if (20 <= 0 and var_174_12 or var_174_12 * (utf8.len(var_174_14) / 20)) > 0 and var_174_12 < var_174_16 then
					arg_171_1.talkMaxDuration = var_174_16

					if var_174_16 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_16 + var_174_11
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101042", "story_v_out_416101.awb") ~= 0 then
					local var_174_17 = manager.audio:GetVoiceLength("story_v_out_416101", "416101042", "story_v_out_416101.awb") / 1000

					if var_174_17 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_11
					end

					if var_174_13.prefab_name ~= "" and arg_171_1.actors_[var_174_13.prefab_name] ~= nil then
						local var_174_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_13.prefab_name].transform, "story_v_out_416101", "416101042", "story_v_out_416101.awb")

						arg_171_1:RecordAudio("416101042", var_174_18)
						arg_171_1:RecordAudio("416101042", var_174_18)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416101", "416101042", "story_v_out_416101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416101", "416101042", "story_v_out_416101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_19 = math.max(var_174_12, arg_171_1.talkMaxDuration)

			if var_174_11 <= arg_171_1.time_ and arg_171_1.time_ < var_174_11 + var_174_19 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_11) / var_174_19

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_11 + var_174_19 and arg_171_1.time_ < var_174_11 + var_174_19 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416101043
		arg_175_1.duration_ = 8.23

		local var_175_0 = {
			zh = 6,
			ja = 8.233
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
				arg_175_0:Play416101044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(416101043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101043", "story_v_out_416101.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101043", "story_v_out_416101.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_416101", "416101043", "story_v_out_416101.awb")

						arg_175_1:RecordAudio("416101043", var_178_6)
						arg_175_1:RecordAudio("416101043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416101", "416101043", "story_v_out_416101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416101", "416101043", "story_v_out_416101.awb")
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
	Play416101044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416101044
		arg_179_1.duration_ = 6.33

		local var_179_0 = {
			zh = 5.3,
			ja = 6.333
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
				arg_179_0:Play416101045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10108"]) and arg_179_1.var_.actorSpriteComps10108 == nil then
				arg_179_1.var_.actorSpriteComps10108 = arg_179_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.125

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10108"]) then
				if arg_179_1.var_.actorSpriteComps10108 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10108"]) and arg_179_1.var_.actorSpriteComps10108 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10108 = nil
			end

			local var_182_2 = arg_179_1.actors_["1148"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1148 == nil then
				arg_179_1.var_.actorSpriteComps1148 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.125

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps1148 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 1, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1148 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps1148 = nil
			end

			local var_182_5 = arg_179_1.actors_["1148"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1148 = var_182_5.localPosition
				var_182_5.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1148", 2)

				for iter_182_8 = 0, var_182_5.childCount - 1 do
					local var_182_6 = var_182_5:GetChild(iter_182_8)

					if var_182_6.name == "split_4" or not string.find(var_182_6.name, "split") then
						var_182_6.gameObject:SetActive(true)
					else
						var_182_6.gameObject:SetActive(false)
					end
				end
			end

			local var_182_7 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				var_182_5.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_179_1.time_ - 0) / var_182_7)
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				var_182_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_182_8 = 0
			local var_182_9 = 0.5

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(416101044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 20 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 20)

				if (20 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 20)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101044", "story_v_out_416101.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_416101", "416101044", "story_v_out_416101.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_416101", "416101044", "story_v_out_416101.awb")

						arg_179_1:RecordAudio("416101044", var_182_15)
						arg_179_1:RecordAudio("416101044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416101", "416101044", "story_v_out_416101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416101", "416101044", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416101045
		arg_183_1.duration_ = 4.83

		local var_183_0 = {
			zh = 4.266,
			ja = 4.833
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
				arg_183_0:Play416101046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1148 = arg_183_1.actors_["1148"].transform.localPosition
				arg_183_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1148", 7)

				for iter_186_0 = 0, arg_183_1.actors_["1148"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["1148"].transform:GetChild(iter_186_0)

					if var_186_0.name == "" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_2 = arg_183_1.actors_["10108"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10108 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10108", 7)

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
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_5 = 0
			local var_186_6 = 0.525

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_7 = arg_183_1:GetWordFromCfg(416101045)
				local var_186_8 = arg_183_1:FormatText(var_186_7.content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 21 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 21)

				if (21 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 21)) > 0 and var_186_6 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_5
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101045", "story_v_out_416101.awb") ~= 0 then
					local var_186_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101045", "story_v_out_416101.awb") / 1000

					if var_186_11 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_5
					end

					if var_186_7.prefab_name ~= "" and arg_183_1.actors_[var_186_7.prefab_name] ~= nil then
						local var_186_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_7.prefab_name].transform, "story_v_out_416101", "416101045", "story_v_out_416101.awb")

						arg_183_1:RecordAudio("416101045", var_186_12)
						arg_183_1:RecordAudio("416101045", var_186_12)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416101", "416101045", "story_v_out_416101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416101", "416101045", "story_v_out_416101.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_6, arg_183_1.talkMaxDuration)

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_5) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_5 + var_186_13 and arg_183_1.time_ < var_186_5 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
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
	Play416101046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416101046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play416101047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(416101046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 62 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 62)

				if (62 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 62)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play416101047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416101047
		arg_191_1.duration_ = 5.6

		local var_191_0 = {
			zh = 4.933,
			ja = 5.6
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
				arg_191_0:Play416101048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.525

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:GetWordFromCfg(416101047)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 21 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 21)

				if (21 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 21)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101047", "story_v_out_416101.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101047", "story_v_out_416101.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_416101", "416101047", "story_v_out_416101.awb")

						arg_191_1:RecordAudio("416101047", var_194_6)
						arg_191_1:RecordAudio("416101047", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416101", "416101047", "story_v_out_416101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416101", "416101047", "story_v_out_416101.awb")
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
	Play416101048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416101048
		arg_195_1.duration_ = 3.87

		local var_195_0 = {
			zh = 3.866,
			ja = 3.666
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
				arg_195_0:Play416101049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1148 = arg_195_1.actors_["1148"].transform.localPosition
				arg_195_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1148", 3)

				for iter_198_0 = 0, arg_195_1.actors_["1148"].transform.childCount - 1 do
					local var_198_0 = arg_195_1.actors_["1148"].transform:GetChild(iter_198_0)

					if var_198_0.name == "" or not string.find(var_198_0.name, "split") then
						var_198_0.gameObject:SetActive(true)
					else
						var_198_0.gameObject:SetActive(false)
					end
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_195_1.time_ - 0) / var_198_1)
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_198_2 = arg_195_1.actors_["1148"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps1148 == nil then
				arg_195_1.var_.actorSpriteComps1148 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.125

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps1148 then
					for iter_198_1, iter_198_2 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_198_2 then
							if arg_195_1.isInRecall_ then
								iter_198_2.color = Color.New(Mathf.Lerp(iter_198_2.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_2.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_2.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_2.color.r, 1, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_2.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps1148 then
				for iter_198_3, iter_198_4 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_198_4 then
						iter_198_4.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1148 = nil
			end

			local var_198_5 = 0
			local var_198_6 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_7 = arg_195_1:GetWordFromCfg(416101048)
				local var_198_8 = arg_195_1:FormatText(var_198_7.content)

				arg_195_1.text_.text = var_198_8

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_10 = 18 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_8) / 18)

				if (18 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_8) / 18)) > 0 and var_198_6 < var_198_10 then
					arg_195_1.talkMaxDuration = var_198_10

					if var_198_10 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_5
					end
				end

				arg_195_1.text_.text = var_198_8
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101048", "story_v_out_416101.awb") ~= 0 then
					local var_198_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101048", "story_v_out_416101.awb") / 1000

					if var_198_11 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_5
					end

					if var_198_7.prefab_name ~= "" and arg_195_1.actors_[var_198_7.prefab_name] ~= nil then
						local var_198_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_7.prefab_name].transform, "story_v_out_416101", "416101048", "story_v_out_416101.awb")

						arg_195_1:RecordAudio("416101048", var_198_12)
						arg_195_1:RecordAudio("416101048", var_198_12)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_416101", "416101048", "story_v_out_416101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_416101", "416101048", "story_v_out_416101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_6, arg_195_1.talkMaxDuration)

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_5) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_5 + var_198_13 and arg_195_1.time_ < var_198_5 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416101049
		arg_199_1.duration_ = 8.1

		local var_199_0 = {
			zh = 3.266,
			ja = 8.1
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
				arg_199_0:Play416101050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1148"]) and arg_199_1.var_.actorSpriteComps1148 == nil then
				arg_199_1.var_.actorSpriteComps1148 = arg_199_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.125

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1148"]) then
				if arg_199_1.var_.actorSpriteComps1148 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1148"]) and arg_199_1.var_.actorSpriteComps1148 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1148 = nil
			end

			local var_202_2 = 0
			local var_202_3 = 0.275

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_4 = arg_199_1:GetWordFromCfg(416101049)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 11 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 11)

				if (11 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 11)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101049", "story_v_out_416101.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101049", "story_v_out_416101.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_out_416101", "416101049", "story_v_out_416101.awb")

						arg_199_1:RecordAudio("416101049", var_202_9)
						arg_199_1:RecordAudio("416101049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416101", "416101049", "story_v_out_416101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416101", "416101049", "story_v_out_416101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play416101050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416101050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416101051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.725

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(416101050).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 69 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 69)

				if (69 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 69)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play416101051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416101051
		arg_207_1.duration_ = 4.3

		local var_207_0 = {
			zh = 4.3,
			ja = 3.5
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
				arg_207_0:Play416101052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1148"]) and arg_207_1.var_.actorSpriteComps1148 == nil then
				arg_207_1.var_.actorSpriteComps1148 = arg_207_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.125

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1148"]) then
				if arg_207_1.var_.actorSpriteComps1148 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 1, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1148"]) and arg_207_1.var_.actorSpriteComps1148 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps1148 = nil
			end

			local var_210_2 = arg_207_1.actors_["1148"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1148 = var_210_2.localPosition
				var_210_2.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1148", 3)

				for iter_210_4 = 0, var_210_2.childCount - 1 do
					local var_210_3 = var_210_2:GetChild(iter_210_4)

					if var_210_3.name == "split_3" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_2.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_207_1.time_ - 0) / var_210_4)
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_210_5 = 0
			local var_210_6 = 0.525

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(416101051)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 21 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 21)

				if (21 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 21)) > 0 and var_210_6 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101051", "story_v_out_416101.awb") ~= 0 then
					local var_210_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101051", "story_v_out_416101.awb") / 1000

					if var_210_11 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_5
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_416101", "416101051", "story_v_out_416101.awb")

						arg_207_1:RecordAudio("416101051", var_210_12)
						arg_207_1:RecordAudio("416101051", var_210_12)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416101", "416101051", "story_v_out_416101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416101", "416101051", "story_v_out_416101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_13 and arg_207_1.time_ < var_210_5 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play416101052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416101052
		arg_211_1.duration_ = 4.87

		local var_211_0 = {
			zh = 4.866,
			ja = 3.633
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
				arg_211_0:Play416101053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.55

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(416101052)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 22 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 22)

				if (22 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 22)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101052", "story_v_out_416101.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101052", "story_v_out_416101.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_416101", "416101052", "story_v_out_416101.awb")

						arg_211_1:RecordAudio("416101052", var_214_6)
						arg_211_1:RecordAudio("416101052", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_416101", "416101052", "story_v_out_416101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_416101", "416101052", "story_v_out_416101.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play416101053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416101053
		arg_215_1.duration_ = 5.17

		local var_215_0 = {
			zh = 3.233,
			ja = 5.166
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
				arg_215_0:Play416101054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.225

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(416101053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 9 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 9)

				if (9 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 9)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101053", "story_v_out_416101.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101053", "story_v_out_416101.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_416101", "416101053", "story_v_out_416101.awb")

						arg_215_1:RecordAudio("416101053", var_218_6)
						arg_215_1:RecordAudio("416101053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_416101", "416101053", "story_v_out_416101.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_416101", "416101053", "story_v_out_416101.awb")
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
	Play416101054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416101054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play416101055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1148 = arg_219_1.actors_["1148"].transform.localPosition
				arg_219_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1148", 7)

				for iter_222_0 = 0, arg_219_1.actors_["1148"].transform.childCount - 1 do
					local var_222_0 = arg_219_1.actors_["1148"].transform:GetChild(iter_222_0)

					if var_222_0.name == "" or not string.find(var_222_0.name, "split") then
						var_222_0.gameObject:SetActive(true)
					else
						var_222_0.gameObject:SetActive(false)
					end
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_219_1.time_ - 0) / var_222_1)
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_2 = 0
			local var_222_3 = 1.375

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(416101054).content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 55 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_4) / 55)

				if (55 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_4) / 55)) > 0 and var_222_3 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_7 and arg_219_1.time_ < var_222_2 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play416101055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416101055
		arg_223_1.duration_ = 4.63

		local var_223_0 = {
			zh = 3.733,
			ja = 4.633
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
				arg_223_0:Play416101056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1148 = arg_223_1.actors_["1148"].transform.localPosition
				arg_223_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1148", 3)

				for iter_226_0 = 0, arg_223_1.actors_["1148"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["1148"].transform:GetChild(iter_226_0)

					if var_226_0.name == "split_4" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_226_2 = arg_223_1.actors_["1148"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1148 == nil then
				arg_223_1.var_.actorSpriteComps1148 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.125

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps1148 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1148 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_226_4 then
						iter_226_4.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps1148 = nil
			end

			local var_226_5 = 0
			local var_226_6 = 0.3

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(416101055)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 12 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 12)

				if (12 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 12)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101055", "story_v_out_416101.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101055", "story_v_out_416101.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_416101", "416101055", "story_v_out_416101.awb")

						arg_223_1:RecordAudio("416101055", var_226_12)
						arg_223_1:RecordAudio("416101055", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416101", "416101055", "story_v_out_416101.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416101", "416101055", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416101056
		arg_227_1.duration_ = 7.67

		local var_227_0 = {
			zh = 4,
			ja = 7.666
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
				arg_227_0:Play416101057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1148"]) and arg_227_1.var_.actorSpriteComps1148 == nil then
				arg_227_1.var_.actorSpriteComps1148 = arg_227_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.125

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1148"]) then
				if arg_227_1.var_.actorSpriteComps1148 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1148"]) and arg_227_1.var_.actorSpriteComps1148 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps1148 = nil
			end

			local var_230_2 = 0
			local var_230_3 = 0.575

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_4 = arg_227_1:GetWordFromCfg(416101056)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 23 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 23)

				if (23 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 23)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101056", "story_v_out_416101.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101056", "story_v_out_416101.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_416101", "416101056", "story_v_out_416101.awb")

						arg_227_1:RecordAudio("416101056", var_230_9)
						arg_227_1:RecordAudio("416101056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416101", "416101056", "story_v_out_416101.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416101", "416101056", "story_v_out_416101.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416101057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416101057
		arg_231_1.duration_ = 6

		local var_231_0 = {
			zh = 6,
			ja = 5.433
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play416101058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1148"]) and arg_231_1.var_.actorSpriteComps1148 == nil then
				arg_231_1.var_.actorSpriteComps1148 = arg_231_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.125

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1148"]) then
				if arg_231_1.var_.actorSpriteComps1148 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1148"]) and arg_231_1.var_.actorSpriteComps1148 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps1148 = nil
			end

			local var_234_2 = 0
			local var_234_3 = 0.525

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(416101057)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 21 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 21)

				if (21 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 21)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101057", "story_v_out_416101.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101057", "story_v_out_416101.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_out_416101", "416101057", "story_v_out_416101.awb")

						arg_231_1:RecordAudio("416101057", var_234_9)
						arg_231_1:RecordAudio("416101057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416101", "416101057", "story_v_out_416101.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416101", "416101057", "story_v_out_416101.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416101058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416101058
		arg_235_1.duration_ = 4.6

		local var_235_0 = {
			zh = 4.6,
			ja = 4.266
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
				arg_235_0:Play416101059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1148"]) and arg_235_1.var_.actorSpriteComps1148 == nil then
				arg_235_1.var_.actorSpriteComps1148 = arg_235_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.125

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1148"]) then
				if arg_235_1.var_.actorSpriteComps1148 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1148"]) and arg_235_1.var_.actorSpriteComps1148 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps1148 = nil
			end

			local var_238_2 = 0
			local var_238_3 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_4 = arg_235_1:GetWordFromCfg(416101058)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 24 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 24)

				if (24 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 24)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101058", "story_v_out_416101.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101058", "story_v_out_416101.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_416101", "416101058", "story_v_out_416101.awb")

						arg_235_1:RecordAudio("416101058", var_238_9)
						arg_235_1:RecordAudio("416101058", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416101", "416101058", "story_v_out_416101.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416101", "416101058", "story_v_out_416101.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416101059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416101059
		arg_239_1.duration_ = 5.53

		local var_239_0 = {
			zh = 2.833,
			ja = 5.533
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
				arg_239_0:Play416101060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.325

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:GetWordFromCfg(416101059)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 13 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 13)

				if (13 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 13)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101059", "story_v_out_416101.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101059", "story_v_out_416101.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_416101", "416101059", "story_v_out_416101.awb")

						arg_239_1:RecordAudio("416101059", var_242_6)
						arg_239_1:RecordAudio("416101059", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416101", "416101059", "story_v_out_416101.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416101", "416101059", "story_v_out_416101.awb")
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
	Play416101060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416101060
		arg_243_1.duration_ = 4.4

		local var_243_0 = {
			zh = 4.4,
			ja = 4.2
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
				arg_243_0:Play416101061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1148"]) and arg_243_1.var_.actorSpriteComps1148 == nil then
				arg_243_1.var_.actorSpriteComps1148 = arg_243_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.125

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1148"]) then
				if arg_243_1.var_.actorSpriteComps1148 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 1, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1148"]) and arg_243_1.var_.actorSpriteComps1148 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1148 = nil
			end

			local var_246_2 = arg_243_1.actors_["1148"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1148 = var_246_2.localPosition
				var_246_2.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1148", 3)

				for iter_246_4 = 0, var_246_2.childCount - 1 do
					local var_246_3 = var_246_2:GetChild(iter_246_4)

					if var_246_3.name == "split_5" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				var_246_2.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_243_1.time_ - 0) / var_246_4)
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				var_246_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_246_5 = 0
			local var_246_6 = 0.325

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:GetWordFromCfg(416101060)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 13 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 13)

				if (13 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 13)) > 0 and var_246_6 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101060", "story_v_out_416101.awb") ~= 0 then
					local var_246_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101060", "story_v_out_416101.awb") / 1000

					if var_246_11 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_5
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_416101", "416101060", "story_v_out_416101.awb")

						arg_243_1:RecordAudio("416101060", var_246_12)
						arg_243_1:RecordAudio("416101060", var_246_12)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416101", "416101060", "story_v_out_416101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416101", "416101060", "story_v_out_416101.awb")
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

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play416101061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416101061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play416101062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1148 = arg_247_1.actors_["1148"].transform.localPosition
				arg_247_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1148", 7)

				for iter_250_0 = 0, arg_247_1.actors_["1148"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["1148"].transform:GetChild(iter_250_0)

					if var_250_0.name == "" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_2 = 0
			local var_250_3 = 1.15

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(416101061).content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 46 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_4) / 46)

				if (46 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_4) / 46)) > 0 and var_250_3 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_7 and arg_247_1.time_ < var_250_2 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play416101062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416101062
		arg_251_1.duration_ = 8.57

		local var_251_0 = {
			zh = 3.933,
			ja = 8.566
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
				arg_251_0:Play416101063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1148 = arg_251_1.actors_["1148"].transform.localPosition
				arg_251_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1148", 3)

				for iter_254_0 = 0, arg_251_1.actors_["1148"].transform.childCount - 1 do
					local var_254_0 = arg_251_1.actors_["1148"].transform:GetChild(iter_254_0)

					if var_254_0.name == "split_4" or not string.find(var_254_0.name, "split") then
						var_254_0.gameObject:SetActive(true)
					else
						var_254_0.gameObject:SetActive(false)
					end
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_251_1.time_ - 0) / var_254_1)
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_254_2 = arg_251_1.actors_["1148"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps1148 == nil then
				arg_251_1.var_.actorSpriteComps1148 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 0.125

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps1148 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps1148 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_254_4 then
						iter_254_4.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1148 = nil
			end

			local var_254_5 = 0
			local var_254_6 = 0.475

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(416101062)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 19 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 19)

				if (19 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 19)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101062", "story_v_out_416101.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101062", "story_v_out_416101.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_416101", "416101062", "story_v_out_416101.awb")

						arg_251_1:RecordAudio("416101062", var_254_12)
						arg_251_1:RecordAudio("416101062", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416101", "416101062", "story_v_out_416101.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416101", "416101062", "story_v_out_416101.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_13 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_13 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_5) / var_254_13

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_5 + var_254_13 and arg_251_1.time_ < var_254_5 + var_254_13 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416101063
		arg_255_1.duration_ = 3.4

		local var_255_0 = {
			zh = 3.4,
			ja = 2.9
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
				arg_255_0:Play416101064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.3

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(416101063)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 12 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 12)

				if (12 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 12)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101063", "story_v_out_416101.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101063", "story_v_out_416101.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_416101", "416101063", "story_v_out_416101.awb")

						arg_255_1:RecordAudio("416101063", var_258_6)
						arg_255_1:RecordAudio("416101063", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416101", "416101063", "story_v_out_416101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416101", "416101063", "story_v_out_416101.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play416101064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416101064
		arg_259_1.duration_ = 9.17

		local var_259_0 = {
			zh = 2.4,
			ja = 9.166
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
				arg_259_0:Play416101065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.225

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(416101064)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 9 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 9)

				if (9 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 9)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101064", "story_v_out_416101.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101064", "story_v_out_416101.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_416101", "416101064", "story_v_out_416101.awb")

						arg_259_1:RecordAudio("416101064", var_262_6)
						arg_259_1:RecordAudio("416101064", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416101", "416101064", "story_v_out_416101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416101", "416101064", "story_v_out_416101.awb")
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
	Play416101065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416101065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play416101066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1148 = arg_263_1.actors_["1148"].transform.localPosition
				arg_263_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1148", 7)

				for iter_266_0 = 0, arg_263_1.actors_["1148"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["1148"].transform:GetChild(iter_266_0)

					if var_266_0.name == "" or not string.find(var_266_0.name, "split") then
						var_266_0.gameObject:SetActive(true)
					else
						var_266_0.gameObject:SetActive(false)
					end
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_263_1.time_ - 0) / var_266_1)
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_266_2 = 0
			local var_266_3 = 1.925

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(416101065).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 77 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 77)

				if (77 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 77)) > 0 and var_266_3 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_7 and arg_263_1.time_ < var_266_2 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416101066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416101067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.2

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(416101066).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 48 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 48)

				if (48 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 48)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416101067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416101067
		arg_271_1.duration_ = 6.73

		local var_271_0 = {
			zh = 2.7,
			ja = 6.733
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
				arg_271_0:Play416101068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10108 = arg_271_1.actors_["10108"].transform.localPosition
				arg_271_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10108", 3)

				for iter_274_0 = 0, arg_271_1.actors_["10108"].transform.childCount - 1 do
					local var_274_0 = arg_271_1.actors_["10108"].transform:GetChild(iter_274_0)

					if var_274_0.name == "split_3" or not string.find(var_274_0.name, "split") then
						var_274_0.gameObject:SetActive(true)
					else
						var_274_0.gameObject:SetActive(false)
					end
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_271_1.time_ - 0) / var_274_1)
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["10108"].transform.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_274_2 = arg_271_1.actors_["10108"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10108 == nil then
				arg_271_1.var_.actorSpriteComps10108 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.125

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps10108 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10108 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_274_4 then
						iter_274_4.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10108 = nil
			end

			local var_274_5 = 0
			local var_274_6 = 0.3

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(416101067)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 12 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 12)

				if (12 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 12)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101067", "story_v_out_416101.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101067", "story_v_out_416101.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_416101", "416101067", "story_v_out_416101.awb")

						arg_271_1:RecordAudio("416101067", var_274_12)
						arg_271_1:RecordAudio("416101067", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416101", "416101067", "story_v_out_416101.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416101", "416101067", "story_v_out_416101.awb")
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
				actorName = "10108",
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
	Play416101068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416101068
		arg_275_1.duration_ = 4.5

		local var_275_0 = {
			zh = 3.8,
			ja = 4.5
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
				arg_275_0:Play416101069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10108"]) and arg_275_1.var_.actorSpriteComps10108 == nil then
				arg_275_1.var_.actorSpriteComps10108 = arg_275_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.125

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10108"]) then
				if arg_275_1.var_.actorSpriteComps10108 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10108"]) and arg_275_1.var_.actorSpriteComps10108 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps10108 = nil
			end

			local var_278_2 = 0
			local var_278_3 = 0.425

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_4 = arg_275_1:GetWordFromCfg(416101068)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 17 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 17)

				if (17 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 17)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101068", "story_v_out_416101.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101068", "story_v_out_416101.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_out_416101", "416101068", "story_v_out_416101.awb")

						arg_275_1:RecordAudio("416101068", var_278_9)
						arg_275_1:RecordAudio("416101068", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416101", "416101068", "story_v_out_416101.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416101", "416101068", "story_v_out_416101.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play416101069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416101069
		arg_279_1.duration_ = 9.83

		local var_279_0 = {
			zh = 2.9,
			ja = 9.833
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
				arg_279_0:Play416101070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10108"]) and arg_279_1.var_.actorSpriteComps10108 == nil then
				arg_279_1.var_.actorSpriteComps10108 = arg_279_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.125

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10108"]) then
				if arg_279_1.var_.actorSpriteComps10108 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10108"]) and arg_279_1.var_.actorSpriteComps10108 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10108 = nil
			end

			local var_282_2 = 0
			local var_282_3 = 0.25

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(416101069)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 10 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 10)

				if (10 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 10)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101069", "story_v_out_416101.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101069", "story_v_out_416101.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_out_416101", "416101069", "story_v_out_416101.awb")

						arg_279_1:RecordAudio("416101069", var_282_9)
						arg_279_1:RecordAudio("416101069", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_416101", "416101069", "story_v_out_416101.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_416101", "416101069", "story_v_out_416101.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play416101070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416101070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play416101071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10108 = arg_283_1.actors_["10108"].transform.localPosition
				arg_283_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10108", 7)

				for iter_286_0 = 0, arg_283_1.actors_["10108"].transform.childCount - 1 do
					local var_286_0 = arg_283_1.actors_["10108"].transform:GetChild(iter_286_0)

					if var_286_0.name == "" or not string.find(var_286_0.name, "split") then
						var_286_0.gameObject:SetActive(true)
					else
						var_286_0.gameObject:SetActive(false)
					end
				end
			end

			local var_286_1 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 then
				arg_283_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_283_1.time_ - 0) / var_286_1)
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 then
				arg_283_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_2 = 0
			local var_286_3 = 2

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(416101070).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 80 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 80)

				if (80 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 80)) > 0 and var_286_3 < var_286_6 then
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

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play416101071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416101071
		arg_287_1.duration_ = 7.3

		local var_287_0 = {
			zh = 4.933,
			ja = 7.3
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
				arg_287_0:Play416101072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1148"]) and arg_287_1.var_.actorSpriteComps1148 == nil then
				arg_287_1.var_.actorSpriteComps1148 = arg_287_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.125

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1148"]) then
				if arg_287_1.var_.actorSpriteComps1148 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1148"]) and arg_287_1.var_.actorSpriteComps1148 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps1148 = nil
			end

			local var_290_2 = arg_287_1.actors_["1148"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1148 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1148", 3)

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
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_287_1.time_ - 0) / var_290_4)
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_290_5 = 0
			local var_290_6 = 0.525

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(416101071)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 21 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 21)

				if (21 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 21)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101071", "story_v_out_416101.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101071", "story_v_out_416101.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_416101", "416101071", "story_v_out_416101.awb")

						arg_287_1:RecordAudio("416101071", var_290_12)
						arg_287_1:RecordAudio("416101071", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416101", "416101071", "story_v_out_416101.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416101", "416101071", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416101072
		arg_291_1.duration_ = 6.63

		local var_291_0 = {
			zh = 4.666,
			ja = 6.633
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play416101073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.5

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(416101072)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 20 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 20)

				if (20 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 20)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101072", "story_v_out_416101.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101072", "story_v_out_416101.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_416101", "416101072", "story_v_out_416101.awb")

						arg_291_1:RecordAudio("416101072", var_294_6)
						arg_291_1:RecordAudio("416101072", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416101", "416101072", "story_v_out_416101.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416101", "416101072", "story_v_out_416101.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play416101073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416101073
		arg_295_1.duration_ = 3.27

		local var_295_0 = {
			zh = 2.5,
			ja = 3.266
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play416101074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.25

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:GetWordFromCfg(416101073)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 10 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 10)

				if (10 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 10)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101073", "story_v_out_416101.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101073", "story_v_out_416101.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_416101", "416101073", "story_v_out_416101.awb")

						arg_295_1:RecordAudio("416101073", var_298_6)
						arg_295_1:RecordAudio("416101073", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416101", "416101073", "story_v_out_416101.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416101", "416101073", "story_v_out_416101.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play416101074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416101074
		arg_299_1.duration_ = 11.6

		local var_299_0 = {
			zh = 4.633,
			ja = 11.6
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play416101075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1148 = arg_299_1.actors_["1148"].transform.localPosition
				arg_299_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1148", 2)

				for iter_302_0 = 0, arg_299_1.actors_["1148"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["1148"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_4" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_302_2 = arg_299_1.actors_["1148"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps1148 == nil then
				arg_299_1.var_.actorSpriteComps1148 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 0.125

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps1148 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps1148 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps1148 = nil
			end

			local var_302_5 = arg_299_1.actors_["10108"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.actorSpriteComps10108 == nil then
				arg_299_1.var_.actorSpriteComps10108 = var_302_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_6 = 0.125

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 and not isNil(var_302_5) then
				if arg_299_1.var_.actorSpriteComps10108 then
					for iter_302_5, iter_302_6 in pairs(arg_299_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_302_6 then
							if arg_299_1.isInRecall_ then
								iter_302_6.color = Color.New(Mathf.Lerp(iter_302_6.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_6), Mathf.Lerp(iter_302_6.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_6), (Mathf.Lerp(iter_302_6.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_6)))
							else
								local var_302_7 = Mathf.Lerp(iter_302_6.color.r, 1, (arg_299_1.time_ - 0) / var_302_6)

								iter_302_6.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.actorSpriteComps10108 then
				for iter_302_7, iter_302_8 in pairs(arg_299_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_302_8 then
						iter_302_8.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10108 = nil
			end

			local var_302_8 = arg_299_1.actors_["10108"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10108 = var_302_8.localPosition
				var_302_8.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10108", 4)

				for iter_302_9 = 0, var_302_8.childCount - 1 do
					local var_302_9 = var_302_8:GetChild(iter_302_9)

					if var_302_9.name == "" or not string.find(var_302_9.name, "split") then
						var_302_9.gameObject:SetActive(true)
					else
						var_302_9.gameObject:SetActive(false)
					end
				end
			end

			local var_302_10 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_10 then
				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_299_1.time_ - 0) / var_302_10)
			end

			if arg_299_1.time_ >= 0 + var_302_10 and arg_299_1.time_ < 0 + var_302_10 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_302_11 = 0
			local var_302_12 = 0.425

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_11 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_13 = arg_299_1:GetWordFromCfg(416101074)
				local var_302_14 = arg_299_1:FormatText(var_302_13.content)

				arg_299_1.text_.text = var_302_14

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_16 = 17 <= 0 and var_302_12 or var_302_12 * (utf8.len(var_302_14) / 17)

				if (17 <= 0 and var_302_12 or var_302_12 * (utf8.len(var_302_14) / 17)) > 0 and var_302_12 < var_302_16 then
					arg_299_1.talkMaxDuration = var_302_16

					if var_302_16 + var_302_11 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_16 + var_302_11
					end
				end

				arg_299_1.text_.text = var_302_14
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101074", "story_v_out_416101.awb") ~= 0 then
					local var_302_17 = manager.audio:GetVoiceLength("story_v_out_416101", "416101074", "story_v_out_416101.awb") / 1000

					if var_302_17 + var_302_11 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_17 + var_302_11
					end

					if var_302_13.prefab_name ~= "" and arg_299_1.actors_[var_302_13.prefab_name] ~= nil then
						local var_302_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_13.prefab_name].transform, "story_v_out_416101", "416101074", "story_v_out_416101.awb")

						arg_299_1:RecordAudio("416101074", var_302_18)
						arg_299_1:RecordAudio("416101074", var_302_18)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416101", "416101074", "story_v_out_416101.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416101", "416101074", "story_v_out_416101.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_19 = math.max(var_302_12, arg_299_1.talkMaxDuration)

			if var_302_11 <= arg_299_1.time_ and arg_299_1.time_ < var_302_11 + var_302_19 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_11) / var_302_19

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_11 + var_302_19 and arg_299_1.time_ < var_302_11 + var_302_19 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play416101075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416101075
		arg_303_1.duration_ = 10.47

		local var_303_0 = {
			zh = 3.7,
			ja = 10.466
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play416101076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.325

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(416101075)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 13 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 13)

				if (13 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 13)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101075", "story_v_out_416101.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101075", "story_v_out_416101.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_416101", "416101075", "story_v_out_416101.awb")

						arg_303_1:RecordAudio("416101075", var_306_6)
						arg_303_1:RecordAudio("416101075", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416101", "416101075", "story_v_out_416101.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416101", "416101075", "story_v_out_416101.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play416101076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416101076
		arg_307_1.duration_ = 5.67

		local var_307_0 = {
			zh = 3.7,
			ja = 5.666
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
				arg_307_0:Play416101077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10108"]) and arg_307_1.var_.actorSpriteComps10108 == nil then
				arg_307_1.var_.actorSpriteComps10108 = arg_307_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 0.125

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10108"]) then
				if arg_307_1.var_.actorSpriteComps10108 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								iter_310_1.color = Color.New(Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_0), Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_0), (Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_0)))
							else
								local var_310_1 = Mathf.Lerp(iter_310_1.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_0)

								iter_310_1.color = Color.New(var_310_1, var_310_1, var_310_1)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10108"]) and arg_307_1.var_.actorSpriteComps10108 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps10108 = nil
			end

			local var_310_2 = arg_307_1.actors_["1148"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1148 == nil then
				arg_307_1.var_.actorSpriteComps1148 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 0.125

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps1148 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								iter_310_5.color = Color.New(Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 0) / var_310_3), Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 0) / var_310_3), (Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 0) / var_310_3)))
							else
								local var_310_4 = Mathf.Lerp(iter_310_5.color.r, 1, (arg_307_1.time_ - 0) / var_310_3)

								iter_310_5.color = Color.New(var_310_4, var_310_4, var_310_4)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1148 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_310_7 then
						iter_310_7.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps1148 = nil
			end

			local var_310_5 = 0
			local var_310_6 = 0.475

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_7 = arg_307_1:GetWordFromCfg(416101076)
				local var_310_8 = arg_307_1:FormatText(var_310_7.content)

				arg_307_1.text_.text = var_310_8

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 19 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 19)

				if (19 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 19)) > 0 and var_310_6 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_5
					end
				end

				arg_307_1.text_.text = var_310_8
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101076", "story_v_out_416101.awb") ~= 0 then
					local var_310_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101076", "story_v_out_416101.awb") / 1000

					if var_310_11 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_5
					end

					if var_310_7.prefab_name ~= "" and arg_307_1.actors_[var_310_7.prefab_name] ~= nil then
						local var_310_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_7.prefab_name].transform, "story_v_out_416101", "416101076", "story_v_out_416101.awb")

						arg_307_1:RecordAudio("416101076", var_310_12)
						arg_307_1:RecordAudio("416101076", var_310_12)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_416101", "416101076", "story_v_out_416101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_416101", "416101076", "story_v_out_416101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_13 = math.max(var_310_6, arg_307_1.talkMaxDuration)

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_13 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_5) / var_310_13

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_5 + var_310_13 and arg_307_1.time_ < var_310_5 + var_310_13 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play416101077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416101077
		arg_311_1.duration_ = 3.97

		local var_311_0 = {
			zh = 2.766,
			ja = 3.966
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play416101078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.3

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(416101077)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 12 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 12)

				if (12 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 12)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101077", "story_v_out_416101.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101077", "story_v_out_416101.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_416101", "416101077", "story_v_out_416101.awb")

						arg_311_1:RecordAudio("416101077", var_314_6)
						arg_311_1:RecordAudio("416101077", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416101", "416101077", "story_v_out_416101.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416101", "416101077", "story_v_out_416101.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play416101078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416101078
		arg_315_1.duration_ = 10.97

		local var_315_0 = {
			zh = 10.133,
			ja = 10.966
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play416101079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 4 < arg_315_1.time_ and arg_315_1.time_ <= 4 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			if arg_315_1.time_ >= 4 + 0.3 and arg_315_1.time_ < 4 + 0.3 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			if 2 < arg_315_1.time_ and arg_315_1.time_ <= 2 + arg_318_0 then
				local var_318_0 = arg_315_1.bgs_.I13f

				arg_315_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_318_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_318_1 = var_318_0:GetComponent("SpriteRenderer")

				if var_318_1 and var_318_1.sprite then
					local var_318_2 = 2 * (var_318_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_318_0.transform.localScale = Vector3.New(var_318_2 / var_318_1.sprite.bounds.size.y < var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x and var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x or var_318_2 / var_318_1.sprite.bounds.size.y, var_318_2 / var_318_1.sprite.bounds.size.y < var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x and var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x or var_318_2 / var_318_1.sprite.bounds.size.y, 0)
				end

				for iter_318_0, iter_318_1 in pairs(arg_315_1.bgs_) do
					if iter_318_0 ~= "I13f" then
						iter_318_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_318_3 = 0

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_4 = 2

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_4 then
				local var_318_5 = Color.New(0, 0, 0)

				var_318_5.a = Mathf.Lerp(0, 1, (arg_315_1.time_ - var_318_3) / var_318_4)
				arg_315_1.mask_.color = var_318_5
			end

			if arg_315_1.time_ >= var_318_3 + var_318_4 and arg_315_1.time_ < var_318_3 + var_318_4 + arg_318_0 then
				local var_318_6 = Color.New(0, 0, 0)

				var_318_6.a = 1
				arg_315_1.mask_.color = var_318_6
			end

			local var_318_7 = 2

			if 2 < arg_315_1.time_ and arg_315_1.time_ <= var_318_7 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_8 = 2

			if var_318_7 <= arg_315_1.time_ and arg_315_1.time_ < var_318_7 + var_318_8 then
				local var_318_9 = Color.New(0, 0, 0)

				var_318_9.a = Mathf.Lerp(1, 0, (arg_315_1.time_ - var_318_7) / var_318_8)
				arg_315_1.mask_.color = var_318_9
			end

			if arg_315_1.time_ >= var_318_7 + var_318_8 and arg_315_1.time_ < var_318_7 + var_318_8 + arg_318_0 then
				local var_318_10 = Color.New(0, 0, 0)

				arg_315_1.mask_.enabled = false
				var_318_10.a = 0
				arg_315_1.mask_.color = var_318_10
			end

			local var_318_11 = arg_315_1.actors_["1148"].transform

			if 1.966 < arg_315_1.time_ and arg_315_1.time_ <= 1.966 + arg_318_0 then
				arg_315_1.var_.moveOldPos1148 = var_318_11.localPosition
				var_318_11.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1148", 7)

				for iter_318_2 = 0, var_318_11.childCount - 1 do
					local var_318_12 = var_318_11:GetChild(iter_318_2)

					if var_318_12.name == "" or not string.find(var_318_12.name, "split") then
						var_318_12.gameObject:SetActive(true)
					else
						var_318_12.gameObject:SetActive(false)
					end
				end
			end

			local var_318_13 = 0.001

			if 1.966 <= arg_315_1.time_ and arg_315_1.time_ < 1.966 + var_318_13 then
				var_318_11.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_315_1.time_ - 1.966) / var_318_13)
			end

			if arg_315_1.time_ >= 1.966 + var_318_13 and arg_315_1.time_ < 1.966 + var_318_13 + arg_318_0 then
				var_318_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_14 = arg_315_1.actors_["10108"].transform

			if 1.966 < arg_315_1.time_ and arg_315_1.time_ <= 1.966 + arg_318_0 then
				arg_315_1.var_.moveOldPos10108 = var_318_14.localPosition
				var_318_14.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10108", 7)

				for iter_318_3 = 0, var_318_14.childCount - 1 do
					local var_318_15 = var_318_14:GetChild(iter_318_3)

					if var_318_15.name == "" or not string.find(var_318_15.name, "split") then
						var_318_15.gameObject:SetActive(true)
					else
						var_318_15.gameObject:SetActive(false)
					end
				end
			end

			local var_318_16 = 0.001

			if 1.966 <= arg_315_1.time_ and arg_315_1.time_ < 1.966 + var_318_16 then
				var_318_14.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_315_1.time_ - 1.966) / var_318_16)
			end

			if arg_315_1.time_ >= 1.966 + var_318_16 and arg_315_1.time_ < 1.966 + var_318_16 + arg_318_0 then
				var_318_14.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.53333333333333 < arg_315_1.time_ and arg_315_1.time_ <= 1.53333333333333 + arg_318_0 then
				arg_315_1:AudioAction("play", "effect", "se_story_5", "se_story_5_back", "")
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_18 = 4
			local var_318_19 = 0.75

			if 4 < arg_315_1.time_ and arg_315_1.time_ <= var_318_18 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_20 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_20:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_21 = arg_315_1:GetWordFromCfg(416101078)
				local var_318_22 = arg_315_1:FormatText(var_318_21.content)

				arg_315_1.text_.text = var_318_22

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_24 = 30 <= 0 and var_318_19 or var_318_19 * (utf8.len(var_318_22) / 30)

				if (30 <= 0 and var_318_19 or var_318_19 * (utf8.len(var_318_22) / 30)) > 0 and var_318_19 < var_318_24 then
					arg_315_1.talkMaxDuration = var_318_24
					var_318_18 = var_318_18 + 0.3

					if var_318_24 + var_318_18 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_24 + var_318_18
					end
				end

				arg_315_1.text_.text = var_318_22
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101078", "story_v_out_416101.awb") ~= 0 then
					local var_318_25 = manager.audio:GetVoiceLength("story_v_out_416101", "416101078", "story_v_out_416101.awb") / 1000

					if var_318_25 + var_318_18 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_25 + var_318_18
					end

					if var_318_21.prefab_name ~= "" and arg_315_1.actors_[var_318_21.prefab_name] ~= nil then
						local var_318_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_21.prefab_name].transform, "story_v_out_416101", "416101078", "story_v_out_416101.awb")

						arg_315_1:RecordAudio("416101078", var_318_26)
						arg_315_1:RecordAudio("416101078", var_318_26)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_416101", "416101078", "story_v_out_416101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_416101", "416101078", "story_v_out_416101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_27 = var_318_18 + 0.3
			local var_318_28 = math.max(var_318_19, arg_315_1.talkMaxDuration)

			if var_318_18 + 0.3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_27 + var_318_28 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_27) / var_318_28

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_27 + var_318_28 and arg_315_1.time_ < var_318_27 + var_318_28 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play416101079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 416101079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play416101080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 1.875

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(416101079).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 75 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 75)

				if (75 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 75)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play416101080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 416101080
		arg_325_1.duration_ = 7.03

		local var_325_0 = {
			zh = 2.366,
			ja = 7.033
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
				arg_325_0:Play416101081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.325

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(416101080)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 13 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 13)

				if (13 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 13)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101080", "story_v_out_416101.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101080", "story_v_out_416101.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_416101", "416101080", "story_v_out_416101.awb")

						arg_325_1:RecordAudio("416101080", var_328_6)
						arg_325_1:RecordAudio("416101080", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_416101", "416101080", "story_v_out_416101.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_416101", "416101080", "story_v_out_416101.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play416101081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 416101081
		arg_329_1.duration_ = 5.63

		local var_329_0 = {
			zh = 3.4,
			ja = 5.633
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
				arg_329_0:Play416101082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1148"]) and arg_329_1.var_.actorSpriteComps1148 == nil then
				arg_329_1.var_.actorSpriteComps1148 = arg_329_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 0.125

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1148"]) then
				if arg_329_1.var_.actorSpriteComps1148 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1148"]) and arg_329_1.var_.actorSpriteComps1148 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps1148 = nil
			end

			local var_332_2 = arg_329_1.actors_["1148"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1148 = var_332_2.localPosition
				var_332_2.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1148", 3)

				for iter_332_4 = 0, var_332_2.childCount - 1 do
					local var_332_3 = var_332_2:GetChild(iter_332_4)

					if var_332_3.name == "split_4" or not string.find(var_332_3.name, "split") then
						var_332_3.gameObject:SetActive(true)
					else
						var_332_3.gameObject:SetActive(false)
					end
				end
			end

			local var_332_4 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_2.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_329_1.time_ - 0) / var_332_4)
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_332_5 = 0
			local var_332_6 = 0.4

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_7 = arg_329_1:GetWordFromCfg(416101081)
				local var_332_8 = arg_329_1:FormatText(var_332_7.content)

				arg_329_1.text_.text = var_332_8

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 16 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 16)

				if (16 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 16)) > 0 and var_332_6 < var_332_10 then
					arg_329_1.talkMaxDuration = var_332_10

					if var_332_10 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_5
					end
				end

				arg_329_1.text_.text = var_332_8
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101081", "story_v_out_416101.awb") ~= 0 then
					local var_332_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101081", "story_v_out_416101.awb") / 1000

					if var_332_11 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_11 + var_332_5
					end

					if var_332_7.prefab_name ~= "" and arg_329_1.actors_[var_332_7.prefab_name] ~= nil then
						local var_332_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_7.prefab_name].transform, "story_v_out_416101", "416101081", "story_v_out_416101.awb")

						arg_329_1:RecordAudio("416101081", var_332_12)
						arg_329_1:RecordAudio("416101081", var_332_12)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_416101", "416101081", "story_v_out_416101.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_416101", "416101081", "story_v_out_416101.awb")
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
				actorName = "1148",
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
	Play416101082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 416101082
		arg_333_1.duration_ = 8.67

		local var_333_0 = {
			zh = 4.466,
			ja = 8.666
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
				arg_333_0:Play416101083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1148"]) and arg_333_1.var_.actorSpriteComps1148 == nil then
				arg_333_1.var_.actorSpriteComps1148 = arg_333_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.125

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1148"]) then
				if arg_333_1.var_.actorSpriteComps1148 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1148"]) and arg_333_1.var_.actorSpriteComps1148 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps1148 = nil
			end

			local var_336_2 = 0
			local var_336_3 = 0.55

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_4 = arg_333_1:GetWordFromCfg(416101082)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 22 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 22)

				if (22 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 22)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101082", "story_v_out_416101.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101082", "story_v_out_416101.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_out_416101", "416101082", "story_v_out_416101.awb")

						arg_333_1:RecordAudio("416101082", var_336_9)
						arg_333_1:RecordAudio("416101082", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_416101", "416101082", "story_v_out_416101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_416101", "416101082", "story_v_out_416101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play416101083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416101083
		arg_337_1.duration_ = 6.3

		local var_337_0 = {
			zh = 5.533,
			ja = 6.3
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
				arg_337_0:Play416101084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.65

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(416101083)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 26 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 26)

				if (26 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 26)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101083", "story_v_out_416101.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101083", "story_v_out_416101.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_416101", "416101083", "story_v_out_416101.awb")

						arg_337_1:RecordAudio("416101083", var_340_6)
						arg_337_1:RecordAudio("416101083", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_416101", "416101083", "story_v_out_416101.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_416101", "416101083", "story_v_out_416101.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play416101084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416101084
		arg_341_1.duration_ = 5.03

		local var_341_0 = {
			zh = 4.666,
			ja = 5.033
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
				arg_341_0:Play416101085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1148"]) and arg_341_1.var_.actorSpriteComps1148 == nil then
				arg_341_1.var_.actorSpriteComps1148 = arg_341_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_0 = 0.125

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1148"]) then
				if arg_341_1.var_.actorSpriteComps1148 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								iter_344_1.color = Color.New(Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_0), Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_0), (Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_0)))
							else
								local var_344_1 = Mathf.Lerp(iter_344_1.color.r, 1, (arg_341_1.time_ - 0) / var_344_0)

								iter_344_1.color = Color.New(var_344_1, var_344_1, var_344_1)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1148"]) and arg_341_1.var_.actorSpriteComps1148 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_344_3 then
						iter_344_3.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps1148 = nil
			end

			local var_344_2 = 0
			local var_344_3 = 0.425

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(416101084)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 17 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 17)

				if (17 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 17)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101084", "story_v_out_416101.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101084", "story_v_out_416101.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_out_416101", "416101084", "story_v_out_416101.awb")

						arg_341_1:RecordAudio("416101084", var_344_9)
						arg_341_1:RecordAudio("416101084", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_416101", "416101084", "story_v_out_416101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_416101", "416101084", "story_v_out_416101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play416101085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416101085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play416101086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1148 = arg_345_1.actors_["1148"].transform.localPosition
				arg_345_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1148", 7)

				for iter_348_0 = 0, arg_345_1.actors_["1148"].transform.childCount - 1 do
					local var_348_0 = arg_345_1.actors_["1148"].transform:GetChild(iter_348_0)

					if var_348_0.name == "" or not string.find(var_348_0.name, "split") then
						var_348_0.gameObject:SetActive(true)
					else
						var_348_0.gameObject:SetActive(false)
					end
				end
			end

			local var_348_1 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				arg_345_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_345_1.time_ - 0) / var_348_1)
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 then
				arg_345_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.233333333333333 < arg_345_1.time_ and arg_345_1.time_ <= 0.233333333333333 + arg_348_0 then
				arg_345_1:AudioAction("play", "effect", "se_story_138", "se_story_138_rustle", "")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_348_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_345_1.bgmTxt_.text ~= var_348_5 and arg_345_1.bgmTxt_.text ~= "" then
						if arg_345_1.bgmTxt2_.text ~= "" then
							arg_345_1.bgmTxt_.text = arg_345_1.bgmTxt2_.text
						end

						arg_345_1.bgmTxt2_.text = var_348_5

						arg_345_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_345_1.bgmTxt_.text = var_348_5
						arg_345_1.bgmTxt2_.text = var_348_5
					end

					if arg_345_1.bgmTimer then
						arg_345_1.bgmTimer:Stop()

						arg_345_1.bgmTimer = nil
					end

					if arg_345_1.settingData.show_music_name == 1 then
						arg_345_1.musicController:SetSelectedState("show")
						arg_345_1.musicAnimator_:Play("open", 0, 0)

						if arg_345_1.settingData.music_time ~= 0 then
							arg_345_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_345_1.settingData.music_time), function()
								if arg_345_1 == nil or isNil(arg_345_1.bgmTxt_) then
									return
								end

								arg_345_1.musicController:SetSelectedState("hide")
								arg_345_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_348_6 = 0
			local var_348_7 = 1.4

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(416101085).content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 56 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_8) / 56)

				if (56 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_8) / 56)) > 0 and var_348_7 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_11 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_11 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_11

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_11 and arg_345_1.time_ < var_348_6 + var_348_11 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416101086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 416101086
		arg_350_1.duration_ = 6.53

		local var_350_0 = {
			zh = 4.033,
			ja = 6.533
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play416101087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1148 = arg_350_1.actors_["1148"].transform.localPosition
				arg_350_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1148", 3)

				for iter_353_0 = 0, arg_350_1.actors_["1148"].transform.childCount - 1 do
					local var_353_0 = arg_350_1.actors_["1148"].transform:GetChild(iter_353_0)

					if var_353_0.name == "split_6" or not string.find(var_353_0.name, "split") then
						var_353_0.gameObject:SetActive(true)
					else
						var_353_0.gameObject:SetActive(false)
					end
				end
			end

			local var_353_1 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_1 then
				arg_350_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_350_1.time_ - 0) / var_353_1)
			end

			if arg_350_1.time_ >= 0 + var_353_1 and arg_350_1.time_ < 0 + var_353_1 + arg_353_0 then
				arg_350_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_353_2 = arg_350_1.actors_["1148"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1148 == nil then
				arg_350_1.var_.actorSpriteComps1148 = var_353_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_3 = 0.125

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.actorSpriteComps1148 then
					for iter_353_1, iter_353_2 in pairs(arg_350_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_353_2 then
							if arg_350_1.isInRecall_ then
								iter_353_2.color = Color.New(Mathf.Lerp(iter_353_2.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_3), Mathf.Lerp(iter_353_2.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_3), (Mathf.Lerp(iter_353_2.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_3)))
							else
								local var_353_4 = Mathf.Lerp(iter_353_2.color.r, 1, (arg_350_1.time_ - 0) / var_353_3)

								iter_353_2.color = Color.New(var_353_4, var_353_4, var_353_4)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1148 then
				for iter_353_3, iter_353_4 in pairs(arg_350_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_353_4 then
						iter_353_4.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps1148 = nil
			end

			if 0.233333333333333 < arg_350_1.time_ and arg_350_1.time_ <= 0.233333333333333 + arg_353_0 then
				arg_350_1:AudioAction("play", "effect", "se_story_138", "se_story_138_rustle", "")
			end

			local var_353_6 = 0
			local var_353_7 = 0.35

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_8 = arg_350_1:GetWordFromCfg(416101086)
				local var_353_9 = arg_350_1:FormatText(var_353_8.content)

				arg_350_1.text_.text = var_353_9

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 14 <= 0 and var_353_7 or var_353_7 * (utf8.len(var_353_9) / 14)

				if (14 <= 0 and var_353_7 or var_353_7 * (utf8.len(var_353_9) / 14)) > 0 and var_353_7 < var_353_11 then
					arg_350_1.talkMaxDuration = var_353_11

					if var_353_11 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_9
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101086", "story_v_out_416101.awb") ~= 0 then
					local var_353_12 = manager.audio:GetVoiceLength("story_v_out_416101", "416101086", "story_v_out_416101.awb") / 1000

					if var_353_12 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_12 + var_353_6
					end

					if var_353_8.prefab_name ~= "" and arg_350_1.actors_[var_353_8.prefab_name] ~= nil then
						local var_353_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_8.prefab_name].transform, "story_v_out_416101", "416101086", "story_v_out_416101.awb")

						arg_350_1:RecordAudio("416101086", var_353_13)
						arg_350_1:RecordAudio("416101086", var_353_13)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_416101", "416101086", "story_v_out_416101.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_416101", "416101086", "story_v_out_416101.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_14 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_14 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_14

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_14 and arg_350_1.time_ < var_353_6 + var_353_14 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play416101087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 416101087
		arg_354_1.duration_ = 5.63

		local var_354_0 = {
			zh = 5.633,
			ja = 5.433
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play416101088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1148 = arg_354_1.actors_["1148"].transform.localPosition
				arg_354_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1148", 3)

				for iter_357_0 = 0, arg_354_1.actors_["1148"].transform.childCount - 1 do
					local var_357_0 = arg_354_1.actors_["1148"].transform:GetChild(iter_357_0)

					if var_357_0.name == "split_3" or not string.find(var_357_0.name, "split") then
						var_357_0.gameObject:SetActive(true)
					else
						var_357_0.gameObject:SetActive(false)
					end
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_354_1.time_ - 0) / var_357_1)
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			if 0.233333333333333 < arg_354_1.time_ and arg_354_1.time_ <= 0.233333333333333 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_138", "se_story_138_rustle", "")
			end

			local var_357_3 = 0
			local var_357_4 = 0.45

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_3 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_5 = arg_354_1:GetWordFromCfg(416101087)
				local var_357_6 = arg_354_1:FormatText(var_357_5.content)

				arg_354_1.text_.text = var_357_6

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_8 = 18 <= 0 and var_357_4 or var_357_4 * (utf8.len(var_357_6) / 18)

				if (18 <= 0 and var_357_4 or var_357_4 * (utf8.len(var_357_6) / 18)) > 0 and var_357_4 < var_357_8 then
					arg_354_1.talkMaxDuration = var_357_8

					if var_357_8 + var_357_3 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_3
					end
				end

				arg_354_1.text_.text = var_357_6
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101087", "story_v_out_416101.awb") ~= 0 then
					local var_357_9 = manager.audio:GetVoiceLength("story_v_out_416101", "416101087", "story_v_out_416101.awb") / 1000

					if var_357_9 + var_357_3 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_3
					end

					if var_357_5.prefab_name ~= "" and arg_354_1.actors_[var_357_5.prefab_name] ~= nil then
						local var_357_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_5.prefab_name].transform, "story_v_out_416101", "416101087", "story_v_out_416101.awb")

						arg_354_1:RecordAudio("416101087", var_357_10)
						arg_354_1:RecordAudio("416101087", var_357_10)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_416101", "416101087", "story_v_out_416101.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_416101", "416101087", "story_v_out_416101.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_11 = math.max(var_357_4, arg_354_1.talkMaxDuration)

			if var_357_3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_3 + var_357_11 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_3) / var_357_11

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_3 + var_357_11 and arg_354_1.time_ < var_357_3 + var_357_11 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play416101088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 416101088
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play416101089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_9000

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1148 = arg_358_1.actors_["1148"].transform.localPosition
				arg_358_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1148", 7)

				for iter_361_0 = 0, arg_358_1.actors_["1148"].transform.childCount - 1 do
					local var_361_0 = arg_358_1.actors_["1148"].transform:GetChild(iter_361_0)

					if var_361_0.name == "" or not string.find(var_361_0.name, "split") then
						var_361_0.gameObject:SetActive(true)
					else
						var_361_0.gameObject:SetActive(false)
					end
				end
			end

			local var_361_1 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_1 then
				arg_358_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_358_1.time_ - 0) / var_361_1)
			end

			if arg_358_1.time_ >= 0 + var_361_1 and arg_358_1.time_ < 0 + var_361_1 + arg_361_0 then
				arg_358_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:AudioAction("stop", "effect", "se_story_138", "se_story_138_rustle", "")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				local var_361_3 = arg_358_1.var_.effect1088

				if not arg_358_1.var_.effect1088 then
					var_361_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_keep"), manager.ui.mainCamera.transform)
					var_361_3.name = "1088"
					arg_358_1.var_.effect1088 = var_361_3
				else
					var_361_3.transform:SetParent(var_361_9000)
				end

				var_361_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_361_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_361_5 = 0

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = false

				arg_358_1:SetGaussion(false)
			end

			local var_361_6 = 0.3

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_6 then
				local var_361_7 = Color.New(1, 1, 1)

				var_361_7.a = Mathf.Lerp(1, 0, (arg_358_1.time_ - var_361_5) / var_361_6)
				arg_358_1.mask_.color = var_361_7
			end

			if arg_358_1.time_ >= var_361_5 + var_361_6 and arg_358_1.time_ < var_361_5 + var_361_6 + arg_361_0 then
				local var_361_8 = Color.New(1, 1, 1)

				arg_358_1.mask_.enabled = false
				var_361_8.a = 0
				arg_358_1.mask_.color = var_361_8
			end

			if 0.166666666666667 < arg_358_1.time_ and arg_358_1.time_ <= 0.166666666666667 + arg_361_0 then
				arg_358_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog", "")
			end

			local var_361_10 = 0
			local var_361_11 = 1.525

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_10 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_12 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(416101088).content)

				arg_358_1.text_.text = var_361_12

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_14 = 61 <= 0 and var_361_11 or var_361_11 * (utf8.len(var_361_12) / 61)

				if (61 <= 0 and var_361_11 or var_361_11 * (utf8.len(var_361_12) / 61)) > 0 and var_361_11 < var_361_14 then
					arg_358_1.talkMaxDuration = var_361_14

					if var_361_14 + var_361_10 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_10
					end
				end

				arg_358_1.text_.text = var_361_12
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_15 = math.max(var_361_11, arg_358_1.talkMaxDuration)

			if var_361_10 <= arg_358_1.time_ and arg_358_1.time_ < var_361_10 + var_361_15 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_10) / var_361_15

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_10 + var_361_15 and arg_358_1.time_ < var_361_10 + var_361_15 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play416101089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 416101089
		arg_362_1.duration_ = 1.47

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play416101090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1148"]) and arg_362_1.var_.actorSpriteComps1148 == nil then
				arg_362_1.var_.actorSpriteComps1148 = arg_362_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.125

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1148"]) then
				if arg_362_1.var_.actorSpriteComps1148 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1148"]) and arg_362_1.var_.actorSpriteComps1148 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps1148 = nil
			end

			local var_365_2 = arg_362_1.actors_["1148"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1148 = var_365_2.localPosition
				var_365_2.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1148", 3)

				for iter_365_4 = 0, var_365_2.childCount - 1 do
					local var_365_3 = var_365_2:GetChild(iter_365_4)

					if var_365_3.name == "split_3" or not string.find(var_365_3.name, "split") then
						var_365_3.gameObject:SetActive(true)
					else
						var_365_3.gameObject:SetActive(false)
					end
				end
			end

			local var_365_4 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_4 then
				var_365_2.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_362_1.time_ - 0) / var_365_4)
			end

			if arg_362_1.time_ >= 0 + var_365_4 and arg_362_1.time_ < 0 + var_365_4 + arg_365_0 then
				var_365_2.localPosition = Vector3.New(0, -429, -180)
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_365_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_7 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_7

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_7
						arg_362_1.bgmTxt2_.text = var_365_7
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_362_1.time_ and arg_362_1.time_ <= 0.466666666666667 + arg_365_0 then
				arg_362_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_365_10 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

				if "" ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_10 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_10

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_10
						arg_362_1.bgmTxt2_.text = var_365_10
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_365_11 = 0
			local var_365_12 = 0.1

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_11 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_13 = arg_362_1:GetWordFromCfg(416101089)
				local var_365_14 = arg_362_1:FormatText(var_365_13.content)

				arg_362_1.text_.text = var_365_14

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_16 = 4 <= 0 and var_365_12 or var_365_12 * (utf8.len(var_365_14) / 4)

				if (4 <= 0 and var_365_12 or var_365_12 * (utf8.len(var_365_14) / 4)) > 0 and var_365_12 < var_365_16 then
					arg_362_1.talkMaxDuration = var_365_16

					if var_365_16 + var_365_11 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_16 + var_365_11
					end
				end

				arg_362_1.text_.text = var_365_14
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101089", "story_v_out_416101.awb") ~= 0 then
					local var_365_17 = manager.audio:GetVoiceLength("story_v_out_416101", "416101089", "story_v_out_416101.awb") / 1000

					if var_365_17 + var_365_11 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_17 + var_365_11
					end

					if var_365_13.prefab_name ~= "" and arg_362_1.actors_[var_365_13.prefab_name] ~= nil then
						local var_365_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_13.prefab_name].transform, "story_v_out_416101", "416101089", "story_v_out_416101.awb")

						arg_362_1:RecordAudio("416101089", var_365_18)
						arg_362_1:RecordAudio("416101089", var_365_18)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_416101", "416101089", "story_v_out_416101.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_416101", "416101089", "story_v_out_416101.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_19 = math.max(var_365_12, arg_362_1.talkMaxDuration)

			if var_365_11 <= arg_362_1.time_ and arg_362_1.time_ < var_365_11 + var_365_19 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_11) / var_365_19

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_11 + var_365_19 and arg_362_1.time_ < var_365_11 + var_365_19 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play416101090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 416101090
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play416101091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1148 = arg_368_1.actors_["1148"].transform.localPosition
				arg_368_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("1148", 7)

				for iter_371_0 = 0, arg_368_1.actors_["1148"].transform.childCount - 1 do
					local var_371_0 = arg_368_1.actors_["1148"].transform:GetChild(iter_371_0)

					if var_371_0.name == "" or not string.find(var_371_0.name, "split") then
						var_371_0.gameObject:SetActive(true)
					else
						var_371_0.gameObject:SetActive(false)
					end
				end
			end

			local var_371_1 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_1 then
				arg_368_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_368_1.time_ - 0) / var_371_1)
			end

			if arg_368_1.time_ >= 0 + var_371_1 and arg_368_1.time_ < 0 + var_371_1 + arg_371_0 then
				arg_368_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_371_2 = 0
			local var_371_3 = 1.95

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_4 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(416101090).content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 78 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 78)

				if (78 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 78)) > 0 and var_371_3 < var_371_6 then
					arg_368_1.talkMaxDuration = var_371_6

					if var_371_6 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_2
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_3, arg_368_1.talkMaxDuration)

			if var_371_2 <= arg_368_1.time_ and arg_368_1.time_ < var_371_2 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_2) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_2 + var_371_7 and arg_368_1.time_ < var_371_2 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play416101091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 416101091
		arg_372_1.duration_ = 2.5

		local var_372_0 = {
			zh = 2.2,
			ja = 2.5
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play416101092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1148 = arg_372_1.actors_["1148"].transform.localPosition
				arg_372_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1148", 3)

				for iter_375_0 = 0, arg_372_1.actors_["1148"].transform.childCount - 1 do
					local var_375_0 = arg_372_1.actors_["1148"].transform:GetChild(iter_375_0)

					if var_375_0.name == "split_6" or not string.find(var_375_0.name, "split") then
						var_375_0.gameObject:SetActive(true)
					else
						var_375_0.gameObject:SetActive(false)
					end
				end
			end

			local var_375_1 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_1 then
				arg_372_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_372_1.time_ - 0) / var_375_1)
			end

			if arg_372_1.time_ >= 0 + var_375_1 and arg_372_1.time_ < 0 + var_375_1 + arg_375_0 then
				arg_372_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_375_2 = arg_372_1.actors_["1148"]

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(var_375_2) and arg_372_1.var_.actorSpriteComps1148 == nil then
				arg_372_1.var_.actorSpriteComps1148 = var_375_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_3 = 0.125

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_3 and not isNil(var_375_2) then
				if arg_372_1.var_.actorSpriteComps1148 then
					for iter_375_1, iter_375_2 in pairs(arg_372_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_375_2 then
							if arg_372_1.isInRecall_ then
								iter_375_2.color = Color.New(Mathf.Lerp(iter_375_2.color.r, arg_372_1.hightColor1.r, (arg_372_1.time_ - 0) / var_375_3), Mathf.Lerp(iter_375_2.color.g, arg_372_1.hightColor1.g, (arg_372_1.time_ - 0) / var_375_3), (Mathf.Lerp(iter_375_2.color.b, arg_372_1.hightColor1.b, (arg_372_1.time_ - 0) / var_375_3)))
							else
								local var_375_4 = Mathf.Lerp(iter_375_2.color.r, 1, (arg_372_1.time_ - 0) / var_375_3)

								iter_375_2.color = Color.New(var_375_4, var_375_4, var_375_4)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 0 + var_375_3 and arg_372_1.time_ < 0 + var_375_3 + arg_375_0 and not isNil(var_375_2) and arg_372_1.var_.actorSpriteComps1148 then
				for iter_375_3, iter_375_4 in pairs(arg_372_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_375_4 then
						iter_375_4.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_372_1.var_.actorSpriteComps1148 = nil
			end

			local var_375_5 = 0
			local var_375_6 = 0.15

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_7 = arg_372_1:GetWordFromCfg(416101091)
				local var_375_8 = arg_372_1:FormatText(var_375_7.content)

				arg_372_1.text_.text = var_375_8

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_10 = 6 <= 0 and var_375_6 or var_375_6 * (utf8.len(var_375_8) / 6)

				if (6 <= 0 and var_375_6 or var_375_6 * (utf8.len(var_375_8) / 6)) > 0 and var_375_6 < var_375_10 then
					arg_372_1.talkMaxDuration = var_375_10

					if var_375_10 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_5
					end
				end

				arg_372_1.text_.text = var_375_8
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101091", "story_v_out_416101.awb") ~= 0 then
					local var_375_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101091", "story_v_out_416101.awb") / 1000

					if var_375_11 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_11 + var_375_5
					end

					if var_375_7.prefab_name ~= "" and arg_372_1.actors_[var_375_7.prefab_name] ~= nil then
						local var_375_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_7.prefab_name].transform, "story_v_out_416101", "416101091", "story_v_out_416101.awb")

						arg_372_1:RecordAudio("416101091", var_375_12)
						arg_372_1:RecordAudio("416101091", var_375_12)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_416101", "416101091", "story_v_out_416101.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_416101", "416101091", "story_v_out_416101.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_13 = math.max(var_375_6, arg_372_1.talkMaxDuration)

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_13 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_5) / var_375_13

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_5 + var_375_13 and arg_372_1.time_ < var_375_5 + var_375_13 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play416101092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 416101092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play416101093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1148 = arg_376_1.actors_["1148"].transform.localPosition
				arg_376_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1148", 7)

				for iter_379_0 = 0, arg_376_1.actors_["1148"].transform.childCount - 1 do
					local var_379_0 = arg_376_1.actors_["1148"].transform:GetChild(iter_379_0)

					if var_379_0.name == "" or not string.find(var_379_0.name, "split") then
						var_379_0.gameObject:SetActive(true)
					else
						var_379_0.gameObject:SetActive(false)
					end
				end
			end

			local var_379_1 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_1 then
				arg_376_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_376_1.time_ - 0) / var_379_1)
			end

			if arg_376_1.time_ >= 0 + var_379_1 and arg_376_1.time_ < 0 + var_379_1 + arg_379_0 then
				arg_376_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:AudioAction("play", "effect", "se_story_side_1084", "se_story_1084_run", "")
			end

			local var_379_3 = 0
			local var_379_4 = 1.175

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_3 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_5 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(416101092).content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 47 <= 0 and var_379_4 or var_379_4 * (utf8.len(var_379_5) / 47)

				if (47 <= 0 and var_379_4 or var_379_4 * (utf8.len(var_379_5) / 47)) > 0 and var_379_4 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_3 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_3
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_8 = math.max(var_379_4, arg_376_1.talkMaxDuration)

			if var_379_3 <= arg_376_1.time_ and arg_376_1.time_ < var_379_3 + var_379_8 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_3) / var_379_8

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_3 + var_379_8 and arg_376_1.time_ < var_379_3 + var_379_8 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play416101093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 416101093
		arg_380_1.duration_ = 5.67

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play416101094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_9000

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = false

				arg_380_1:SetGaussion(false)
			end

			local var_383_0 = 0.666666666666667

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				local var_383_1 = Color.New(1, 1, 1)

				var_383_1.a = Mathf.Lerp(1, 0, (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.mask_.color = var_383_1
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				local var_383_2 = Color.New(1, 1, 1)

				arg_380_1.mask_.enabled = false
				var_383_2.a = 0
				arg_380_1.mask_.color = var_383_2
			end

			if 0.266666666666667 < arg_380_1.time_ and arg_380_1.time_ <= 0.266666666666667 + arg_383_0 then
				local var_383_3 = arg_380_1.var_.effect1093

				if not arg_380_1.var_.effect1093 then
					var_383_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_383_3.name = "1093"
					arg_380_1.var_.effect1093 = var_383_3
				else
					var_383_3.transform:SetParent(var_383_9000)
				end

				var_383_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_383_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.99166666666667 < arg_380_1.time_ and arg_380_1.time_ <= 1.99166666666667 + arg_383_0 then
				if arg_380_1.var_.effect1093 then
					Object.Destroy(arg_380_1.var_.effect1093)

					arg_380_1.var_.effect1093 = nil
				end
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_10", "se_story_10_light", "")
			end

			if 0.9 < arg_380_1.time_ and arg_380_1.time_ <= 0.9 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if 3.2 < arg_380_1.time_ and arg_380_1.time_ <= 3.2 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_9 = 0.666666666666667
			local var_383_10 = 1.325

			if 0.666666666666667 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_11 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_11:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_12 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(416101093).content)

				arg_380_1.text_.text = var_383_12

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_14 = 53 <= 0 and var_383_10 or var_383_10 * (utf8.len(var_383_12) / 53)

				if (53 <= 0 and var_383_10 or var_383_10 * (utf8.len(var_383_12) / 53)) > 0 and var_383_10 < var_383_14 then
					arg_380_1.talkMaxDuration = var_383_14
					var_383_9 = var_383_9 + 0.3

					if var_383_14 + var_383_9 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_9
					end
				end

				arg_380_1.text_.text = var_383_12
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_15 = var_383_9 + 0.3
			local var_383_16 = math.max(var_383_10, arg_380_1.talkMaxDuration)

			if var_383_9 + 0.3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_15 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_15) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_15 + var_383_16 and arg_380_1.time_ < var_383_15 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play416101094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 416101094
		arg_386_1.duration_ = 5.9

		local var_386_0 = {
			zh = 5.9,
			ja = 1.9
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play416101095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1148 = arg_386_1.actors_["1148"].transform.localPosition
				arg_386_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("1148", 3)

				for iter_389_0 = 0, arg_386_1.actors_["1148"].transform.childCount - 1 do
					local var_389_0 = arg_386_1.actors_["1148"].transform:GetChild(iter_389_0)

					if var_389_0.name == "split_6" or not string.find(var_389_0.name, "split") then
						var_389_0.gameObject:SetActive(true)
					else
						var_389_0.gameObject:SetActive(false)
					end
				end
			end

			local var_389_1 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_1 then
				arg_386_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_386_1.time_ - 0) / var_389_1)
			end

			if arg_386_1.time_ >= 0 + var_389_1 and arg_386_1.time_ < 0 + var_389_1 + arg_389_0 then
				arg_386_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_389_2 = arg_386_1.actors_["1148"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.actorSpriteComps1148 == nil then
				arg_386_1.var_.actorSpriteComps1148 = var_389_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_3 = 0.125

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_3 and not isNil(var_389_2) then
				if arg_386_1.var_.actorSpriteComps1148 then
					for iter_389_1, iter_389_2 in pairs(arg_386_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_389_2 then
							if arg_386_1.isInRecall_ then
								iter_389_2.color = Color.New(Mathf.Lerp(iter_389_2.color.r, arg_386_1.hightColor1.r, (arg_386_1.time_ - 0) / var_389_3), Mathf.Lerp(iter_389_2.color.g, arg_386_1.hightColor1.g, (arg_386_1.time_ - 0) / var_389_3), (Mathf.Lerp(iter_389_2.color.b, arg_386_1.hightColor1.b, (arg_386_1.time_ - 0) / var_389_3)))
							else
								local var_389_4 = Mathf.Lerp(iter_389_2.color.r, 1, (arg_386_1.time_ - 0) / var_389_3)

								iter_389_2.color = Color.New(var_389_4, var_389_4, var_389_4)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_3 and arg_386_1.time_ < 0 + var_389_3 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.actorSpriteComps1148 then
				for iter_389_3, iter_389_4 in pairs(arg_386_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_389_4 then
						iter_389_4.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_386_1.var_.actorSpriteComps1148 = nil
			end

			local var_389_5 = 0
			local var_389_6 = 0.275

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_7 = arg_386_1:GetWordFromCfg(416101094)
				local var_389_8 = arg_386_1:FormatText(var_389_7.content)

				arg_386_1.text_.text = var_389_8

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_10 = 11 <= 0 and var_389_6 or var_389_6 * (utf8.len(var_389_8) / 11)

				if (11 <= 0 and var_389_6 or var_389_6 * (utf8.len(var_389_8) / 11)) > 0 and var_389_6 < var_389_10 then
					arg_386_1.talkMaxDuration = var_389_10

					if var_389_10 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_5
					end
				end

				arg_386_1.text_.text = var_389_8
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101094", "story_v_out_416101.awb") ~= 0 then
					local var_389_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101094", "story_v_out_416101.awb") / 1000

					if var_389_11 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_11 + var_389_5
					end

					if var_389_7.prefab_name ~= "" and arg_386_1.actors_[var_389_7.prefab_name] ~= nil then
						local var_389_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_7.prefab_name].transform, "story_v_out_416101", "416101094", "story_v_out_416101.awb")

						arg_386_1:RecordAudio("416101094", var_389_12)
						arg_386_1:RecordAudio("416101094", var_389_12)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_416101", "416101094", "story_v_out_416101.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_416101", "416101094", "story_v_out_416101.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_13 = math.max(var_389_6, arg_386_1.talkMaxDuration)

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_13 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_5) / var_389_13

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_5 + var_389_13 and arg_386_1.time_ < var_389_5 + var_389_13 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play416101095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 416101095
		arg_390_1.duration_ = 11.3

		local var_390_0 = {
			zh = 5.2,
			ja = 11.3
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play416101096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1148"]) and arg_390_1.var_.actorSpriteComps1148 == nil then
				arg_390_1.var_.actorSpriteComps1148 = arg_390_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_0 = 0.125

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1148"]) then
				if arg_390_1.var_.actorSpriteComps1148 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								iter_393_1.color = Color.New(Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor2.r, (arg_390_1.time_ - 0) / var_393_0), Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor2.g, (arg_390_1.time_ - 0) / var_393_0), (Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor2.b, (arg_390_1.time_ - 0) / var_393_0)))
							else
								local var_393_1 = Mathf.Lerp(iter_393_1.color.r, 0.5, (arg_390_1.time_ - 0) / var_393_0)

								iter_393_1.color = Color.New(var_393_1, var_393_1, var_393_1)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1148"]) and arg_390_1.var_.actorSpriteComps1148 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_393_3 then
						iter_393_3.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_390_1.var_.actorSpriteComps1148 = nil
			end

			local var_393_2 = 0
			local var_393_3 = 0.5

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_4 = arg_390_1:GetWordFromCfg(416101095)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_7 = 20 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 20)

				if (20 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 20)) > 0 and var_393_3 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_2
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101095", "story_v_out_416101.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101095", "story_v_out_416101.awb") / 1000

					if var_393_8 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_2
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_out_416101", "416101095", "story_v_out_416101.awb")

						arg_390_1:RecordAudio("416101095", var_393_9)
						arg_390_1:RecordAudio("416101095", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_416101", "416101095", "story_v_out_416101.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_416101", "416101095", "story_v_out_416101.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_3, arg_390_1.talkMaxDuration)

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_2) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_2 + var_393_10 and arg_390_1.time_ < var_393_2 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play416101096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 416101096
		arg_394_1.duration_ = 4.7

		local var_394_0 = {
			zh = 3.566,
			ja = 4.7
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play416101097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1148"]) and arg_394_1.var_.actorSpriteComps1148 == nil then
				arg_394_1.var_.actorSpriteComps1148 = arg_394_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_0 = 0.125

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1148"]) then
				if arg_394_1.var_.actorSpriteComps1148 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								iter_397_1.color = Color.New(Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, (arg_394_1.time_ - 0) / var_397_0), Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, (arg_394_1.time_ - 0) / var_397_0), (Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, (arg_394_1.time_ - 0) / var_397_0)))
							else
								local var_397_1 = Mathf.Lerp(iter_397_1.color.r, 1, (arg_394_1.time_ - 0) / var_397_0)

								iter_397_1.color = Color.New(var_397_1, var_397_1, var_397_1)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1148"]) and arg_394_1.var_.actorSpriteComps1148 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_397_3 then
						iter_397_3.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_394_1.var_.actorSpriteComps1148 = nil
			end

			local var_397_2 = arg_394_1.actors_["1148"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1148 = var_397_2.localPosition
				var_397_2.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1148", 3)

				for iter_397_4 = 0, var_397_2.childCount - 1 do
					local var_397_3 = var_397_2:GetChild(iter_397_4)

					if var_397_3.name == "split_3" or not string.find(var_397_3.name, "split") then
						var_397_3.gameObject:SetActive(true)
					else
						var_397_3.gameObject:SetActive(false)
					end
				end
			end

			local var_397_4 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				var_397_2.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_394_1.time_ - 0) / var_397_4)
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				var_397_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_397_5 = 0
			local var_397_6 = 0.3

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_7 = arg_394_1:GetWordFromCfg(416101096)
				local var_397_8 = arg_394_1:FormatText(var_397_7.content)

				arg_394_1.text_.text = var_397_8

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_10 = 12 <= 0 and var_397_6 or var_397_6 * (utf8.len(var_397_8) / 12)

				if (12 <= 0 and var_397_6 or var_397_6 * (utf8.len(var_397_8) / 12)) > 0 and var_397_6 < var_397_10 then
					arg_394_1.talkMaxDuration = var_397_10

					if var_397_10 + var_397_5 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_10 + var_397_5
					end
				end

				arg_394_1.text_.text = var_397_8
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101096", "story_v_out_416101.awb") ~= 0 then
					local var_397_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101096", "story_v_out_416101.awb") / 1000

					if var_397_11 + var_397_5 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_11 + var_397_5
					end

					if var_397_7.prefab_name ~= "" and arg_394_1.actors_[var_397_7.prefab_name] ~= nil then
						local var_397_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_7.prefab_name].transform, "story_v_out_416101", "416101096", "story_v_out_416101.awb")

						arg_394_1:RecordAudio("416101096", var_397_12)
						arg_394_1:RecordAudio("416101096", var_397_12)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_416101", "416101096", "story_v_out_416101.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_416101", "416101096", "story_v_out_416101.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_13 = math.max(var_397_6, arg_394_1.talkMaxDuration)

			if var_397_5 <= arg_394_1.time_ and arg_394_1.time_ < var_397_5 + var_397_13 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_5) / var_397_13

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_5 + var_397_13 and arg_394_1.time_ < var_397_5 + var_397_13 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play416101097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 416101097
		arg_398_1.duration_ = 5.7

		local var_398_0 = {
			zh = 5.333,
			ja = 5.7
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play416101098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.55

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(416101097)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 22 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 22)

				if (22 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 22)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101097", "story_v_out_416101.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101097", "story_v_out_416101.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_416101", "416101097", "story_v_out_416101.awb")

						arg_398_1:RecordAudio("416101097", var_401_6)
						arg_398_1:RecordAudio("416101097", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_416101", "416101097", "story_v_out_416101.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_416101", "416101097", "story_v_out_416101.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play416101098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 416101098
		arg_402_1.duration_ = 10.17

		local var_402_0 = {
			zh = 4.966,
			ja = 10.166
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play416101099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos1148 = arg_402_1.actors_["1148"].transform.localPosition
				arg_402_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("1148", 7)

				for iter_405_0 = 0, arg_402_1.actors_["1148"].transform.childCount - 1 do
					local var_405_0 = arg_402_1.actors_["1148"].transform:GetChild(iter_405_0)

					if var_405_0.name == "" or not string.find(var_405_0.name, "split") then
						var_405_0.gameObject:SetActive(true)
					else
						var_405_0.gameObject:SetActive(false)
					end
				end
			end

			local var_405_1 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_1 then
				arg_402_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_402_1.time_ - 0) / var_405_1)
			end

			if arg_402_1.time_ >= 0 + var_405_1 and arg_402_1.time_ < 0 + var_405_1 + arg_405_0 then
				arg_402_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_405_2 = 0
			local var_405_3 = 0.35

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_4 = arg_402_1:GetWordFromCfg(416101098)
				local var_405_5 = arg_402_1:FormatText(var_405_4.content)

				arg_402_1.text_.text = var_405_5

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_7 = 14 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 14)

				if (14 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 14)) > 0 and var_405_3 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_5
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101098", "story_v_out_416101.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101098", "story_v_out_416101.awb") / 1000

					if var_405_8 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_2
					end

					if var_405_4.prefab_name ~= "" and arg_402_1.actors_[var_405_4.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_4.prefab_name].transform, "story_v_out_416101", "416101098", "story_v_out_416101.awb")

						arg_402_1:RecordAudio("416101098", var_405_9)
						arg_402_1:RecordAudio("416101098", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_416101", "416101098", "story_v_out_416101.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_416101", "416101098", "story_v_out_416101.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_10 and arg_402_1.time_ < var_405_2 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play416101099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416101099
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play416101100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 1.575

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_1 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(416101099).content)

				arg_406_1.text_.text = var_409_1

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_3 = 63 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 63)

				if (63 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 63)) > 0 and var_409_0 < var_409_3 then
					arg_406_1.talkMaxDuration = var_409_3

					if var_409_3 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_3 + 0
					end
				end

				arg_406_1.text_.text = var_409_1
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_4 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_4

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play416101100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 416101100
		arg_410_1.duration_ = 6.77

		local var_410_0 = {
			zh = 5.166,
			ja = 6.766
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play416101101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1148 = arg_410_1.actors_["1148"].transform.localPosition
				arg_410_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1148", 3)

				for iter_413_0 = 0, arg_410_1.actors_["1148"].transform.childCount - 1 do
					local var_413_0 = arg_410_1.actors_["1148"].transform:GetChild(iter_413_0)

					if var_413_0.name == "split_3" or not string.find(var_413_0.name, "split") then
						var_413_0.gameObject:SetActive(true)
					else
						var_413_0.gameObject:SetActive(false)
					end
				end
			end

			local var_413_1 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_1 then
				arg_410_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_410_1.time_ - 0) / var_413_1)
			end

			if arg_410_1.time_ >= 0 + var_413_1 and arg_410_1.time_ < 0 + var_413_1 + arg_413_0 then
				arg_410_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_413_2 = arg_410_1.actors_["1148"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1148 == nil then
				arg_410_1.var_.actorSpriteComps1148 = var_413_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_3 = 0.125

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.actorSpriteComps1148 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								iter_413_2.color = Color.New(Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_3), Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_3), (Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_3)))
							else
								local var_413_4 = Mathf.Lerp(iter_413_2.color.r, 1, (arg_410_1.time_ - 0) / var_413_3)

								iter_413_2.color = Color.New(var_413_4, var_413_4, var_413_4)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1148 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_413_4 then
						iter_413_4.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps1148 = nil
			end

			local var_413_5 = 0
			local var_413_6 = 0.575

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_5 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_7 = arg_410_1:GetWordFromCfg(416101100)
				local var_413_8 = arg_410_1:FormatText(var_413_7.content)

				arg_410_1.text_.text = var_413_8

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_10 = 23 <= 0 and var_413_6 or var_413_6 * (utf8.len(var_413_8) / 23)

				if (23 <= 0 and var_413_6 or var_413_6 * (utf8.len(var_413_8) / 23)) > 0 and var_413_6 < var_413_10 then
					arg_410_1.talkMaxDuration = var_413_10

					if var_413_10 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_10 + var_413_5
					end
				end

				arg_410_1.text_.text = var_413_8
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101100", "story_v_out_416101.awb") ~= 0 then
					local var_413_11 = manager.audio:GetVoiceLength("story_v_out_416101", "416101100", "story_v_out_416101.awb") / 1000

					if var_413_11 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_11 + var_413_5
					end

					if var_413_7.prefab_name ~= "" and arg_410_1.actors_[var_413_7.prefab_name] ~= nil then
						local var_413_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_7.prefab_name].transform, "story_v_out_416101", "416101100", "story_v_out_416101.awb")

						arg_410_1:RecordAudio("416101100", var_413_12)
						arg_410_1:RecordAudio("416101100", var_413_12)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_416101", "416101100", "story_v_out_416101.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_416101", "416101100", "story_v_out_416101.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_13 = math.max(var_413_6, arg_410_1.talkMaxDuration)

			if var_413_5 <= arg_410_1.time_ and arg_410_1.time_ < var_413_5 + var_413_13 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_5) / var_413_13

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_5 + var_413_13 and arg_410_1.time_ < var_413_5 + var_413_13 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play416101101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 416101101
		arg_414_1.duration_ = 10.7

		local var_414_0 = {
			zh = 6.866,
			ja = 10.7
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play416101102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1148 = arg_414_1.actors_["1148"].transform.localPosition
				arg_414_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("1148", 7)

				for iter_417_0 = 0, arg_414_1.actors_["1148"].transform.childCount - 1 do
					local var_417_0 = arg_414_1.actors_["1148"].transform:GetChild(iter_417_0)

					if var_417_0.name == "" or not string.find(var_417_0.name, "split") then
						var_417_0.gameObject:SetActive(true)
					else
						var_417_0.gameObject:SetActive(false)
					end
				end
			end

			local var_417_1 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_1 then
				arg_414_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_414_1.time_ - 0) / var_417_1)
			end

			if arg_414_1.time_ >= 0 + var_417_1 and arg_414_1.time_ < 0 + var_417_1 + arg_417_0 then
				arg_414_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_417_2 = 0
			local var_417_3 = 0.55

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_2 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_4 = arg_414_1:GetWordFromCfg(416101101)
				local var_417_5 = arg_414_1:FormatText(var_417_4.content)

				arg_414_1.text_.text = var_417_5

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_7 = 22 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_5) / 22)

				if (22 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_5) / 22)) > 0 and var_417_3 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_2
					end
				end

				arg_414_1.text_.text = var_417_5
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101101", "story_v_out_416101.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_out_416101", "416101101", "story_v_out_416101.awb") / 1000

					if var_417_8 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_2
					end

					if var_417_4.prefab_name ~= "" and arg_414_1.actors_[var_417_4.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_4.prefab_name].transform, "story_v_out_416101", "416101101", "story_v_out_416101.awb")

						arg_414_1:RecordAudio("416101101", var_417_9)
						arg_414_1:RecordAudio("416101101", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_416101", "416101101", "story_v_out_416101.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_416101", "416101101", "story_v_out_416101.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_3, arg_414_1.talkMaxDuration)

			if var_417_2 <= arg_414_1.time_ and arg_414_1.time_ < var_417_2 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_2) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_2 + var_417_10 and arg_414_1.time_ < var_417_2 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play416101102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 416101102
		arg_418_1.duration_ = 5.2

		local var_418_0 = {
			zh = 4.4,
			ja = 5.2
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play416101103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0.533333333333333 < arg_418_1.time_ and arg_418_1.time_ <= 0.533333333333333 + arg_421_0 then
				arg_418_1:AudioAction("play", "effect", "se_story_138", "se_story_138_weaponfall", "")
			end

			local var_421_1 = 0
			local var_421_2 = 0.25

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_3 = arg_418_1:GetWordFromCfg(416101102)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_6 = 10 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_4) / 10)

				if (10 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_4) / 10)) > 0 and var_421_2 < var_421_6 then
					arg_418_1.talkMaxDuration = var_421_6

					if var_421_6 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101102", "story_v_out_416101.awb") ~= 0 then
					local var_421_7 = manager.audio:GetVoiceLength("story_v_out_416101", "416101102", "story_v_out_416101.awb") / 1000

					if var_421_7 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_1
					end

					if var_421_3.prefab_name ~= "" and arg_418_1.actors_[var_421_3.prefab_name] ~= nil then
						local var_421_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_3.prefab_name].transform, "story_v_out_416101", "416101102", "story_v_out_416101.awb")

						arg_418_1:RecordAudio("416101102", var_421_8)
						arg_418_1:RecordAudio("416101102", var_421_8)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_416101", "416101102", "story_v_out_416101.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_416101", "416101102", "story_v_out_416101.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_9 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_9 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_9

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_9 and arg_418_1.time_ < var_421_1 + var_421_9 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play416101103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 416101103
		arg_422_1.duration_ = 9

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play416101104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_9000

			if 4 < arg_422_1.time_ and arg_422_1.time_ <= 4 + arg_425_0 then
				arg_422_1.allBtn_.enabled = false
			end

			if arg_422_1.time_ >= 4 + 0.3 and arg_422_1.time_ < 4 + 0.3 + arg_425_0 then
				arg_422_1.allBtn_.enabled = true
			end

			local var_425_0 = "SS1604"

			if arg_422_1.bgs_.SS1604 == nil then
				local var_425_1 = Object.Instantiate(arg_422_1.paintGo_)

				var_425_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_425_0)
				var_425_1.name = var_425_0
				var_425_1.transform.parent = arg_422_1.stage_.transform
				var_425_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.bgs_[var_425_0] = var_425_1
			end

			if 2 < arg_422_1.time_ and arg_422_1.time_ <= 2 + arg_425_0 then
				local var_425_2 = arg_422_1.bgs_.SS1604

				arg_422_1.bgs_.SS1604.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_425_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_425_3 = var_425_2:GetComponent("SpriteRenderer")

				if var_425_3 and var_425_3.sprite then
					local var_425_4 = 2 * (var_425_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_425_2.transform.localScale = Vector3.New(var_425_4 / var_425_3.sprite.bounds.size.y < var_425_4 * manager.ui.mainCameraCom_.aspect / var_425_3.sprite.bounds.size.x and var_425_4 * manager.ui.mainCameraCom_.aspect / var_425_3.sprite.bounds.size.x or var_425_4 / var_425_3.sprite.bounds.size.y, var_425_4 / var_425_3.sprite.bounds.size.y < var_425_4 * manager.ui.mainCameraCom_.aspect / var_425_3.sprite.bounds.size.x and var_425_4 * manager.ui.mainCameraCom_.aspect / var_425_3.sprite.bounds.size.x or var_425_4 / var_425_3.sprite.bounds.size.y, 0)
				end

				for iter_425_0, iter_425_1 in pairs(arg_422_1.bgs_) do
					if iter_425_0 ~= "SS1604" then
						iter_425_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_425_5 = 0

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_6 = 2

			if var_425_5 <= arg_422_1.time_ and arg_422_1.time_ < var_425_5 + var_425_6 then
				local var_425_7 = Color.New(0, 0, 0)

				var_425_7.a = Mathf.Lerp(0, 1, (arg_422_1.time_ - var_425_5) / var_425_6)
				arg_422_1.mask_.color = var_425_7
			end

			if arg_422_1.time_ >= var_425_5 + var_425_6 and arg_422_1.time_ < var_425_5 + var_425_6 + arg_425_0 then
				local var_425_8 = Color.New(0, 0, 0)

				var_425_8.a = 1
				arg_422_1.mask_.color = var_425_8
			end

			local var_425_9 = 2

			if 2 < arg_422_1.time_ and arg_422_1.time_ <= var_425_9 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_10 = 2

			if var_425_9 <= arg_422_1.time_ and arg_422_1.time_ < var_425_9 + var_425_10 then
				local var_425_11 = Color.New(0, 0, 0)

				var_425_11.a = Mathf.Lerp(1, 0, (arg_422_1.time_ - var_425_9) / var_425_10)
				arg_422_1.mask_.color = var_425_11
			end

			if arg_422_1.time_ >= var_425_9 + var_425_10 and arg_422_1.time_ < var_425_9 + var_425_10 + arg_425_0 then
				local var_425_12 = Color.New(0, 0, 0)

				arg_422_1.mask_.enabled = false
				var_425_12.a = 0
				arg_422_1.mask_.color = var_425_12
			end

			if 1.8 < arg_422_1.time_ and arg_422_1.time_ <= 1.8 + arg_425_0 then
				if arg_422_1.var_.effect10932 then
					Object.Destroy(arg_422_1.var_.effect10932)

					arg_422_1.var_.effect10932 = nil
				end
			end

			if 2 < arg_422_1.time_ and arg_422_1.time_ <= 2 + arg_425_0 then
				local var_425_14 = arg_422_1.var_.effect10932

				if not arg_422_1.var_.effect10932 then
					var_425_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_keep"), manager.ui.mainCamera.transform)
					var_425_14.name = "10932"
					arg_422_1.var_.effect10932 = var_425_14
				else
					var_425_14.transform:SetParent(var_425_9000)
				end

				var_425_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_425_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_422_1.frameCnt_ <= 1 then
				arg_422_1.dialog_:SetActive(false)
			end

			local var_425_16 = 4
			local var_425_17 = 1.575

			if 4 < arg_422_1.time_ and arg_422_1.time_ <= var_425_16 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0

				arg_422_1.dialog_:SetActive(true)

				arg_422_1.dialogCg_.alpha = 0

				local var_425_18 = LeanTween.value(arg_422_1.dialog_, 0, 1, 0.3)

				var_425_18:setOnUpdate(LuaHelper.FloatAction(function(arg_426_0)
					arg_422_1.dialogCg_.alpha = arg_426_0
				end))
				var_425_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_422_1.dialog_)
					var_425_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_422_1.duration_ = arg_422_1.duration_ + 0.3

				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_19 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(416101103).content)

				arg_422_1.text_.text = var_425_19

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_21 = 63 <= 0 and var_425_17 or var_425_17 * (utf8.len(var_425_19) / 63)

				if (63 <= 0 and var_425_17 or var_425_17 * (utf8.len(var_425_19) / 63)) > 0 and var_425_17 < var_425_21 then
					arg_422_1.talkMaxDuration = var_425_21
					var_425_16 = var_425_16 + 0.3

					if var_425_21 + var_425_16 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_21 + var_425_16
					end
				end

				arg_422_1.text_.text = var_425_19
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_22 = var_425_16 + 0.3
			local var_425_23 = math.max(var_425_17, arg_422_1.talkMaxDuration)

			if var_425_16 + 0.3 <= arg_422_1.time_ and arg_422_1.time_ < var_425_22 + var_425_23 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_22) / var_425_23

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_22 + var_425_23 and arg_422_1.time_ < var_425_22 + var_425_23 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play416101104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 416101104
		arg_428_1.duration_ = 8.9

		local var_428_0 = {
			zh = 7.1,
			ja = 8.9
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play416101105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.45

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_1 = arg_428_1:GetWordFromCfg(416101104)
				local var_431_2 = arg_428_1:FormatText(var_431_1.content)

				arg_428_1.text_.text = var_431_2

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 18 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 18)

				if (18 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 18)) > 0 and var_431_0 < var_431_4 then
					arg_428_1.talkMaxDuration = var_431_4

					if var_431_4 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_4 + 0
					end
				end

				arg_428_1.text_.text = var_431_2
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101104", "story_v_out_416101.awb") ~= 0 then
					local var_431_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101104", "story_v_out_416101.awb") / 1000

					if var_431_5 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + 0
					end

					if var_431_1.prefab_name ~= "" and arg_428_1.actors_[var_431_1.prefab_name] ~= nil then
						local var_431_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_1.prefab_name].transform, "story_v_out_416101", "416101104", "story_v_out_416101.awb")

						arg_428_1:RecordAudio("416101104", var_431_6)
						arg_428_1:RecordAudio("416101104", var_431_6)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_416101", "416101104", "story_v_out_416101.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_416101", "416101104", "story_v_out_416101.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_7 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_7 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_7

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_7 and arg_428_1.time_ < 0 + var_431_7 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play416101105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 416101105
		arg_432_1.duration_ = 7.1

		local var_432_0 = {
			zh = 6.933,
			ja = 7.1
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
			arg_432_1.auto_ = false
		end

		function arg_432_1.playNext_(arg_434_0)
			arg_432_1.onStoryFinished_()
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.375

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:GetWordFromCfg(416101105)
				local var_435_2 = arg_432_1:FormatText(var_435_1.content)

				arg_432_1.text_.text = var_435_2

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 15 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 15)

				if (15 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 15)) > 0 and var_435_0 < var_435_4 then
					arg_432_1.talkMaxDuration = var_435_4

					if var_435_4 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_4 + 0
					end
				end

				arg_432_1.text_.text = var_435_2
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416101", "416101105", "story_v_out_416101.awb") ~= 0 then
					local var_435_5 = manager.audio:GetVoiceLength("story_v_out_416101", "416101105", "story_v_out_416101.awb") / 1000

					if var_435_5 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + 0
					end

					if var_435_1.prefab_name ~= "" and arg_432_1.actors_[var_435_1.prefab_name] ~= nil then
						local var_435_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_1.prefab_name].transform, "story_v_out_416101", "416101105", "story_v_out_416101.awb")

						arg_432_1:RecordAudio("416101105", var_435_6)
						arg_432_1:RecordAudio("416101105", var_435_6)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_416101", "416101105", "story_v_out_416101.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_416101", "416101105", "story_v_out_416101.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/SS1604"
	},
	voices = {
		"story_v_out_416101.awb"
	}
}
