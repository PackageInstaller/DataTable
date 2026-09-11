return {
	Play416041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416041001
		arg_1_1.duration_ = 7.77

		local var_1_0 = {
			zh = 5.533,
			ja = 7.766
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
				arg_1_0:Play416041002(arg_1_1)
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

			local var_4_9 = "1148"

			if arg_1_1.actors_["1148"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

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

			local var_4_12 = arg_1_1.actors_["1148"]

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1148 == nil then
				arg_1_1.var_.actorSpriteComps1148 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.125

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1148 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_1_1.time_ >= 1.66666666666667 + var_4_13 and arg_1_1.time_ < 1.66666666666667 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1148 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1148 = nil
			end

			local var_4_15 = arg_1_1.actors_["1148"].transform

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1148", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_6" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_1_1.time_ - 1.66666666666667) / var_4_17)
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_17 and arg_1_1.time_ < 1.66666666666667 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -429, -180)
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1148 = var_4_18.alpha
					arg_1_1.var_.characterEffect1148 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1148 = 0
			end

			local var_4_19 = 0.857666666666667

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_19 then
				if arg_1_1.var_.characterEffect1148 then
					arg_1_1.var_.characterEffect1148.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1148, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_19 and arg_1_1.time_ < 1.66666666666667 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1148 then
				arg_1_1.var_.characterEffect1148.alpha = 1
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

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
			local var_4_27 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(416041001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 16 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 16)

				if (16 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 16)) > 0 and var_4_27 < var_4_32 then
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

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041001", "story_v_out_416041.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_416041", "416041001", "story_v_out_416041.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_416041", "416041001", "story_v_out_416041.awb")

						arg_1_1:RecordAudio("416041001", var_4_34)
						arg_1_1:RecordAudio("416041001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416041", "416041001", "story_v_out_416041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416041", "416041001", "story_v_out_416041.awb")
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
				actorName = "1148",
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
	Play416041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1148"]) and arg_9_1.var_.actorSpriteComps1148 == nil then
				arg_9_1.var_.actorSpriteComps1148 = arg_9_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.125

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1148"]) then
				if arg_9_1.var_.actorSpriteComps1148 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1148"]) and arg_9_1.var_.actorSpriteComps1148 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1148 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 1.2

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

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416041002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 48 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 48)

				if (48 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 48)) > 0 and var_12_3 < var_12_6 then
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
	Play416041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416041003
		arg_13_1.duration_ = 5.03

		local var_13_0 = {
			zh = 3.133,
			ja = 5.033
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
				arg_13_0:Play416041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1148"]) and arg_13_1.var_.actorSpriteComps1148 == nil then
				arg_13_1.var_.actorSpriteComps1148 = arg_13_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.125

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1148"]) then
				if arg_13_1.var_.actorSpriteComps1148 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1148"]) and arg_13_1.var_.actorSpriteComps1148 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1148 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(416041003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 12 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 12)

				if (12 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 12)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041003", "story_v_out_416041.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041003", "story_v_out_416041.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_416041", "416041003", "story_v_out_416041.awb")

						arg_13_1:RecordAudio("416041003", var_16_9)
						arg_13_1:RecordAudio("416041003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416041", "416041003", "story_v_out_416041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416041", "416041003", "story_v_out_416041.awb")
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
	Play416041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416041004
		arg_17_1.duration_ = 5.5

		local var_17_0 = {
			zh = 5.166,
			ja = 5.5
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
				arg_17_0:Play416041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1148"]) and arg_17_1.var_.actorSpriteComps1148 == nil then
				arg_17_1.var_.actorSpriteComps1148 = arg_17_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1148"]) then
				if arg_17_1.var_.actorSpriteComps1148 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1148"]) and arg_17_1.var_.actorSpriteComps1148 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1148 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:GetWordFromCfg(416041004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 17 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 17)

				if (17 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 17)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041004", "story_v_out_416041.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041004", "story_v_out_416041.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_416041", "416041004", "story_v_out_416041.awb")

						arg_17_1:RecordAudio("416041004", var_20_9)
						arg_17_1:RecordAudio("416041004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416041", "416041004", "story_v_out_416041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416041", "416041004", "story_v_out_416041.awb")
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
	Play416041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416041005
		arg_21_1.duration_ = 6.87

		local var_21_0 = {
			zh = 4.033,
			ja = 6.866
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
				arg_21_0:Play416041006(arg_21_1)
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

			local var_24_2 = 0
			local var_24_3 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
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

				local var_24_4 = arg_21_1:GetWordFromCfg(416041005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 20 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 20)

				if (20 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 20)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041005", "story_v_out_416041.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041005", "story_v_out_416041.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_416041", "416041005", "story_v_out_416041.awb")

						arg_21_1:RecordAudio("416041005", var_24_9)
						arg_21_1:RecordAudio("416041005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416041", "416041005", "story_v_out_416041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416041", "416041005", "story_v_out_416041.awb")
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
	Play416041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416041006
		arg_25_1.duration_ = 4.6

		local var_25_0 = {
			zh = 4.6,
			ja = 4.2
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
				arg_25_0:Play416041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.575

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

				local var_28_1 = arg_25_1:GetWordFromCfg(416041006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 23 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 23)

				if (23 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 23)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041006", "story_v_out_416041.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041006", "story_v_out_416041.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_416041", "416041006", "story_v_out_416041.awb")

						arg_25_1:RecordAudio("416041006", var_28_6)
						arg_25_1:RecordAudio("416041006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416041", "416041006", "story_v_out_416041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416041", "416041006", "story_v_out_416041.awb")
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
	Play416041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416041007
		arg_29_1.duration_ = 4.1

		local var_29_0 = {
			zh = 3.1,
			ja = 4.1
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
				arg_29_0:Play416041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1148"]) and arg_29_1.var_.actorSpriteComps1148 == nil then
				arg_29_1.var_.actorSpriteComps1148 = arg_29_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1148"]) then
				if arg_29_1.var_.actorSpriteComps1148 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1148"]) and arg_29_1.var_.actorSpriteComps1148 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1148 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_4 = arg_29_1:GetWordFromCfg(416041007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 10 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 10)

				if (10 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 10)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041007", "story_v_out_416041.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041007", "story_v_out_416041.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_416041", "416041007", "story_v_out_416041.awb")

						arg_29_1:RecordAudio("416041007", var_32_9)
						arg_29_1:RecordAudio("416041007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416041", "416041007", "story_v_out_416041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416041", "416041007", "story_v_out_416041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416041008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1148 = arg_33_1.actors_["1148"].transform.localPosition
				arg_33_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1148", 7)

				for iter_36_0 = 0, arg_33_1.actors_["1148"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1148"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_2 = 0
			local var_36_3 = 1.125

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

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(416041008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 45 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 45)

				if (45 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 45)) > 0 and var_36_3 < var_36_6 then
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
	Play416041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416041009
		arg_37_1.duration_ = 8.93

		local var_37_0 = {
			zh = 7.6,
			ja = 8.933
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
				arg_37_0:Play416041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.I14f == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I14f")
				var_40_0.name = "I14f"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.I14f = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.I14f

				arg_37_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "I14f" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 4

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_4 + 0.3 and arg_37_1.time_ < var_40_4 + 0.3 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_5 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_6 = 2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_5) / var_40_6)
				arg_37_1.mask_.color = var_40_7
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 then
				local var_40_8 = Color.New(0, 0, 0)

				var_40_8.a = 1
				arg_37_1.mask_.color = var_40_8
			end

			local var_40_9 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_10 = 2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 then
				local var_40_11 = Color.New(0, 0, 0)

				var_40_11.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_9) / var_40_10)
				arg_37_1.mask_.color = var_40_11
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 then
				local var_40_12 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_12.a = 0
				arg_37_1.mask_.color = var_40_12
			end

			local var_40_13 = arg_37_1.actors_["1148"]

			if 3.44233333333333 < arg_37_1.time_ and arg_37_1.time_ <= 3.44233333333333 + arg_40_0 and not isNil(var_40_13) and arg_37_1.var_.actorSpriteComps1148 == nil then
				arg_37_1.var_.actorSpriteComps1148 = var_40_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_14 = 0.125

			if 3.44233333333333 <= arg_37_1.time_ and arg_37_1.time_ < 3.44233333333333 + var_40_14 and not isNil(var_40_13) then
				if arg_37_1.var_.actorSpriteComps1148 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								iter_40_3.color = Color.New(Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 3.44233333333333) / var_40_14), Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 3.44233333333333) / var_40_14), (Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 3.44233333333333) / var_40_14)))
							else
								local var_40_15 = Mathf.Lerp(iter_40_3.color.r, 1, (arg_37_1.time_ - 3.44233333333333) / var_40_14)

								iter_40_3.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 3.44233333333333 + var_40_14 and arg_37_1.time_ < 3.44233333333333 + var_40_14 + arg_40_0 and not isNil(var_40_13) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_16 = arg_37_1.actors_["1148"].transform

			if 3.44233333333333 < arg_37_1.time_ and arg_37_1.time_ <= 3.44233333333333 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = var_40_16.localPosition
				var_40_16.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 3)

				for iter_40_6 = 0, var_40_16.childCount - 1 do
					local var_40_17 = var_40_16:GetChild(iter_40_6)

					if var_40_17.name == "split_1_1" or not string.find(var_40_17.name, "split") then
						var_40_17.gameObject:SetActive(true)
					else
						var_40_17.gameObject:SetActive(false)
					end
				end
			end

			local var_40_18 = 0.001

			if 3.44233333333333 <= arg_37_1.time_ and arg_37_1.time_ < 3.44233333333333 + var_40_18 then
				var_40_16.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_37_1.time_ - 3.44233333333333) / var_40_18)
			end

			if arg_37_1.time_ >= 3.44233333333333 + var_40_18 and arg_37_1.time_ < 3.44233333333333 + var_40_18 + arg_40_0 then
				var_40_16.localPosition = Vector3.New(0, -429, -180)
			end

			if 3.44233333333333 < arg_37_1.time_ and arg_37_1.time_ <= 3.44233333333333 + arg_40_0 then
				local var_40_19 = arg_37_1.actors_["1148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_19 then
					arg_37_1.var_.alphaOldValue1148 = var_40_19.alpha
					arg_37_1.var_.characterEffect1148 = var_40_19
				end

				arg_37_1.var_.alphaOldValue1148 = 0
			end

			local var_40_20 = 0.857666666666667

			if 3.44233333333333 <= arg_37_1.time_ and arg_37_1.time_ < 3.44233333333333 + var_40_20 then
				if arg_37_1.var_.characterEffect1148 then
					arg_37_1.var_.characterEffect1148.alpha = Mathf.Lerp(arg_37_1.var_.alphaOldValue1148, 1, (arg_37_1.time_ - 3.44233333333333) / var_40_20)
				end
			end

			if arg_37_1.time_ >= 3.44233333333333 + var_40_20 and arg_37_1.time_ < 3.44233333333333 + var_40_20 + arg_40_0 and arg_37_1.var_.characterEffect1148 then
				arg_37_1.var_.characterEffect1148.alpha = 1
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_40_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_23 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_23

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_23
						arg_37_1.bgmTxt2_.text = var_40_23
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.7 < arg_37_1.time_ and arg_37_1.time_ <= 1.7 + arg_40_0 then
				arg_37_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_40_26 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if "" ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_26 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_26

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_26
						arg_37_1.bgmTxt2_.text = var_40_26
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_27 = 4
			local var_40_28 = 0.3

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_27 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_29 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_29:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_37_1.dialogCg_.alpha = arg_43_0
				end))
				var_40_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_30 = arg_37_1:GetWordFromCfg(416041009)
				local var_40_31 = arg_37_1:FormatText(var_40_30.content)

				arg_37_1.text_.text = var_40_31

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_33 = 12 <= 0 and var_40_28 or var_40_28 * (utf8.len(var_40_31) / 12)

				if (12 <= 0 and var_40_28 or var_40_28 * (utf8.len(var_40_31) / 12)) > 0 and var_40_28 < var_40_33 then
					arg_37_1.talkMaxDuration = var_40_33
					var_40_27 = var_40_27 + 0.3

					if var_40_33 + var_40_27 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_33 + var_40_27
					end
				end

				arg_37_1.text_.text = var_40_31
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041009", "story_v_out_416041.awb") ~= 0 then
					local var_40_34 = manager.audio:GetVoiceLength("story_v_out_416041", "416041009", "story_v_out_416041.awb") / 1000

					if var_40_34 + var_40_27 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_34 + var_40_27
					end

					if var_40_30.prefab_name ~= "" and arg_37_1.actors_[var_40_30.prefab_name] ~= nil then
						local var_40_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_30.prefab_name].transform, "story_v_out_416041", "416041009", "story_v_out_416041.awb")

						arg_37_1:RecordAudio("416041009", var_40_35)
						arg_37_1:RecordAudio("416041009", var_40_35)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416041", "416041009", "story_v_out_416041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416041", "416041009", "story_v_out_416041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_36 = var_40_27 + 0.3
			local var_40_37 = math.max(var_40_28, arg_37_1.talkMaxDuration)

			if var_40_27 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_36 + var_40_37 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_36) / var_40_37

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_36 + var_40_37 and arg_37_1.time_ < var_40_36 + var_40_37 + arg_40_0 then
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
				startTime = 3.44233333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play416041010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416041010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416041011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1148 = arg_45_1.actors_["1148"].transform.localPosition
				arg_45_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1148", 7)

				for iter_48_0 = 0, arg_45_1.actors_["1148"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1148"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_2 = 0
			local var_48_3 = 1.425

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

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(416041010).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 57 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 57)

				if (57 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 57)) > 0 and var_48_3 < var_48_6 then
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
	Play416041011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416041011
		arg_49_1.duration_ = 3.53

		local var_49_0 = {
			zh = 3.533,
			ja = 2.9
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
				arg_49_0:Play416041012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.325

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(416041011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 13 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 13)

				if (13 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 13)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041011", "story_v_out_416041.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041011", "story_v_out_416041.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_416041", "416041011", "story_v_out_416041.awb")

						arg_49_1:RecordAudio("416041011", var_52_6)
						arg_49_1:RecordAudio("416041011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416041", "416041011", "story_v_out_416041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416041", "416041011", "story_v_out_416041.awb")
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
	Play416041012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416041012
		arg_53_1.duration_ = 4.27

		local var_53_0 = {
			zh = 4.266,
			ja = 2.7
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
				arg_53_0:Play416041013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1148 = arg_53_1.actors_["1148"].transform.localPosition
				arg_53_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1148", 3)

				for iter_56_0 = 0, arg_53_1.actors_["1148"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1148"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_6" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_56_2 = arg_53_1.actors_["1148"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1148 == nil then
				arg_53_1.var_.actorSpriteComps1148 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.125

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps1148 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1148 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1148 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
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

				local var_56_7 = arg_53_1:GetWordFromCfg(416041012)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 18 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 18)

				if (18 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 18)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041012", "story_v_out_416041.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041012", "story_v_out_416041.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_416041", "416041012", "story_v_out_416041.awb")

						arg_53_1:RecordAudio("416041012", var_56_12)
						arg_53_1:RecordAudio("416041012", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416041", "416041012", "story_v_out_416041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416041", "416041012", "story_v_out_416041.awb")
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
	Play416041013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416041013
		arg_57_1.duration_ = 5.3

		local var_57_0 = {
			zh = 5.3,
			ja = 4.666
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
				arg_57_0:Play416041014(arg_57_1)
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

				local var_60_1 = arg_57_1:GetWordFromCfg(416041013)
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

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041013", "story_v_out_416041.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041013", "story_v_out_416041.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_416041", "416041013", "story_v_out_416041.awb")

						arg_57_1:RecordAudio("416041013", var_60_6)
						arg_57_1:RecordAudio("416041013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416041", "416041013", "story_v_out_416041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416041", "416041013", "story_v_out_416041.awb")
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
	Play416041014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416041014
		arg_61_1.duration_ = 2.9

		local var_61_0 = {
			zh = 2.9,
			ja = 2.6
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
				arg_61_0:Play416041015(arg_61_1)
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
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1148"]) and arg_61_1.var_.actorSpriteComps1148 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1148 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:GetWordFromCfg(416041014)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 6 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 6)

				if (6 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 6)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041014", "story_v_out_416041.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041014", "story_v_out_416041.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_416041", "416041014", "story_v_out_416041.awb")

						arg_61_1:RecordAudio("416041014", var_64_9)
						arg_61_1:RecordAudio("416041014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416041", "416041014", "story_v_out_416041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416041", "416041014", "story_v_out_416041.awb")
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
	Play416041015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416041015
		arg_65_1.duration_ = 6.6

		local var_65_0 = {
			zh = 6.333,
			ja = 6.6
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
				arg_65_0:Play416041016(arg_65_1)
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
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1148"]) and arg_65_1.var_.actorSpriteComps1148 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1148 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(416041015)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 28 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 28)

				if (28 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 28)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041015", "story_v_out_416041.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041015", "story_v_out_416041.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_416041", "416041015", "story_v_out_416041.awb")

						arg_65_1:RecordAudio("416041015", var_68_9)
						arg_65_1:RecordAudio("416041015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416041", "416041015", "story_v_out_416041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416041", "416041015", "story_v_out_416041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play416041016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416041016
		arg_69_1.duration_ = 9.27

		local var_69_0 = {
			zh = 4.733,
			ja = 9.266
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
				arg_69_0:Play416041017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1148 = arg_69_1.actors_["1148"].transform.localPosition
				arg_69_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1148", 3)

				for iter_72_0 = 0, arg_69_1.actors_["1148"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1148"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_3" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_72_2 = 0
			local var_72_3 = 0.55

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
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

				local var_72_4 = arg_69_1:GetWordFromCfg(416041016)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 22 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 22)

				if (22 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 22)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041016", "story_v_out_416041.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041016", "story_v_out_416041.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_416041", "416041016", "story_v_out_416041.awb")

						arg_69_1:RecordAudio("416041016", var_72_9)
						arg_69_1:RecordAudio("416041016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416041", "416041016", "story_v_out_416041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416041", "416041016", "story_v_out_416041.awb")
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

		arg_69_1.nodeConfigList_ = {
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
	Play416041017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416041017
		arg_73_1.duration_ = 3.2

		local var_73_0 = {
			zh = 2.633,
			ja = 3.2
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
				arg_73_0:Play416041018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1148 = arg_73_1.actors_["1148"].transform.localPosition
				arg_73_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1148", 7)

				for iter_76_0 = 0, arg_73_1.actors_["1148"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1148"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_2 = 0
			local var_76_3 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:GetWordFromCfg(416041017)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)

				if (12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041017", "story_v_out_416041.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041017", "story_v_out_416041.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_416041", "416041017", "story_v_out_416041.awb")

						arg_73_1:RecordAudio("416041017", var_76_9)
						arg_73_1:RecordAudio("416041017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416041", "416041017", "story_v_out_416041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416041", "416041017", "story_v_out_416041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play416041018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416041018
		arg_77_1.duration_ = 4

		local var_77_0 = {
			zh = 4,
			ja = 3.833
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
				arg_77_0:Play416041019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1148 = arg_77_1.actors_["1148"].transform.localPosition
				arg_77_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1148", 3)

				for iter_80_0 = 0, arg_77_1.actors_["1148"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["1148"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_6" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_80_2 = arg_77_1.actors_["1148"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1148 == nil then
				arg_77_1.var_.actorSpriteComps1148 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.125

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1148 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1148 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1148 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
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

				local var_80_7 = arg_77_1:GetWordFromCfg(416041018)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 16 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 16)

				if (16 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 16)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041018", "story_v_out_416041.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041018", "story_v_out_416041.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_416041", "416041018", "story_v_out_416041.awb")

						arg_77_1:RecordAudio("416041018", var_80_12)
						arg_77_1:RecordAudio("416041018", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416041", "416041018", "story_v_out_416041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416041", "416041018", "story_v_out_416041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
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
	Play416041019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416041019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play416041020(arg_81_1)
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

			local var_84_2 = 0
			local var_84_3 = 1.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(416041019).content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 55 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 55)

				if (55 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 55)) > 0 and var_84_3 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_7 and arg_81_1.time_ < var_84_2 + var_84_7 + arg_84_0 then
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
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play416041020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416041020
		arg_85_1.duration_ = 4.8

		local var_85_0 = {
			zh = 4.233,
			ja = 4.8
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
				arg_85_0:Play416041021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1148"]) and arg_85_1.var_.actorSpriteComps1148 == nil then
				arg_85_1.var_.actorSpriteComps1148 = arg_85_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1148"]) then
				if arg_85_1.var_.actorSpriteComps1148 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1148"]) and arg_85_1.var_.actorSpriteComps1148 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1148 = nil
			end

			local var_88_2 = arg_85_1.actors_["1148"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1148", 3)

				for iter_88_4 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_4)

					if var_88_3.name == "split_6" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_85_1.time_ - 0) / var_88_4)
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_88_5 = 0
			local var_88_6 = 0.475

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

				local var_88_7 = arg_85_1:GetWordFromCfg(416041020)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 19 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 19)

				if (19 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 19)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041020", "story_v_out_416041.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041020", "story_v_out_416041.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416041", "416041020", "story_v_out_416041.awb")

						arg_85_1:RecordAudio("416041020", var_88_12)
						arg_85_1:RecordAudio("416041020", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416041", "416041020", "story_v_out_416041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416041", "416041020", "story_v_out_416041.awb")
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
	Play416041021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416041021
		arg_89_1.duration_ = 5.9

		local var_89_0 = {
			zh = 3.4,
			ja = 5.9
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
				arg_89_0:Play416041022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1148"]) and arg_89_1.var_.actorSpriteComps1148 == nil then
				arg_89_1.var_.actorSpriteComps1148 = arg_89_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1148"]) then
				if arg_89_1.var_.actorSpriteComps1148 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1148"]) and arg_89_1.var_.actorSpriteComps1148 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps1148 = nil
			end

			local var_92_2 = 0
			local var_92_3 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_4 = arg_89_1:GetWordFromCfg(416041021)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 18 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 18)

				if (18 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 18)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041021", "story_v_out_416041.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041021", "story_v_out_416041.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_out_416041", "416041021", "story_v_out_416041.awb")

						arg_89_1:RecordAudio("416041021", var_92_9)
						arg_89_1:RecordAudio("416041021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416041", "416041021", "story_v_out_416041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416041", "416041021", "story_v_out_416041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416041022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416041022
		arg_93_1.duration_ = 6.4

		local var_93_0 = {
			zh = 5,
			ja = 6.4
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
				arg_93_0:Play416041023(arg_93_1)
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

			local var_96_2 = arg_93_1.actors_["1148"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1148 == nil then
				arg_93_1.var_.actorSpriteComps1148 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.125

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1148 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1148 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1148 = nil
			end

			local var_96_5 = 0
			local var_96_6 = 0.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
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

				local var_96_7 = arg_93_1:GetWordFromCfg(416041022)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 17 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 17)

				if (17 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 17)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041022", "story_v_out_416041.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041022", "story_v_out_416041.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_416041", "416041022", "story_v_out_416041.awb")

						arg_93_1:RecordAudio("416041022", var_96_12)
						arg_93_1:RecordAudio("416041022", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416041", "416041022", "story_v_out_416041.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416041", "416041022", "story_v_out_416041.awb")
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
	Play416041023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416041023
		arg_97_1.duration_ = 4.83

		local var_97_0 = {
			zh = 3.4,
			ja = 4.833
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
				arg_97_0:Play416041024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.375

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(416041023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 15 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 15)

				if (15 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 15)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041023", "story_v_out_416041.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041023", "story_v_out_416041.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_416041", "416041023", "story_v_out_416041.awb")

						arg_97_1:RecordAudio("416041023", var_100_6)
						arg_97_1:RecordAudio("416041023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416041", "416041023", "story_v_out_416041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416041", "416041023", "story_v_out_416041.awb")
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
	Play416041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416041024
		arg_101_1.duration_ = 2.6

		local var_101_0 = {
			zh = 2.6,
			ja = 2.5
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
				arg_101_0:Play416041025(arg_101_1)
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
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1148"]) and arg_101_1.var_.actorSpriteComps1148 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps1148 = nil
			end

			local var_104_2 = 0
			local var_104_3 = 0.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_4 = arg_101_1:GetWordFromCfg(416041024)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 9 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 9)

				if (9 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 9)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041024", "story_v_out_416041.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041024", "story_v_out_416041.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_416041", "416041024", "story_v_out_416041.awb")

						arg_101_1:RecordAudio("416041024", var_104_9)
						arg_101_1:RecordAudio("416041024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416041", "416041024", "story_v_out_416041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416041", "416041024", "story_v_out_416041.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416041025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416041025
		arg_105_1.duration_ = 5.97

		local var_105_0 = {
			zh = 3.6,
			ja = 5.966
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
				arg_105_0:Play416041026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1148"]) and arg_105_1.var_.actorSpriteComps1148 == nil then
				arg_105_1.var_.actorSpriteComps1148 = arg_105_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.125

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1148"]) then
				if arg_105_1.var_.actorSpriteComps1148 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 1, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1148"]) and arg_105_1.var_.actorSpriteComps1148 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps1148 = nil
			end

			local var_108_2 = arg_105_1.actors_["1148"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1148 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1148", 3)

				for iter_108_4 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_4)

					if var_108_3.name == "split_1_1" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_108_5 = 0
			local var_108_6 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
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

				local var_108_7 = arg_105_1:GetWordFromCfg(416041025)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 16 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 16)

				if (16 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 16)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041025", "story_v_out_416041.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041025", "story_v_out_416041.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_416041", "416041025", "story_v_out_416041.awb")

						arg_105_1:RecordAudio("416041025", var_108_12)
						arg_105_1:RecordAudio("416041025", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416041", "416041025", "story_v_out_416041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416041", "416041025", "story_v_out_416041.awb")
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
				actorName = "1148",
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
	Play416041026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416041026
		arg_109_1.duration_ = 3.8

		local var_109_0 = {
			zh = 3.7,
			ja = 3.8
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
				arg_109_0:Play416041027(arg_109_1)
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
			local var_112_3 = 0.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_4 = arg_109_1:GetWordFromCfg(416041026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 10 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 10)

				if (10 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 10)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041026", "story_v_out_416041.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041026", "story_v_out_416041.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_416041", "416041026", "story_v_out_416041.awb")

						arg_109_1:RecordAudio("416041026", var_112_9)
						arg_109_1:RecordAudio("416041026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416041", "416041026", "story_v_out_416041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416041", "416041026", "story_v_out_416041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play416041027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416041027
		arg_113_1.duration_ = 5.2

		local var_113_0 = {
			zh = 4.333,
			ja = 5.2
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
				arg_113_0:Play416041028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1148"]) and arg_113_1.var_.actorSpriteComps1148 == nil then
				arg_113_1.var_.actorSpriteComps1148 = arg_113_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.125

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1148"]) then
				if arg_113_1.var_.actorSpriteComps1148 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1148"]) and arg_113_1.var_.actorSpriteComps1148 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps1148 = nil
			end

			local var_116_2 = 0
			local var_116_3 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
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

				local var_116_4 = arg_113_1:GetWordFromCfg(416041027)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 23 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 23)

				if (23 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 23)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041027", "story_v_out_416041.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041027", "story_v_out_416041.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_out_416041", "416041027", "story_v_out_416041.awb")

						arg_113_1:RecordAudio("416041027", var_116_9)
						arg_113_1:RecordAudio("416041027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416041", "416041027", "story_v_out_416041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416041", "416041027", "story_v_out_416041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play416041028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416041028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play416041029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1148 = arg_117_1.actors_["1148"].transform.localPosition
				arg_117_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1148", 7)

				for iter_120_0 = 0, arg_117_1.actors_["1148"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["1148"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_2 = 0
			local var_120_3 = 1.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(416041028).content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 56 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_4) / 56)

				if (56 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_4) / 56)) > 0 and var_120_3 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_7 and arg_117_1.time_ < var_120_2 + var_120_7 + arg_120_0 then
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
	Play416041029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416041029
		arg_121_1.duration_ = 4.53

		local var_121_0 = {
			zh = 1.6,
			ja = 4.533
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
				arg_121_0:Play416041030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_1")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(416041029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 4 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 4)

				if (4 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 4)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041029", "story_v_out_416041.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041029", "story_v_out_416041.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_416041", "416041029", "story_v_out_416041.awb")

						arg_121_1:RecordAudio("416041029", var_124_6)
						arg_121_1:RecordAudio("416041029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416041", "416041029", "story_v_out_416041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416041", "416041029", "story_v_out_416041.awb")
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
	Play416041030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416041030
		arg_125_1.duration_ = 5.2

		local var_125_0 = {
			zh = 2.433,
			ja = 5.2
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
				arg_125_0:Play416041031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.125

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_1")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(416041030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 5 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 5)

				if (5 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 5)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041030", "story_v_out_416041.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041030", "story_v_out_416041.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_416041", "416041030", "story_v_out_416041.awb")

						arg_125_1:RecordAudio("416041030", var_128_6)
						arg_125_1:RecordAudio("416041030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416041", "416041030", "story_v_out_416041.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416041", "416041030", "story_v_out_416041.awb")
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
	Play416041031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416041031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play416041032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_clap02", "")
			end

			local var_132_1 = 0
			local var_132_2 = 1.3

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(416041031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 52 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 52)

				if (52 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 52)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416041032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416041032
		arg_133_1.duration_ = 7.03

		local var_133_0 = {
			zh = 5.466,
			ja = 7.033
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
				arg_133_0:Play416041033(arg_133_1)
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
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 1, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1148"]) and arg_133_1.var_.actorSpriteComps1148 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps1148 = nil
			end

			local var_136_2 = arg_133_1.actors_["1148"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1148 = var_136_2.localPosition
				var_136_2.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1148", 3)

				for iter_136_4 = 0, var_136_2.childCount - 1 do
					local var_136_3 = var_136_2:GetChild(iter_136_4)

					if var_136_3.name == "split_2" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				var_136_2.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_133_1.time_ - 0) / var_136_4)
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				var_136_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_136_5 = 0
			local var_136_6 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(416041032)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 14 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 14)

				if (14 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 14)) > 0 and var_136_6 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041032", "story_v_out_416041.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041032", "story_v_out_416041.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_416041", "416041032", "story_v_out_416041.awb")

						arg_133_1:RecordAudio("416041032", var_136_12)
						arg_133_1:RecordAudio("416041032", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416041", "416041032", "story_v_out_416041.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416041", "416041032", "story_v_out_416041.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_13 and arg_133_1.time_ < var_136_5 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play416041033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416041033
		arg_137_1.duration_ = 3.2

		local var_137_0 = {
			zh = 2.666,
			ja = 3.2
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
				arg_137_0:Play416041034(arg_137_1)
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
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1148"]) and arg_137_1.var_.actorSpriteComps1148 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps1148 = nil
			end

			local var_140_2 = 0
			local var_140_3 = 0.3

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_4 = arg_137_1:GetWordFromCfg(416041033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 12 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 12)

				if (12 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 12)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041033", "story_v_out_416041.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041033", "story_v_out_416041.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_416041", "416041033", "story_v_out_416041.awb")

						arg_137_1:RecordAudio("416041033", var_140_9)
						arg_137_1:RecordAudio("416041033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416041", "416041033", "story_v_out_416041.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416041", "416041033", "story_v_out_416041.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play416041034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416041034
		arg_141_1.duration_ = 8.27

		local var_141_0 = {
			zh = 4.333,
			ja = 8.266
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
				arg_141_0:Play416041035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148 = arg_141_1.actors_["1148"].transform.localPosition
				arg_141_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1148", 3)

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
				arg_141_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_144_2 = arg_141_1.actors_["1148"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1148 == nil then
				arg_141_1.var_.actorSpriteComps1148 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps1148 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1148 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps1148 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.525

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(416041034)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 21 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 21)

				if (21 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 21)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041034", "story_v_out_416041.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041034", "story_v_out_416041.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_416041", "416041034", "story_v_out_416041.awb")

						arg_141_1:RecordAudio("416041034", var_144_12)
						arg_141_1:RecordAudio("416041034", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416041", "416041034", "story_v_out_416041.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416041", "416041034", "story_v_out_416041.awb")
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
	Play416041035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416041035
		arg_145_1.duration_ = 6.9

		local var_145_0 = {
			zh = 4.766,
			ja = 6.9
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
				arg_145_0:Play416041036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.475

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
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

				local var_148_1 = arg_145_1:GetWordFromCfg(416041035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 19 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 19)

				if (19 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 19)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041035", "story_v_out_416041.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041035", "story_v_out_416041.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_416041", "416041035", "story_v_out_416041.awb")

						arg_145_1:RecordAudio("416041035", var_148_6)
						arg_145_1:RecordAudio("416041035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416041", "416041035", "story_v_out_416041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416041", "416041035", "story_v_out_416041.awb")
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
	Play416041036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416041036
		arg_149_1.duration_ = 6.39

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play416041037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_9000

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1148 = arg_149_1.actors_["1148"].transform.localPosition
				arg_149_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1148", 7)

				for iter_152_0 = 0, arg_149_1.actors_["1148"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["1148"].transform:GetChild(iter_152_0)

					if var_152_0.name == "" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_2 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = false

				arg_149_1:SetGaussion(false)
			end

			local var_152_3 = 0.8

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_3 then
				local var_152_4 = Color.New(0.2735849, 0.2735849, 0.2735849)

				var_152_4.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_2) / var_152_3)
				arg_149_1.mask_.color = var_152_4
			end

			if arg_149_1.time_ >= var_152_2 + var_152_3 and arg_149_1.time_ < var_152_2 + var_152_3 + arg_152_0 then
				local var_152_5 = Color.New(0.2735849, 0.2735849, 0.2735849)

				arg_149_1.mask_.enabled = false
				var_152_5.a = 0
				arg_149_1.mask_.color = var_152_5
			end

			if 0.566666666666667 < arg_149_1.time_ and arg_149_1.time_ <= 0.566666666666667 + arg_152_0 then
				local var_152_6 = arg_149_1.var_.effect77

				if not arg_149_1.var_.effect77 then
					var_152_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_152_6.name = "77"
					arg_149_1.var_.effect77 = var_152_6
				else
					var_152_6.transform:SetParent(var_152_9000)
				end

				var_152_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_152_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.16666666666667 < arg_149_1.time_ and arg_149_1.time_ <= 2.16666666666667 + arg_152_0 then
				if arg_149_1.var_.effect77 then
					Object.Destroy(arg_149_1.var_.effect77)

					arg_149_1.var_.effect77 = nil
				end
			end

			if 0.633333333333333 < arg_149_1.time_ and arg_149_1.time_ <= 0.633333333333333 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_10 = 1.39166666666667
			local var_152_11 = 1.775

			if 1.39166666666667 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_12 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_12:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(416041036).content)

				arg_149_1.text_.text = var_152_13

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 71 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 71)

				if (71 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 71)) > 0 and var_152_11 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15
					var_152_10 = var_152_10 + 0.3

					if var_152_15 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_13
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = var_152_10 + 0.3
			local var_152_17 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_16) / var_152_17

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play416041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416041037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play416041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0.3 < arg_155_1.time_ and arg_155_1.time_ <= 0.3 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			local var_158_1 = 0
			local var_158_2 = 1.625

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(416041037).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 65 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 65)

				if (65 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 65)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play416041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416041038
		arg_159_1.duration_ = 4.57

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play416041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1148 = arg_159_1.actors_["1148"].transform.localPosition
				arg_159_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("1148", 3)

				for iter_162_0 = 0, arg_159_1.actors_["1148"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["1148"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_4" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_162_2 = arg_159_1.actors_["1148"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1148 == nil then
				arg_159_1.var_.actorSpriteComps1148 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 0.125

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps1148 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1148 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps1148 = nil
			end

			local var_162_5 = 0
			local var_162_6 = 0.175

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(416041038)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 7 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 7)

				if (7 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 7)) > 0 and var_162_6 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041038", "story_v_out_416041.awb") ~= 0 then
					local var_162_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041038", "story_v_out_416041.awb") / 1000

					if var_162_11 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_5
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_416041", "416041038", "story_v_out_416041.awb")

						arg_159_1:RecordAudio("416041038", var_162_12)
						arg_159_1:RecordAudio("416041038", var_162_12)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_416041", "416041038", "story_v_out_416041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_416041", "416041038", "story_v_out_416041.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_13 and arg_159_1.time_ < var_162_5 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play416041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416041039
		arg_163_1.duration_ = 3.47

		local var_163_0 = {
			zh = 3.466,
			ja = 0.999999999999
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
				arg_163_0:Play416041040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148 = arg_163_1.actors_["1148"].transform.localPosition
				arg_163_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1148", 7)

				for iter_166_0 = 0, arg_163_1.actors_["1148"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1148"].transform:GetChild(iter_166_0)

					if var_166_0.name == "" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_166_2 = 0
			local var_166_3 = 0.125

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1087].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_4 = arg_163_1:GetWordFromCfg(416041039)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 5 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 5)

				if (5 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 5)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041039", "story_v_out_416041.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_416041", "416041039", "story_v_out_416041.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_416041", "416041039", "story_v_out_416041.awb")

						arg_163_1:RecordAudio("416041039", var_166_9)
						arg_163_1:RecordAudio("416041039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416041", "416041039", "story_v_out_416041.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416041", "416041039", "story_v_out_416041.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
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
	Play416041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416041040
		arg_167_1.duration_ = 4.16

		local var_167_0 = {
			zh = 4.158,
			ja = 3.425
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
				arg_167_0:Play416041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_170_0 = 0.725

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				local var_170_1, var_170_2 = math.modf((arg_167_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_170_2 * 0.13, var_170_2 * 0.13, var_170_2 * 0.13) + arg_167_1.var_.shakeOldPos
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				manager.ui.mainCamera.transform.localPosition = arg_167_1.var_.shakeOldPos
			end

			if 0.433333333333333 < arg_167_1.time_ and arg_167_1.time_ <= 0.433333333333333 + arg_170_0 then
				arg_167_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_4 = 0.725
			local var_170_5 = 0.275

			if 0.725 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_6 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_6:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_4")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_7 = arg_167_1:GetWordFromCfg(416041040)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 11 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_8) / 11)

				if (11 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_8) / 11)) > 0 and var_170_5 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10
					var_170_4 = var_170_4 + 0.3

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041040", "story_v_out_416041.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_416041", "416041040", "story_v_out_416041.awb") / 1000

					if var_170_11 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_4
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_416041", "416041040", "story_v_out_416041.awb")

						arg_167_1:RecordAudio("416041040", var_170_12)
						arg_167_1:RecordAudio("416041040", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416041", "416041040", "story_v_out_416041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416041", "416041040", "story_v_out_416041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = var_170_4 + 0.3
			local var_170_14 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 + 0.3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_13 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_13) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_13 + var_170_14 and arg_167_1.time_ < var_170_13 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play416041041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416041041
		arg_173_1.duration_ = 5.63

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416041042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				local var_176_0 = arg_173_1.var_.effect1041

				if not arg_173_1.var_.effect1041 then
					var_176_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_176_0.name = "1041"
					arg_173_1.var_.effect1041 = var_176_0
				else
					var_176_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_176_0.transform.localPosition = Vector3.New(0.04, -0.2, 2)
				var_176_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_176_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_176_3 = var_176_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_176_0, iter_176_1 in ipairs((var_176_3:ToTable())) do
					iter_176_1.transform.localScale = Vector3.New(iter_176_1.transform.localScale.x / var_176_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_176_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_176_1.transform.localScale.y / var_176_2, iter_176_1.transform.localScale.z)
				end
			end

			local var_176_5 = manager.ui.mainCamera.transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.shakeOldPos = var_176_5.localPosition
			end

			local var_176_6 = 0.333333333333333

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 then
				local var_176_7, var_176_8 = math.modf((arg_173_1.time_ - 0) / 0.066)

				var_176_5.localPosition = Vector3.New(var_176_8 * 0.13, var_176_8 * 0.13, var_176_8 * 0.13) + arg_173_1.var_.shakeOldPos
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 then
				var_176_5.localPosition = arg_173_1.var_.shakeOldPos
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			local var_176_10 = 0.633333333333333
			local var_176_11 = 1.175

			if 0.633333333333333 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_12 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(416041041).content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_14 = 47 <= 0 and var_176_11 or var_176_11 * (utf8.len(var_176_12) / 47)

				if (47 <= 0 and var_176_11 or var_176_11 * (utf8.len(var_176_12) / 47)) > 0 and var_176_11 < var_176_14 then
					arg_173_1.talkMaxDuration = var_176_14

					if var_176_14 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_15 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_15 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_15

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_15 and arg_173_1.time_ < var_176_10 + var_176_15 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416041042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416041042
		arg_177_1.duration_ = 4.67

		local var_177_0 = {
			zh = 4.666,
			ja = 3.933
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
				arg_177_0:Play416041043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(416041042)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 19 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 19)

				if (19 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 19)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041042", "story_v_out_416041.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041042", "story_v_out_416041.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_416041", "416041042", "story_v_out_416041.awb")

						arg_177_1:RecordAudio("416041042", var_180_6)
						arg_177_1:RecordAudio("416041042", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416041", "416041042", "story_v_out_416041.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416041", "416041042", "story_v_out_416041.awb")
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
	Play416041043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416041043
		arg_181_1.duration_ = 4

		local var_181_0 = {
			zh = 4,
			ja = 3.733
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
				arg_181_0:Play416041044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.475

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_2")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(416041043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 19 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 19)

				if (19 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 19)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041043", "story_v_out_416041.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041043", "story_v_out_416041.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_416041", "416041043", "story_v_out_416041.awb")

						arg_181_1:RecordAudio("416041043", var_184_6)
						arg_181_1:RecordAudio("416041043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416041", "416041043", "story_v_out_416041.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416041", "416041043", "story_v_out_416041.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play416041044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416041044
		arg_185_1.duration_ = 3.47

		local var_185_0 = {
			zh = 3.466,
			ja = 0.999999999999
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
				arg_185_0:Play416041045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.366666666666667

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1087].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(416041044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 5 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 5)

				if (5 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 5)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041044", "story_v_out_416041.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041044", "story_v_out_416041.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_416041", "416041044", "story_v_out_416041.awb")

						arg_185_1:RecordAudio("416041044", var_188_6)
						arg_185_1:RecordAudio("416041044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416041", "416041044", "story_v_out_416041.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416041", "416041044", "story_v_out_416041.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play416041045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416041045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416041046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0.366666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 0.366666666666667 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			local var_192_1 = 0
			local var_192_2 = 1.7

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(416041045).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 68 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 68)

				if (68 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 68)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play416041046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416041046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play416041047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.675

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(416041046).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 67 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 67)

				if (67 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 67)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play416041047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416041047
		arg_197_1.duration_ = 4.9

		local var_197_0 = {
			zh = 4.9,
			ja = 3.633
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
				arg_197_0:Play416041048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1087].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(416041047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 12 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 12)

				if (12 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 12)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416041", "416041047", "story_v_out_416041.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_416041", "416041047", "story_v_out_416041.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_416041", "416041047", "story_v_out_416041.awb")

						arg_197_1:RecordAudio("416041047", var_200_6)
						arg_197_1:RecordAudio("416041047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416041", "416041047", "story_v_out_416041.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416041", "416041047", "story_v_out_416041.awb")
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
	Play416041048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416041048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
			arg_201_1.auto_ = false
		end

		function arg_201_1.playNext_(arg_203_0)
			arg_201_1.onStoryFinished_()
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.25

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

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(416041048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 50 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 50)

				if (50 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 50)) > 0 and var_204_0 < var_204_3 then
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
	assets = {
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/I14f"
	},
	voices = {
		"story_v_out_416041.awb"
	}
}
