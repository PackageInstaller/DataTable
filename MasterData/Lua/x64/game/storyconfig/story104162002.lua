return {
	Play416202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416202001
		arg_1_1.duration_ = 9.63

		local var_1_0 = {
			zh = 7,
			ja = 9.633
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
				arg_1_0:Play416202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I13i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13i")
				var_4_0.name = "I13i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I13i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I13i

				arg_1_1.bgs_.I13i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I13i" then
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

			local var_4_9 = "10109"

			if arg_1_1.actors_["10109"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

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

			local var_4_12 = arg_1_1.actors_["10109"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10109 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10109", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -346.2, -395)
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_15 = arg_1_1.actors_["10109"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_15 then
					arg_1_1.var_.alphaOldValue10109 = var_4_15.alpha
					arg_1_1.var_.characterEffect10109 = var_4_15
				end

				arg_1_1.var_.alphaOldValue10109 = 0
			end

			local var_4_16 = 0.233333333333333

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 then
				if arg_1_1.var_.characterEffect10109 then
					arg_1_1.var_.characterEffect10109.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10109, 1, (arg_1_1.time_ - 1.8) / var_4_16)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and arg_1_1.var_.characterEffect10109 then
				arg_1_1.var_.characterEffect10109.alpha = 1
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(416202001)
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

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202001", "story_v_out_416202.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_416202", "416202001", "story_v_out_416202.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_416202", "416202001", "story_v_out_416202.awb")

						arg_1_1:RecordAudio("416202001", var_4_31)
						arg_1_1:RecordAudio("416202001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416202", "416202001", "story_v_out_416202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416202", "416202001", "story_v_out_416202.awb")
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
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416202002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10109"]) and arg_9_1.var_.actorSpriteComps10109 == nil then
				arg_9_1.var_.actorSpriteComps10109 = arg_9_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10109"]) then
				if arg_9_1.var_.actorSpriteComps10109 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10109"]) and arg_9_1.var_.actorSpriteComps10109 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10109 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 1.45

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

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416202002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 58 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 58)

				if (58 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 58)) > 0 and var_12_3 < var_12_6 then
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

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play416202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416202003
		arg_13_1.duration_ = 12.1

		local var_13_0 = {
			zh = 8.2,
			ja = 12.1
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
				arg_13_0:Play416202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10109"]) and arg_13_1.var_.actorSpriteComps10109 == nil then
				arg_13_1.var_.actorSpriteComps10109 = arg_13_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10109"]) then
				if arg_13_1.var_.actorSpriteComps10109 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 1, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10109"]) and arg_13_1.var_.actorSpriteComps10109 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10109 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(416202003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 21 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 21)

				if (21 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 21)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202003", "story_v_out_416202.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_416202", "416202003", "story_v_out_416202.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_416202", "416202003", "story_v_out_416202.awb")

						arg_13_1:RecordAudio("416202003", var_16_9)
						arg_13_1:RecordAudio("416202003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416202", "416202003", "story_v_out_416202.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416202", "416202003", "story_v_out_416202.awb")
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
	Play416202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416202004
		arg_17_1.duration_ = 4.9

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play416202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(416202004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 15 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 15)

				if (15 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 15)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202004", "story_v_out_416202.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202004", "story_v_out_416202.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_416202", "416202004", "story_v_out_416202.awb")

						arg_17_1:RecordAudio("416202004", var_20_6)
						arg_17_1:RecordAudio("416202004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416202", "416202004", "story_v_out_416202.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416202", "416202004", "story_v_out_416202.awb")
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
	Play416202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416202005
		arg_21_1.duration_ = 4.07

		local var_21_0 = {
			zh = 3.7,
			ja = 4.066
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
				arg_21_0:Play416202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10109 = arg_21_1.actors_["10109"].transform.localPosition
				arg_21_1.actors_["10109"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10109", 7)

				for iter_24_0 = 0, arg_21_1.actors_["10109"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10109"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10109"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10109"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_2 = 0
			local var_24_3 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(416202005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 15 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 15)

				if (15 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 15)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202005", "story_v_out_416202.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_416202", "416202005", "story_v_out_416202.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_416202", "416202005", "story_v_out_416202.awb")

						arg_21_1:RecordAudio("416202005", var_24_9)
						arg_21_1:RecordAudio("416202005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416202", "416202005", "story_v_out_416202.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416202", "416202005", "story_v_out_416202.awb")
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

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play416202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416202006
		arg_25_1.duration_ = 10.96

		local var_25_0 = {
			zh = 7.658,
			ja = 10.958
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
				arg_25_0:Play416202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.SS1609 == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1609")
				var_28_0.name = "SS1609"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.SS1609 = var_28_0
			end

			if 1.15 < arg_25_1.time_ and arg_25_1.time_ <= 1.15 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.SS1609

				arg_25_1.bgs_.SS1609.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "SS1609" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 1.16666666666667

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 1.16666666666667

			if 1.16666666666667 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2.43333333333333

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			local var_28_12 = arg_25_1.bgs_.SS1609.transform

			if 1.16666666666667 < arg_25_1.time_ and arg_25_1.time_ <= 1.16666666666667 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS1609 = var_28_12.localPosition
			end

			local var_28_13 = 0.001

			if 1.16666666666667 <= arg_25_1.time_ and arg_25_1.time_ < 1.16666666666667 + var_28_13 then
				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS1609, Vector3.New(0, 1, 9), (arg_25_1.time_ - 1.16666666666667) / var_28_13)
			end

			if arg_25_1.time_ >= 1.16666666666667 + var_28_13 and arg_25_1.time_ < 1.16666666666667 + var_28_13 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_28_14 = arg_25_1.bgs_.SS1609.transform

			if 1.20066666666667 < arg_25_1.time_ and arg_25_1.time_ <= 1.20066666666667 + arg_28_0 then
				arg_25_1.var_.moveOldPosSS1609 = var_28_14.localPosition
			end

			local var_28_15 = 2.39933333333333

			if 1.20066666666667 <= arg_25_1.time_ and arg_25_1.time_ < 1.20066666666667 + var_28_15 then
				var_28_14.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPosSS1609, Vector3.New(0, 0.29, 6), (arg_25_1.time_ - 1.20066666666667) / var_28_15)
			end

			if arg_25_1.time_ >= 1.20066666666667 + var_28_15 and arg_25_1.time_ < 1.20066666666667 + var_28_15 + arg_28_0 then
				var_28_14.localPosition = Vector3.New(0, 0.29, 6)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_16 = 3.025
			local var_28_17 = 0.575

			if 3.025 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_18 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_18:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:GetWordFromCfg(416202006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_22 = 23 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_20) / 23)

				if (23 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_20) / 23)) > 0 and var_28_17 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22
					var_28_16 = var_28_16 + 0.3

					if var_28_22 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_20
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202006", "story_v_out_416202.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_416202", "416202006", "story_v_out_416202.awb") / 1000

					if var_28_23 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_16
					end

					if var_28_19.prefab_name ~= "" and arg_25_1.actors_[var_28_19.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_19.prefab_name].transform, "story_v_out_416202", "416202006", "story_v_out_416202.awb")

						arg_25_1:RecordAudio("416202006", var_28_24)
						arg_25_1:RecordAudio("416202006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416202", "416202006", "story_v_out_416202.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416202", "416202006", "story_v_out_416202.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = var_28_16 + 0.3
			local var_28_26 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_25 + var_28_26 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_25) / var_28_26

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_25 + var_28_26 and arg_25_1.time_ < var_28_25 + var_28_26 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1609",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1609",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 1.20066666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play416202007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416202007
		arg_31_1.duration_ = 6.17

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play416202008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPosSS1609 = arg_31_1.bgs_.SS1609.transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.bgs_.SS1609.transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPosSS1609, Vector3.New(0, 0.29, 6), (arg_31_1.time_ - 0) / var_34_0)
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.bgs_.SS1609.transform.localPosition = Vector3.New(0, 0.29, 6)
			end

			local var_34_1 = arg_31_1.bgs_.SS1609.transform

			if 0.0166666666666667 < arg_31_1.time_ and arg_31_1.time_ <= 0.0166666666666667 + arg_34_0 then
				arg_31_1.var_.moveOldPosSS1609 = var_34_1.localPosition
			end

			local var_34_2 = 1.88333333333333

			if 0.0166666666666667 <= arg_31_1.time_ and arg_31_1.time_ < 0.0166666666666667 + var_34_2 then
				var_34_1.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPosSS1609, Vector3.New(0, 1, 8.85), (arg_31_1.time_ - 0.0166666666666667) / var_34_2)
			end

			if arg_31_1.time_ >= 0.0166666666666667 + var_34_2 and arg_31_1.time_ < 0.0166666666666667 + var_34_2 + arg_34_0 then
				var_34_1.localPosition = Vector3.New(0, 1, 8.85)
			end

			local var_34_3 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			if arg_31_1.time_ >= var_34_3 + 1.8 and arg_31_1.time_ < var_34_3 + 1.8 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_4 = 1.16666666666667
			local var_34_5 = 0.533333333333333

			if 1.16666666666667 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_6 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_6:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_7 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(416202007).content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 63 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 63)

				if (63 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 63)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9
					var_34_4 = var_34_4 + 0.3

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = var_34_4 + 0.3
			local var_34_11 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1609",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1609",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.88333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play416202008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416202008
		arg_37_1.duration_ = 9.1

		local var_37_0 = {
			zh = 6.633,
			ja = 9.1
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
				arg_37_0:Play416202009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.7

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(416202008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 28 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 28)

				if (28 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 28)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202008", "story_v_out_416202.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202008", "story_v_out_416202.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_416202", "416202008", "story_v_out_416202.awb")

						arg_37_1:RecordAudio("416202008", var_40_6)
						arg_37_1:RecordAudio("416202008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416202", "416202008", "story_v_out_416202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416202", "416202008", "story_v_out_416202.awb")
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
	Play416202009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416202009
		arg_41_1.duration_ = 6

		local var_41_0 = {
			zh = 6,
			ja = 5.433
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
				arg_41_0:Play416202010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(416202009)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 16 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 16)

				if (16 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 16)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202009", "story_v_out_416202.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202009", "story_v_out_416202.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_416202", "416202009", "story_v_out_416202.awb")

						arg_41_1:RecordAudio("416202009", var_44_6)
						arg_41_1:RecordAudio("416202009", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416202", "416202009", "story_v_out_416202.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416202", "416202009", "story_v_out_416202.awb")
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
	Play416202010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416202010
		arg_45_1.duration_ = 12.5

		local var_45_0 = {
			zh = 6.833,
			ja = 12.5
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
				arg_45_0:Play416202011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(416202010)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 37 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 37)

				if (37 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 37)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202010", "story_v_out_416202.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202010", "story_v_out_416202.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_416202", "416202010", "story_v_out_416202.awb")

						arg_45_1:RecordAudio("416202010", var_48_6)
						arg_45_1:RecordAudio("416202010", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416202", "416202010", "story_v_out_416202.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416202", "416202010", "story_v_out_416202.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416202011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416202011
		arg_49_1.duration_ = 6.03

		local var_49_0 = {
			zh = 4.9,
			ja = 6.033
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
				arg_49_0:Play416202012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.675

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(416202011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 27 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 27)

				if (27 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 27)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202011", "story_v_out_416202.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202011", "story_v_out_416202.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_416202", "416202011", "story_v_out_416202.awb")

						arg_49_1:RecordAudio("416202011", var_52_6)
						arg_49_1:RecordAudio("416202011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416202", "416202011", "story_v_out_416202.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416202", "416202011", "story_v_out_416202.awb")
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
	Play416202012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416202012
		arg_53_1.duration_ = 8.4

		local var_53_0 = {
			zh = 4.466,
			ja = 8.4
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
				arg_53_0:Play416202013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(416202012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 24)

				if (24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 24)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202012", "story_v_out_416202.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202012", "story_v_out_416202.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_416202", "416202012", "story_v_out_416202.awb")

						arg_53_1:RecordAudio("416202012", var_56_6)
						arg_53_1:RecordAudio("416202012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416202", "416202012", "story_v_out_416202.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416202", "416202012", "story_v_out_416202.awb")
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
	Play416202013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416202013
		arg_57_1.duration_ = 8.4

		local var_57_0 = {
			zh = 8.4,
			ja = 5.8
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
				arg_57_0:Play416202014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10109")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(416202013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 20 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 20)

				if (20 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 20)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202013", "story_v_out_416202.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202013", "story_v_out_416202.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_416202", "416202013", "story_v_out_416202.awb")

						arg_57_1:RecordAudio("416202013", var_60_6)
						arg_57_1:RecordAudio("416202013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416202", "416202013", "story_v_out_416202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416202", "416202013", "story_v_out_416202.awb")
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
	Play416202014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416202014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416202015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(416202014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 56 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 56)

				if (56 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 56)) > 0 and var_64_0 < var_64_3 then
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
	Play416202015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416202015
		arg_65_1.duration_ = 3.47

		local var_65_0 = {
			zh = 3.433,
			ja = 3.466
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
				arg_65_0:Play416202016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(416202015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202015", "story_v_out_416202.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202015", "story_v_out_416202.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_416202", "416202015", "story_v_out_416202.awb")

						arg_65_1:RecordAudio("416202015", var_68_6)
						arg_65_1:RecordAudio("416202015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416202", "416202015", "story_v_out_416202.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416202", "416202015", "story_v_out_416202.awb")
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
	Play416202016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416202016
		arg_69_1.duration_ = 8.03

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play416202017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 1.46666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 1.46666666666667 + arg_72_0 then
				local var_72_0 = arg_69_1.bgs_.I13i

				arg_69_1.bgs_.I13i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_1 = var_72_0:GetComponent("SpriteRenderer")

				if var_72_1 and var_72_1.sprite then
					local var_72_2 = 2 * (var_72_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_0.transform.localScale = Vector3.New(var_72_2 / var_72_1.sprite.bounds.size.y < var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x and var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x or var_72_2 / var_72_1.sprite.bounds.size.y, var_72_2 / var_72_1.sprite.bounds.size.y < var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x and var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x or var_72_2 / var_72_1.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "I13i" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_3 = 1.46666666666667

			if 1.46666666666667 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_3 + 0.3 and arg_69_1.time_ < var_72_3 + 0.3 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_4 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_5 = 1.46666666666667

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_5 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_4) / var_72_5)
				arg_69_1.mask_.color = var_72_6
			end

			if arg_69_1.time_ >= var_72_4 + var_72_5 and arg_69_1.time_ < var_72_4 + var_72_5 + arg_72_0 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = 1
				arg_69_1.mask_.color = var_72_7
			end

			local var_72_8 = 1.46666666666667

			if 1.46666666666667 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 then
				local var_72_10 = Color.New(0, 0, 0)

				var_72_10.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_8) / var_72_9)
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				local var_72_11 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_11.a = 0
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_12 = 3.03333333333333
			local var_72_13 = 1.05

			if 3.03333333333333 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_14 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_14:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(416202016).content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 42 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 42)

				if (42 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 42)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17
					var_72_12 = var_72_12 + 0.3

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = var_72_12 + 0.3
			local var_72_19 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_18) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play416202017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416202017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play416202018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.525

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(416202017).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 61 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 61)

				if (61 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 61)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416202018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416202018
		arg_79_1.duration_ = 6.53

		local var_79_0 = {
			zh = 4.333,
			ja = 6.533
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
				arg_79_0:Play416202019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.actors_["10122"] == nil then
				local var_82_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

				if not isNil(var_82_0) then
					local var_82_1 = Object.Instantiate(var_82_0, arg_79_1.canvasGo_.transform)

					var_82_1.transform:SetSiblingIndex(1)

					var_82_1.name = "10122"
					var_82_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_79_1.actors_["10122"] = var_82_1

					if arg_79_1.isInRecall_ then
						for iter_82_0, iter_82_1 in ipairs((var_82_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_82_1.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_82_2 = arg_79_1.actors_["10122"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10122 == nil then
				arg_79_1.var_.actorSpriteComps10122 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps10122 then
					for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_82_3 then
							if arg_79_1.isInRecall_ then
								iter_82_3.color = Color.New(Mathf.Lerp(iter_82_3.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_3.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_3.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_3.color.r, 1, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_3.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10122 then
				for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_82_5 then
						iter_82_5.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10122 = nil
			end

			local var_82_5 = arg_79_1.actors_["10122"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10122 = var_82_5.localPosition
				var_82_5.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10122", 2)

				for iter_82_6 = 0, var_82_5.childCount - 1 do
					local var_82_6 = var_82_5:GetChild(iter_82_6)

					if var_82_6.name == "split_5" or not string.find(var_82_6.name, "split") then
						var_82_6.gameObject:SetActive(true)
					else
						var_82_6.gameObject:SetActive(false)
					end
				end
			end

			local var_82_7 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				var_82_5.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_79_1.time_ - 0) / var_82_7)
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				var_82_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_82_8 = 0
			local var_82_9 = 0.5

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(416202018)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 20 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 20)

				if (20 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 20)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202018", "story_v_out_416202.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_416202", "416202018", "story_v_out_416202.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_416202", "416202018", "story_v_out_416202.awb")

						arg_79_1:RecordAudio("416202018", var_82_15)
						arg_79_1:RecordAudio("416202018", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_416202", "416202018", "story_v_out_416202.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_416202", "416202018", "story_v_out_416202.awb")
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
				actorName = "10122",
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
	Play416202019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416202019
		arg_83_1.duration_ = 5.13

		local var_83_0 = {
			zh = 5.133,
			ja = 4.366
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
				arg_83_0:Play416202020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["10127"] == nil then
				local var_86_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_86_0) then
					local var_86_1 = Object.Instantiate(var_86_0, arg_83_1.canvasGo_.transform)

					var_86_1.transform:SetSiblingIndex(1)

					var_86_1.name = "10127"
					var_86_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_83_1.actors_["10127"] = var_86_1

					if arg_83_1.isInRecall_ then
						for iter_86_0, iter_86_1 in ipairs((var_86_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_86_1.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_86_2 = arg_83_1.actors_["10127"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10127 == nil then
				arg_83_1.var_.actorSpriteComps10127 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10127 then
					for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_86_3 then
							if arg_83_1.isInRecall_ then
								iter_86_3.color = Color.New(Mathf.Lerp(iter_86_3.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_3.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_3.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_3.color.r, 1, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_3.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10127 then
				for iter_86_4, iter_86_5 in pairs(arg_83_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_86_5 then
						iter_86_5.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps10127 = nil
			end

			local var_86_5 = arg_83_1.actors_["10122"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.actorSpriteComps10122 == nil then
				arg_83_1.var_.actorSpriteComps10122 = var_86_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_6 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.actorSpriteComps10122 then
					for iter_86_6, iter_86_7 in pairs(arg_83_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_86_7 then
							if arg_83_1.isInRecall_ then
								iter_86_7.color = Color.New(Mathf.Lerp(iter_86_7.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_6), Mathf.Lerp(iter_86_7.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_6), (Mathf.Lerp(iter_86_7.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_6)))
							else
								local var_86_7 = Mathf.Lerp(iter_86_7.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_6)

								iter_86_7.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.actorSpriteComps10122 then
				for iter_86_8, iter_86_9 in pairs(arg_83_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_86_9 then
						iter_86_9.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps10122 = nil
			end

			local var_86_8 = arg_83_1.actors_["10127"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10127 = var_86_8.localPosition
				var_86_8.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10127", 4)

				for iter_86_10 = 0, var_86_8.childCount - 1 do
					local var_86_9 = var_86_8:GetChild(iter_86_10)

					if var_86_9.name == "" or not string.find(var_86_9.name, "split") then
						var_86_9.gameObject:SetActive(true)
					else
						var_86_9.gameObject:SetActive(false)
					end
				end
			end

			local var_86_10 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_10 then
				var_86_8.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_83_1.time_ - 0) / var_86_10)
			end

			if arg_83_1.time_ >= 0 + var_86_10 and arg_83_1.time_ < 0 + var_86_10 + arg_86_0 then
				var_86_8.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_86_11 = 0
			local var_86_12 = 0.7

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_13 = arg_83_1:GetWordFromCfg(416202019)
				local var_86_14 = arg_83_1:FormatText(var_86_13.content)

				arg_83_1.text_.text = var_86_14

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_16 = 28 <= 0 and var_86_12 or var_86_12 * (utf8.len(var_86_14) / 28)

				if (28 <= 0 and var_86_12 or var_86_12 * (utf8.len(var_86_14) / 28)) > 0 and var_86_12 < var_86_16 then
					arg_83_1.talkMaxDuration = var_86_16

					if var_86_16 + var_86_11 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_16 + var_86_11
					end
				end

				arg_83_1.text_.text = var_86_14
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202019", "story_v_out_416202.awb") ~= 0 then
					local var_86_17 = manager.audio:GetVoiceLength("story_v_out_416202", "416202019", "story_v_out_416202.awb") / 1000

					if var_86_17 + var_86_11 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_17 + var_86_11
					end

					if var_86_13.prefab_name ~= "" and arg_83_1.actors_[var_86_13.prefab_name] ~= nil then
						local var_86_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_13.prefab_name].transform, "story_v_out_416202", "416202019", "story_v_out_416202.awb")

						arg_83_1:RecordAudio("416202019", var_86_18)
						arg_83_1:RecordAudio("416202019", var_86_18)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_416202", "416202019", "story_v_out_416202.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_416202", "416202019", "story_v_out_416202.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_19 = math.max(var_86_12, arg_83_1.talkMaxDuration)

			if var_86_11 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_19 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_11) / var_86_19

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_11 + var_86_19 and arg_83_1.time_ < var_86_11 + var_86_19 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416202020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416202020
		arg_87_1.duration_ = 4.17

		local var_87_0 = {
			zh = 2.966,
			ja = 4.166
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
				arg_87_0:Play416202021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.4

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(416202020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 16 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 16)

				if (16 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 16)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202020", "story_v_out_416202.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_416202", "416202020", "story_v_out_416202.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_416202", "416202020", "story_v_out_416202.awb")

						arg_87_1:RecordAudio("416202020", var_90_6)
						arg_87_1:RecordAudio("416202020", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_416202", "416202020", "story_v_out_416202.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_416202", "416202020", "story_v_out_416202.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play416202021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416202021
		arg_91_1.duration_ = 9.4

		local var_91_0 = {
			zh = 5.233,
			ja = 9.4
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
			arg_91_1.auto_ = false
		end

		function arg_91_1.playNext_(arg_93_0)
			arg_91_1.onStoryFinished_()
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10122"]) and arg_91_1.var_.actorSpriteComps10122 == nil then
				arg_91_1.var_.actorSpriteComps10122 = arg_91_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10122"]) then
				if arg_91_1.var_.actorSpriteComps10122 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								iter_94_1.color = Color.New(Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_0), Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_0), (Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_0)))
							else
								local var_94_1 = Mathf.Lerp(iter_94_1.color.r, 1, (arg_91_1.time_ - 0) / var_94_0)

								iter_94_1.color = Color.New(var_94_1, var_94_1, var_94_1)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10122"]) and arg_91_1.var_.actorSpriteComps10122 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10122 = nil
			end

			local var_94_2 = arg_91_1.actors_["10127"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps10127 == nil then
				arg_91_1.var_.actorSpriteComps10127 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps10127 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								iter_94_5.color = Color.New(Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_3), Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_3), (Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_3)))
							else
								local var_94_4 = Mathf.Lerp(iter_94_5.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_3)

								iter_94_5.color = Color.New(var_94_4, var_94_4, var_94_4)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps10127 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_94_7 then
						iter_94_7.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10127 = nil
			end

			local var_94_5 = 0
			local var_94_6 = 0.625

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(416202021)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 25 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 25)

				if (25 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 25)) > 0 and var_94_6 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416202", "416202021", "story_v_out_416202.awb") ~= 0 then
					local var_94_11 = manager.audio:GetVoiceLength("story_v_out_416202", "416202021", "story_v_out_416202.awb") / 1000

					if var_94_11 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_5
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_416202", "416202021", "story_v_out_416202.awb")

						arg_91_1:RecordAudio("416202021", var_94_12)
						arg_91_1:RecordAudio("416202021", var_94_12)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_416202", "416202021", "story_v_out_416202.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_416202", "416202021", "story_v_out_416202.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_13 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_13 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_13

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_13 and arg_91_1.time_ < var_94_5 + var_94_13 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13i",
		"TextureConfig/Background/SS1609"
	},
	voices = {
		"story_v_out_416202.awb"
	}
}
