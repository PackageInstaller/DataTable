return {
	Play416062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416062001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			zh = 4.866,
			ja = 6.666
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
				arg_1_0:Play416062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.3 and arg_1_1.time_ < 2 + 0.3 + arg_4_0 then
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

			local var_4_9 = "1086"

			if arg_1_1.actors_["1086"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

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

			local var_4_12 = arg_1_1.actors_["1086"].transform

			if 1.67800913522889 < arg_1_1.time_ and arg_1_1.time_ <= 1.67800913522889 + arg_4_0 then
				arg_1_1.var_.moveOldPos1086 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1086", 3)

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

			if 1.67800913522889 <= arg_1_1.time_ and arg_1_1.time_ < 1.67800913522889 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_1_1.time_ - 1.67800913522889) / var_4_14)
			end

			if arg_1_1.time_ >= 1.67800913522889 + var_4_14 and arg_1_1.time_ < 1.67800913522889 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_4_15 = arg_1_1.actors_["1086"]

			if 1.67800913522889 < arg_1_1.time_ and arg_1_1.time_ <= 1.67800913522889 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1086 == nil then
				arg_1_1.var_.actorSpriteComps1086 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.125

			if 1.67800913522889 <= arg_1_1.time_ and arg_1_1.time_ < 1.67800913522889 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps1086 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.67800913522889) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.67800913522889) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.67800913522889) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.67800913522889) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.67800913522889 + var_4_16 and arg_1_1.time_ < 1.67800913522889 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1086 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1086 = nil
			end

			if 1.67800913522889 < arg_1_1.time_ and arg_1_1.time_ <= 1.67800913522889 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1086"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1086 = var_4_18.alpha
					arg_1_1.var_.characterEffect1086 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1086 = 0
			end

			local var_4_19 = 0.857666666666667

			if 1.67800913522889 <= arg_1_1.time_ and arg_1_1.time_ < 1.67800913522889 + var_4_19 then
				if arg_1_1.var_.characterEffect1086 then
					arg_1_1.var_.characterEffect1086.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1086, 1, (arg_1_1.time_ - 1.67800913522889) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.67800913522889 + var_4_19 and arg_1_1.time_ < 1.67800913522889 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1086 then
				arg_1_1.var_.characterEffect1086.alpha = 1
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(416062001)
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062001", "story_v_out_416062.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_416062", "416062001", "story_v_out_416062.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_416062", "416062001", "story_v_out_416062.awb")

						arg_1_1:RecordAudio("416062001", var_4_34)
						arg_1_1:RecordAudio("416062001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416062", "416062001", "story_v_out_416062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416062", "416062001", "story_v_out_416062.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.67800913522889,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416062002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1086 = arg_9_1.actors_["1086"].transform.localPosition
				arg_9_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1086", 7)

				for iter_12_0 = 0, arg_9_1.actors_["1086"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["1086"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_2 = 0
			local var_12_3 = 1.55

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

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416062002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 62 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 62)

				if (62 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 62)) > 0 and var_12_3 < var_12_6 then
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
				actorName = "1086",
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
	Play416062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416062003
		arg_13_1.duration_ = 9.17

		local var_13_0 = {
			zh = 5.366,
			ja = 9.166
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
				arg_13_0:Play416062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1086 = arg_13_1.actors_["1086"].transform.localPosition
				arg_13_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1086", 3)

				for iter_16_0 = 0, arg_13_1.actors_["1086"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1086"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_16_2 = arg_13_1.actors_["1086"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1086 == nil then
				arg_13_1.var_.actorSpriteComps1086 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.125

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps1086 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1086 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1086 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.65

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(416062003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 26 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 26)

				if (26 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 26)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062003", "story_v_out_416062.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062003", "story_v_out_416062.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_416062", "416062003", "story_v_out_416062.awb")

						arg_13_1:RecordAudio("416062003", var_16_12)
						arg_13_1:RecordAudio("416062003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416062", "416062003", "story_v_out_416062.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416062", "416062003", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416062004
		arg_17_1.duration_ = 7.27

		local var_17_0 = {
			zh = 3.6,
			ja = 7.266
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
				arg_17_0:Play416062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1086 = arg_17_1.actors_["1086"].transform.localPosition
				arg_17_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1086", 2)

				for iter_20_0 = 0, arg_17_1.actors_["1086"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["1086"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_20_2 = "1148"

			if arg_17_1.actors_["1148"] == nil then
				local var_20_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_20_3) then
					local var_20_4 = Object.Instantiate(var_20_3, arg_17_1.canvasGo_.transform)

					var_20_4.transform:SetSiblingIndex(1)

					var_20_4.name = var_20_2
					var_20_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_2] = var_20_4

					if arg_17_1.isInRecall_ then
						for iter_20_1, iter_20_2 in ipairs((var_20_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_2.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_5 = arg_17_1.actors_["1148"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1148 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1148", 4)

				for iter_20_3 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_3)

					if var_20_6.name == "split_5" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_20_8 = arg_17_1.actors_["1148"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1148 == nil then
				arg_17_1.var_.actorSpriteComps1148 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 and not isNil(var_20_8) then
				if arg_17_1.var_.actorSpriteComps1148 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								iter_20_5.color = Color.New(Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_9), Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_9), (Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_9)))
							else
								local var_20_10 = Mathf.Lerp(iter_20_5.color.r, 1, (arg_17_1.time_ - 0) / var_20_9)

								iter_20_5.color = Color.New(var_20_10, var_20_10, var_20_10)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1148 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_20_7 then
						iter_20_7.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1148 = nil
			end

			local var_20_11 = arg_17_1.actors_["1086"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.actorSpriteComps1086 == nil then
				arg_17_1.var_.actorSpriteComps1086 = var_20_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_12 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_12 and not isNil(var_20_11) then
				if arg_17_1.var_.actorSpriteComps1086 then
					for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_20_9 then
							if arg_17_1.isInRecall_ then
								iter_20_9.color = Color.New(Mathf.Lerp(iter_20_9.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_12), Mathf.Lerp(iter_20_9.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_12), (Mathf.Lerp(iter_20_9.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_12)))
							else
								local var_20_13 = Mathf.Lerp(iter_20_9.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_12)

								iter_20_9.color = Color.New(var_20_13, var_20_13, var_20_13)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_12 and arg_17_1.time_ < 0 + var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.actorSpriteComps1086 then
				for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_20_11 then
						iter_20_11.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1086 = nil
			end

			local var_20_14 = 0
			local var_20_15 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_16 = arg_17_1:GetWordFromCfg(416062004)
				local var_20_17 = arg_17_1:FormatText(var_20_16.content)

				arg_17_1.text_.text = var_20_17

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 14 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 14)

				if (14 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 14)) > 0 and var_20_15 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19

					if var_20_19 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_17
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062004", "story_v_out_416062.awb") ~= 0 then
					local var_20_20 = manager.audio:GetVoiceLength("story_v_out_416062", "416062004", "story_v_out_416062.awb") / 1000

					if var_20_20 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_14
					end

					if var_20_16.prefab_name ~= "" and arg_17_1.actors_[var_20_16.prefab_name] ~= nil then
						local var_20_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_16.prefab_name].transform, "story_v_out_416062", "416062004", "story_v_out_416062.awb")

						arg_17_1:RecordAudio("416062004", var_20_21)
						arg_17_1:RecordAudio("416062004", var_20_21)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416062", "416062004", "story_v_out_416062.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416062", "416062004", "story_v_out_416062.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_22 and arg_17_1.time_ < var_20_14 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_17_1:InitPlayNodeList()
	end,
	Play416062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416062005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 5.133,
			ja = 7.3
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
				arg_21_0:Play416062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1148"]) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = arg_21_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1148"]) then
				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1148"]) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_2 = arg_21_1.actors_["1086"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1086 == nil then
				arg_21_1.var_.actorSpriteComps1086 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1086 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1086 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1086 = nil
			end

			local var_24_5 = arg_21_1.actors_["1148"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 4)

				for iter_24_8 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_8)

					if var_24_6.name == "split_4" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_24_8 = 0
			local var_24_9 = 0.6

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
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

				local var_24_10 = arg_21_1:GetWordFromCfg(416062005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 24 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 24)

				if (24 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 24)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062005", "story_v_out_416062.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062005", "story_v_out_416062.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_416062", "416062005", "story_v_out_416062.awb")

						arg_21_1:RecordAudio("416062005", var_24_15)
						arg_21_1:RecordAudio("416062005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416062", "416062005", "story_v_out_416062.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416062", "416062005", "story_v_out_416062.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
	Play416062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416062006
		arg_25_1.duration_ = 7.67

		local var_25_0 = {
			zh = 4.5,
			ja = 7.666
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
				arg_25_0:Play416062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1086"]) and arg_25_1.var_.actorSpriteComps1086 == nil then
				arg_25_1.var_.actorSpriteComps1086 = arg_25_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.125

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1086"]) then
				if arg_25_1.var_.actorSpriteComps1086 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 1, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1086"]) and arg_25_1.var_.actorSpriteComps1086 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1086 = nil
			end

			local var_28_2 = arg_25_1.actors_["1148"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.125

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_5.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_5.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_5 = arg_25_1.actors_["1086"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1086 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1086", 2)

				for iter_28_8 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_8)

					if var_28_6.name == "split_2" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_28_8 = 0
			local var_28_9 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(416062006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 17 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 17)

				if (17 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 17)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062006", "story_v_out_416062.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062006", "story_v_out_416062.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_416062", "416062006", "story_v_out_416062.awb")

						arg_25_1:RecordAudio("416062006", var_28_15)
						arg_25_1:RecordAudio("416062006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416062", "416062006", "story_v_out_416062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416062", "416062006", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416062007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416062008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1148 = arg_29_1.actors_["1148"].transform.localPosition
				arg_29_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1148", 7)

				for iter_32_0 = 0, arg_29_1.actors_["1148"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1148"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_2 = arg_29_1.actors_["1086"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1086 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1086", 7)

				for iter_32_1 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_1)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.6 < arg_29_1.time_ and arg_29_1.time_ <= 0.6 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_finger", "")
			end

			if 0.6 < arg_29_1.time_ and arg_29_1.time_ <= 0.6 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_recordopen", "")
			end

			local var_32_7 = 0
			local var_32_8 = 1.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(416062007).content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 77 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 77)

				if (77 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 77)) > 0 and var_32_8 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_12 and arg_29_1.time_ < var_32_7 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "1086",
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
	Play416062008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416062008
		arg_33_1.duration_ = 7.2

		local var_33_0 = {
			zh = 7.033,
			ja = 7.2
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
				arg_33_0:Play416062009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1148"]) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = arg_33_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1148"]) then
				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1148"]) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_2 = arg_33_1.actors_["1148"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1148 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1148", 3)

				for iter_36_4 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_4)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_36_5 = 0
			local var_36_6 = 0.6

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

				local var_36_7 = arg_33_1:GetWordFromCfg(416062008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 24 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 24)

				if (24 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 24)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062008", "story_v_out_416062.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062008", "story_v_out_416062.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_416062", "416062008", "story_v_out_416062.awb")

						arg_33_1:RecordAudio("416062008", var_36_12)
						arg_33_1:RecordAudio("416062008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416062", "416062008", "story_v_out_416062.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416062", "416062008", "story_v_out_416062.awb")
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
				actorName = "1148",
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
	Play416062009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416062009
		arg_37_1.duration_ = 7.7

		local var_37_0 = {
			zh = 4.466,
			ja = 7.7
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
				arg_37_0:Play416062010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = arg_37_1.actors_["1148"].transform.localPosition
				arg_37_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 2)

				for iter_40_0 = 0, arg_37_1.actors_["1148"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1148"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_40_2 = arg_37_1.actors_["1148"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1148 == nil then
				arg_37_1.var_.actorSpriteComps1148 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1148 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_5 = arg_37_1.actors_["1086"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1086 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1086", 4)

				for iter_40_5 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_5)

					if var_40_6.name == "split_2" or not string.find(var_40_6.name, "split") then
						var_40_6.gameObject:SetActive(true)
					else
						var_40_6.gameObject:SetActive(false)
					end
				end
			end

			local var_40_7 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_37_1.time_ - 0) / var_40_7)
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_40_8 = arg_37_1.actors_["1086"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps1086 == nil then
				arg_37_1.var_.actorSpriteComps1086 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.actorSpriteComps1086 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								iter_40_7.color = Color.New(Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_9), Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_9), (Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_9)))
							else
								local var_40_10 = Mathf.Lerp(iter_40_7.color.r, 1, (arg_37_1.time_ - 0) / var_40_9)

								iter_40_7.color = Color.New(var_40_10, var_40_10, var_40_10)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps1086 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_40_9 then
						iter_40_9.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1086 = nil
			end

			local var_40_11 = 0
			local var_40_12 = 0.55

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(416062009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 22 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 22)

				if (22 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 22)) > 0 and var_40_12 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16

					if var_40_16 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062009", "story_v_out_416062.awb") ~= 0 then
					local var_40_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062009", "story_v_out_416062.awb") / 1000

					if var_40_17 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_11
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_416062", "416062009", "story_v_out_416062.awb")

						arg_37_1:RecordAudio("416062009", var_40_18)
						arg_37_1:RecordAudio("416062009", var_40_18)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416062", "416062009", "story_v_out_416062.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416062", "416062009", "story_v_out_416062.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "1086",
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
	Play416062010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416062010
		arg_41_1.duration_ = 4

		local var_41_0 = {
			zh = 2.866,
			ja = 4
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
				arg_41_0:Play416062011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(416062010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 10 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 10)

				if (10 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 10)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062010", "story_v_out_416062.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062010", "story_v_out_416062.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_416062", "416062010", "story_v_out_416062.awb")

						arg_41_1:RecordAudio("416062010", var_44_6)
						arg_41_1:RecordAudio("416062010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416062", "416062010", "story_v_out_416062.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416062", "416062010", "story_v_out_416062.awb")
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
	Play416062011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416062011
		arg_45_1.duration_ = 7.6

		local var_45_0 = {
			zh = 4.933,
			ja = 7.6
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
				arg_45_0:Play416062012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1086"]) and arg_45_1.var_.actorSpriteComps1086 == nil then
				arg_45_1.var_.actorSpriteComps1086 = arg_45_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1086"]) then
				if arg_45_1.var_.actorSpriteComps1086 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1086"]) and arg_45_1.var_.actorSpriteComps1086 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1086 = nil
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

				arg_45_1:CheckSpriteTmpPos("1148", 2)

				for iter_48_8 = 0, var_48_5.childCount - 1 do
					local var_48_6 = var_48_5:GetChild(iter_48_8)

					if var_48_6.name == "split_2" or not string.find(var_48_6.name, "split") then
						var_48_6.gameObject:SetActive(true)
					else
						var_48_6.gameObject:SetActive(false)
					end
				end
			end

			local var_48_7 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_45_1.time_ - 0) / var_48_7)
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_48_8 = 0
			local var_48_9 = 0.525

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

				local var_48_10 = arg_45_1:GetWordFromCfg(416062011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 21 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 21)

				if (21 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 21)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062011", "story_v_out_416062.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062011", "story_v_out_416062.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_416062", "416062011", "story_v_out_416062.awb")

						arg_45_1:RecordAudio("416062011", var_48_15)
						arg_45_1:RecordAudio("416062011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416062", "416062011", "story_v_out_416062.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416062", "416062011", "story_v_out_416062.awb")
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
	Play416062012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416062012
		arg_49_1.duration_ = 4.7

		local var_49_0 = {
			zh = 3.366,
			ja = 4.7
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
				arg_49_0:Play416062013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1148"]) and arg_49_1.var_.actorSpriteComps1148 == nil then
				arg_49_1.var_.actorSpriteComps1148 = arg_49_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.125

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1148"]) then
				if arg_49_1.var_.actorSpriteComps1148 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1148"]) and arg_49_1.var_.actorSpriteComps1148 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1148 = nil
			end

			local var_52_2 = arg_49_1.actors_["1086"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1086 == nil then
				arg_49_1.var_.actorSpriteComps1086 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.125

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1086 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								iter_52_5.color = Color.New(Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_5.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_5.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1086 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_52_7 then
						iter_52_7.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1086 = nil
			end

			local var_52_5 = arg_49_1.actors_["1086"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1086 = var_52_5.localPosition
				var_52_5.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1086", 4)

				for iter_52_8 = 0, var_52_5.childCount - 1 do
					local var_52_6 = var_52_5:GetChild(iter_52_8)

					if var_52_6.name == "split_4" or not string.find(var_52_6.name, "split") then
						var_52_6.gameObject:SetActive(true)
					else
						var_52_6.gameObject:SetActive(false)
					end
				end
			end

			local var_52_7 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_49_1.time_ - 0) / var_52_7)
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_52_8 = 0
			local var_52_9 = 0.35

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(416062012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 14 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 14)

				if (14 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 14)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062012", "story_v_out_416062.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062012", "story_v_out_416062.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_416062", "416062012", "story_v_out_416062.awb")

						arg_49_1:RecordAudio("416062012", var_52_15)
						arg_49_1:RecordAudio("416062012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416062", "416062012", "story_v_out_416062.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416062", "416062012", "story_v_out_416062.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416062013
		arg_53_1.duration_ = 6.7

		local var_53_0 = {
			zh = 6.7,
			ja = 2.733
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
				arg_53_0:Play416062014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1086"]) and arg_53_1.var_.actorSpriteComps1086 == nil then
				arg_53_1.var_.actorSpriteComps1086 = arg_53_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.125

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1086"]) then
				if arg_53_1.var_.actorSpriteComps1086 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1086"]) and arg_53_1.var_.actorSpriteComps1086 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1086 = nil
			end

			local var_56_2 = arg_53_1.actors_["1148"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1148 == nil then
				arg_53_1.var_.actorSpriteComps1148 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.125

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps1148 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								iter_56_5.color = Color.New(Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_5.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_5.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1148 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_56_7 then
						iter_56_7.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1148 = nil
			end

			local var_56_5 = arg_53_1.actors_["1148"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1148 = var_56_5.localPosition
				var_56_5.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1148", 2)

				for iter_56_8 = 0, var_56_5.childCount - 1 do
					local var_56_6 = var_56_5:GetChild(iter_56_8)

					if var_56_6.name == "split_6" or not string.find(var_56_6.name, "split") then
						var_56_6.gameObject:SetActive(true)
					else
						var_56_6.gameObject:SetActive(false)
					end
				end
			end

			local var_56_7 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				var_56_5.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_53_1.time_ - 0) / var_56_7)
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				var_56_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_56_8 = 0
			local var_56_9 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
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

				local var_56_10 = arg_53_1:GetWordFromCfg(416062013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 18 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 18)

				if (18 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 18)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062013", "story_v_out_416062.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062013", "story_v_out_416062.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_416062", "416062013", "story_v_out_416062.awb")

						arg_53_1:RecordAudio("416062013", var_56_15)
						arg_53_1:RecordAudio("416062013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416062", "416062013", "story_v_out_416062.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416062", "416062013", "story_v_out_416062.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play416062014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416062014
		arg_57_1.duration_ = 7.07

		local var_57_0 = {
			zh = 4.9,
			ja = 7.066
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
				arg_57_0:Play416062015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(416062014)
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062014", "story_v_out_416062.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062014", "story_v_out_416062.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_416062", "416062014", "story_v_out_416062.awb")

						arg_57_1:RecordAudio("416062014", var_60_6)
						arg_57_1:RecordAudio("416062014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416062", "416062014", "story_v_out_416062.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416062", "416062014", "story_v_out_416062.awb")
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
	Play416062015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416062015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416062016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1086 = arg_61_1.actors_["1086"].transform.localPosition
				arg_61_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1086", 7)

				for iter_64_0 = 0, arg_61_1.actors_["1086"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1086"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_2 = arg_61_1.actors_["1148"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1148", 7)

				for iter_64_1 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_1)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_5 = 0
			local var_64_6 = 1.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(416062015).content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 56 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_7) / 56)

				if (56 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_7) / 56)) > 0 and var_64_6 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_10 and arg_61_1.time_ < var_64_5 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_61_1:InitPlayNodeList()
	end,
	Play416062016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416062016
		arg_65_1.duration_ = 5.73

		local var_65_0 = {
			zh = 2.933,
			ja = 5.733
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
				arg_65_0:Play416062017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1086 = arg_65_1.actors_["1086"].transform.localPosition
				arg_65_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1086", 3)

				for iter_68_0 = 0, arg_65_1.actors_["1086"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["1086"].transform:GetChild(iter_68_0)

					if var_68_0.name == "" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_68_2 = arg_65_1.actors_["1086"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1086 == nil then
				arg_65_1.var_.actorSpriteComps1086 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.125

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1086 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1086 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1086 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(416062016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 14 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 14)

				if (14 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 14)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062016", "story_v_out_416062.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062016", "story_v_out_416062.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_416062", "416062016", "story_v_out_416062.awb")

						arg_65_1:RecordAudio("416062016", var_68_12)
						arg_65_1:RecordAudio("416062016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416062", "416062016", "story_v_out_416062.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416062", "416062016", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416062017
		arg_69_1.duration_ = 5.4

		local var_69_0 = {
			zh = 3.9,
			ja = 5.4
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
				arg_69_0:Play416062018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1086 = arg_69_1.actors_["1086"].transform.localPosition
				arg_69_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1086", 2)

				for iter_72_0 = 0, arg_69_1.actors_["1086"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1086"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_72_2 = arg_69_1.actors_["1086"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1086 == nil then
				arg_69_1.var_.actorSpriteComps1086 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.125

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1086 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1086 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1086 = nil
			end

			local var_72_5 = arg_69_1.actors_["1148"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps1148 == nil then
				arg_69_1.var_.actorSpriteComps1148 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 0.125

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps1148 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								iter_72_6.color = Color.New(Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_6.color.r, 1, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_6.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps1148 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_72_8 then
						iter_72_8.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1148 = nil
			end

			local var_72_8 = arg_69_1.actors_["1148"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1148 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1148", 4)

				for iter_72_9 = 0, var_72_8.childCount - 1 do
					local var_72_9 = var_72_8:GetChild(iter_72_9)

					if var_72_9.name == "split_4" or not string.find(var_72_9.name, "split") then
						var_72_9.gameObject:SetActive(true)
					else
						var_72_9.gameObject:SetActive(false)
					end
				end
			end

			local var_72_10 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_10 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_69_1.time_ - 0) / var_72_10)
			end

			if arg_69_1.time_ >= 0 + var_72_10 and arg_69_1.time_ < 0 + var_72_10 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_72_11 = 0
			local var_72_12 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
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

				local var_72_13 = arg_69_1:GetWordFromCfg(416062017)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 17 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 17)

				if (17 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 17)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062017", "story_v_out_416062.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062017", "story_v_out_416062.awb") / 1000

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_416062", "416062017", "story_v_out_416062.awb")

						arg_69_1:RecordAudio("416062017", var_72_18)
						arg_69_1:RecordAudio("416062017", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416062", "416062017", "story_v_out_416062.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416062", "416062017", "story_v_out_416062.awb")
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
				actorName = "1086",
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

		arg_69_1:InitPlayNodeList()
	end,
	Play416062018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416062018
		arg_73_1.duration_ = 10.63

		local var_73_0 = {
			zh = 5.766,
			ja = 10.633
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
				arg_73_0:Play416062019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1148"]) and arg_73_1.var_.actorSpriteComps1148 == nil then
				arg_73_1.var_.actorSpriteComps1148 = arg_73_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.125

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1148"]) then
				if arg_73_1.var_.actorSpriteComps1148 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1148"]) and arg_73_1.var_.actorSpriteComps1148 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1148 = nil
			end

			local var_76_2 = arg_73_1.actors_["1086"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1086 == nil then
				arg_73_1.var_.actorSpriteComps1086 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.125

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps1086 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1086 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_76_7 then
						iter_76_7.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1086 = nil
			end

			local var_76_5 = 0
			local var_76_6 = 0.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(416062018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 26 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 26)

				if (26 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 26)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062018", "story_v_out_416062.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062018", "story_v_out_416062.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_416062", "416062018", "story_v_out_416062.awb")

						arg_73_1:RecordAudio("416062018", var_76_12)
						arg_73_1:RecordAudio("416062018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416062", "416062018", "story_v_out_416062.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416062", "416062018", "story_v_out_416062.awb")
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
	Play416062019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416062019
		arg_77_1.duration_ = 5.3

		local var_77_0 = {
			zh = 4.533,
			ja = 5.3
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
				arg_77_0:Play416062020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1086"]) and arg_77_1.var_.actorSpriteComps1086 == nil then
				arg_77_1.var_.actorSpriteComps1086 = arg_77_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.125

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1086"]) then
				if arg_77_1.var_.actorSpriteComps1086 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1086"]) and arg_77_1.var_.actorSpriteComps1086 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1086 = nil
			end

			local var_80_2 = arg_77_1.actors_["1148"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1148 == nil then
				arg_77_1.var_.actorSpriteComps1148 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.125

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1148 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_5.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_5.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1148 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1148 = nil
			end

			local var_80_5 = arg_77_1.actors_["1148"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1148 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1148", 4)

				for iter_80_8 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_8)

					if var_80_6.name == "split_4" or not string.find(var_80_6.name, "split") then
						var_80_6.gameObject:SetActive(true)
					else
						var_80_6.gameObject:SetActive(false)
					end
				end
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_77_1.time_ - 0) / var_80_7)
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_80_8 = 0
			local var_80_9 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(416062019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 17 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 17)

				if (17 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 17)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062019", "story_v_out_416062.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062019", "story_v_out_416062.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_416062", "416062019", "story_v_out_416062.awb")

						arg_77_1:RecordAudio("416062019", var_80_15)
						arg_77_1:RecordAudio("416062019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416062", "416062019", "story_v_out_416062.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416062", "416062019", "story_v_out_416062.awb")
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
				actorName = "1148",
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
	Play416062020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416062020
		arg_81_1.duration_ = 8.6

		local var_81_0 = {
			zh = 6.033,
			ja = 8.6
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
				arg_81_0:Play416062021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1148"]) and arg_81_1.var_.actorSpriteComps1148 == nil then
				arg_81_1.var_.actorSpriteComps1148 = arg_81_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.125

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1148"]) then
				if arg_81_1.var_.actorSpriteComps1148 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1148"]) and arg_81_1.var_.actorSpriteComps1148 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps1148 = nil
			end

			local var_84_2 = arg_81_1.actors_["1086"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1086 == nil then
				arg_81_1.var_.actorSpriteComps1086 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.125

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps1086 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1086 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1086 = nil
			end

			local var_84_5 = arg_81_1.actors_["1086"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1086 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1086", 2)

				for iter_84_8 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_8)

					if var_84_6.name == "split_2" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_84_8 = 0
			local var_84_9 = 0.7

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(416062020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 28 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 28)

				if (28 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 28)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062020", "story_v_out_416062.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062020", "story_v_out_416062.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_416062", "416062020", "story_v_out_416062.awb")

						arg_81_1:RecordAudio("416062020", var_84_15)
						arg_81_1:RecordAudio("416062020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416062", "416062020", "story_v_out_416062.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416062", "416062020", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416062021
		arg_85_1.duration_ = 3.37

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play416062022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1086"]) and arg_85_1.var_.actorSpriteComps1086 == nil then
				arg_85_1.var_.actorSpriteComps1086 = arg_85_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1086"]) then
				if arg_85_1.var_.actorSpriteComps1086 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1086"]) and arg_85_1.var_.actorSpriteComps1086 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1086 = nil
			end

			local var_88_2 = arg_85_1.actors_["1148"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1148 == nil then
				arg_85_1.var_.actorSpriteComps1148 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1148 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1148 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1148 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.3

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

				local var_88_7 = arg_85_1:GetWordFromCfg(416062021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 12 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 12)

				if (12 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 12)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062021", "story_v_out_416062.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062021", "story_v_out_416062.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416062", "416062021", "story_v_out_416062.awb")

						arg_85_1:RecordAudio("416062021", var_88_12)
						arg_85_1:RecordAudio("416062021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416062", "416062021", "story_v_out_416062.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416062", "416062021", "story_v_out_416062.awb")
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
	Play416062022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416062022
		arg_89_1.duration_ = 6.1

		local var_89_0 = {
			zh = 3.8,
			ja = 6.1
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
				arg_89_0:Play416062023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1148 = arg_89_1.actors_["1148"].transform.localPosition
				arg_89_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1148", 2)

				for iter_92_0 = 0, arg_89_1.actors_["1148"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["1148"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_4" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_92_2 = arg_89_1.actors_["1148"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1148 == nil then
				arg_89_1.var_.actorSpriteComps1148 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps1148 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								iter_92_2.color = Color.New(Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_2.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_2.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1148 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps1148 = nil
			end

			local var_92_5 = "1028"

			if arg_89_1.actors_["1028"] == nil then
				local var_92_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_92_6) then
					local var_92_7 = Object.Instantiate(var_92_6, arg_89_1.canvasGo_.transform)

					var_92_7.transform:SetSiblingIndex(1)

					var_92_7.name = var_92_5
					var_92_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_89_1.actors_[var_92_5] = var_92_7

					if arg_89_1.isInRecall_ then
						for iter_92_5, iter_92_6 in ipairs((var_92_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_92_6.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_92_8 = arg_89_1.actors_["1028"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps1028 == nil then
				arg_89_1.var_.actorSpriteComps1028 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_9 and not isNil(var_92_8) then
				if arg_89_1.var_.actorSpriteComps1028 then
					for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_92_8 then
							if arg_89_1.isInRecall_ then
								iter_92_8.color = Color.New(Mathf.Lerp(iter_92_8.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_9), Mathf.Lerp(iter_92_8.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_9), (Mathf.Lerp(iter_92_8.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_9)))
							else
								local var_92_10 = Mathf.Lerp(iter_92_8.color.r, 1, (arg_89_1.time_ - 0) / var_92_9)

								iter_92_8.color = Color.New(var_92_10, var_92_10, var_92_10)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_9 and arg_89_1.time_ < 0 + var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps1028 then
				for iter_92_9, iter_92_10 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_92_10 then
						iter_92_10.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1028 = nil
			end

			local var_92_11 = arg_89_1.actors_["1028"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1028 = var_92_11.localPosition
				var_92_11.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1028", 4)

				for iter_92_11 = 0, var_92_11.childCount - 1 do
					local var_92_12 = var_92_11:GetChild(iter_92_11)

					if var_92_12.name == "" or not string.find(var_92_12.name, "split") then
						var_92_12.gameObject:SetActive(true)
					else
						var_92_12.gameObject:SetActive(false)
					end
				end
			end

			local var_92_13 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_13 then
				var_92_11.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_89_1.time_ - 0) / var_92_13)
			end

			if arg_89_1.time_ >= 0 + var_92_13 and arg_89_1.time_ < 0 + var_92_13 + arg_92_0 then
				var_92_11.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_92_14 = 0
			local var_92_15 = 0.5

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_16 = arg_89_1:GetWordFromCfg(416062022)
				local var_92_17 = arg_89_1:FormatText(var_92_16.content)

				arg_89_1.text_.text = var_92_17

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 20 <= 0 and var_92_15 or var_92_15 * (utf8.len(var_92_17) / 20)

				if (20 <= 0 and var_92_15 or var_92_15 * (utf8.len(var_92_17) / 20)) > 0 and var_92_15 < var_92_19 then
					arg_89_1.talkMaxDuration = var_92_19

					if var_92_19 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_14
					end
				end

				arg_89_1.text_.text = var_92_17
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062022", "story_v_out_416062.awb") ~= 0 then
					local var_92_20 = manager.audio:GetVoiceLength("story_v_out_416062", "416062022", "story_v_out_416062.awb") / 1000

					if var_92_20 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_14
					end

					if var_92_16.prefab_name ~= "" and arg_89_1.actors_[var_92_16.prefab_name] ~= nil then
						local var_92_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_16.prefab_name].transform, "story_v_out_416062", "416062022", "story_v_out_416062.awb")

						arg_89_1:RecordAudio("416062022", var_92_21)
						arg_89_1:RecordAudio("416062022", var_92_21)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416062", "416062022", "story_v_out_416062.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416062", "416062022", "story_v_out_416062.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_15, arg_89_1.talkMaxDuration)

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_14) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_14 + var_92_22 and arg_89_1.time_ < var_92_14 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416062023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416062023
		arg_93_1.duration_ = 9.6

		local var_93_0 = {
			zh = 5.033,
			ja = 9.6
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
				arg_93_0:Play416062024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1028"]) and arg_93_1.var_.actorSpriteComps1028 == nil then
				arg_93_1.var_.actorSpriteComps1028 = arg_93_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.125

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1028"]) then
				if arg_93_1.var_.actorSpriteComps1028 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1028"]) and arg_93_1.var_.actorSpriteComps1028 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1028 = nil
			end

			local var_96_2 = arg_93_1.actors_["1148"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1148 == nil then
				arg_93_1.var_.actorSpriteComps1148 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.125

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1148 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								iter_96_5.color = Color.New(Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_5.color.r, 1, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_5.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1148 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_96_7 then
						iter_96_7.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1148 = nil
			end

			local var_96_5 = arg_93_1.actors_["1148"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148 = var_96_5.localPosition
				var_96_5.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1148", 2)

				for iter_96_8 = 0, var_96_5.childCount - 1 do
					local var_96_6 = var_96_5:GetChild(iter_96_8)

					if var_96_6.name == "split_6" or not string.find(var_96_6.name, "split") then
						var_96_6.gameObject:SetActive(true)
					else
						var_96_6.gameObject:SetActive(false)
					end
				end
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_93_1.time_ - 0) / var_96_7)
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_96_8 = arg_93_1.actors_["1148"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1148", 2)

				for iter_96_9 = 0, var_96_8.childCount - 1 do
					local var_96_9 = var_96_8:GetChild(iter_96_9)

					if var_96_9.name == "split_1_1" or not string.find(var_96_9.name, "split") then
						var_96_9.gameObject:SetActive(true)
					else
						var_96_9.gameObject:SetActive(false)
					end
				end
			end

			local var_96_10 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_10 then
				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_93_1.time_ - 0) / var_96_10)
			end

			if arg_93_1.time_ >= 0 + var_96_10 and arg_93_1.time_ < 0 + var_96_10 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_96_11 = 0
			local var_96_12 = 0.525

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
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

				local var_96_13 = arg_93_1:GetWordFromCfg(416062023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 21 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 21)

				if (21 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 21)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062023", "story_v_out_416062.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062023", "story_v_out_416062.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_416062", "416062023", "story_v_out_416062.awb")

						arg_93_1:RecordAudio("416062023", var_96_18)
						arg_93_1:RecordAudio("416062023", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416062", "416062023", "story_v_out_416062.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416062", "416062023", "story_v_out_416062.awb")
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
	Play416062024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416062024
		arg_97_1.duration_ = 4.23

		local var_97_0 = {
			zh = 2.566,
			ja = 4.233
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
				arg_97_0:Play416062025(arg_97_1)
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

			local var_100_2 = arg_97_1.actors_["1028"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1028 == nil then
				arg_97_1.var_.actorSpriteComps1028 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.125

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps1028 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1028 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps1028 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(416062024)
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062024", "story_v_out_416062.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062024", "story_v_out_416062.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_416062", "416062024", "story_v_out_416062.awb")

						arg_97_1:RecordAudio("416062024", var_100_12)
						arg_97_1:RecordAudio("416062024", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416062", "416062024", "story_v_out_416062.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416062", "416062024", "story_v_out_416062.awb")
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

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play416062025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416062025
		arg_101_1.duration_ = 7.37

		local var_101_0 = {
			zh = 4.8,
			ja = 7.366
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
				arg_101_0:Play416062026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1028"]) and arg_101_1.var_.actorSpriteComps1028 == nil then
				arg_101_1.var_.actorSpriteComps1028 = arg_101_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.125

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1028"]) then
				if arg_101_1.var_.actorSpriteComps1028 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1028"]) and arg_101_1.var_.actorSpriteComps1028 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps1028 = nil
			end

			local var_104_2 = arg_101_1.actors_["1148"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1148 == nil then
				arg_101_1.var_.actorSpriteComps1148 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.125

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps1148 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								iter_104_5.color = Color.New(Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_5.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_5.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1148 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_104_7 then
						iter_104_7.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1148 = nil
			end

			local var_104_5 = arg_101_1.actors_["1148"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1148", 2)

				for iter_104_8 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_8)

					if var_104_6.name == "split_4" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_104_8 = 0
			local var_104_9 = 0.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
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

				local var_104_10 = arg_101_1:GetWordFromCfg(416062025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 19 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 19)

				if (19 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 19)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062025", "story_v_out_416062.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062025", "story_v_out_416062.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_416062", "416062025", "story_v_out_416062.awb")

						arg_101_1:RecordAudio("416062025", var_104_15)
						arg_101_1:RecordAudio("416062025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416062", "416062025", "story_v_out_416062.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416062", "416062025", "story_v_out_416062.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
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
	Play416062026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416062026
		arg_105_1.duration_ = 6

		local var_105_0 = {
			zh = 4.666,
			ja = 6
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
				arg_105_0:Play416062027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.425

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

				local var_108_1 = arg_105_1:GetWordFromCfg(416062026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 17 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 17)

				if (17 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 17)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062026", "story_v_out_416062.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062026", "story_v_out_416062.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_416062", "416062026", "story_v_out_416062.awb")

						arg_105_1:RecordAudio("416062026", var_108_6)
						arg_105_1:RecordAudio("416062026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416062", "416062026", "story_v_out_416062.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416062", "416062026", "story_v_out_416062.awb")
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
	Play416062027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416062027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play416062028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1148"]) and arg_109_1.var_.actorSpriteComps1148 == nil then
				arg_109_1.var_.actorSpriteComps1148 = arg_109_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.125

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1148"]) then
				if arg_109_1.var_.actorSpriteComps1148 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1148"]) and arg_109_1.var_.actorSpriteComps1148 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps1148 = nil
			end

			local var_112_2 = 0
			local var_112_3 = 0.925

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(416062027).content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 37 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 37)

				if (37 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 37)) > 0 and var_112_3 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_7 and arg_109_1.time_ < var_112_2 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play416062028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416062028
		arg_113_1.duration_ = 4.87

		local var_113_0 = {
			zh = 3.833,
			ja = 4.866
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
				arg_113_0:Play416062029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1028"]) and arg_113_1.var_.actorSpriteComps1028 == nil then
				arg_113_1.var_.actorSpriteComps1028 = arg_113_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.125

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1028"]) then
				if arg_113_1.var_.actorSpriteComps1028 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1028"]) and arg_113_1.var_.actorSpriteComps1028 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps1028 = nil
			end

			local var_116_2 = arg_113_1.actors_["1028"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1028 = var_116_2.localPosition
				var_116_2.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1028", 4)

				for iter_116_4 = 0, var_116_2.childCount - 1 do
					local var_116_3 = var_116_2:GetChild(iter_116_4)

					if var_116_3.name == "split_6" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_113_1.time_ - 0) / var_116_4)
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_116_5 = 0
			local var_116_6 = 0.4

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(416062028)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 16 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 16)

				if (16 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 16)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062028", "story_v_out_416062.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062028", "story_v_out_416062.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_416062", "416062028", "story_v_out_416062.awb")

						arg_113_1:RecordAudio("416062028", var_116_12)
						arg_113_1:RecordAudio("416062028", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416062", "416062028", "story_v_out_416062.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416062", "416062028", "story_v_out_416062.awb")
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
				actorName = "1028",
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
	Play416062029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416062029
		arg_117_1.duration_ = 7.47

		local var_117_0 = {
			zh = 4.066,
			ja = 7.466
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
				arg_117_0:Play416062030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1148"]) and arg_117_1.var_.actorSpriteComps1148 == nil then
				arg_117_1.var_.actorSpriteComps1148 = arg_117_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.125

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1148"]) then
				if arg_117_1.var_.actorSpriteComps1148 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 1, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1148"]) and arg_117_1.var_.actorSpriteComps1148 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps1148 = nil
			end

			local var_120_2 = arg_117_1.actors_["1028"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1028 == nil then
				arg_117_1.var_.actorSpriteComps1028 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.125

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps1028 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								iter_120_5.color = Color.New(Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_5.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_5.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1028 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_120_7 then
						iter_120_7.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps1028 = nil
			end

			local var_120_5 = arg_117_1.actors_["1148"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1148 = var_120_5.localPosition
				var_120_5.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1148", 2)

				for iter_120_8 = 0, var_120_5.childCount - 1 do
					local var_120_6 = var_120_5:GetChild(iter_120_8)

					if var_120_6.name == "split_6" or not string.find(var_120_6.name, "split") then
						var_120_6.gameObject:SetActive(true)
					else
						var_120_6.gameObject:SetActive(false)
					end
				end
			end

			local var_120_7 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				var_120_5.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_117_1.time_ - 0) / var_120_7)
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				var_120_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_120_8 = 0
			local var_120_9 = 0.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
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

				local var_120_10 = arg_117_1:GetWordFromCfg(416062029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 16 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 16)

				if (16 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 16)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062029", "story_v_out_416062.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062029", "story_v_out_416062.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_416062", "416062029", "story_v_out_416062.awb")

						arg_117_1:RecordAudio("416062029", var_120_15)
						arg_117_1:RecordAudio("416062029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416062", "416062029", "story_v_out_416062.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416062", "416062029", "story_v_out_416062.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play416062030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416062030
		arg_121_1.duration_ = 3.8

		local var_121_0 = {
			zh = 3.8,
			ja = 3.6
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
				arg_121_0:Play416062031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1148"]) and arg_121_1.var_.actorSpriteComps1148 == nil then
				arg_121_1.var_.actorSpriteComps1148 = arg_121_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.125

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1148"]) then
				if arg_121_1.var_.actorSpriteComps1148 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1148"]) and arg_121_1.var_.actorSpriteComps1148 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1148 = nil
			end

			local var_124_2 = arg_121_1.actors_["1028"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1028 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1028", 7)

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
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_5 = arg_121_1.actors_["1086"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1086 = var_124_5.localPosition
				var_124_5.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1086", 4)

				for iter_124_5 = 0, var_124_5.childCount - 1 do
					local var_124_6 = var_124_5:GetChild(iter_124_5)

					if var_124_6.name == "split_4" or not string.find(var_124_6.name, "split") then
						var_124_6.gameObject:SetActive(true)
					else
						var_124_6.gameObject:SetActive(false)
					end
				end
			end

			local var_124_7 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_121_1.time_ - 0) / var_124_7)
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_124_8 = arg_121_1.actors_["1086"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1086 == nil then
				arg_121_1.var_.actorSpriteComps1086 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.125

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_9 and not isNil(var_124_8) then
				if arg_121_1.var_.actorSpriteComps1086 then
					for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_121_1.time_ >= 0 + var_124_9 and arg_121_1.time_ < 0 + var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1086 then
				for iter_124_8, iter_124_9 in pairs(arg_121_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_124_9 then
						iter_124_9.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps1086 = nil
			end

			local var_124_11 = 0
			local var_124_12 = 0.375

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(416062030)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 15 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 15)

				if (15 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 15)) > 0 and var_124_12 < var_124_16 then
					arg_121_1.talkMaxDuration = var_124_16

					if var_124_16 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062030", "story_v_out_416062.awb") ~= 0 then
					local var_124_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062030", "story_v_out_416062.awb") / 1000

					if var_124_17 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_11
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_416062", "416062030", "story_v_out_416062.awb")

						arg_121_1:RecordAudio("416062030", var_124_18)
						arg_121_1:RecordAudio("416062030", var_124_18)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416062", "416062030", "story_v_out_416062.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416062", "416062030", "story_v_out_416062.awb")
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416062031
		arg_125_1.duration_ = 7.53

		local var_125_0 = {
			zh = 5,
			ja = 7.533
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
				arg_125_0:Play416062032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1086"]) and arg_125_1.var_.actorSpriteComps1086 == nil then
				arg_125_1.var_.actorSpriteComps1086 = arg_125_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1086"]) then
				if arg_125_1.var_.actorSpriteComps1086 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1086"]) and arg_125_1.var_.actorSpriteComps1086 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps1086 = nil
			end

			local var_128_2 = arg_125_1.actors_["1148"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1148 == nil then
				arg_125_1.var_.actorSpriteComps1148 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps1148 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								iter_128_5.color = Color.New(Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_3), Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_3), (Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_3)))
							else
								local var_128_4 = Mathf.Lerp(iter_128_5.color.r, 1, (arg_125_1.time_ - 0) / var_128_3)

								iter_128_5.color = Color.New(var_128_4, var_128_4, var_128_4)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps1148 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_128_7 then
						iter_128_7.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps1148 = nil
			end

			local var_128_5 = arg_125_1.actors_["1148"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1148 = var_128_5.localPosition
				var_128_5.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1148", 2)

				for iter_128_8 = 0, var_128_5.childCount - 1 do
					local var_128_6 = var_128_5:GetChild(iter_128_8)

					if var_128_6.name == "split_3" or not string.find(var_128_6.name, "split") then
						var_128_6.gameObject:SetActive(true)
					else
						var_128_6.gameObject:SetActive(false)
					end
				end
			end

			local var_128_7 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_125_1.time_ - 0) / var_128_7)
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_128_8 = 0
			local var_128_9 = 0.575

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
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

				local var_128_10 = arg_125_1:GetWordFromCfg(416062031)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 23 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 23)

				if (23 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 23)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062031", "story_v_out_416062.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062031", "story_v_out_416062.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_416062", "416062031", "story_v_out_416062.awb")

						arg_125_1:RecordAudio("416062031", var_128_15)
						arg_125_1:RecordAudio("416062031", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416062", "416062031", "story_v_out_416062.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416062", "416062031", "story_v_out_416062.awb")
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
	Play416062032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416062032
		arg_129_1.duration_ = 9

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play416062033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_9000

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= 4 + 0.5 and arg_129_1.time_ < 4 + 0.5 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_0 = "I13h"

			if arg_129_1.bgs_.I13h == nil then
				local var_132_1 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_0)
				var_132_1.name = var_132_0
				var_132_1.transform.parent = arg_129_1.stage_.transform
				var_132_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_0] = var_132_1
			end

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				local var_132_2 = arg_129_1.bgs_.I13h

				arg_129_1.bgs_.I13h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_132_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_3 = var_132_2:GetComponent("SpriteRenderer")

				if var_132_3 and var_132_3.sprite then
					local var_132_4 = 2 * (var_132_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_132_2.transform.localScale = Vector3.New(var_132_4 / var_132_3.sprite.bounds.size.y < var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x and var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x or var_132_4 / var_132_3.sprite.bounds.size.y, var_132_4 / var_132_3.sprite.bounds.size.y < var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x and var_132_4 * manager.ui.mainCameraCom_.aspect / var_132_3.sprite.bounds.size.x or var_132_4 / var_132_3.sprite.bounds.size.y, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "I13h" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_5 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_6 = 2

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 then
				local var_132_7 = Color.New(0, 0, 0)

				var_132_7.a = Mathf.Lerp(0, 1, (arg_129_1.time_ - var_132_5) / var_132_6)
				arg_129_1.mask_.color = var_132_7
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 then
				local var_132_8 = Color.New(0, 0, 0)

				var_132_8.a = 1
				arg_129_1.mask_.color = var_132_8
			end

			local var_132_9 = 2

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_10 = 2

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_10 then
				local var_132_11 = Color.New(0, 0, 0)

				var_132_11.a = Mathf.Lerp(1, 0, (arg_129_1.time_ - var_132_9) / var_132_10)
				arg_129_1.mask_.color = var_132_11
			end

			if arg_129_1.time_ >= var_132_9 + var_132_10 and arg_129_1.time_ < var_132_9 + var_132_10 + arg_132_0 then
				local var_132_12 = Color.New(0, 0, 0)

				arg_129_1.mask_.enabled = false
				var_132_12.a = 0
				arg_129_1.mask_.color = var_132_12
			end

			local var_132_13 = arg_129_1.actors_["1148"].transform

			if 1.966 < arg_129_1.time_ and arg_129_1.time_ <= 1.966 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148 = var_132_13.localPosition
				var_132_13.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1148", 7)

				for iter_132_2 = 0, var_132_13.childCount - 1 do
					local var_132_14 = var_132_13:GetChild(iter_132_2)

					if var_132_14.name == "" or not string.find(var_132_14.name, "split") then
						var_132_14.gameObject:SetActive(true)
					else
						var_132_14.gameObject:SetActive(false)
					end
				end
			end

			local var_132_15 = 0.001

			if 1.966 <= arg_129_1.time_ and arg_129_1.time_ < 1.966 + var_132_15 then
				var_132_13.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_129_1.time_ - 1.966) / var_132_15)
			end

			if arg_129_1.time_ >= 1.966 + var_132_15 and arg_129_1.time_ < 1.966 + var_132_15 + arg_132_0 then
				var_132_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_16 = arg_129_1.actors_["1086"].transform

			if 1.966 < arg_129_1.time_ and arg_129_1.time_ <= 1.966 + arg_132_0 then
				arg_129_1.var_.moveOldPos1086 = var_132_16.localPosition
				var_132_16.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1086", 7)

				for iter_132_3 = 0, var_132_16.childCount - 1 do
					local var_132_17 = var_132_16:GetChild(iter_132_3)

					if var_132_17.name == "" or not string.find(var_132_17.name, "split") then
						var_132_17.gameObject:SetActive(true)
					else
						var_132_17.gameObject:SetActive(false)
					end
				end
			end

			local var_132_18 = 0.001

			if 1.966 <= arg_129_1.time_ and arg_129_1.time_ < 1.966 + var_132_18 then
				var_132_16.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_129_1.time_ - 1.966) / var_132_18)
			end

			if arg_129_1.time_ >= 1.966 + var_132_18 and arg_129_1.time_ < 1.966 + var_132_18 + arg_132_0 then
				var_132_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.57664596547062 < arg_129_1.time_ and arg_129_1.time_ <= 2.57664596547062 + arg_132_0 then
				local var_132_19 = arg_129_1.var_.effect2032

				if not arg_129_1.var_.effect2032 then
					var_132_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_132_19.name = "2032"
					arg_129_1.var_.effect2032 = var_132_19
				else
					var_132_19.transform:SetParent(var_132_9000)
				end

				var_132_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_132_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_132_21 = manager.ui.mainCamera.transform

			if 2.57664596547062 < arg_129_1.time_ and arg_129_1.time_ <= 2.57664596547062 + arg_132_0 then
				arg_129_1.var_.shakeOldPos = var_132_21.localPosition
			end

			local var_132_22 = 0.666666666666667

			if 2.57664596547062 <= arg_129_1.time_ and arg_129_1.time_ < 2.57664596547062 + var_132_22 then
				local var_132_23, var_132_24 = math.modf((arg_129_1.time_ - 2.57664596547062) / 0.066)

				var_132_21.localPosition = Vector3.New(var_132_24 * 0.13, var_132_24 * 0.13, var_132_24 * 0.13) + arg_129_1.var_.shakeOldPos
			end

			if arg_129_1.time_ >= 2.57664596547062 + var_132_22 and arg_129_1.time_ < 2.57664596547062 + var_132_22 + arg_132_0 then
				var_132_21.localPosition = arg_129_1.var_.shakeOldPos
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_132_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_27 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_27

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_27
						arg_129_1.bgmTxt2_.text = var_132_27
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.33333333333333 < arg_129_1.time_ and arg_129_1.time_ <= 1.33333333333333 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_132_30 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_30 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_30

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_30
						arg_129_1.bgmTxt2_.text = var_132_30
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_138", "se_story_138_thunderhit", "")
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_32 = 4
			local var_132_33 = 1.575

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_32 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_34 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_34:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_129_1.dialogCg_.alpha = arg_135_0
				end))
				var_132_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_35 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(416062032).content)

				arg_129_1.text_.text = var_132_35

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_37 = 63 <= 0 and var_132_33 or var_132_33 * (utf8.len(var_132_35) / 63)

				if (63 <= 0 and var_132_33 or var_132_33 * (utf8.len(var_132_35) / 63)) > 0 and var_132_33 < var_132_37 then
					arg_129_1.talkMaxDuration = var_132_37
					var_132_32 = var_132_32 + 0.3

					if var_132_37 + var_132_32 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_37 + var_132_32
					end
				end

				arg_129_1.text_.text = var_132_35
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_38 = var_132_32 + 0.3
			local var_132_39 = math.max(var_132_33, arg_129_1.talkMaxDuration)

			if var_132_32 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_38 + var_132_39 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_38) / var_132_39

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_38 + var_132_39 and arg_129_1.time_ < var_132_38 + var_132_39 + arg_132_0 then
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play416062033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416062033
		arg_137_1.duration_ = 5.57

		local var_137_0 = {
			zh = 5.3,
			ja = 5.566
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
				arg_137_0:Play416062034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1028 = arg_137_1.actors_["1028"].transform.localPosition
				arg_137_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1028", 3)

				for iter_140_0 = 0, arg_137_1.actors_["1028"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1028"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_2" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1028"].transform.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_140_2 = arg_137_1.actors_["1028"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1028 == nil then
				arg_137_1.var_.actorSpriteComps1028 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.125

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps1028 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1028 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps1028 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 0.525

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(416062033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 21 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 21)

				if (21 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 21)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062033", "story_v_out_416062.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062033", "story_v_out_416062.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_416062", "416062033", "story_v_out_416062.awb")

						arg_137_1:RecordAudio("416062033", var_140_12)
						arg_137_1:RecordAudio("416062033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416062", "416062033", "story_v_out_416062.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416062", "416062033", "story_v_out_416062.awb")
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
				actorName = "1028",
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
	Play416062034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416062034
		arg_141_1.duration_ = 6.77

		local var_141_0 = {
			zh = 6.766,
			ja = 6.066
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
				arg_141_0:Play416062035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1028 = arg_141_1.actors_["1028"].transform.localPosition
				arg_141_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1028", 2)

				for iter_144_0 = 0, arg_141_1.actors_["1028"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["1028"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1028"].transform.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_144_2 = arg_141_1.actors_["1028"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1028 == nil then
				arg_141_1.var_.actorSpriteComps1028 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps1028 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1028 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps1028 = nil
			end

			local var_144_5 = arg_141_1.actors_["1086"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1086 = var_144_5.localPosition
				var_144_5.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1086", 4)

				for iter_144_5 = 0, var_144_5.childCount - 1 do
					local var_144_6 = var_144_5:GetChild(iter_144_5)

					if var_144_6.name == "" or not string.find(var_144_6.name, "split") then
						var_144_6.gameObject:SetActive(true)
					else
						var_144_6.gameObject:SetActive(false)
					end
				end
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_141_1.time_ - 0) / var_144_7)
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_144_8 = arg_141_1.actors_["1086"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps1086 == nil then
				arg_141_1.var_.actorSpriteComps1086 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 and not isNil(var_144_8) then
				if arg_141_1.var_.actorSpriteComps1086 then
					for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_144_7 then
							if arg_141_1.isInRecall_ then
								iter_144_7.color = Color.New(Mathf.Lerp(iter_144_7.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_9), Mathf.Lerp(iter_144_7.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_9), (Mathf.Lerp(iter_144_7.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_9)))
							else
								local var_144_10 = Mathf.Lerp(iter_144_7.color.r, 1, (arg_141_1.time_ - 0) / var_144_9)

								iter_144_7.color = Color.New(var_144_10, var_144_10, var_144_10)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps1086 then
				for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_144_9 then
						iter_144_9.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps1086 = nil
			end

			local var_144_11 = 0
			local var_144_12 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(416062034)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 19 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 19)

				if (19 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 19)) > 0 and var_144_12 < var_144_16 then
					arg_141_1.talkMaxDuration = var_144_16

					if var_144_16 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062034", "story_v_out_416062.awb") ~= 0 then
					local var_144_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062034", "story_v_out_416062.awb") / 1000

					if var_144_17 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_11
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_416062", "416062034", "story_v_out_416062.awb")

						arg_141_1:RecordAudio("416062034", var_144_18)
						arg_141_1:RecordAudio("416062034", var_144_18)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416062", "416062034", "story_v_out_416062.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416062", "416062034", "story_v_out_416062.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_19 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_19

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_19 and arg_141_1.time_ < var_144_11 + var_144_19 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416062035
		arg_145_1.duration_ = 7.8

		local var_145_0 = {
			zh = 4.933,
			ja = 7.8
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
				arg_145_0:Play416062036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1086"]) and arg_145_1.var_.actorSpriteComps1086 == nil then
				arg_145_1.var_.actorSpriteComps1086 = arg_145_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.125

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1086"]) then
				if arg_145_1.var_.actorSpriteComps1086 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1086"]) and arg_145_1.var_.actorSpriteComps1086 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps1086 = nil
			end

			local var_148_2 = arg_145_1.actors_["1028"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1028 == nil then
				arg_145_1.var_.actorSpriteComps1028 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.125

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1028 then
					for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_148_5 then
							if arg_145_1.isInRecall_ then
								iter_148_5.color = Color.New(Mathf.Lerp(iter_148_5.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_5.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_5.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_5.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_5.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1028 then
				for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_148_7 then
						iter_148_7.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1028 = nil
			end

			local var_148_5 = 0
			local var_148_6 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:GetWordFromCfg(416062035)
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

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062035", "story_v_out_416062.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062035", "story_v_out_416062.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_416062", "416062035", "story_v_out_416062.awb")

						arg_145_1:RecordAudio("416062035", var_148_12)
						arg_145_1:RecordAudio("416062035", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416062", "416062035", "story_v_out_416062.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416062", "416062035", "story_v_out_416062.awb")
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

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play416062036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416062036
		arg_149_1.duration_ = 4.57

		local var_149_0 = {
			zh = 3.5,
			ja = 4.566
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
				arg_149_0:Play416062037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1028"]) and arg_149_1.var_.actorSpriteComps1028 == nil then
				arg_149_1.var_.actorSpriteComps1028 = arg_149_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.125

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1028"]) then
				if arg_149_1.var_.actorSpriteComps1028 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1028"]) and arg_149_1.var_.actorSpriteComps1028 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1028 = nil
			end

			local var_152_2 = arg_149_1.actors_["1086"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1086 == nil then
				arg_149_1.var_.actorSpriteComps1086 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.125

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps1086 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								iter_152_5.color = Color.New(Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_5.color.r, 1, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_5.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1086 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_152_7 then
						iter_152_7.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps1086 = nil
			end

			local var_152_5 = 0
			local var_152_6 = 0.375

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(416062036)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 15 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 15)

				if (15 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 15)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062036", "story_v_out_416062.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062036", "story_v_out_416062.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_416062", "416062036", "story_v_out_416062.awb")

						arg_149_1:RecordAudio("416062036", var_152_12)
						arg_149_1:RecordAudio("416062036", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416062", "416062036", "story_v_out_416062.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416062", "416062036", "story_v_out_416062.awb")
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

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416062037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416062037
		arg_153_1.duration_ = 8.2

		local var_153_0 = {
			zh = 4.433,
			ja = 8.2
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
				arg_153_0:Play416062038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1086"]) and arg_153_1.var_.actorSpriteComps1086 == nil then
				arg_153_1.var_.actorSpriteComps1086 = arg_153_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.125

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1086"]) then
				if arg_153_1.var_.actorSpriteComps1086 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1086"]) and arg_153_1.var_.actorSpriteComps1086 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps1086 = nil
			end

			local var_156_2 = arg_153_1.actors_["1028"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1028 == nil then
				arg_153_1.var_.actorSpriteComps1028 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.125

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1028 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								iter_156_5.color = Color.New(Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_5.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_5.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1028 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_156_7 then
						iter_156_7.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1028 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(416062037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 20 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 20)

				if (20 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 20)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062037", "story_v_out_416062.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062037", "story_v_out_416062.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_416062", "416062037", "story_v_out_416062.awb")

						arg_153_1:RecordAudio("416062037", var_156_12)
						arg_153_1:RecordAudio("416062037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416062", "416062037", "story_v_out_416062.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416062", "416062037", "story_v_out_416062.awb")
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

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416062038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416062038
		arg_157_1.duration_ = 5

		local var_157_0 = {
			zh = 2.766,
			ja = 5
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
				arg_157_0:Play416062039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1086 = arg_157_1.actors_["1086"].transform.localPosition
				arg_157_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1086", 7)

				for iter_160_0 = 0, arg_157_1.actors_["1086"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["1086"].transform:GetChild(iter_160_0)

					if var_160_0.name == "" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_2 = arg_157_1.actors_["1148"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1148 == nil then
				arg_157_1.var_.actorSpriteComps1148 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.125

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps1148 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1148 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1148 = nil
			end

			local var_160_5 = arg_157_1.actors_["1148"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1148 = var_160_5.localPosition
				var_160_5.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1148", 4)

				for iter_160_5 = 0, var_160_5.childCount - 1 do
					local var_160_6 = var_160_5:GetChild(iter_160_5)

					if var_160_6.name == "split_2" or not string.find(var_160_6.name, "split") then
						var_160_6.gameObject:SetActive(true)
					else
						var_160_6.gameObject:SetActive(false)
					end
				end
			end

			local var_160_7 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_157_1.time_ - 0) / var_160_7)
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_160_8 = arg_157_1.actors_["1028"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps1028 == nil then
				arg_157_1.var_.actorSpriteComps1028 = var_160_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.125

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_9 and not isNil(var_160_8) then
				if arg_157_1.var_.actorSpriteComps1028 then
					for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_160_7 then
							if arg_157_1.isInRecall_ then
								iter_160_7.color = Color.New(Mathf.Lerp(iter_160_7.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_9), Mathf.Lerp(iter_160_7.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_9), (Mathf.Lerp(iter_160_7.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_9)))
							else
								local var_160_10 = Mathf.Lerp(iter_160_7.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_9)

								iter_160_7.color = Color.New(var_160_10, var_160_10, var_160_10)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_9 and arg_157_1.time_ < 0 + var_160_9 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps1028 then
				for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_160_9 then
						iter_160_9.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps1028 = nil
			end

			local var_160_11 = 0
			local var_160_12 = 0.275

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_13 = arg_157_1:GetWordFromCfg(416062038)
				local var_160_14 = arg_157_1:FormatText(var_160_13.content)

				arg_157_1.text_.text = var_160_14

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_16 = 11 <= 0 and var_160_12 or var_160_12 * (utf8.len(var_160_14) / 11)

				if (11 <= 0 and var_160_12 or var_160_12 * (utf8.len(var_160_14) / 11)) > 0 and var_160_12 < var_160_16 then
					arg_157_1.talkMaxDuration = var_160_16

					if var_160_16 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_16 + var_160_11
					end
				end

				arg_157_1.text_.text = var_160_14
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062038", "story_v_out_416062.awb") ~= 0 then
					local var_160_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062038", "story_v_out_416062.awb") / 1000

					if var_160_17 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_17 + var_160_11
					end

					if var_160_13.prefab_name ~= "" and arg_157_1.actors_[var_160_13.prefab_name] ~= nil then
						local var_160_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_13.prefab_name].transform, "story_v_out_416062", "416062038", "story_v_out_416062.awb")

						arg_157_1:RecordAudio("416062038", var_160_18)
						arg_157_1:RecordAudio("416062038", var_160_18)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416062", "416062038", "story_v_out_416062.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416062", "416062038", "story_v_out_416062.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_19 = math.max(var_160_12, arg_157_1.talkMaxDuration)

			if var_160_11 <= arg_157_1.time_ and arg_157_1.time_ < var_160_11 + var_160_19 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_11) / var_160_19

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_11 + var_160_19 and arg_157_1.time_ < var_160_11 + var_160_19 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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

		arg_157_1:InitPlayNodeList()
	end,
	Play416062039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416062039
		arg_161_1.duration_ = 7.23

		local var_161_0 = {
			zh = 4.366,
			ja = 7.233
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
				arg_161_0:Play416062040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1028"]) and arg_161_1.var_.actorSpriteComps1028 == nil then
				arg_161_1.var_.actorSpriteComps1028 = arg_161_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.125

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1028"]) then
				if arg_161_1.var_.actorSpriteComps1028 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 1, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1028"]) and arg_161_1.var_.actorSpriteComps1028 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps1028 = nil
			end

			local var_164_2 = arg_161_1.actors_["1148"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1148 == nil then
				arg_161_1.var_.actorSpriteComps1148 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.125

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps1148 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_164_5 then
							if arg_161_1.isInRecall_ then
								iter_164_5.color = Color.New(Mathf.Lerp(iter_164_5.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_5.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_5.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_5.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_5.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1148 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_164_7 then
						iter_164_7.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps1148 = nil
			end

			local var_164_5 = arg_161_1.actors_["1148"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1148 = var_164_5.localPosition
				var_164_5.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1148", 4)

				for iter_164_8 = 0, var_164_5.childCount - 1 do
					local var_164_6 = var_164_5:GetChild(iter_164_8)

					if var_164_6.name == "split_2" or not string.find(var_164_6.name, "split") then
						var_164_6.gameObject:SetActive(true)
					else
						var_164_6.gameObject:SetActive(false)
					end
				end
			end

			local var_164_7 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_161_1.time_ - 0) / var_164_7)
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_164_8 = arg_161_1.actors_["1028"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1028 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1028", 2)

				for iter_164_9 = 0, var_164_8.childCount - 1 do
					local var_164_9 = var_164_8:GetChild(iter_164_9)

					if var_164_9.name == "split_6" or not string.find(var_164_9.name, "split") then
						var_164_9.gameObject:SetActive(true)
					else
						var_164_9.gameObject:SetActive(false)
					end
				end
			end

			local var_164_10 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_10 then
				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_161_1.time_ - 0) / var_164_10)
			end

			if arg_161_1.time_ >= 0 + var_164_10 and arg_161_1.time_ < 0 + var_164_10 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_164_11 = 0
			local var_164_12 = 0.45

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(416062039)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_16 = 18 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 18)

				if (18 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 18)) > 0 and var_164_12 < var_164_16 then
					arg_161_1.talkMaxDuration = var_164_16

					if var_164_16 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062039", "story_v_out_416062.awb") ~= 0 then
					local var_164_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062039", "story_v_out_416062.awb") / 1000

					if var_164_17 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_11
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_416062", "416062039", "story_v_out_416062.awb")

						arg_161_1:RecordAudio("416062039", var_164_18)
						arg_161_1:RecordAudio("416062039", var_164_18)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416062", "416062039", "story_v_out_416062.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416062", "416062039", "story_v_out_416062.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_19 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_19 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_19

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_19 and arg_161_1.time_ < var_164_11 + var_164_19 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416062040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416062040
		arg_165_1.duration_ = 4.17

		local var_165_0 = {
			zh = 3,
			ja = 4.166
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
				arg_165_0:Play416062041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1148"]) and arg_165_1.var_.actorSpriteComps1148 == nil then
				arg_165_1.var_.actorSpriteComps1148 = arg_165_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.125

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1148"]) then
				if arg_165_1.var_.actorSpriteComps1148 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1148"]) and arg_165_1.var_.actorSpriteComps1148 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1148 = nil
			end

			local var_168_2 = arg_165_1.actors_["1028"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1028 == nil then
				arg_165_1.var_.actorSpriteComps1028 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.125

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1028 then
					for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_168_5 then
							if arg_165_1.isInRecall_ then
								iter_168_5.color = Color.New(Mathf.Lerp(iter_168_5.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_5.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_5.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_5.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_5.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1028 then
				for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_168_7 then
						iter_168_7.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1028 = nil
			end

			local var_168_5 = arg_165_1.actors_["1148"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1148 = var_168_5.localPosition
				var_168_5.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1148", 4)

				for iter_168_8 = 0, var_168_5.childCount - 1 do
					local var_168_6 = var_168_5:GetChild(iter_168_8)

					if var_168_6.name == "split_1_1" or not string.find(var_168_6.name, "split") then
						var_168_6.gameObject:SetActive(true)
					else
						var_168_6.gameObject:SetActive(false)
					end
				end
			end

			local var_168_7 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				var_168_5.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_165_1.time_ - 0) / var_168_7)
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				var_168_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_168_8 = 0
			local var_168_9 = 0.325

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(416062040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 13 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 13)

				if (13 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 13)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062040", "story_v_out_416062.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062040", "story_v_out_416062.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_416062", "416062040", "story_v_out_416062.awb")

						arg_165_1:RecordAudio("416062040", var_168_15)
						arg_165_1:RecordAudio("416062040", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416062", "416062040", "story_v_out_416062.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416062", "416062040", "story_v_out_416062.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play416062041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416062041
		arg_169_1.duration_ = 7.5

		local var_169_0 = {
			zh = 5.8,
			ja = 7.5
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
				arg_169_0:Play416062042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1028"]) and arg_169_1.var_.actorSpriteComps1028 == nil then
				arg_169_1.var_.actorSpriteComps1028 = arg_169_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.125

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1028"]) then
				if arg_169_1.var_.actorSpriteComps1028 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 1, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1028"]) and arg_169_1.var_.actorSpriteComps1028 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps1028 = nil
			end

			local var_172_2 = arg_169_1.actors_["1148"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1148 == nil then
				arg_169_1.var_.actorSpriteComps1148 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.125

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps1148 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1148 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_172_7 then
						iter_172_7.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1148 = nil
			end

			local var_172_5 = 0
			local var_172_6 = 0.475

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:GetWordFromCfg(416062041)
				local var_172_8 = arg_169_1:FormatText(var_172_7.content)

				arg_169_1.text_.text = var_172_8

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 19 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 19)

				if (19 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 19)) > 0 and var_172_6 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_8
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062041", "story_v_out_416062.awb") ~= 0 then
					local var_172_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062041", "story_v_out_416062.awb") / 1000

					if var_172_11 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_5
					end

					if var_172_7.prefab_name ~= "" and arg_169_1.actors_[var_172_7.prefab_name] ~= nil then
						local var_172_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_7.prefab_name].transform, "story_v_out_416062", "416062041", "story_v_out_416062.awb")

						arg_169_1:RecordAudio("416062041", var_172_12)
						arg_169_1:RecordAudio("416062041", var_172_12)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416062", "416062041", "story_v_out_416062.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416062", "416062041", "story_v_out_416062.awb")
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

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416062042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416062042
		arg_173_1.duration_ = 5.23

		local var_173_0 = {
			zh = 4.633,
			ja = 5.233
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
				arg_173_0:Play416062043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1148"]) and arg_173_1.var_.actorSpriteComps1148 == nil then
				arg_173_1.var_.actorSpriteComps1148 = arg_173_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.125

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1148"]) then
				if arg_173_1.var_.actorSpriteComps1148 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 1, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1148"]) and arg_173_1.var_.actorSpriteComps1148 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps1148 = nil
			end

			local var_176_2 = arg_173_1.actors_["1028"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1028 == nil then
				arg_173_1.var_.actorSpriteComps1028 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.125

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps1028 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								iter_176_5.color = Color.New(Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_5.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_5.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1028 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_176_7 then
						iter_176_7.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps1028 = nil
			end

			local var_176_5 = 0
			local var_176_6 = 0.375

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_7 = arg_173_1:GetWordFromCfg(416062042)
				local var_176_8 = arg_173_1:FormatText(var_176_7.content)

				arg_173_1.text_.text = var_176_8

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_10 = 15 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 15)

				if (15 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 15)) > 0 and var_176_6 < var_176_10 then
					arg_173_1.talkMaxDuration = var_176_10

					if var_176_10 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_8
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062042", "story_v_out_416062.awb") ~= 0 then
					local var_176_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062042", "story_v_out_416062.awb") / 1000

					if var_176_11 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_5
					end

					if var_176_7.prefab_name ~= "" and arg_173_1.actors_[var_176_7.prefab_name] ~= nil then
						local var_176_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_7.prefab_name].transform, "story_v_out_416062", "416062042", "story_v_out_416062.awb")

						arg_173_1:RecordAudio("416062042", var_176_12)
						arg_173_1:RecordAudio("416062042", var_176_12)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416062", "416062042", "story_v_out_416062.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416062", "416062042", "story_v_out_416062.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_13 and arg_173_1.time_ < var_176_5 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416062043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416062043
		arg_177_1.duration_ = 7.43

		local var_177_0 = {
			zh = 3.4,
			ja = 7.433
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
				arg_177_0:Play416062044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1148"]) and arg_177_1.var_.actorSpriteComps1148 == nil then
				arg_177_1.var_.actorSpriteComps1148 = arg_177_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.125

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1148"]) then
				if arg_177_1.var_.actorSpriteComps1148 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1148"]) and arg_177_1.var_.actorSpriteComps1148 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps1148 = nil
			end

			local var_180_2 = arg_177_1.actors_["1028"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1028 == nil then
				arg_177_1.var_.actorSpriteComps1028 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.125

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps1028 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								iter_180_5.color = Color.New(Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_5.color.r, 1, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_5.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1028 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_180_7 then
						iter_180_7.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1028 = nil
			end

			local var_180_5 = 0
			local var_180_6 = 0.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(416062043)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 13 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 13)

				if (13 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 13)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062043", "story_v_out_416062.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062043", "story_v_out_416062.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_416062", "416062043", "story_v_out_416062.awb")

						arg_177_1:RecordAudio("416062043", var_180_12)
						arg_177_1:RecordAudio("416062043", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416062", "416062043", "story_v_out_416062.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416062", "416062043", "story_v_out_416062.awb")
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

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416062044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416062044
		arg_181_1.duration_ = 8.5

		local var_181_0 = {
			zh = 6.3,
			ja = 8.5
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
				arg_181_0:Play416062045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1148"]) and arg_181_1.var_.actorSpriteComps1148 == nil then
				arg_181_1.var_.actorSpriteComps1148 = arg_181_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.125

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1148"]) then
				if arg_181_1.var_.actorSpriteComps1148 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1148"]) and arg_181_1.var_.actorSpriteComps1148 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1148 = nil
			end

			local var_184_2 = arg_181_1.actors_["1028"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1028 == nil then
				arg_181_1.var_.actorSpriteComps1028 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.125

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1028 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1028 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1028 = nil
			end

			local var_184_5 = 0
			local var_184_6 = 0.65

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_7 = arg_181_1:GetWordFromCfg(416062044)
				local var_184_8 = arg_181_1:FormatText(var_184_7.content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 26 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 26)

				if (26 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 26)) > 0 and var_184_6 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062044", "story_v_out_416062.awb") ~= 0 then
					local var_184_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062044", "story_v_out_416062.awb") / 1000

					if var_184_11 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_5
					end

					if var_184_7.prefab_name ~= "" and arg_181_1.actors_[var_184_7.prefab_name] ~= nil then
						local var_184_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_7.prefab_name].transform, "story_v_out_416062", "416062044", "story_v_out_416062.awb")

						arg_181_1:RecordAudio("416062044", var_184_12)
						arg_181_1:RecordAudio("416062044", var_184_12)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416062", "416062044", "story_v_out_416062.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416062", "416062044", "story_v_out_416062.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_13 and arg_181_1.time_ < var_184_5 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play416062045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416062045
		arg_185_1.duration_ = 4.7

		local var_185_0 = {
			zh = 4.433,
			ja = 4.7
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
				arg_185_0:Play416062046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1148 = arg_185_1.actors_["1148"].transform.localPosition
				arg_185_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1148", 4)

				for iter_188_0 = 0, arg_185_1.actors_["1148"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["1148"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_4" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["1148"].transform.localPosition = Vector3.New(390, -429, -180)
			end

			local var_188_2 = 0
			local var_188_3 = 0.4

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(416062045)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 16 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 16)

				if (16 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 16)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062045", "story_v_out_416062.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_416062", "416062045", "story_v_out_416062.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_416062", "416062045", "story_v_out_416062.awb")

						arg_185_1:RecordAudio("416062045", var_188_9)
						arg_185_1:RecordAudio("416062045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416062", "416062045", "story_v_out_416062.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416062", "416062045", "story_v_out_416062.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
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

		arg_185_1:InitPlayNodeList()
	end,
	Play416062046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416062046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416062047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1028 = arg_189_1.actors_["1028"].transform.localPosition
				arg_189_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1028", 7)

				for iter_192_0 = 0, arg_189_1.actors_["1028"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1028"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_2 = arg_189_1.actors_["1148"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1148", 7)

				for iter_192_1 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_1)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_5 = 0
			local var_192_6 = 1.525

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(416062046).content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 61 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_7) / 61)

				if (61 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_7) / 61)) > 0 and var_192_6 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_10 and arg_189_1.time_ < var_192_5 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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

		arg_189_1:InitPlayNodeList()
	end,
	Play416062047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416062047
		arg_193_1.duration_ = 5.2

		local var_193_0 = {
			zh = 4.366,
			ja = 5.2
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
				arg_193_0:Play416062048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1086 = arg_193_1.actors_["1086"].transform.localPosition
				arg_193_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1086", 3)

				for iter_196_0 = 0, arg_193_1.actors_["1086"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["1086"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_2" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_196_2 = arg_193_1.actors_["1086"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1086 == nil then
				arg_193_1.var_.actorSpriteComps1086 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.125

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps1086 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1086 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1086 = nil
			end

			local var_196_5 = 0
			local var_196_6 = 0.55

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(416062047)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 22 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 22)

				if (22 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 22)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062047", "story_v_out_416062.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062047", "story_v_out_416062.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_416062", "416062047", "story_v_out_416062.awb")

						arg_193_1:RecordAudio("416062047", var_196_12)
						arg_193_1:RecordAudio("416062047", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416062", "416062047", "story_v_out_416062.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416062", "416062047", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416062048
		arg_197_1.duration_ = 10.07

		local var_197_0 = {
			zh = 7.066,
			ja = 10.066
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
				arg_197_0:Play416062049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.875

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(416062048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 35 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 35)

				if (35 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 35)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062048", "story_v_out_416062.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062048", "story_v_out_416062.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_416062", "416062048", "story_v_out_416062.awb")

						arg_197_1:RecordAudio("416062048", var_200_6)
						arg_197_1:RecordAudio("416062048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416062", "416062048", "story_v_out_416062.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416062", "416062048", "story_v_out_416062.awb")
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
	Play416062049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416062049
		arg_201_1.duration_ = 6.7

		local var_201_0 = {
			zh = 4.133,
			ja = 6.7
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
				arg_201_0:Play416062050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.525

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(416062049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 21 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 21)

				if (21 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 21)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062049", "story_v_out_416062.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062049", "story_v_out_416062.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_416062", "416062049", "story_v_out_416062.awb")

						arg_201_1:RecordAudio("416062049", var_204_6)
						arg_201_1:RecordAudio("416062049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416062", "416062049", "story_v_out_416062.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416062", "416062049", "story_v_out_416062.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play416062050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416062050
		arg_205_1.duration_ = 8.93

		local var_205_0 = {
			zh = 6.1,
			ja = 8.933
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
				arg_205_0:Play416062051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1086 = arg_205_1.actors_["1086"].transform.localPosition
				arg_205_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1086", 2)

				for iter_208_0 = 0, arg_205_1.actors_["1086"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["1086"].transform:GetChild(iter_208_0)

					if var_208_0.name == "" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_208_2 = arg_205_1.actors_["1086"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1086 == nil then
				arg_205_1.var_.actorSpriteComps1086 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.125

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps1086 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1086 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1086 = nil
			end

			local var_208_5 = arg_205_1.actors_["1028"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1028 == nil then
				arg_205_1.var_.actorSpriteComps1028 = var_208_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_6 = 0.125

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 and not isNil(var_208_5) then
				if arg_205_1.var_.actorSpriteComps1028 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								iter_208_6.color = Color.New(Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_6), Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_6), (Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_6)))
							else
								local var_208_7 = Mathf.Lerp(iter_208_6.color.r, 1, (arg_205_1.time_ - 0) / var_208_6)

								iter_208_6.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1028 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_208_8 then
						iter_208_8.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps1028 = nil
			end

			local var_208_8 = arg_205_1.actors_["1028"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1028 = var_208_8.localPosition
				var_208_8.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1028", 4)

				for iter_208_9 = 0, var_208_8.childCount - 1 do
					local var_208_9 = var_208_8:GetChild(iter_208_9)

					if var_208_9.name == "split_6" or not string.find(var_208_9.name, "split") then
						var_208_9.gameObject:SetActive(true)
					else
						var_208_9.gameObject:SetActive(false)
					end
				end
			end

			local var_208_10 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_10 then
				var_208_8.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_205_1.time_ - 0) / var_208_10)
			end

			if arg_205_1.time_ >= 0 + var_208_10 and arg_205_1.time_ < 0 + var_208_10 + arg_208_0 then
				var_208_8.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_208_11 = 0
			local var_208_12 = 0.75

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_13 = arg_205_1:GetWordFromCfg(416062050)
				local var_208_14 = arg_205_1:FormatText(var_208_13.content)

				arg_205_1.text_.text = var_208_14

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_16 = 30 <= 0 and var_208_12 or var_208_12 * (utf8.len(var_208_14) / 30)

				if (30 <= 0 and var_208_12 or var_208_12 * (utf8.len(var_208_14) / 30)) > 0 and var_208_12 < var_208_16 then
					arg_205_1.talkMaxDuration = var_208_16

					if var_208_16 + var_208_11 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_16 + var_208_11
					end
				end

				arg_205_1.text_.text = var_208_14
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062050", "story_v_out_416062.awb") ~= 0 then
					local var_208_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062050", "story_v_out_416062.awb") / 1000

					if var_208_17 + var_208_11 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_17 + var_208_11
					end

					if var_208_13.prefab_name ~= "" and arg_205_1.actors_[var_208_13.prefab_name] ~= nil then
						local var_208_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_13.prefab_name].transform, "story_v_out_416062", "416062050", "story_v_out_416062.awb")

						arg_205_1:RecordAudio("416062050", var_208_18)
						arg_205_1:RecordAudio("416062050", var_208_18)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_416062", "416062050", "story_v_out_416062.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_416062", "416062050", "story_v_out_416062.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_19 = math.max(var_208_12, arg_205_1.talkMaxDuration)

			if var_208_11 <= arg_205_1.time_ and arg_205_1.time_ < var_208_11 + var_208_19 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_11) / var_208_19

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_11 + var_208_19 and arg_205_1.time_ < var_208_11 + var_208_19 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416062051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416062051
		arg_209_1.duration_ = 6.87

		local var_209_0 = {
			zh = 5.7,
			ja = 6.866
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
				arg_209_0:Play416062052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1028"]) and arg_209_1.var_.actorSpriteComps1028 == nil then
				arg_209_1.var_.actorSpriteComps1028 = arg_209_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.125

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1028"]) then
				if arg_209_1.var_.actorSpriteComps1028 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1028"]) and arg_209_1.var_.actorSpriteComps1028 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps1028 = nil
			end

			local var_212_2 = arg_209_1.actors_["1028"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1028 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1028", 2)

				for iter_212_4 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_4)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_212_5 = arg_209_1.actors_["1148"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps1148 == nil then
				arg_209_1.var_.actorSpriteComps1148 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 0.125

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps1148 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								iter_212_6.color = Color.New(Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_6.color.r, 1, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_6.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps1148 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_212_8 then
						iter_212_8.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1148 = nil
			end

			local var_212_8 = arg_209_1.actors_["1148"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1148 = var_212_8.localPosition
				var_212_8.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1148", 4)

				for iter_212_9 = 0, var_212_8.childCount - 1 do
					local var_212_9 = var_212_8:GetChild(iter_212_9)

					if var_212_9.name == "" or not string.find(var_212_9.name, "split") then
						var_212_9.gameObject:SetActive(true)
					else
						var_212_9.gameObject:SetActive(false)
					end
				end
			end

			local var_212_10 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_10 then
				var_212_8.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_209_1.time_ - 0) / var_212_10)
			end

			if arg_209_1.time_ >= 0 + var_212_10 and arg_209_1.time_ < 0 + var_212_10 + arg_212_0 then
				var_212_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_212_11 = 0
			local var_212_12 = 0.475

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_13 = arg_209_1:GetWordFromCfg(416062051)
				local var_212_14 = arg_209_1:FormatText(var_212_13.content)

				arg_209_1.text_.text = var_212_14

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_16 = 19 <= 0 and var_212_12 or var_212_12 * (utf8.len(var_212_14) / 19)

				if (19 <= 0 and var_212_12 or var_212_12 * (utf8.len(var_212_14) / 19)) > 0 and var_212_12 < var_212_16 then
					arg_209_1.talkMaxDuration = var_212_16

					if var_212_16 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_11
					end
				end

				arg_209_1.text_.text = var_212_14
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062051", "story_v_out_416062.awb") ~= 0 then
					local var_212_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062051", "story_v_out_416062.awb") / 1000

					if var_212_17 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_17 + var_212_11
					end

					if var_212_13.prefab_name ~= "" and arg_209_1.actors_[var_212_13.prefab_name] ~= nil then
						local var_212_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_13.prefab_name].transform, "story_v_out_416062", "416062051", "story_v_out_416062.awb")

						arg_209_1:RecordAudio("416062051", var_212_18)
						arg_209_1:RecordAudio("416062051", var_212_18)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_416062", "416062051", "story_v_out_416062.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_416062", "416062051", "story_v_out_416062.awb")
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
				actorName = "1028",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play416062052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 416062052
		arg_213_1.duration_ = 3.93

		local var_213_0 = {
			zh = 3,
			ja = 3.933
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
				arg_213_0:Play416062053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.425

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(416062052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 17 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 17)

				if (17 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 17)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062052", "story_v_out_416062.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062052", "story_v_out_416062.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_416062", "416062052", "story_v_out_416062.awb")

						arg_213_1:RecordAudio("416062052", var_216_6)
						arg_213_1:RecordAudio("416062052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_416062", "416062052", "story_v_out_416062.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_416062", "416062052", "story_v_out_416062.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play416062053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 416062053
		arg_217_1.duration_ = 9

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play416062054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 2 < arg_217_1.time_ and arg_217_1.time_ <= 2 + arg_220_0 then
				local var_220_0 = arg_217_1.bgs_.I13h

				arg_217_1.bgs_.I13h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_220_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_1 = var_220_0:GetComponent("SpriteRenderer")

				if var_220_1 and var_220_1.sprite then
					local var_220_2 = 2 * (var_220_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_220_0.transform.localScale = Vector3.New(var_220_2 / var_220_1.sprite.bounds.size.y < var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x and var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x or var_220_2 / var_220_1.sprite.bounds.size.y, var_220_2 / var_220_1.sprite.bounds.size.y < var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x and var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x or var_220_2 / var_220_1.sprite.bounds.size.y, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "I13h" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_3 = 4

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_3 + 0.3 and arg_217_1.time_ < var_220_3 + 0.3 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_4 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_5 = 2

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_5 then
				local var_220_6 = Color.New(0, 0, 0)

				var_220_6.a = Mathf.Lerp(0, 1, (arg_217_1.time_ - var_220_4) / var_220_5)
				arg_217_1.mask_.color = var_220_6
			end

			if arg_217_1.time_ >= var_220_4 + var_220_5 and arg_217_1.time_ < var_220_4 + var_220_5 + arg_220_0 then
				local var_220_7 = Color.New(0, 0, 0)

				var_220_7.a = 1
				arg_217_1.mask_.color = var_220_7
			end

			local var_220_8 = 2

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_9 = 2

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 then
				local var_220_10 = Color.New(0, 0, 0)

				var_220_10.a = Mathf.Lerp(1, 0, (arg_217_1.time_ - var_220_8) / var_220_9)
				arg_217_1.mask_.color = var_220_10
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 then
				local var_220_11 = Color.New(0, 0, 0)

				arg_217_1.mask_.enabled = false
				var_220_11.a = 0
				arg_217_1.mask_.color = var_220_11
			end

			local var_220_12 = arg_217_1.actors_["1148"].transform

			if 1.966 < arg_217_1.time_ and arg_217_1.time_ <= 1.966 + arg_220_0 then
				arg_217_1.var_.moveOldPos1148 = var_220_12.localPosition
				var_220_12.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1148", 7)

				for iter_220_2 = 0, var_220_12.childCount - 1 do
					local var_220_13 = var_220_12:GetChild(iter_220_2)

					if var_220_13.name == "" or not string.find(var_220_13.name, "split") then
						var_220_13.gameObject:SetActive(true)
					else
						var_220_13.gameObject:SetActive(false)
					end
				end
			end

			local var_220_14 = 0.001

			if 1.966 <= arg_217_1.time_ and arg_217_1.time_ < 1.966 + var_220_14 then
				var_220_12.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_217_1.time_ - 1.966) / var_220_14)
			end

			if arg_217_1.time_ >= 1.966 + var_220_14 and arg_217_1.time_ < 1.966 + var_220_14 + arg_220_0 then
				var_220_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_15 = arg_217_1.actors_["1028"].transform

			if 1.966 < arg_217_1.time_ and arg_217_1.time_ <= 1.966 + arg_220_0 then
				arg_217_1.var_.moveOldPos1028 = var_220_15.localPosition
				var_220_15.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1028", 7)

				for iter_220_3 = 0, var_220_15.childCount - 1 do
					local var_220_16 = var_220_15:GetChild(iter_220_3)

					if var_220_16.name == "" or not string.find(var_220_16.name, "split") then
						var_220_16.gameObject:SetActive(true)
					else
						var_220_16.gameObject:SetActive(false)
					end
				end
			end

			local var_220_17 = 0.001

			if 1.966 <= arg_217_1.time_ and arg_217_1.time_ < 1.966 + var_220_17 then
				var_220_15.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_217_1.time_ - 1.966) / var_220_17)
			end

			if arg_217_1.time_ >= 1.966 + var_220_17 and arg_217_1.time_ < 1.966 + var_220_17 + arg_220_0 then
				var_220_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_18 = 4
			local var_220_19 = 0.925

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_18 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_20 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_20:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_21 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(416062053).content)

				arg_217_1.text_.text = var_220_21

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_23 = 37 <= 0 and var_220_19 or var_220_19 * (utf8.len(var_220_21) / 37)

				if (37 <= 0 and var_220_19 or var_220_19 * (utf8.len(var_220_21) / 37)) > 0 and var_220_19 < var_220_23 then
					arg_217_1.talkMaxDuration = var_220_23
					var_220_18 = var_220_18 + 0.3

					if var_220_23 + var_220_18 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_18
					end
				end

				arg_217_1.text_.text = var_220_21
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_24 = var_220_18 + 0.3
			local var_220_25 = math.max(var_220_19, arg_217_1.talkMaxDuration)

			if var_220_18 + 0.3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_24 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_24) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_24 + var_220_25 and arg_217_1.time_ < var_220_24 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play416062054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416062054
		arg_223_1.duration_ = 3.53

		local var_223_0 = {
			zh = 3.533,
			ja = 3.4
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
				arg_223_0:Play416062055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1086"]) and arg_223_1.var_.actorSpriteComps1086 == nil then
				arg_223_1.var_.actorSpriteComps1086 = arg_223_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.125

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1086"]) then
				if arg_223_1.var_.actorSpriteComps1086 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1086"]) and arg_223_1.var_.actorSpriteComps1086 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps1086 = nil
			end

			local var_226_2 = arg_223_1.actors_["1086"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1086 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1086", 3)

				for iter_226_4 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_4)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_226_5 = 0
			local var_226_6 = 0.475

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(416062054)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 19 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 19)

				if (19 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 19)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062054", "story_v_out_416062.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062054", "story_v_out_416062.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_416062", "416062054", "story_v_out_416062.awb")

						arg_223_1:RecordAudio("416062054", var_226_12)
						arg_223_1:RecordAudio("416062054", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416062", "416062054", "story_v_out_416062.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416062", "416062054", "story_v_out_416062.awb")
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
				actorName = "1086",
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
	Play416062055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416062055
		arg_227_1.duration_ = 4.37

		local var_227_0 = {
			zh = 3.2,
			ja = 4.366
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
				arg_227_0:Play416062056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1086 = arg_227_1.actors_["1086"].transform.localPosition
				arg_227_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1086", 2)

				for iter_230_0 = 0, arg_227_1.actors_["1086"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["1086"].transform:GetChild(iter_230_0)

					if var_230_0.name == "" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["1086"].transform.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_230_2 = arg_227_1.actors_["1086"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1086 == nil then
				arg_227_1.var_.actorSpriteComps1086 = var_230_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_3 = 0.125

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.actorSpriteComps1086 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								iter_230_2.color = Color.New(Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_3), Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_3), (Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_3)))
							else
								local var_230_4 = Mathf.Lerp(iter_230_2.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_3)

								iter_230_2.color = Color.New(var_230_4, var_230_4, var_230_4)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1086 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_230_4 then
						iter_230_4.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps1086 = nil
			end

			local var_230_5 = arg_227_1.actors_["1028"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.actorSpriteComps1028 == nil then
				arg_227_1.var_.actorSpriteComps1028 = var_230_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_6 = 0.125

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.actorSpriteComps1028 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								iter_230_6.color = Color.New(Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_6), Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_6), (Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_6)))
							else
								local var_230_7 = Mathf.Lerp(iter_230_6.color.r, 1, (arg_227_1.time_ - 0) / var_230_6)

								iter_230_6.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.actorSpriteComps1028 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_230_8 then
						iter_230_8.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1028 = nil
			end

			local var_230_8 = arg_227_1.actors_["1028"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1028 = var_230_8.localPosition
				var_230_8.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1028", 4)

				for iter_230_9 = 0, var_230_8.childCount - 1 do
					local var_230_9 = var_230_8:GetChild(iter_230_9)

					if var_230_9.name == "" or not string.find(var_230_9.name, "split") then
						var_230_9.gameObject:SetActive(true)
					else
						var_230_9.gameObject:SetActive(false)
					end
				end
			end

			local var_230_10 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_10 then
				var_230_8.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_227_1.time_ - 0) / var_230_10)
			end

			if arg_227_1.time_ >= 0 + var_230_10 and arg_227_1.time_ < 0 + var_230_10 + arg_230_0 then
				var_230_8.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_230_11 = 0
			local var_230_12 = 0.35

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_13 = arg_227_1:GetWordFromCfg(416062055)
				local var_230_14 = arg_227_1:FormatText(var_230_13.content)

				arg_227_1.text_.text = var_230_14

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_16 = 14 <= 0 and var_230_12 or var_230_12 * (utf8.len(var_230_14) / 14)

				if (14 <= 0 and var_230_12 or var_230_12 * (utf8.len(var_230_14) / 14)) > 0 and var_230_12 < var_230_16 then
					arg_227_1.talkMaxDuration = var_230_16

					if var_230_16 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_11
					end
				end

				arg_227_1.text_.text = var_230_14
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062055", "story_v_out_416062.awb") ~= 0 then
					local var_230_17 = manager.audio:GetVoiceLength("story_v_out_416062", "416062055", "story_v_out_416062.awb") / 1000

					if var_230_17 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_17 + var_230_11
					end

					if var_230_13.prefab_name ~= "" and arg_227_1.actors_[var_230_13.prefab_name] ~= nil then
						local var_230_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_13.prefab_name].transform, "story_v_out_416062", "416062055", "story_v_out_416062.awb")

						arg_227_1:RecordAudio("416062055", var_230_18)
						arg_227_1:RecordAudio("416062055", var_230_18)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416062", "416062055", "story_v_out_416062.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416062", "416062055", "story_v_out_416062.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_19 = math.max(var_230_12, arg_227_1.talkMaxDuration)

			if var_230_11 <= arg_227_1.time_ and arg_227_1.time_ < var_230_11 + var_230_19 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_11) / var_230_19

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_11 + var_230_19 and arg_227_1.time_ < var_230_11 + var_230_19 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416062056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416062056
		arg_231_1.duration_ = 10.3

		local var_231_0 = {
			zh = 7,
			ja = 10.3
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
				arg_231_0:Play416062057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1086"]) and arg_231_1.var_.actorSpriteComps1086 == nil then
				arg_231_1.var_.actorSpriteComps1086 = arg_231_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.125

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1086"]) then
				if arg_231_1.var_.actorSpriteComps1086 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1086"]) and arg_231_1.var_.actorSpriteComps1086 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps1086 = nil
			end

			local var_234_2 = arg_231_1.actors_["1028"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1028 == nil then
				arg_231_1.var_.actorSpriteComps1028 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.125

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps1028 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								iter_234_5.color = Color.New(Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_5.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_5.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1028 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_234_7 then
						iter_234_7.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps1028 = nil
			end

			local var_234_5 = 0
			local var_234_6 = 0.7

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(416062056)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 28 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 28)

				if (28 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 28)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062056", "story_v_out_416062.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062056", "story_v_out_416062.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_416062", "416062056", "story_v_out_416062.awb")

						arg_231_1:RecordAudio("416062056", var_234_12)
						arg_231_1:RecordAudio("416062056", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416062", "416062056", "story_v_out_416062.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416062", "416062056", "story_v_out_416062.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_13 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_13

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_13 and arg_231_1.time_ < var_234_5 + var_234_13 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416062057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416062057
		arg_235_1.duration_ = 8.6

		local var_235_0 = {
			zh = 5.1,
			ja = 8.6
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
				arg_235_0:Play416062058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1028"]) and arg_235_1.var_.actorSpriteComps1028 == nil then
				arg_235_1.var_.actorSpriteComps1028 = arg_235_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.125

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1028"]) then
				if arg_235_1.var_.actorSpriteComps1028 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 1, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1028"]) and arg_235_1.var_.actorSpriteComps1028 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps1028 = nil
			end

			local var_238_2 = arg_235_1.actors_["1086"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps1086 == nil then
				arg_235_1.var_.actorSpriteComps1086 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.125

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps1086 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								iter_238_5.color = Color.New(Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_5.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_5.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps1086 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_238_7 then
						iter_238_7.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps1086 = nil
			end

			local var_238_5 = 0
			local var_238_6 = 0.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(416062057)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 22 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 22)

				if (22 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 22)) > 0 and var_238_6 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062057", "story_v_out_416062.awb") ~= 0 then
					local var_238_11 = manager.audio:GetVoiceLength("story_v_out_416062", "416062057", "story_v_out_416062.awb") / 1000

					if var_238_11 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_5
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_416062", "416062057", "story_v_out_416062.awb")

						arg_235_1:RecordAudio("416062057", var_238_12)
						arg_235_1:RecordAudio("416062057", var_238_12)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416062", "416062057", "story_v_out_416062.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416062", "416062057", "story_v_out_416062.awb")
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

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416062058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416062058
		arg_239_1.duration_ = 10.13

		local var_239_0 = {
			zh = 7.233,
			ja = 10.133
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
				arg_239_0:Play416062059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.775

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(416062058)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 31 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 31)

				if (31 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 31)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062058", "story_v_out_416062.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_416062", "416062058", "story_v_out_416062.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_416062", "416062058", "story_v_out_416062.awb")

						arg_239_1:RecordAudio("416062058", var_242_6)
						arg_239_1:RecordAudio("416062058", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416062", "416062058", "story_v_out_416062.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416062", "416062058", "story_v_out_416062.awb")
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
	Play416062059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416062059
		arg_243_1.duration_ = 9.3

		local var_243_0 = {
			zh = 8.333,
			ja = 9.3
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
				arg_243_0:Play416062060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1086"]) and arg_243_1.var_.actorSpriteComps1086 == nil then
				arg_243_1.var_.actorSpriteComps1086 = arg_243_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.125

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1086"]) then
				if arg_243_1.var_.actorSpriteComps1086 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1086"]) and arg_243_1.var_.actorSpriteComps1086 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1086 = nil
			end

			local var_246_2 = arg_243_1.actors_["1028"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1028 == nil then
				arg_243_1.var_.actorSpriteComps1028 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.125

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps1028 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_246_5 then
							if arg_243_1.isInRecall_ then
								iter_246_5.color = Color.New(Mathf.Lerp(iter_246_5.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_5.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_5.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_5.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_5.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1028 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_246_7 then
						iter_246_7.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1028 = nil
			end

			local var_246_5 = arg_243_1.actors_["1086"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1086 = var_246_5.localPosition
				var_246_5.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1086", 2)

				for iter_246_8 = 0, var_246_5.childCount - 1 do
					local var_246_6 = var_246_5:GetChild(iter_246_8)

					if var_246_6.name == "split_2" or not string.find(var_246_6.name, "split") then
						var_246_6.gameObject:SetActive(true)
					else
						var_246_6.gameObject:SetActive(false)
					end
				end
			end

			local var_246_7 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				var_246_5.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_243_1.time_ - 0) / var_246_7)
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				var_246_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_246_8 = 0
			local var_246_9 = 0.825

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(416062059)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 33 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 33)

				if (33 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 33)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062059", "story_v_out_416062.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_416062", "416062059", "story_v_out_416062.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_416062", "416062059", "story_v_out_416062.awb")

						arg_243_1:RecordAudio("416062059", var_246_15)
						arg_243_1:RecordAudio("416062059", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416062", "416062059", "story_v_out_416062.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416062", "416062059", "story_v_out_416062.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416062060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416062060
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play416062061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				local var_250_0 = arg_247_1.bgs_.I13f

				arg_247_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_1 = var_250_0:GetComponent("SpriteRenderer")

				if var_250_1 and var_250_1.sprite then
					local var_250_2 = 2 * (var_250_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_0.transform.localScale = Vector3.New(var_250_2 / var_250_1.sprite.bounds.size.y < var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x and var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x or var_250_2 / var_250_1.sprite.bounds.size.y, var_250_2 / var_250_1.sprite.bounds.size.y < var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x and var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x or var_250_2 / var_250_1.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "I13f" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_3 = 4

			if 4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			if arg_247_1.time_ >= var_250_3 + 0.3 and arg_247_1.time_ < var_250_3 + 0.3 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			local var_250_4 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_5 = 2

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_5 then
				local var_250_6 = Color.New(0, 0, 0)

				var_250_6.a = Mathf.Lerp(0, 1, (arg_247_1.time_ - var_250_4) / var_250_5)
				arg_247_1.mask_.color = var_250_6
			end

			if arg_247_1.time_ >= var_250_4 + var_250_5 and arg_247_1.time_ < var_250_4 + var_250_5 + arg_250_0 then
				local var_250_7 = Color.New(0, 0, 0)

				var_250_7.a = 1
				arg_247_1.mask_.color = var_250_7
			end

			local var_250_8 = 2

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_9 = 2

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_9 then
				local var_250_10 = Color.New(0, 0, 0)

				var_250_10.a = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_8) / var_250_9)
				arg_247_1.mask_.color = var_250_10
			end

			if arg_247_1.time_ >= var_250_8 + var_250_9 and arg_247_1.time_ < var_250_8 + var_250_9 + arg_250_0 then
				local var_250_11 = Color.New(0, 0, 0)

				arg_247_1.mask_.enabled = false
				var_250_11.a = 0
				arg_247_1.mask_.color = var_250_11
			end

			local var_250_12 = arg_247_1.actors_["1086"].transform

			if 1.966 < arg_247_1.time_ and arg_247_1.time_ <= 1.966 + arg_250_0 then
				arg_247_1.var_.moveOldPos1086 = var_250_12.localPosition
				var_250_12.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1086", 7)

				for iter_250_2 = 0, var_250_12.childCount - 1 do
					local var_250_13 = var_250_12:GetChild(iter_250_2)

					if var_250_13.name == "" or not string.find(var_250_13.name, "split") then
						var_250_13.gameObject:SetActive(true)
					else
						var_250_13.gameObject:SetActive(false)
					end
				end
			end

			local var_250_14 = 0.001

			if 1.966 <= arg_247_1.time_ and arg_247_1.time_ < 1.966 + var_250_14 then
				var_250_12.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 1.966) / var_250_14)
			end

			if arg_247_1.time_ >= 1.966 + var_250_14 and arg_247_1.time_ < 1.966 + var_250_14 + arg_250_0 then
				var_250_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_15 = arg_247_1.actors_["1028"].transform

			if 1.966 < arg_247_1.time_ and arg_247_1.time_ <= 1.966 + arg_250_0 then
				arg_247_1.var_.moveOldPos1028 = var_250_15.localPosition
				var_250_15.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1028", 7)

				for iter_250_3 = 0, var_250_15.childCount - 1 do
					local var_250_16 = var_250_15:GetChild(iter_250_3)

					if var_250_16.name == "" or not string.find(var_250_16.name, "split") then
						var_250_16.gameObject:SetActive(true)
					else
						var_250_16.gameObject:SetActive(false)
					end
				end
			end

			local var_250_17 = 0.001

			if 1.966 <= arg_247_1.time_ and arg_247_1.time_ < 1.966 + var_250_17 then
				var_250_15.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 1.966) / var_250_17)
			end

			if arg_247_1.time_ >= 1.966 + var_250_17 and arg_247_1.time_ < 1.966 + var_250_17 + arg_250_0 then
				var_250_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_18 = 4
			local var_250_19 = 1.375

			if 4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_18 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_20 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_20:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_21 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(416062060).content)

				arg_247_1.text_.text = var_250_21

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_23 = 55 <= 0 and var_250_19 or var_250_19 * (utf8.len(var_250_21) / 55)

				if (55 <= 0 and var_250_19 or var_250_19 * (utf8.len(var_250_21) / 55)) > 0 and var_250_19 < var_250_23 then
					arg_247_1.talkMaxDuration = var_250_23
					var_250_18 = var_250_18 + 0.3

					if var_250_23 + var_250_18 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_18
					end
				end

				arg_247_1.text_.text = var_250_21
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_24 = var_250_18 + 0.3
			local var_250_25 = math.max(var_250_19, arg_247_1.talkMaxDuration)

			if var_250_18 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_24 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_24) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_24 + var_250_25 and arg_247_1.time_ < var_250_24 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play416062061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 416062061
		arg_253_1.duration_ = 16.83

		local var_253_0 = {
			zh = 11.0993333333333,
			ja = 16.8333333333333
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
			arg_253_1.auto_ = false
		end

		function arg_253_1.playNext_(arg_255_0)
			arg_253_1.onStoryFinished_()
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_9000

			if arg_253_1.actors_["10109"] == nil then
				local var_256_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_256_0) then
					local var_256_1 = Object.Instantiate(var_256_0, arg_253_1.canvasGo_.transform)

					var_256_1.transform:SetSiblingIndex(1)

					var_256_1.name = "10109"
					var_256_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_253_1.actors_["10109"] = var_256_1

					if arg_253_1.isInRecall_ then
						for iter_256_0, iter_256_1 in ipairs((var_256_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_256_1.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_256_2 = arg_253_1.actors_["10109"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10109 = var_256_2.localPosition
				var_256_2.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10109", 3)

				for iter_256_2 = 0, var_256_2.childCount - 1 do
					local var_256_3 = var_256_2:GetChild(iter_256_2)

					if var_256_3.name == "" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				var_256_2.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_253_1.time_ - 0) / var_256_4)
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				var_256_2.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_256_5 = arg_253_1.actors_["10109"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps10109 == nil then
				arg_253_1.var_.actorSpriteComps10109 = var_256_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_6 = 0.125

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.actorSpriteComps10109 then
					for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_256_4 then
							if arg_253_1.isInRecall_ then
								iter_256_4.color = Color.New(Mathf.Lerp(iter_256_4.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_6), Mathf.Lerp(iter_256_4.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_6), (Mathf.Lerp(iter_256_4.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_6)))
							else
								local var_256_7 = Mathf.Lerp(iter_256_4.color.r, 1, (arg_253_1.time_ - 0) / var_256_6)

								iter_256_4.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps10109 then
				for iter_256_5, iter_256_6 in pairs(arg_253_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_256_6 then
						iter_256_6.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10109 = nil
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				local var_256_8 = arg_253_1.var_.effect2061

				if not arg_253_1.var_.effect2061 then
					var_256_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_256_8.name = "2061"
					arg_253_1.var_.effect2061 = var_256_8
				else
					var_256_8.transform:SetParent(var_256_9000)
				end

				var_256_8.transform.localPosition = Vector3.New(0, 0, 0.04)
				var_256_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_256_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_256_7, iter_256_8 in ipairs((var_256_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_256_8.transform.localScale = Vector3.New(iter_256_8.transform.localScale.x / var_256_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_256_8.transform.localScale.y / var_256_10, iter_256_8.transform.localScale.z)
				end
			end

			local var_256_12 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			if arg_253_1.time_ >= var_256_12 + 0.3 and arg_253_1.time_ < var_256_12 + 0.3 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				local var_256_13 = arg_253_1.actors_["10109"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_256_13 then
					arg_253_1.var_.alphaOldValue10109 = var_256_13.alpha
					arg_253_1.var_.characterEffect10109 = var_256_13
				end

				arg_253_1.var_.alphaOldValue10109 = 0
			end

			local var_256_14 = 0.857666666666667

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_14 then
				if arg_253_1.var_.characterEffect10109 then
					arg_253_1.var_.characterEffect10109.alpha = Mathf.Lerp(arg_253_1.var_.alphaOldValue10109, 1, (arg_253_1.time_ - 0) / var_256_14)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_14 and arg_253_1.time_ < 0 + var_256_14 + arg_256_0 and arg_253_1.var_.characterEffect10109 then
				arg_253_1.var_.characterEffect10109.alpha = 1
			end

			local var_256_15 = 0.433333333333333
			local var_256_16 = 0.625

			if 0.433333333333333 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_17 = arg_253_1:GetWordFromCfg(416062061)
				local var_256_18 = arg_253_1:FormatText(var_256_17.content)

				arg_253_1.text_.text = var_256_18

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_20 = 25 <= 0 and var_256_16 or var_256_16 * (utf8.len(var_256_18) / 25)

				if (25 <= 0 and var_256_16 or var_256_16 * (utf8.len(var_256_18) / 25)) > 0 and var_256_16 < var_256_20 then
					arg_253_1.talkMaxDuration = var_256_20

					if var_256_20 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_20 + var_256_15
					end
				end

				arg_253_1.text_.text = var_256_18
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416062", "416062061", "story_v_out_416062.awb") ~= 0 then
					local var_256_21 = manager.audio:GetVoiceLength("story_v_out_416062", "416062061", "story_v_out_416062.awb") / 1000

					if var_256_21 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_21 + var_256_15
					end

					if var_256_17.prefab_name ~= "" and arg_253_1.actors_[var_256_17.prefab_name] ~= nil then
						local var_256_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_17.prefab_name].transform, "story_v_out_416062", "416062061", "story_v_out_416062.awb")

						arg_253_1:RecordAudio("416062061", var_256_22)
						arg_253_1:RecordAudio("416062061", var_256_22)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_416062", "416062061", "story_v_out_416062.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_416062", "416062061", "story_v_out_416062.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_23 = math.max(var_256_16, arg_253_1.talkMaxDuration)

			if var_256_15 <= arg_253_1.time_ and arg_253_1.time_ < var_256_15 + var_256_23 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_15) / var_256_23

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_15 + var_256_23 and arg_253_1.time_ < var_256_15 + var_256_23 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
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
	assets = {
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/I13h"
	},
	voices = {
		"story_v_out_416062.awb"
	}
}
