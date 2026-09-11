return {
	Play416061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416061001
		arg_1_1.duration_ = 5.73

		local var_1_0 = {
			zh = 5.73266666666667,
			ja = 4.66666666666667
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
				arg_1_0:Play416061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 2.66666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2.66666666666667 + 0.3 and arg_1_1.time_ < 2.66666666666667 + 0.3 + arg_4_0 then
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

			local var_4_6 = 2.70066666666667

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

			local var_4_12 = arg_1_1.actors_["1148"].transform

			if 2.5 < arg_1_1.time_ and arg_1_1.time_ <= 2.5 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1148", 3)

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

			if 2.5 <= arg_1_1.time_ and arg_1_1.time_ < 2.5 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_1_1.time_ - 2.5) / var_4_14)
			end

			if arg_1_1.time_ >= 2.5 + var_4_14 and arg_1_1.time_ < 2.5 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -429, -180)
			end

			local var_4_15 = arg_1_1.actors_["1148"]

			if 2.5 < arg_1_1.time_ and arg_1_1.time_ <= 2.5 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1148 == nil then
				arg_1_1.var_.actorSpriteComps1148 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.125

			if 2.5 <= arg_1_1.time_ and arg_1_1.time_ < 2.5 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps1148 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2.5) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2.5) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2.5) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 2.5) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2.5 + var_4_16 and arg_1_1.time_ < 2.5 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1148 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1148 = nil
			end

			if 2.5 < arg_1_1.time_ and arg_1_1.time_ <= 2.5 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1148 = var_4_18.alpha
					arg_1_1.var_.characterEffect1148 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1148 = 0
			end

			local var_4_19 = 0.333333333333333

			if 2.5 <= arg_1_1.time_ and arg_1_1.time_ < 2.5 + var_4_19 then
				if arg_1_1.var_.characterEffect1148 then
					arg_1_1.var_.characterEffect1148.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1148, 1, (arg_1_1.time_ - 2.5) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 2.5 + var_4_19 and arg_1_1.time_ < 2.5 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1148 then
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

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
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

			local var_4_26 = 2.66666666666667
			local var_4_27 = 0.3

			if 2.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
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

				local var_4_29 = arg_1_1:GetWordFromCfg(416061001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 12 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 12)

				if (12 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 12)) > 0 and var_4_27 < var_4_32 then
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

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061001", "story_v_out_416061.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_416061", "416061001", "story_v_out_416061.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_416061", "416061001", "story_v_out_416061.awb")

						arg_1_1:RecordAudio("416061001", var_4_34)
						arg_1_1:RecordAudio("416061001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416061", "416061001", "story_v_out_416061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416061", "416061001", "story_v_out_416061.awb")
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
				startTime = 2.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416061002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1148 = arg_9_1.actors_["1148"].transform.localPosition
				arg_9_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1148", 7)

				for iter_12_0 = 0, arg_9_1.actors_["1148"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["1148"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
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

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416061002).content)

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

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play416061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416061003
		arg_13_1.duration_ = 3.83

		local var_13_0 = {
			zh = 3.1,
			ja = 3.833
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
				arg_13_0:Play416061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1086"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "1086"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["1086"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["1086"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1086 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1086", 3)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "split_4" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_16_5 = arg_13_1.actors_["1086"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1086 == nil then
				arg_13_1.var_.actorSpriteComps1086 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.125

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps1086 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1086 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1086 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
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

				local var_16_10 = arg_13_1:GetWordFromCfg(416061003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 15 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 15)

				if (15 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 15)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061003", "story_v_out_416061.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061003", "story_v_out_416061.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_416061", "416061003", "story_v_out_416061.awb")

						arg_13_1:RecordAudio("416061003", var_16_15)
						arg_13_1:RecordAudio("416061003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416061", "416061003", "story_v_out_416061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416061", "416061003", "story_v_out_416061.awb")
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
	Play416061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416061004
		arg_17_1.duration_ = 6.23

		local var_17_0 = {
			zh = 4.566,
			ja = 6.233
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
				arg_17_0:Play416061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1086 = arg_17_1.actors_["1086"].transform.localPosition
				arg_17_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1086", 7)

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
				arg_17_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_2 = arg_17_1.actors_["1148"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1148 == nil then
				arg_17_1.var_.actorSpriteComps1148 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1148 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1148 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1148 = nil
			end

			local var_20_5 = arg_17_1.actors_["1148"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1148 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1148", 3)

				for iter_20_5 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_5)

					if var_20_6.name == "split_3" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -429, -180)
			end

			local var_20_8 = 0
			local var_20_9 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
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

				local var_20_10 = arg_17_1:GetWordFromCfg(416061004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 22 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 22)

				if (22 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 22)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061004", "story_v_out_416061.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061004", "story_v_out_416061.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_416061", "416061004", "story_v_out_416061.awb")

						arg_17_1:RecordAudio("416061004", var_20_15)
						arg_17_1:RecordAudio("416061004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416061", "416061004", "story_v_out_416061.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416061", "416061004", "story_v_out_416061.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
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
	Play416061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416061005
		arg_21_1.duration_ = 6.8

		local var_21_0 = {
			zh = 2.766,
			ja = 6.8
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
				arg_21_0:Play416061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = arg_21_1.actors_["1148"].transform.localPosition
				arg_21_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 7)

				for iter_24_0 = 0, arg_21_1.actors_["1148"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["1148"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_2 = "1028"

			if arg_21_1.actors_["1028"] == nil then
				local var_24_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

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

			local var_24_5 = arg_21_1.actors_["1028"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1028 == nil then
				arg_21_1.var_.actorSpriteComps1028 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps1028 then
					for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_24_4 then
							if arg_21_1.isInRecall_ then
								iter_24_4.color = Color.New(Mathf.Lerp(iter_24_4.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_4.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_4.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_4.color.r, 1, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_4.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1028 then
				for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_24_6 then
						iter_24_6.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1028 = nil
			end

			local var_24_8 = arg_21_1.actors_["1028"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1028 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1028", 3)

				for iter_24_7 = 0, var_24_8.childCount - 1 do
					local var_24_9 = var_24_8:GetChild(iter_24_7)

					if var_24_9.name == "split_2" or not string.find(var_24_9.name, "split") then
						var_24_9.gameObject:SetActive(true)
					else
						var_24_9.gameObject:SetActive(false)
					end
				end
			end

			local var_24_10 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_10 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_21_1.time_ - 0) / var_24_10)
			end

			if arg_21_1.time_ >= 0 + var_24_10 and arg_21_1.time_ < 0 + var_24_10 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_24_11 = 0
			local var_24_12 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(416061005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 11 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 11)

				if (11 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 11)) > 0 and var_24_12 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061005", "story_v_out_416061.awb") ~= 0 then
					local var_24_17 = manager.audio:GetVoiceLength("story_v_out_416061", "416061005", "story_v_out_416061.awb") / 1000

					if var_24_17 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_11
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_416061", "416061005", "story_v_out_416061.awb")

						arg_21_1:RecordAudio("416061005", var_24_18)
						arg_21_1:RecordAudio("416061005", var_24_18)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416061", "416061005", "story_v_out_416061.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416061", "416061005", "story_v_out_416061.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_19 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_19 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_19

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_19 and arg_21_1.time_ < var_24_11 + var_24_19 + arg_24_0 then
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

		arg_21_1:InitPlayNodeList()
	end,
	Play416061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416061006
		arg_25_1.duration_ = 6.67

		local var_25_0 = {
			zh = 5.1,
			ja = 6.666
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
				arg_25_0:Play416061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1148"]) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = arg_25_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.125

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1148"]) then
				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1148"]) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_2 = arg_25_1.actors_["1028"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1028 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1028", 7)

				for iter_28_4 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_4)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_5 = arg_25_1.actors_["1148"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 3)

				for iter_28_5 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_5)

					if var_28_6.name == "split_3" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -429, -180)
			end

			local var_28_8 = 0
			local var_28_9 = 0.6

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
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

				local var_28_10 = arg_25_1:GetWordFromCfg(416061006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 24 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 24)

				if (24 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 24)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061006", "story_v_out_416061.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061006", "story_v_out_416061.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_416061", "416061006", "story_v_out_416061.awb")

						arg_25_1:RecordAudio("416061006", var_28_15)
						arg_25_1:RecordAudio("416061006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416061", "416061006", "story_v_out_416061.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416061", "416061006", "story_v_out_416061.awb")
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

		arg_25_1:InitPlayNodeList()
	end,
	Play416061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416061007
		arg_29_1.duration_ = 3.47

		local var_29_0 = {
			zh = 2.6,
			ja = 3.466
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
				arg_29_0:Play416061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(416061007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 13 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 13)

				if (13 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 13)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061007", "story_v_out_416061.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061007", "story_v_out_416061.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_416061", "416061007", "story_v_out_416061.awb")

						arg_29_1:RecordAudio("416061007", var_32_6)
						arg_29_1:RecordAudio("416061007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416061", "416061007", "story_v_out_416061.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416061", "416061007", "story_v_out_416061.awb")
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
	Play416061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416061008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416061009(arg_33_1)
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
			local var_36_3 = 1.7

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

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(416061008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 68 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 68)

				if (68 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 68)) > 0 and var_36_3 < var_36_6 then
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
	Play416061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416061009
		arg_37_1.duration_ = 3.1

		local var_37_0 = {
			zh = 2.4,
			ja = 3.1
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
				arg_37_0:Play416061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1148"]) and arg_37_1.var_.actorSpriteComps1148 == nil then
				arg_37_1.var_.actorSpriteComps1148 = arg_37_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1148"]) then
				if arg_37_1.var_.actorSpriteComps1148 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1148"]) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_2 = arg_37_1.actors_["1148"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 3)

				for iter_40_4 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_4)

					if var_40_3.name == "split_3" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_40_5 = 0
			local var_40_6 = 0.3

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(416061009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 12 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 12)

				if (12 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 12)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061009", "story_v_out_416061.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_416061", "416061009", "story_v_out_416061.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_416061", "416061009", "story_v_out_416061.awb")

						arg_37_1:RecordAudio("416061009", var_40_12)
						arg_37_1:RecordAudio("416061009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416061", "416061009", "story_v_out_416061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416061", "416061009", "story_v_out_416061.awb")
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
				actorName = "1148",
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
	Play416061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416061010
		arg_41_1.duration_ = 1.37

		local var_41_0 = {
			zh = 1.2,
			ja = 1.366
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
				arg_41_0:Play416061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1148 = arg_41_1.actors_["1148"].transform.localPosition
				arg_41_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1148", 7)

				for iter_44_0 = 0, arg_41_1.actors_["1148"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1148"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_2 = arg_41_1.actors_["1028"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1028 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1028", 2)

				for iter_44_1 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_1)

					if var_44_3.name == "split_7" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_44_5 = arg_41_1.actors_["1086"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1086 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1086", 4)

				for iter_44_2 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_2)

					if var_44_6.name == "split_4" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_44_8 = arg_41_1.actors_["1086"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1086 == nil then
				arg_41_1.var_.actorSpriteComps1086 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.actorSpriteComps1086 then
					for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_44_4 then
							if arg_41_1.isInRecall_ then
								iter_44_4.color = Color.New(Mathf.Lerp(iter_44_4.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_4.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_4.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_4.color.r, 1, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_4.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1086 then
				for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_44_6 then
						iter_44_6.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1086 = nil
			end

			local var_44_11 = arg_41_1.actors_["1028"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.actorSpriteComps1028 == nil then
				arg_41_1.var_.actorSpriteComps1028 = var_44_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_12 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_12 and not isNil(var_44_11) then
				if arg_41_1.var_.actorSpriteComps1028 then
					for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_44_8 then
							if arg_41_1.isInRecall_ then
								iter_44_8.color = Color.New(Mathf.Lerp(iter_44_8.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_12), Mathf.Lerp(iter_44_8.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_12), (Mathf.Lerp(iter_44_8.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_12)))
							else
								local var_44_13 = Mathf.Lerp(iter_44_8.color.r, 1, (arg_41_1.time_ - 0) / var_44_12)

								iter_44_8.color = Color.New(var_44_13, var_44_13, var_44_13)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_12 and arg_41_1.time_ < 0 + var_44_12 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.actorSpriteComps1028 then
				for iter_44_9, iter_44_10 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_44_10 then
						iter_44_10.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1028 = nil
			end

			local var_44_14 = 0
			local var_44_15 = 0.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1089].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(416061010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 4 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 4)

				if (4 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 4)) > 0 and var_44_15 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061010", "story_v_out_416061.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_416061", "416061010", "story_v_out_416061.awb") / 1000

					if var_44_20 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_14
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_416061", "416061010", "story_v_out_416061.awb")

						arg_41_1:RecordAudio("416061010", var_44_21)
						arg_41_1:RecordAudio("416061010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416061", "416061010", "story_v_out_416061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416061", "416061010", "story_v_out_416061.awb")
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

		arg_41_1:InitPlayNodeList()
	end,
	Play416061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416061011
		arg_45_1.duration_ = 9

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 4 < arg_45_1.time_ and arg_45_1.time_ <= 4 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= 4 + 0.3 and arg_45_1.time_ < 4 + 0.3 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_0 = "SS1603"

			if arg_45_1.bgs_.SS1603 == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 then
				local var_48_2 = arg_45_1.bgs_.SS1603

				arg_45_1.bgs_.SS1603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_3 = var_48_2:GetComponent("SpriteRenderer")

				if var_48_3 and var_48_3.sprite then
					local var_48_4 = 2 * (var_48_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_2.transform.localScale = Vector3.New(var_48_4 / var_48_3.sprite.bounds.size.y < var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x and var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x or var_48_4 / var_48_3.sprite.bounds.size.y, var_48_4 / var_48_3.sprite.bounds.size.y < var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x and var_48_4 * manager.ui.mainCameraCom_.aspect / var_48_3.sprite.bounds.size.x or var_48_4 / var_48_3.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "SS1603" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_5 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_6 = 2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 then
				local var_48_7 = Color.New(0, 0, 0)

				var_48_7.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_5) / var_48_6)
				arg_45_1.mask_.color = var_48_7
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 then
				local var_48_8 = Color.New(0, 0, 0)

				var_48_8.a = 1
				arg_45_1.mask_.color = var_48_8
			end

			local var_48_9 = 1.999999999999

			if 1.999999999999 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_10 = 2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 then
				local var_48_11 = Color.New(0, 0, 0)

				var_48_11.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_9) / var_48_10)
				arg_45_1.mask_.color = var_48_11
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 then
				local var_48_12 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_12.a = 0
				arg_45_1.mask_.color = var_48_12
			end

			local var_48_13 = arg_45_1.actors_["1086"].transform

			if 1.966 < arg_45_1.time_ and arg_45_1.time_ <= 1.966 + arg_48_0 then
				arg_45_1.var_.moveOldPos1086 = var_48_13.localPosition
				var_48_13.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1086", 7)

				for iter_48_2 = 0, var_48_13.childCount - 1 do
					local var_48_14 = var_48_13:GetChild(iter_48_2)

					if var_48_14.name == "" or not string.find(var_48_14.name, "split") then
						var_48_14.gameObject:SetActive(true)
					else
						var_48_14.gameObject:SetActive(false)
					end
				end
			end

			local var_48_15 = 0.001

			if 1.966 <= arg_45_1.time_ and arg_45_1.time_ < 1.966 + var_48_15 then
				var_48_13.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 1.966) / var_48_15)
			end

			if arg_45_1.time_ >= 1.966 + var_48_15 and arg_45_1.time_ < 1.966 + var_48_15 + arg_48_0 then
				var_48_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_16 = arg_45_1.actors_["1028"].transform

			if 1.966 < arg_45_1.time_ and arg_45_1.time_ <= 1.966 + arg_48_0 then
				arg_45_1.var_.moveOldPos1028 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1028", 7)

				for iter_48_3 = 0, var_48_16.childCount - 1 do
					local var_48_17 = var_48_16:GetChild(iter_48_3)

					if var_48_17.name == "" or not string.find(var_48_17.name, "split") then
						var_48_17.gameObject:SetActive(true)
					else
						var_48_17.gameObject:SetActive(false)
					end
				end
			end

			local var_48_18 = 0.001

			if 1.966 <= arg_45_1.time_ and arg_45_1.time_ < 1.966 + var_48_18 then
				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 1.966) / var_48_18)
			end

			if arg_45_1.time_ >= 1.966 + var_48_18 and arg_45_1.time_ < 1.966 + var_48_18 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_19 = 4
			local var_48_20 = 1.425

			if 4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_21 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_21:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_22 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(416061011).content)

				arg_45_1.text_.text = var_48_22

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_24 = 57 <= 0 and var_48_20 or var_48_20 * (utf8.len(var_48_22) / 57)

				if (57 <= 0 and var_48_20 or var_48_20 * (utf8.len(var_48_22) / 57)) > 0 and var_48_20 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24
					var_48_19 = var_48_19 + 0.3

					if var_48_24 + var_48_19 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_19
					end
				end

				arg_45_1.text_.text = var_48_22
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = var_48_19 + 0.3
			local var_48_26 = math.max(var_48_20, arg_45_1.talkMaxDuration)

			if var_48_19 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_25 + var_48_26 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_25) / var_48_26

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_25 + var_48_26 and arg_45_1.time_ < var_48_25 + var_48_26 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play416061012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416061012
		arg_51_1.duration_ = 7.9

		local var_51_0 = {
			zh = 5.9,
			ja = 7.9
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play416061013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPosSS1603 = arg_51_1.bgs_.SS1603.transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPosSS1603, Vector3.New(0, 1, 10), (arg_51_1.time_ - 0) / var_54_0)
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.bgs_.SS1603.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_54_1 = arg_51_1.bgs_.SS1603.transform

			if 0.034 < arg_51_1.time_ and arg_51_1.time_ <= 0.034 + arg_54_0 then
				arg_51_1.var_.moveOldPosSS1603 = var_54_1.localPosition
			end

			local var_54_2 = 0.366

			if 0.034 <= arg_51_1.time_ and arg_51_1.time_ < 0.034 + var_54_2 then
				var_54_1.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPosSS1603, Vector3.New(0.2, 1, 9), (arg_51_1.time_ - 0.034) / var_54_2)
			end

			if arg_51_1.time_ >= 0.034 + var_54_2 and arg_51_1.time_ < 0.034 + var_54_2 + arg_54_0 then
				var_54_1.localPosition = Vector3.New(0.2, 1, 9)
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_3 = 0.4
			local var_54_4 = 0.525

			if 0.4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_5 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_5:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(416061012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 21 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_7) / 21)

				if (21 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_7) / 21)) > 0 and var_54_4 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9
					var_54_3 = var_54_3 + 0.3

					if var_54_9 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061012", "story_v_out_416061.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061012", "story_v_out_416061.awb") / 1000

					if var_54_10 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_3
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_416061", "416061012", "story_v_out_416061.awb")

						arg_51_1:RecordAudio("416061012", var_54_11)
						arg_51_1:RecordAudio("416061012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_416061", "416061012", "story_v_out_416061.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_416061", "416061012", "story_v_out_416061.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = var_54_3 + 0.3
			local var_54_13 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_12) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_12 + var_54_13 and arg_51_1.time_ < var_54_12 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.366,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play416061013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416061013
		arg_57_1.duration_ = 2.9

		local var_57_0 = {
			zh = 2.4,
			ja = 2.9
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
				arg_57_0:Play416061014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_9000

			if 0.633333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.633333333333333 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_60_0 = 0.333333333333333

			if 0.633333333333333 <= arg_57_1.time_ and arg_57_1.time_ < 0.633333333333333 + var_60_0 then
				local var_60_1, var_60_2 = math.modf((arg_57_1.time_ - 0.633333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_60_2 * 0.13, var_60_2 * 0.13, var_60_2 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= 0.633333333333333 + var_60_0 and arg_57_1.time_ < 0.633333333333333 + var_60_0 + arg_60_0 then
				manager.ui.mainCamera.transform.localPosition = arg_57_1.var_.shakeOldPos
			end

			if 0.633333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.633333333333333 + arg_60_0 then
				local var_60_3 = arg_57_1.var_.effect61013

				if not arg_57_1.var_.effect61013 then
					var_60_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_60_3.name = "61013"
					arg_57_1.var_.effect61013 = var_60_3
				else
					var_60_3.transform:SetParent(var_60_9000)
				end

				var_60_3.transform.localPosition = Vector3.New(0, -0.25, 0)
				var_60_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.633333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.633333333333333 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_131", "se_story_131__explosion", "")
			end

			local var_60_6 = 0
			local var_60_7 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
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

				local var_60_8 = arg_57_1:GetWordFromCfg(416061013)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 11 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 11)

				if (11 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 11)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061013", "story_v_out_416061.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_416061", "416061013", "story_v_out_416061.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_416061", "416061013", "story_v_out_416061.awb")

						arg_57_1:RecordAudio("416061013", var_60_13)
						arg_57_1:RecordAudio("416061013", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416061", "416061013", "story_v_out_416061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416061", "416061013", "story_v_out_416061.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416061014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416061014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416061015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_9001
			local var_64_9000

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_0 = arg_61_1.var_.effect61014

				if not arg_61_1.var_.effect61014 then
					var_64_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_64_0.name = "61014"
					arg_61_1.var_.effect61014 = var_64_0
				else
					var_64_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_64_0.transform.localPosition = Vector3.New(-0.66, -0.53, 2.12)
				var_64_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_61_1.time_ and arg_61_1.time_ <= 0.2 + arg_64_0 then
				local var_64_2 = arg_61_1.var_.effect61015

				if not arg_61_1.var_.effect61015 then
					var_64_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_64_2.name = "61015"
					arg_61_1.var_.effect61015 = var_64_2
				else
					var_64_2.transform:SetParent(var_64_9001)
				end

				var_64_2.transform.localPosition = Vector3.New(-0.11, -0.01, 3.02)
				var_64_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.4 < arg_61_1.time_ and arg_61_1.time_ <= 0.4 + arg_64_0 then
				local var_64_4 = arg_61_1.var_.effect61016

				if not arg_61_1.var_.effect61016 then
					var_64_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_64_4.name = "61016"
					arg_61_1.var_.effect61016 = var_64_4
				else
					var_64_4.transform:SetParent(var_64_9000)
				end

				var_64_4.transform.localPosition = Vector3.New(0.68, -0.21, 2.54)
				var_64_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_64_6 = manager.ui.mainCamera.transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.shakeOldPos = var_64_6.localPosition
			end

			local var_64_7 = 1

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				local var_64_8, var_64_9 = math.modf((arg_61_1.time_ - 0) / 0.066)

				var_64_6.localPosition = Vector3.New(var_64_9 * 0.13, var_64_9 * 0.13, var_64_9 * 0.13) + arg_61_1.var_.shakeOldPos
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_6.localPosition = arg_61_1.var_.shakeOldPos
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_explosion", "")
			end

			local var_64_11 = 0
			local var_64_12 = 1.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(416061014).content)

				arg_61_1.text_.text = var_64_13

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 44 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_13) / 44)

				if (44 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_13) / 44)) > 0 and var_64_12 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_13
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_16 and arg_61_1.time_ < var_64_11 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416061015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416061015
		arg_65_1.duration_ = 7.37

		local var_65_0 = {
			zh = 5.66633333333333,
			ja = 7.36633333333333
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
				arg_65_0:Play416061016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPosSS1603 = arg_65_1.bgs_.SS1603.transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPosSS1603, Vector3.New(0.2, 1, 9), (arg_65_1.time_ - 0) / var_68_0)
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.bgs_.SS1603.transform.localPosition = Vector3.New(0.2, 1, 9)
			end

			local var_68_1 = arg_65_1.bgs_.SS1603.transform

			if 0.034 < arg_65_1.time_ and arg_65_1.time_ <= 0.034 + arg_68_0 then
				arg_65_1.var_.moveOldPosSS1603 = var_68_1.localPosition
			end

			local var_68_2 = 0.299333333333333

			if 0.034 <= arg_65_1.time_ and arg_65_1.time_ < 0.034 + var_68_2 then
				var_68_1.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPosSS1603, Vector3.New(0, 1, 8), (arg_65_1.time_ - 0.034) / var_68_2)
			end

			if arg_65_1.time_ >= 0.034 + var_68_2 and arg_65_1.time_ < 0.034 + var_68_2 + arg_68_0 then
				var_68_1.localPosition = Vector3.New(0, 1, 8)
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_3 = 0.333333333333333
			local var_68_4 = 0.65

			if 0.333333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_5 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_5:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(416061015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 26 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_7) / 26)

				if (26 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_7) / 26)) > 0 and var_68_4 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9
					var_68_3 = var_68_3 + 0.3

					if var_68_9 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061015", "story_v_out_416061.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061015", "story_v_out_416061.awb") / 1000

					if var_68_10 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_3
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_416061", "416061015", "story_v_out_416061.awb")

						arg_65_1:RecordAudio("416061015", var_68_11)
						arg_65_1:RecordAudio("416061015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416061", "416061015", "story_v_out_416061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416061", "416061015", "story_v_out_416061.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = var_68_3 + 0.3
			local var_68_13 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.299333333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play416061016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416061016
		arg_71_1.duration_ = 8.17

		local var_71_0 = {
			zh = 8.16633333333333,
			ja = 6.36633333333333
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play416061017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPosSS1603 = arg_71_1.bgs_.SS1603.transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPosSS1603, Vector3.New(0, 1, 8), (arg_71_1.time_ - 0) / var_74_0)
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.bgs_.SS1603.transform.localPosition = Vector3.New(0, 1, 8)
			end

			local var_74_1 = arg_71_1.bgs_.SS1603.transform

			if 0.034 < arg_71_1.time_ and arg_71_1.time_ <= 0.034 + arg_74_0 then
				arg_71_1.var_.moveOldPosSS1603 = var_74_1.localPosition
			end

			local var_74_2 = 0.299333333333333

			if 0.034 <= arg_71_1.time_ and arg_71_1.time_ < 0.034 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPosSS1603, Vector3.New(1, 1, 7), (arg_71_1.time_ - 0.034) / var_74_2)
			end

			if arg_71_1.time_ >= 0.034 + var_74_2 and arg_71_1.time_ < 0.034 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(1, 1, 7)
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_3 = 0.333333333333333
			local var_74_4 = 0.725

			if 0.333333333333333 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_5 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_5:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(416061016)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 29 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_7) / 29)

				if (29 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_7) / 29)) > 0 and var_74_4 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9
					var_74_3 = var_74_3 + 0.3

					if var_74_9 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061016", "story_v_out_416061.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061016", "story_v_out_416061.awb") / 1000

					if var_74_10 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_3
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_416061", "416061016", "story_v_out_416061.awb")

						arg_71_1:RecordAudio("416061016", var_74_11)
						arg_71_1:RecordAudio("416061016", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416061", "416061016", "story_v_out_416061.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416061", "416061016", "story_v_out_416061.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = var_74_3 + 0.3
			local var_74_13 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_13 and arg_71_1.time_ < var_74_12 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.299333333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play416061017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416061017
		arg_77_1.duration_ = 5.47

		local var_77_0 = {
			zh = 5.06633333333333,
			ja = 5.46633333333333
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
				arg_77_0:Play416061018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPosSS1603 = arg_77_1.bgs_.SS1603.transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPosSS1603, Vector3.New(1, 1, 7), (arg_77_1.time_ - 0) / var_80_0)
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.bgs_.SS1603.transform.localPosition = Vector3.New(1, 1, 7)
			end

			local var_80_1 = arg_77_1.bgs_.SS1603.transform

			if 0.034 < arg_77_1.time_ and arg_77_1.time_ <= 0.034 + arg_80_0 then
				arg_77_1.var_.moveOldPosSS1603 = var_80_1.localPosition
			end

			local var_80_2 = 0.299333333333333

			if 0.034 <= arg_77_1.time_ and arg_77_1.time_ < 0.034 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPosSS1603, Vector3.New(0.4, 0.4, 6), (arg_77_1.time_ - 0.034) / var_80_2)
			end

			if arg_77_1.time_ >= 0.034 + var_80_2 and arg_77_1.time_ < 0.034 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0.4, 0.4, 6)
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_3 = 0.333333333333333
			local var_80_4 = 0.525

			if 0.333333333333333 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_5 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_5:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(416061017)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 21 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_7) / 21)

				if (21 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_7) / 21)) > 0 and var_80_4 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9
					var_80_3 = var_80_3 + 0.3

					if var_80_9 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061017", "story_v_out_416061.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061017", "story_v_out_416061.awb") / 1000

					if var_80_10 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_3
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_416061", "416061017", "story_v_out_416061.awb")

						arg_77_1:RecordAudio("416061017", var_80_11)
						arg_77_1:RecordAudio("416061017", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416061", "416061017", "story_v_out_416061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416061", "416061017", "story_v_out_416061.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = var_80_3 + 0.3
			local var_80_13 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_13 and arg_77_1.time_ < var_80_12 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.299333333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play416061018 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416061018
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play416061019(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun07", "")
			end

			local var_86_1 = 0
			local var_86_2 = 1.225

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

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(416061018).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 49 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 49)

				if (49 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 49)) > 0 and var_86_2 < var_86_5 then
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
	Play416061019 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416061019
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play416061020(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.225

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(416061019).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 49 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 49)

				if (49 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 49)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play416061020 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416061020
		arg_91_1.duration_ = 5.63

		local var_91_0 = {
			zh = 5.63333333333333,
			ja = 5.19933333333333
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
				arg_91_0:Play416061021(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPosSS1603 = arg_91_1.bgs_.SS1603.transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPosSS1603, Vector3.New(0.4, 0.4, 6), (arg_91_1.time_ - 0) / var_94_0)
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.bgs_.SS1603.transform.localPosition = Vector3.New(0.4, 0.4, 6)
			end

			local var_94_1 = arg_91_1.bgs_.SS1603.transform

			if 0.034 < arg_91_1.time_ and arg_91_1.time_ <= 0.034 + arg_94_0 then
				arg_91_1.var_.moveOldPosSS1603 = var_94_1.localPosition
			end

			local var_94_2 = 0.199333333333333

			if 0.034 <= arg_91_1.time_ and arg_91_1.time_ < 0.034 + var_94_2 then
				var_94_1.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPosSS1603, Vector3.New(1, 0.3, 6), (arg_91_1.time_ - 0.034) / var_94_2)
			end

			if arg_91_1.time_ >= 0.034 + var_94_2 and arg_91_1.time_ < 0.034 + var_94_2 + arg_94_0 then
				var_94_1.localPosition = Vector3.New(1, 0.3, 6)
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_3 = 0.233333333333333
			local var_94_4 = 0.5

			if 0.233333333333333 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_5 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_5:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(416061020)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 20 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_7) / 20)

				if (20 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_7) / 20)) > 0 and var_94_4 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9
					var_94_3 = var_94_3 + 0.3

					if var_94_9 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_3
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061020", "story_v_out_416061.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061020", "story_v_out_416061.awb") / 1000

					if var_94_10 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_3
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_416061", "416061020", "story_v_out_416061.awb")

						arg_91_1:RecordAudio("416061020", var_94_11)
						arg_91_1:RecordAudio("416061020", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_416061", "416061020", "story_v_out_416061.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_416061", "416061020", "story_v_out_416061.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = var_94_3 + 0.3
			local var_94_13 = math.max(var_94_4, arg_91_1.talkMaxDuration)

			if var_94_3 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_13 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_13

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_13 and arg_91_1.time_ < var_94_12 + var_94_13 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.199333333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play416061021 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416061021
		arg_97_1.duration_ = 4.97

		local var_97_0 = {
			zh = 4.2,
			ja = 4.966
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
				arg_97_0:Play416061022(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.325

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

				local var_100_1 = arg_97_1:GetWordFromCfg(416061021)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 13 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 13)

				if (13 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 13)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061021", "story_v_out_416061.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061021", "story_v_out_416061.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_416061", "416061021", "story_v_out_416061.awb")

						arg_97_1:RecordAudio("416061021", var_100_6)
						arg_97_1:RecordAudio("416061021", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416061", "416061021", "story_v_out_416061.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416061", "416061021", "story_v_out_416061.awb")
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
	Play416061022 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416061022
		arg_101_1.duration_ = 4.57

		local var_101_0 = {
			zh = 2.6,
			ja = 4.566
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
				arg_101_0:Play416061023(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.325

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(416061022)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 13 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 13)

				if (13 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 13)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061022", "story_v_out_416061.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061022", "story_v_out_416061.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_416061", "416061022", "story_v_out_416061.awb")

						arg_101_1:RecordAudio("416061022", var_104_6)
						arg_101_1:RecordAudio("416061022", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416061", "416061022", "story_v_out_416061.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416061", "416061022", "story_v_out_416061.awb")
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
	Play416061023 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416061023
		arg_105_1.duration_ = 5.53

		local var_105_0 = {
			zh = 3.466,
			ja = 5.533
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
				arg_105_0:Play416061024(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(416061023)
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

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061023", "story_v_out_416061.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061023", "story_v_out_416061.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_416061", "416061023", "story_v_out_416061.awb")

						arg_105_1:RecordAudio("416061023", var_108_6)
						arg_105_1:RecordAudio("416061023", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416061", "416061023", "story_v_out_416061.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416061", "416061023", "story_v_out_416061.awb")
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
	Play416061024 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416061024
		arg_109_1.duration_ = 7.1

		local var_109_0 = {
			zh = 4.066,
			ja = 7.1
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
				arg_109_0:Play416061025(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(416061024)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 21 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 21)

				if (21 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 21)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061024", "story_v_out_416061.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061024", "story_v_out_416061.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_416061", "416061024", "story_v_out_416061.awb")

						arg_109_1:RecordAudio("416061024", var_112_6)
						arg_109_1:RecordAudio("416061024", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416061", "416061024", "story_v_out_416061.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416061", "416061024", "story_v_out_416061.awb")
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
	Play416061025 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416061025
		arg_113_1.duration_ = 6

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play416061026(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				local var_116_0 = arg_113_1.var_.effect0601

				if not arg_113_1.var_.effect0601 then
					var_116_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_116_0.name = "0601"
					arg_113_1.var_.effect0601 = var_116_0
				else
					var_116_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_116_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_116_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_116_2 = manager.ui.mainCamera.transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.shakeOldPos = var_116_2.localPosition
			end

			local var_116_3 = 0.666666666666667

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 then
				local var_116_4, var_116_5 = math.modf((arg_113_1.time_ - 0) / 0.066)

				var_116_2.localPosition = Vector3.New(var_116_5 * 0.13, var_116_5 * 0.13, var_116_5 * 0.13) + arg_113_1.var_.shakeOldPos
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 then
				var_116_2.localPosition = arg_113_1.var_.shakeOldPos
			end

			if 0.3 < arg_113_1.time_ and arg_113_1.time_ <= 0.3 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_smash03", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_7 = 1
			local var_116_8 = 1.4

			if 1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_9 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_9:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(416061025).content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 56 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 56)

				if (56 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 56)) > 0 and var_116_8 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12
					var_116_7 = var_116_7 + 0.3

					if var_116_12 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_7
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = var_116_7 + 0.3
			local var_116_14 = math.max(var_116_8, arg_113_1.talkMaxDuration)

			if var_116_7 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_13 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_13) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_13 + var_116_14 and arg_113_1.time_ < var_116_13 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play416061026 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416061026
		arg_119_1.duration_ = 6.07

		local var_119_0 = {
			zh = 4.09966666666667,
			ja = 6.06666666666667
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
				arg_119_0:Play416061027(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPosSS1603 = arg_119_1.bgs_.SS1603.transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosSS1603, Vector3.New(1, 0.3, 6), (arg_119_1.time_ - 0) / var_122_0)
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.bgs_.SS1603.transform.localPosition = Vector3.New(1, 0.3, 6)
			end

			local var_122_1 = arg_119_1.bgs_.SS1603.transform

			if 0.034 < arg_119_1.time_ and arg_119_1.time_ <= 0.034 + arg_122_0 then
				arg_119_1.var_.moveOldPosSS1603 = var_122_1.localPosition
			end

			local var_122_2 = 0.632666666666667

			if 0.034 <= arg_119_1.time_ and arg_119_1.time_ < 0.034 + var_122_2 then
				var_122_1.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosSS1603, Vector3.New(2, 0, 5), (arg_119_1.time_ - 0.034) / var_122_2)
			end

			if arg_119_1.time_ >= 0.034 + var_122_2 and arg_119_1.time_ < 0.034 + var_122_2 + arg_122_0 then
				var_122_1.localPosition = Vector3.New(2, 0, 5)
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_3 = 0.666666666666667
			local var_122_4 = 0.325

			if 0.666666666666667 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_5 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_5:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(416061026)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 13 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_7) / 13)

				if (13 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_7) / 13)) > 0 and var_122_4 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9
					var_122_3 = var_122_3 + 0.3

					if var_122_9 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_3
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061026", "story_v_out_416061.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061026", "story_v_out_416061.awb") / 1000

					if var_122_10 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_3
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_416061", "416061026", "story_v_out_416061.awb")

						arg_119_1:RecordAudio("416061026", var_122_11)
						arg_119_1:RecordAudio("416061026", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416061", "416061026", "story_v_out_416061.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416061", "416061026", "story_v_out_416061.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = var_122_3 + 0.3
			local var_122_13 = math.max(var_122_4, arg_119_1.talkMaxDuration)

			if var_122_3 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.632666666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play416061027 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416061027
		arg_125_1.duration_ = 5.2

		local var_125_0 = {
			zh = 4.933,
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
				arg_125_0:Play416061028(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.375

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
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(416061027)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 15 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 15)

				if (15 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 15)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061027", "story_v_out_416061.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061027", "story_v_out_416061.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_416061", "416061027", "story_v_out_416061.awb")

						arg_125_1:RecordAudio("416061027", var_128_6)
						arg_125_1:RecordAudio("416061027", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416061", "416061027", "story_v_out_416061.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416061", "416061027", "story_v_out_416061.awb")
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
	Play416061028 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416061028
		arg_129_1.duration_ = 6.57

		local var_129_0 = {
			zh = 4.5,
			ja = 6.566
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
				arg_129_0:Play416061029(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.575

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(416061028)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 23 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 23)

				if (23 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 23)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061028", "story_v_out_416061.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061028", "story_v_out_416061.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_416061", "416061028", "story_v_out_416061.awb")

						arg_129_1:RecordAudio("416061028", var_132_6)
						arg_129_1:RecordAudio("416061028", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416061", "416061028", "story_v_out_416061.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416061", "416061028", "story_v_out_416061.awb")
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
	Play416061029 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416061029
		arg_133_1.duration_ = 7.03

		local var_133_0 = {
			zh = 3.46666666666667,
			ja = 7.03266666666667
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
				arg_133_0:Play416061030(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPosSS1603 = arg_133_1.bgs_.SS1603.transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosSS1603, Vector3.New(2, 0, 5), (arg_133_1.time_ - 0) / var_136_0)
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.bgs_.SS1603.transform.localPosition = Vector3.New(2, 0, 5)
			end

			local var_136_1 = arg_133_1.bgs_.SS1603.transform

			if 0.034 < arg_133_1.time_ and arg_133_1.time_ <= 0.034 + arg_136_0 then
				arg_133_1.var_.moveOldPosSS1603 = var_136_1.localPosition
			end

			local var_136_2 = 0.632666666666667

			if 0.034 <= arg_133_1.time_ and arg_133_1.time_ < 0.034 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosSS1603, Vector3.New(1, 0.2, 5), (arg_133_1.time_ - 0.034) / var_136_2)
			end

			if arg_133_1.time_ >= 0.034 + var_136_2 and arg_133_1.time_ < 0.034 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(1, 0.2, 5)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_3 = 0.666666666666667
			local var_136_4 = 0.375

			if 0.666666666666667 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_5 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_5:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(416061029)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 15 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_7) / 15)

				if (15 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_7) / 15)) > 0 and var_136_4 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9
					var_136_3 = var_136_3 + 0.3

					if var_136_9 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061029", "story_v_out_416061.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061029", "story_v_out_416061.awb") / 1000

					if var_136_10 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_3
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_416061", "416061029", "story_v_out_416061.awb")

						arg_133_1:RecordAudio("416061029", var_136_11)
						arg_133_1:RecordAudio("416061029", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416061", "416061029", "story_v_out_416061.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416061", "416061029", "story_v_out_416061.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = var_136_3 + 0.3
			local var_136_13 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.632666666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play416061030 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416061030
		arg_139_1.duration_ = 9.6

		local var_139_0 = {
			zh = 3.866,
			ja = 9.6
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
				arg_139_0:Play416061031(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.425

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:GetWordFromCfg(416061030)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 17 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 17)

				if (17 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 17)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061030", "story_v_out_416061.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061030", "story_v_out_416061.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_416061", "416061030", "story_v_out_416061.awb")

						arg_139_1:RecordAudio("416061030", var_142_6)
						arg_139_1:RecordAudio("416061030", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416061", "416061030", "story_v_out_416061.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416061", "416061030", "story_v_out_416061.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play416061031 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416061031
		arg_143_1.duration_ = 6.9

		local var_143_0 = {
			zh = 3.866,
			ja = 6.9
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
				arg_143_0:Play416061032(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(416061031)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 21)

				if (21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 21)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061031", "story_v_out_416061.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061031", "story_v_out_416061.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_416061", "416061031", "story_v_out_416061.awb")

						arg_143_1:RecordAudio("416061031", var_146_6)
						arg_143_1:RecordAudio("416061031", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_416061", "416061031", "story_v_out_416061.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_416061", "416061031", "story_v_out_416061.awb")
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
	Play416061032 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 416061032
		arg_147_1.duration_ = 8.83

		local var_147_0 = {
			zh = 4.766,
			ja = 8.833
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
				arg_147_0:Play416061033(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.575

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:GetWordFromCfg(416061032)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 23 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 23)

				if (23 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 23)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061032", "story_v_out_416061.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061032", "story_v_out_416061.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_416061", "416061032", "story_v_out_416061.awb")

						arg_147_1:RecordAudio("416061032", var_150_6)
						arg_147_1:RecordAudio("416061032", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_416061", "416061032", "story_v_out_416061.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_416061", "416061032", "story_v_out_416061.awb")
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
	Play416061033 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416061033
		arg_151_1.duration_ = 1.37

		local var_151_0 = {
			zh = 1.233,
			ja = 1.366
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
				arg_151_0:Play416061034(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1090].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(416061033)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 4 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 4)

				if (4 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 4)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061033", "story_v_out_416061.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061033", "story_v_out_416061.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_416061", "416061033", "story_v_out_416061.awb")

						arg_151_1:RecordAudio("416061033", var_154_6)
						arg_151_1:RecordAudio("416061033", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_416061", "416061033", "story_v_out_416061.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_416061", "416061033", "story_v_out_416061.awb")
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
	Play416061034 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416061034
		arg_155_1.duration_ = 8.83

		local var_155_0 = {
			zh = 8.166,
			ja = 8.833
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
				arg_155_0:Play416061035(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.725

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(416061034)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 29 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 29)

				if (29 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 29)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061034", "story_v_out_416061.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061034", "story_v_out_416061.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_416061", "416061034", "story_v_out_416061.awb")

						arg_155_1:RecordAudio("416061034", var_158_6)
						arg_155_1:RecordAudio("416061034", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416061", "416061034", "story_v_out_416061.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416061", "416061034", "story_v_out_416061.awb")
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
	Play416061035 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416061035
		arg_159_1.duration_ = 6.23

		local var_159_0 = {
			zh = 3.766,
			ja = 6.233
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
				arg_159_0:Play416061036(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.5

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1090].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(416061035)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 20 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 20)

				if (20 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 20)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061035", "story_v_out_416061.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061035", "story_v_out_416061.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_416061", "416061035", "story_v_out_416061.awb")

						arg_159_1:RecordAudio("416061035", var_162_6)
						arg_159_1:RecordAudio("416061035", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_416061", "416061035", "story_v_out_416061.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_416061", "416061035", "story_v_out_416061.awb")
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
	Play416061036 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416061036
		arg_163_1.duration_ = 4.83

		local var_163_0 = {
			zh = 3.29933333333333,
			ja = 4.83333333333333
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
				arg_163_0:Play416061037(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPosSS1603 = arg_163_1.bgs_.SS1603.transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.bgs_.SS1603.transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPosSS1603, Vector3.New(1, 0.2, 5), (arg_163_1.time_ - 0) / var_166_0)
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.bgs_.SS1603.transform.localPosition = Vector3.New(1, 0.2, 5)
			end

			local var_166_1 = arg_163_1.bgs_.SS1603.transform

			if 0.034 < arg_163_1.time_ and arg_163_1.time_ <= 0.034 + arg_166_0 then
				arg_163_1.var_.moveOldPosSS1603 = var_166_1.localPosition
			end

			local var_166_2 = 0.799333333333333

			if 0.034 <= arg_163_1.time_ and arg_163_1.time_ < 0.034 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPosSS1603, Vector3.New(1, 0.3, 6), (arg_163_1.time_ - 0.034) / var_166_2)
			end

			if arg_163_1.time_ >= 0.034 + var_166_2 and arg_163_1.time_ < 0.034 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(1, 0.3, 6)
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_3 = 0.833333333333333
			local var_166_4 = 0.25

			if 0.833333333333333 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_5 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_5:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1090].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(416061036)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 10 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_7) / 10)

				if (10 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_7) / 10)) > 0 and var_166_4 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9
					var_166_3 = var_166_3 + 0.3

					if var_166_9 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061036", "story_v_out_416061.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_416061", "416061036", "story_v_out_416061.awb") / 1000

					if var_166_10 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_3
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_416061", "416061036", "story_v_out_416061.awb")

						arg_163_1:RecordAudio("416061036", var_166_11)
						arg_163_1:RecordAudio("416061036", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416061", "416061036", "story_v_out_416061.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416061", "416061036", "story_v_out_416061.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = var_166_3 + 0.3
			local var_166_13 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 + 0.3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.799333333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play416061037 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416061037
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play416061038(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(416061037).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 53 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 53)

				if (53 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 53)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416061038 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416061038
		arg_173_1.duration_ = 5.03

		local var_173_0 = {
			zh = 4.2,
			ja = 5.033
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
				arg_173_0:Play416061039(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.45

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(416061038)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 18 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 18)

				if (18 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 18)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061038", "story_v_out_416061.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061038", "story_v_out_416061.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_416061", "416061038", "story_v_out_416061.awb")

						arg_173_1:RecordAudio("416061038", var_176_6)
						arg_173_1:RecordAudio("416061038", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416061", "416061038", "story_v_out_416061.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416061", "416061038", "story_v_out_416061.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416061039 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416061039
		arg_177_1.duration_ = 3.63

		local var_177_0 = {
			zh = 2.4,
			ja = 3.633
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
				arg_177_0:Play416061040(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1090].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(416061039)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 13 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 13)

				if (13 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 13)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061039", "story_v_out_416061.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061039", "story_v_out_416061.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_416061", "416061039", "story_v_out_416061.awb")

						arg_177_1:RecordAudio("416061039", var_180_6)
						arg_177_1:RecordAudio("416061039", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416061", "416061039", "story_v_out_416061.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416061", "416061039", "story_v_out_416061.awb")
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
	Play416061040 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416061040
		arg_181_1.duration_ = 7.7

		local var_181_0 = {
			zh = 4.666,
			ja = 7.7
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
				arg_181_0:Play416061041(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.65

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
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(416061040)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 26 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 26)

				if (26 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 26)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061040", "story_v_out_416061.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061040", "story_v_out_416061.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_416061", "416061040", "story_v_out_416061.awb")

						arg_181_1:RecordAudio("416061040", var_184_6)
						arg_181_1:RecordAudio("416061040", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416061", "416061040", "story_v_out_416061.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416061", "416061040", "story_v_out_416061.awb")
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
	Play416061041 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416061041
		arg_185_1.duration_ = 6.03

		local var_185_0 = {
			zh = 3.1,
			ja = 6.033
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
				arg_185_0:Play416061042(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.425

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1090].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(416061041)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 17 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 17)

				if (17 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 17)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061041", "story_v_out_416061.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061041", "story_v_out_416061.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_416061", "416061041", "story_v_out_416061.awb")

						arg_185_1:RecordAudio("416061041", var_188_6)
						arg_185_1:RecordAudio("416061041", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416061", "416061041", "story_v_out_416061.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416061", "416061041", "story_v_out_416061.awb")
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
	Play416061042 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416061042
		arg_189_1.duration_ = 4.3

		local var_189_0 = {
			zh = 3.533,
			ja = 4.3
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
				arg_189_0:Play416061043(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.4

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(416061042)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 16 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 16)

				if (16 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 16)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061042", "story_v_out_416061.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061042", "story_v_out_416061.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_416061", "416061042", "story_v_out_416061.awb")

						arg_189_1:RecordAudio("416061042", var_192_6)
						arg_189_1:RecordAudio("416061042", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_416061", "416061042", "story_v_out_416061.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_416061", "416061042", "story_v_out_416061.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play416061043 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416061043
		arg_193_1.duration_ = 9.3

		local var_193_0 = {
			zh = 9.3,
			ja = 8.666
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
				arg_193_0:Play416061044(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				local var_196_0 = arg_193_1.bgs_.I13f

				arg_193_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_1 = var_196_0:GetComponent("SpriteRenderer")

				if var_196_1 and var_196_1.sprite then
					local var_196_2 = 2 * (var_196_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_0.transform.localScale = Vector3.New(var_196_2 / var_196_1.sprite.bounds.size.y < var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x and var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x or var_196_2 / var_196_1.sprite.bounds.size.y, var_196_2 / var_196_1.sprite.bounds.size.y < var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x and var_196_2 * manager.ui.mainCameraCom_.aspect / var_196_1.sprite.bounds.size.x or var_196_2 / var_196_1.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "I13f" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_3 = 4

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_3 + 0.3 and arg_193_1.time_ < var_196_3 + 0.3 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_4 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_5 = 2

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_5 then
				local var_196_6 = Color.New(0, 0, 0)

				var_196_6.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_4) / var_196_5)
				arg_193_1.mask_.color = var_196_6
			end

			if arg_193_1.time_ >= var_196_4 + var_196_5 and arg_193_1.time_ < var_196_4 + var_196_5 + arg_196_0 then
				local var_196_7 = Color.New(0, 0, 0)

				var_196_7.a = 1
				arg_193_1.mask_.color = var_196_7
			end

			local var_196_8 = 2

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 then
				local var_196_10 = Color.New(0, 0, 0)

				var_196_10.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_8) / var_196_9)
				arg_193_1.mask_.color = var_196_10
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 then
				local var_196_11 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_11.a = 0
				arg_193_1.mask_.color = var_196_11
			end

			local var_196_12 = arg_193_1.actors_["1086"].transform

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= 3.73333333333333 + arg_196_0 then
				arg_193_1.var_.moveOldPos1086 = var_196_12.localPosition
				var_196_12.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1086", 3)

				for iter_196_2 = 0, var_196_12.childCount - 1 do
					local var_196_13 = var_196_12:GetChild(iter_196_2)

					if var_196_13.name == "split_6" or not string.find(var_196_13.name, "split") then
						var_196_13.gameObject:SetActive(true)
					else
						var_196_13.gameObject:SetActive(false)
					end
				end
			end

			local var_196_14 = 0.001

			if 3.73333333333333 <= arg_193_1.time_ and arg_193_1.time_ < 3.73333333333333 + var_196_14 then
				var_196_12.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_193_1.time_ - 3.73333333333333) / var_196_14)
			end

			if arg_193_1.time_ >= 3.73333333333333 + var_196_14 and arg_193_1.time_ < 3.73333333333333 + var_196_14 + arg_196_0 then
				var_196_12.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_196_15 = arg_193_1.actors_["1086"]

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= 3.73333333333333 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps1086 == nil then
				arg_193_1.var_.actorSpriteComps1086 = var_196_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_16 = 0.125

			if 3.73333333333333 <= arg_193_1.time_ and arg_193_1.time_ < 3.73333333333333 + var_196_16 and not isNil(var_196_15) then
				if arg_193_1.var_.actorSpriteComps1086 then
					for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_196_4 then
							if arg_193_1.isInRecall_ then
								iter_196_4.color = Color.New(Mathf.Lerp(iter_196_4.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 3.73333333333333) / var_196_16), Mathf.Lerp(iter_196_4.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 3.73333333333333) / var_196_16), (Mathf.Lerp(iter_196_4.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 3.73333333333333) / var_196_16)))
							else
								local var_196_17 = Mathf.Lerp(iter_196_4.color.r, 1, (arg_193_1.time_ - 3.73333333333333) / var_196_16)

								iter_196_4.color = Color.New(var_196_17, var_196_17, var_196_17)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 3.73333333333333 + var_196_16 and arg_193_1.time_ < 3.73333333333333 + var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps1086 then
				for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_196_6 then
						iter_196_6.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1086 = nil
			end

			if 3.73333333333333 < arg_193_1.time_ and arg_193_1.time_ <= 3.73333333333333 + arg_196_0 then
				local var_196_18 = arg_193_1.actors_["1086"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_18 then
					arg_193_1.var_.alphaOldValue1086 = var_196_18.alpha
					arg_193_1.var_.characterEffect1086 = var_196_18
				end

				arg_193_1.var_.alphaOldValue1086 = 0
			end

			local var_196_19 = 0.857666666666667

			if 3.73333333333333 <= arg_193_1.time_ and arg_193_1.time_ < 3.73333333333333 + var_196_19 then
				if arg_193_1.var_.characterEffect1086 then
					arg_193_1.var_.characterEffect1086.alpha = Mathf.Lerp(arg_193_1.var_.alphaOldValue1086, 1, (arg_193_1.time_ - 3.73333333333333) / var_196_19)
				end
			end

			if arg_193_1.time_ >= 3.73333333333333 + var_196_19 and arg_193_1.time_ < 3.73333333333333 + var_196_19 + arg_196_0 and arg_193_1.var_.characterEffect1086 then
				arg_193_1.var_.characterEffect1086.alpha = 1
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_20 = 4
			local var_196_21 = 0.35

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_20 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_22 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_22:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_23 = arg_193_1:GetWordFromCfg(416061043)
				local var_196_24 = arg_193_1:FormatText(var_196_23.content)

				arg_193_1.text_.text = var_196_24

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_26 = 14 <= 0 and var_196_21 or var_196_21 * (utf8.len(var_196_24) / 14)

				if (14 <= 0 and var_196_21 or var_196_21 * (utf8.len(var_196_24) / 14)) > 0 and var_196_21 < var_196_26 then
					arg_193_1.talkMaxDuration = var_196_26
					var_196_20 = var_196_20 + 0.3

					if var_196_26 + var_196_20 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_26 + var_196_20
					end
				end

				arg_193_1.text_.text = var_196_24
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061043", "story_v_out_416061.awb") ~= 0 then
					local var_196_27 = manager.audio:GetVoiceLength("story_v_out_416061", "416061043", "story_v_out_416061.awb") / 1000

					if var_196_27 + var_196_20 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_27 + var_196_20
					end

					if var_196_23.prefab_name ~= "" and arg_193_1.actors_[var_196_23.prefab_name] ~= nil then
						local var_196_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_23.prefab_name].transform, "story_v_out_416061", "416061043", "story_v_out_416061.awb")

						arg_193_1:RecordAudio("416061043", var_196_28)
						arg_193_1:RecordAudio("416061043", var_196_28)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416061", "416061043", "story_v_out_416061.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416061", "416061043", "story_v_out_416061.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_29 = var_196_20 + 0.3
			local var_196_30 = math.max(var_196_21, arg_193_1.talkMaxDuration)

			if var_196_20 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_29 + var_196_30 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_29) / var_196_30

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_29 + var_196_30 and arg_193_1.time_ < var_196_29 + var_196_30 + arg_196_0 then
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
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play416061044 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416061044
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play416061045(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1086 = arg_199_1.actors_["1086"].transform.localPosition
				arg_199_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1086", 7)

				for iter_202_0 = 0, arg_199_1.actors_["1086"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["1086"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_202_2 = 0
			local var_202_3 = 1.8

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_4 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(416061044).content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 72 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_4) / 72)

				if (72 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_4) / 72)) > 0 and var_202_3 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_7 and arg_199_1.time_ < var_202_2 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play416061045 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416061045
		arg_203_1.duration_ = 6.7

		local var_203_0 = {
			zh = 3.466,
			ja = 6.7
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
				arg_203_0:Play416061046(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1148 = arg_203_1.actors_["1148"].transform.localPosition
				arg_203_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1148", 3)

				for iter_206_0 = 0, arg_203_1.actors_["1148"].transform.childCount - 1 do
					local var_206_0 = arg_203_1.actors_["1148"].transform:GetChild(iter_206_0)

					if var_206_0.name == "split_6" or not string.find(var_206_0.name, "split") then
						var_206_0.gameObject:SetActive(true)
					else
						var_206_0.gameObject:SetActive(false)
					end
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_203_1.time_ - 0) / var_206_1)
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_206_2 = arg_203_1.actors_["1148"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1148 == nil then
				arg_203_1.var_.actorSpriteComps1148 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 0.125

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps1148 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1148 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_206_4 then
						iter_206_4.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1148 = nil
			end

			local var_206_5 = 0
			local var_206_6 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(416061045)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 19 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 19)

				if (19 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 19)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061045", "story_v_out_416061.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_416061", "416061045", "story_v_out_416061.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_416061", "416061045", "story_v_out_416061.awb")

						arg_203_1:RecordAudio("416061045", var_206_12)
						arg_203_1:RecordAudio("416061045", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416061", "416061045", "story_v_out_416061.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416061", "416061045", "story_v_out_416061.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play416061046 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416061046
		arg_207_1.duration_ = 2.7

		local var_207_0 = {
			zh = 2.2,
			ja = 2.7
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
				arg_207_0:Play416061047(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.15

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
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

				local var_210_1 = arg_207_1:GetWordFromCfg(416061046)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 6 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 6)

				if (6 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 6)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061046", "story_v_out_416061.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061046", "story_v_out_416061.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_416061", "416061046", "story_v_out_416061.awb")

						arg_207_1:RecordAudio("416061046", var_210_6)
						arg_207_1:RecordAudio("416061046", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416061", "416061046", "story_v_out_416061.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416061", "416061046", "story_v_out_416061.awb")
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
	Play416061047 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416061047
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play416061048(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1148 = arg_211_1.actors_["1148"].transform.localPosition
				arg_211_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1148", 7)

				for iter_214_0 = 0, arg_211_1.actors_["1148"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["1148"].transform:GetChild(iter_214_0)

					if var_214_0.name == "" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_211_1.time_ - 0) / var_214_1)
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_2 = 0
			local var_214_3 = 0.95

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(416061047).content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_6 = 38 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_4) / 38)

				if (38 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_4) / 38)) > 0 and var_214_3 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_7 and arg_211_1.time_ < var_214_2 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play416061048 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416061048
		arg_215_1.duration_ = 6.43

		local var_215_0 = {
			zh = 4.3,
			ja = 6.433
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
				arg_215_0:Play416061049(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1148 = arg_215_1.actors_["1148"].transform.localPosition
				arg_215_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1148", 3)

				for iter_218_0 = 0, arg_215_1.actors_["1148"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["1148"].transform:GetChild(iter_218_0)

					if var_218_0.name == "split_6" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_215_1.time_ - 0) / var_218_1)
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_218_2 = arg_215_1.actors_["1148"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1148 == nil then
				arg_215_1.var_.actorSpriteComps1148 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 0.125

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps1148 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1148 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_218_4 then
						iter_218_4.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1148 = nil
			end

			local var_218_5 = 0
			local var_218_6 = 0.55

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
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

				local var_218_7 = arg_215_1:GetWordFromCfg(416061048)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 22 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 22)

				if (22 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 22)) > 0 and var_218_6 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061048", "story_v_out_416061.awb") ~= 0 then
					local var_218_11 = manager.audio:GetVoiceLength("story_v_out_416061", "416061048", "story_v_out_416061.awb") / 1000

					if var_218_11 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_5
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_416061", "416061048", "story_v_out_416061.awb")

						arg_215_1:RecordAudio("416061048", var_218_12)
						arg_215_1:RecordAudio("416061048", var_218_12)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_416061", "416061048", "story_v_out_416061.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_416061", "416061048", "story_v_out_416061.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_13 and arg_215_1.time_ < var_218_5 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play416061049 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416061049
		arg_219_1.duration_ = 7.47

		local var_219_0 = {
			zh = 6.466,
			ja = 7.466
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
				arg_219_0:Play416061050(arg_219_1)
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

			local var_222_2 = arg_219_1.actors_["1028"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1028 == nil then
				arg_219_1.var_.actorSpriteComps1028 = var_222_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_3 = 0.125

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.actorSpriteComps1028 then
					for iter_222_1, iter_222_2 in pairs(arg_219_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_222_2 then
							if arg_219_1.isInRecall_ then
								iter_222_2.color = Color.New(Mathf.Lerp(iter_222_2.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_3), Mathf.Lerp(iter_222_2.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_3), (Mathf.Lerp(iter_222_2.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_3)))
							else
								local var_222_4 = Mathf.Lerp(iter_222_2.color.r, 1, (arg_219_1.time_ - 0) / var_222_3)

								iter_222_2.color = Color.New(var_222_4, var_222_4, var_222_4)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1028 then
				for iter_222_3, iter_222_4 in pairs(arg_219_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_222_4 then
						iter_222_4.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps1028 = nil
			end

			local var_222_5 = arg_219_1.actors_["1028"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1028 = var_222_5.localPosition
				var_222_5.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1028", 3)

				for iter_222_5 = 0, var_222_5.childCount - 1 do
					local var_222_6 = var_222_5:GetChild(iter_222_5)

					if var_222_6.name == "split_2" or not string.find(var_222_6.name, "split") then
						var_222_6.gameObject:SetActive(true)
					else
						var_222_6.gameObject:SetActive(false)
					end
				end
			end

			local var_222_7 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_219_1.time_ - 0) / var_222_7)
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_222_8 = 0
			local var_222_9 = 0.55

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:GetWordFromCfg(416061049)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 22 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 22)

				if (22 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 22)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061049", "story_v_out_416061.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061049", "story_v_out_416061.awb") / 1000

					if var_222_14 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_8
					end

					if var_222_10.prefab_name ~= "" and arg_219_1.actors_[var_222_10.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_10.prefab_name].transform, "story_v_out_416061", "416061049", "story_v_out_416061.awb")

						arg_219_1:RecordAudio("416061049", var_222_15)
						arg_219_1:RecordAudio("416061049", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416061", "416061049", "story_v_out_416061.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416061", "416061049", "story_v_out_416061.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_16 and arg_219_1.time_ < var_222_8 + var_222_16 + arg_222_0 then
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

		arg_219_1:InitPlayNodeList()
	end,
	Play416061050 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416061050
		arg_223_1.duration_ = 1.47

		local var_223_0 = {
			zh = 1.466,
			ja = 1.4
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
				arg_223_0:Play416061051(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1086 = arg_223_1.actors_["1086"].transform.localPosition
				arg_223_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1086", 7)

				for iter_226_0 = 0, arg_223_1.actors_["1086"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["1086"].transform:GetChild(iter_226_0)

					if var_226_0.name == "" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_226_2 = arg_223_1.actors_["1148"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1148 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1148", 3)

				for iter_226_1 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_1)

					if var_226_3.name == "split_1_1" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_226_5 = arg_223_1.actors_["1148"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.actorSpriteComps1148 == nil then
				arg_223_1.var_.actorSpriteComps1148 = var_226_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_6 = 0.125

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_6 and not isNil(var_226_5) then
				if arg_223_1.var_.actorSpriteComps1148 then
					for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_226_3 then
							if arg_223_1.isInRecall_ then
								iter_226_3.color = Color.New(Mathf.Lerp(iter_226_3.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_6), Mathf.Lerp(iter_226_3.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_6), (Mathf.Lerp(iter_226_3.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_6)))
							else
								local var_226_7 = Mathf.Lerp(iter_226_3.color.r, 1, (arg_223_1.time_ - 0) / var_226_6)

								iter_226_3.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_6 and arg_223_1.time_ < 0 + var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.actorSpriteComps1148 then
				for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_226_5 then
						iter_226_5.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps1148 = nil
			end

			local var_226_8 = 0
			local var_226_9 = 0.125

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(416061050)
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

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061050", "story_v_out_416061.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061050", "story_v_out_416061.awb") / 1000

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_416061", "416061050", "story_v_out_416061.awb")

						arg_223_1:RecordAudio("416061050", var_226_15)
						arg_223_1:RecordAudio("416061050", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416061", "416061050", "story_v_out_416061.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416061", "416061050", "story_v_out_416061.awb")
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

		arg_223_1:InitPlayNodeList()
	end,
	Play416061051 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416061051
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play416061052(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1148 = arg_227_1.actors_["1148"].transform.localPosition
				arg_227_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1148", 7)

				for iter_230_0 = 0, arg_227_1.actors_["1148"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["1148"].transform:GetChild(iter_230_0)

					if var_230_0.name == "" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_230_2 = arg_227_1.actors_["1028"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1028 = var_230_2.localPosition
				var_230_2.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1028", 7)

				for iter_230_1 = 0, var_230_2.childCount - 1 do
					local var_230_3 = var_230_2:GetChild(iter_230_1)

					if var_230_3.name == "" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_2.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_227_1.time_ - 0) / var_230_4)
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_230_5 = 0
			local var_230_6 = 1.475

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_7 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(416061051).content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 59 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_7) / 59)

				if (59 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_7) / 59)) > 0 and var_230_6 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_5
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_6, arg_227_1.talkMaxDuration)

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_5) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_5 + var_230_10 and arg_227_1.time_ < var_230_5 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play416061052 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416061052
		arg_231_1.duration_ = 4.63

		local var_231_0 = {
			zh = 2.4,
			ja = 4.633
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
				arg_231_0:Play416061053(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1148 = arg_231_1.actors_["1148"].transform.localPosition
				arg_231_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1148", 3)

				for iter_234_0 = 0, arg_231_1.actors_["1148"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["1148"].transform:GetChild(iter_234_0)

					if var_234_0.name == "split_2" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_234_2 = arg_231_1.actors_["1148"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1148 == nil then
				arg_231_1.var_.actorSpriteComps1148 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.125

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps1148 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								iter_234_2.color = Color.New(Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_2.color.r, 1, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_2.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1148 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_234_4 then
						iter_234_4.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps1148 = nil
			end

			local var_234_5 = 0
			local var_234_6 = 0.225

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(416061052)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 9 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 9)

				if (9 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 9)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061052", "story_v_out_416061.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_416061", "416061052", "story_v_out_416061.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_416061", "416061052", "story_v_out_416061.awb")

						arg_231_1:RecordAudio("416061052", var_234_12)
						arg_231_1:RecordAudio("416061052", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416061", "416061052", "story_v_out_416061.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416061", "416061052", "story_v_out_416061.awb")
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

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play416061053 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416061053
		arg_235_1.duration_ = 5.6

		local var_235_0 = {
			zh = 4.4,
			ja = 5.6
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
				arg_235_0:Play416061054(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.45

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(416061053)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 18 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 18)

				if (18 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 18)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061053", "story_v_out_416061.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061053", "story_v_out_416061.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_416061", "416061053", "story_v_out_416061.awb")

						arg_235_1:RecordAudio("416061053", var_238_6)
						arg_235_1:RecordAudio("416061053", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416061", "416061053", "story_v_out_416061.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416061", "416061053", "story_v_out_416061.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416061054 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416061054
		arg_239_1.duration_ = 4.27

		local var_239_0 = {
			zh = 3,
			ja = 4.266
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
				arg_239_0:Play416061055(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1148 = arg_239_1.actors_["1148"].transform.localPosition
				arg_239_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1148", 2)

				for iter_242_0 = 0, arg_239_1.actors_["1148"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["1148"].transform:GetChild(iter_242_0)

					if var_242_0.name == "split_2" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_242_2 = arg_239_1.actors_["1148"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1148 == nil then
				arg_239_1.var_.actorSpriteComps1148 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.125

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps1148 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1148 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps1148 = nil
			end

			local var_242_5 = "1148_2"

			if arg_239_1.actors_["1148_2"] == nil then
				local var_242_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148_2")

				if not isNil(var_242_6) then
					local var_242_7 = Object.Instantiate(var_242_6, arg_239_1.canvasGo_.transform)

					var_242_7.transform:SetSiblingIndex(1)

					var_242_7.name = var_242_5
					var_242_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_239_1.actors_[var_242_5] = var_242_7

					if arg_239_1.isInRecall_ then
						for iter_242_5, iter_242_6 in ipairs((var_242_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_242_6.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_242_8 = arg_239_1.actors_["1148_2"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1148_2 = var_242_8.localPosition
				var_242_8.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1148_2", 4)

				for iter_242_7 = 0, var_242_8.childCount - 1 do
					local var_242_9 = var_242_8:GetChild(iter_242_7)

					if var_242_9.name == "split_1_1" or not string.find(var_242_9.name, "split") then
						var_242_9.gameObject:SetActive(true)
					else
						var_242_9.gameObject:SetActive(false)
					end
				end
			end

			local var_242_10 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_10 then
				var_242_8.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1148_2, Vector3.New(390, -429, -180), (arg_239_1.time_ - 0) / var_242_10)
			end

			if arg_239_1.time_ >= 0 + var_242_10 and arg_239_1.time_ < 0 + var_242_10 + arg_242_0 then
				var_242_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_242_11 = arg_239_1.actors_["1148_2"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_11) and arg_239_1.var_.actorSpriteComps1148_2 == nil then
				arg_239_1.var_.actorSpriteComps1148_2 = var_242_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_12 = 0.125

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_12 and not isNil(var_242_11) then
				if arg_239_1.var_.actorSpriteComps1148_2 then
					for iter_242_8, iter_242_9 in pairs(arg_239_1.var_.actorSpriteComps1148_2:ToTable()) do
						if iter_242_9 then
							if arg_239_1.isInRecall_ then
								iter_242_9.color = Color.New(Mathf.Lerp(iter_242_9.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_12), Mathf.Lerp(iter_242_9.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_12), (Mathf.Lerp(iter_242_9.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_12)))
							else
								local var_242_13 = Mathf.Lerp(iter_242_9.color.r, 1, (arg_239_1.time_ - 0) / var_242_12)

								iter_242_9.color = Color.New(var_242_13, var_242_13, var_242_13)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_12 and arg_239_1.time_ < 0 + var_242_12 + arg_242_0 and not isNil(var_242_11) and arg_239_1.var_.actorSpriteComps1148_2 then
				for iter_242_10, iter_242_11 in pairs(arg_239_1.var_.actorSpriteComps1148_2:ToTable()) do
					if iter_242_11 then
						iter_242_11.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1148_2 = nil
			end

			local var_242_14 = 0
			local var_242_15 = 0.375

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_16 = arg_239_1:GetWordFromCfg(416061054)
				local var_242_17 = arg_239_1:FormatText(var_242_16.content)

				arg_239_1.text_.text = var_242_17

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_19 = 15 <= 0 and var_242_15 or var_242_15 * (utf8.len(var_242_17) / 15)

				if (15 <= 0 and var_242_15 or var_242_15 * (utf8.len(var_242_17) / 15)) > 0 and var_242_15 < var_242_19 then
					arg_239_1.talkMaxDuration = var_242_19

					if var_242_19 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_14
					end
				end

				arg_239_1.text_.text = var_242_17
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061054", "story_v_out_416061.awb") ~= 0 then
					local var_242_20 = manager.audio:GetVoiceLength("story_v_out_416061", "416061054", "story_v_out_416061.awb") / 1000

					if var_242_20 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_20 + var_242_14
					end

					if var_242_16.prefab_name ~= "" and arg_239_1.actors_[var_242_16.prefab_name] ~= nil then
						local var_242_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_16.prefab_name].transform, "story_v_out_416061", "416061054", "story_v_out_416061.awb")

						arg_239_1:RecordAudio("416061054", var_242_21)
						arg_239_1:RecordAudio("416061054", var_242_21)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416061", "416061054", "story_v_out_416061.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416061", "416061054", "story_v_out_416061.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_22 = math.max(var_242_15, arg_239_1.talkMaxDuration)

			if var_242_14 <= arg_239_1.time_ and arg_239_1.time_ < var_242_14 + var_242_22 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_14) / var_242_22

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_14 + var_242_22 and arg_239_1.time_ < var_242_14 + var_242_22 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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
				actorName = "1148_2",
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
	Play416061055 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416061055
		arg_243_1.duration_ = 6.2

		local var_243_0 = {
			zh = 6.2,
			ja = 5
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
				arg_243_0:Play416061056(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1148 = arg_243_1.actors_["1148"].transform.localPosition
				arg_243_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1148", 2)

				for iter_246_0 = 0, arg_243_1.actors_["1148"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["1148"].transform:GetChild(iter_246_0)

					if var_246_0.name == "split_2" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_246_2 = arg_243_1.actors_["1148"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1148 == nil then
				arg_243_1.var_.actorSpriteComps1148 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.125

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps1148 then
					for iter_246_1, iter_246_2 in pairs(arg_243_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_246_2 then
							if arg_243_1.isInRecall_ then
								iter_246_2.color = Color.New(Mathf.Lerp(iter_246_2.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_2.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_2.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_2.color.r, 1, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_2.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1148 then
				for iter_246_3, iter_246_4 in pairs(arg_243_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_246_4 then
						iter_246_4.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1148 = nil
			end

			local var_246_5 = arg_243_1.actors_["1148_2"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.actorSpriteComps1148_2 == nil then
				arg_243_1.var_.actorSpriteComps1148_2 = var_246_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_6 = 0.125

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_6 and not isNil(var_246_5) then
				if arg_243_1.var_.actorSpriteComps1148_2 then
					for iter_246_5, iter_246_6 in pairs(arg_243_1.var_.actorSpriteComps1148_2:ToTable()) do
						if iter_246_6 then
							if arg_243_1.isInRecall_ then
								iter_246_6.color = Color.New(Mathf.Lerp(iter_246_6.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_6), Mathf.Lerp(iter_246_6.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_6), (Mathf.Lerp(iter_246_6.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_6)))
							else
								local var_246_7 = Mathf.Lerp(iter_246_6.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_6)

								iter_246_6.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_6 and arg_243_1.time_ < 0 + var_246_6 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.actorSpriteComps1148_2 then
				for iter_246_7, iter_246_8 in pairs(arg_243_1.var_.actorSpriteComps1148_2:ToTable()) do
					if iter_246_8 then
						iter_246_8.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1148_2 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.525

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(416061055)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 21 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 21)

				if (21 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 21)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061055", "story_v_out_416061.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061055", "story_v_out_416061.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_416061", "416061055", "story_v_out_416061.awb")

						arg_243_1:RecordAudio("416061055", var_246_15)
						arg_243_1:RecordAudio("416061055", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416061", "416061055", "story_v_out_416061.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416061", "416061055", "story_v_out_416061.awb")
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
	Play416061056 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416061056
		arg_247_1.duration_ = 4.9

		local var_247_0 = {
			zh = 4.133,
			ja = 4.9
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
				arg_247_0:Play416061057(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.3

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(416061056)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 12 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 12)

				if (12 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 12)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061056", "story_v_out_416061.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061056", "story_v_out_416061.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_416061", "416061056", "story_v_out_416061.awb")

						arg_247_1:RecordAudio("416061056", var_250_6)
						arg_247_1:RecordAudio("416061056", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416061", "416061056", "story_v_out_416061.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416061", "416061056", "story_v_out_416061.awb")
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
	Play416061057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416061057
		arg_251_1.duration_ = 6.57

		local var_251_0 = {
			zh = 4.6,
			ja = 6.566
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
				arg_251_0:Play416061058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1148"]) and arg_251_1.var_.actorSpriteComps1148 == nil then
				arg_251_1.var_.actorSpriteComps1148 = arg_251_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.125

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1148"]) then
				if arg_251_1.var_.actorSpriteComps1148 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 1, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1148"]) and arg_251_1.var_.actorSpriteComps1148 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1148 = nil
			end

			local var_254_2 = arg_251_1.actors_["1148"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1148 = var_254_2.localPosition
				var_254_2.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1148", 7)

				for iter_254_4 = 0, var_254_2.childCount - 1 do
					local var_254_3 = var_254_2:GetChild(iter_254_4)

					if var_254_3.name == "" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_2.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_251_1.time_ - 0) / var_254_4)
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_254_5 = arg_251_1.actors_["1028"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1028 = var_254_5.localPosition
				var_254_5.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1028", 3)

				for iter_254_5 = 0, var_254_5.childCount - 1 do
					local var_254_6 = var_254_5:GetChild(iter_254_5)

					if var_254_6.name == "split_6" or not string.find(var_254_6.name, "split") then
						var_254_6.gameObject:SetActive(true)
					else
						var_254_6.gameObject:SetActive(false)
					end
				end
			end

			local var_254_7 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				var_254_5.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_251_1.time_ - 0) / var_254_7)
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				var_254_5.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_254_8 = arg_251_1.actors_["1028"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1028 == nil then
				arg_251_1.var_.actorSpriteComps1028 = var_254_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_9 = 0.125

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_9 and not isNil(var_254_8) then
				if arg_251_1.var_.actorSpriteComps1028 then
					for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_254_7 then
							if arg_251_1.isInRecall_ then
								iter_254_7.color = Color.New(Mathf.Lerp(iter_254_7.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_9), Mathf.Lerp(iter_254_7.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_9), (Mathf.Lerp(iter_254_7.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_9)))
							else
								local var_254_10 = Mathf.Lerp(iter_254_7.color.r, 1, (arg_251_1.time_ - 0) / var_254_9)

								iter_254_7.color = Color.New(var_254_10, var_254_10, var_254_10)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_9 and arg_251_1.time_ < 0 + var_254_9 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1028 then
				for iter_254_8, iter_254_9 in pairs(arg_251_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_254_9 then
						iter_254_9.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1028 = nil
			end

			local var_254_11 = arg_251_1.actors_["1148_2"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1148_2 = var_254_11.localPosition
				var_254_11.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1148_2", 7)

				for iter_254_10 = 0, var_254_11.childCount - 1 do
					local var_254_12 = var_254_11:GetChild(iter_254_10)

					if var_254_12.name == "" or not string.find(var_254_12.name, "split") then
						var_254_12.gameObject:SetActive(true)
					else
						var_254_12.gameObject:SetActive(false)
					end
				end
			end

			local var_254_13 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_13 then
				var_254_11.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1148_2, Vector3.New(0, -2000, 0), (arg_251_1.time_ - 0) / var_254_13)
			end

			if arg_251_1.time_ >= 0 + var_254_13 and arg_251_1.time_ < 0 + var_254_13 + arg_254_0 then
				var_254_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_254_14 = 0
			local var_254_15 = 0.525

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_16 = arg_251_1:GetWordFromCfg(416061057)
				local var_254_17 = arg_251_1:FormatText(var_254_16.content)

				arg_251_1.text_.text = var_254_17

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_19 = 21 <= 0 and var_254_15 or var_254_15 * (utf8.len(var_254_17) / 21)

				if (21 <= 0 and var_254_15 or var_254_15 * (utf8.len(var_254_17) / 21)) > 0 and var_254_15 < var_254_19 then
					arg_251_1.talkMaxDuration = var_254_19

					if var_254_19 + var_254_14 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_19 + var_254_14
					end
				end

				arg_251_1.text_.text = var_254_17
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061057", "story_v_out_416061.awb") ~= 0 then
					local var_254_20 = manager.audio:GetVoiceLength("story_v_out_416061", "416061057", "story_v_out_416061.awb") / 1000

					if var_254_20 + var_254_14 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_20 + var_254_14
					end

					if var_254_16.prefab_name ~= "" and arg_251_1.actors_[var_254_16.prefab_name] ~= nil then
						local var_254_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_16.prefab_name].transform, "story_v_out_416061", "416061057", "story_v_out_416061.awb")

						arg_251_1:RecordAudio("416061057", var_254_21)
						arg_251_1:RecordAudio("416061057", var_254_21)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416061", "416061057", "story_v_out_416061.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416061", "416061057", "story_v_out_416061.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_22 = math.max(var_254_15, arg_251_1.talkMaxDuration)

			if var_254_14 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_22 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_14) / var_254_22

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_14 + var_254_22 and arg_251_1.time_ < var_254_14 + var_254_22 + arg_254_0 then
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
			},
			{
				assetPath = "",
				actorName = "1148_2",
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
	Play416061058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416061058
		arg_255_1.duration_ = 4.57

		local var_255_0 = {
			zh = 3.766,
			ja = 4.566
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
				arg_255_0:Play416061059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1028 = arg_255_1.actors_["1028"].transform.localPosition
				arg_255_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1028", 7)

				for iter_258_0 = 0, arg_255_1.actors_["1028"].transform.childCount - 1 do
					local var_258_0 = arg_255_1.actors_["1028"].transform:GetChild(iter_258_0)

					if var_258_0.name == "" or not string.find(var_258_0.name, "split") then
						var_258_0.gameObject:SetActive(true)
					else
						var_258_0.gameObject:SetActive(false)
					end
				end
			end

			local var_258_1 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 then
				arg_255_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_255_1.time_ - 0) / var_258_1)
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 then
				arg_255_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_258_2 = arg_255_1.actors_["1148"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1148 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1148", 3)

				for iter_258_1 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_1)

					if var_258_3.name == "split_2" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_258_5 = arg_255_1.actors_["1148"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.actorSpriteComps1148 == nil then
				arg_255_1.var_.actorSpriteComps1148 = var_258_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_6 = 0.125

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_6 and not isNil(var_258_5) then
				if arg_255_1.var_.actorSpriteComps1148 then
					for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_258_3 then
							if arg_255_1.isInRecall_ then
								iter_258_3.color = Color.New(Mathf.Lerp(iter_258_3.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_6), Mathf.Lerp(iter_258_3.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_6), (Mathf.Lerp(iter_258_3.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_6)))
							else
								local var_258_7 = Mathf.Lerp(iter_258_3.color.r, 1, (arg_255_1.time_ - 0) / var_258_6)

								iter_258_3.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_6 and arg_255_1.time_ < 0 + var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.actorSpriteComps1148 then
				for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_258_5 then
						iter_258_5.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1148 = nil
			end

			local var_258_8 = 0
			local var_258_9 = 0.2

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(416061058)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 8 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 8)

				if (8 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 8)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061058", "story_v_out_416061.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_out_416061", "416061058", "story_v_out_416061.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_out_416061", "416061058", "story_v_out_416061.awb")

						arg_255_1:RecordAudio("416061058", var_258_15)
						arg_255_1:RecordAudio("416061058", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416061", "416061058", "story_v_out_416061.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416061", "416061058", "story_v_out_416061.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play416061059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416061059
		arg_259_1.duration_ = 6.4

		local var_259_0 = {
			zh = 5.3,
			ja = 6.4
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
				arg_259_0:Play416061060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1148 = arg_259_1.actors_["1148"].transform.localPosition
				arg_259_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1148", 4)

				for iter_262_0 = 0, arg_259_1.actors_["1148"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["1148"].transform:GetChild(iter_262_0)

					if var_262_0.name == "split_6" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["1148"].transform.localPosition = Vector3.New(390, -429, -180)
			end

			local var_262_2 = arg_259_1.actors_["1148_2"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1148_2 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1148_2", 2)

				for iter_262_1 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_1)

					if var_262_3.name == "split_2" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1148_2, Vector3.New(-390, -429, -180), (arg_259_1.time_ - 0) / var_262_4)
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_262_5 = arg_259_1.actors_["1148"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.actorSpriteComps1148 == nil then
				arg_259_1.var_.actorSpriteComps1148 = var_262_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_6 = 0.125

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_6 and not isNil(var_262_5) then
				if arg_259_1.var_.actorSpriteComps1148 then
					for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_262_3 then
							if arg_259_1.isInRecall_ then
								iter_262_3.color = Color.New(Mathf.Lerp(iter_262_3.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_6), Mathf.Lerp(iter_262_3.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_6), (Mathf.Lerp(iter_262_3.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_6)))
							else
								local var_262_7 = Mathf.Lerp(iter_262_3.color.r, 1, (arg_259_1.time_ - 0) / var_262_6)

								iter_262_3.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_6 and arg_259_1.time_ < 0 + var_262_6 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.actorSpriteComps1148 then
				for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_262_5 then
						iter_262_5.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps1148 = nil
			end

			local var_262_8 = arg_259_1.actors_["1148_2"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1148_2 == nil then
				arg_259_1.var_.actorSpriteComps1148_2 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_9 = 0.125

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_9 and not isNil(var_262_8) then
				if arg_259_1.var_.actorSpriteComps1148_2 then
					for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps1148_2:ToTable()) do
						if iter_262_7 then
							if arg_259_1.isInRecall_ then
								iter_262_7.color = Color.New(Mathf.Lerp(iter_262_7.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_9), Mathf.Lerp(iter_262_7.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_9), (Mathf.Lerp(iter_262_7.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_9)))
							else
								local var_262_10 = Mathf.Lerp(iter_262_7.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_9)

								iter_262_7.color = Color.New(var_262_10, var_262_10, var_262_10)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_9 and arg_259_1.time_ < 0 + var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1148_2 then
				for iter_262_8, iter_262_9 in pairs(arg_259_1.var_.actorSpriteComps1148_2:ToTable()) do
					if iter_262_9 then
						iter_262_9.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps1148_2 = nil
			end

			local var_262_11 = 0
			local var_262_12 = 0.7

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_11 + arg_262_0 then
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

				local var_262_13 = arg_259_1:GetWordFromCfg(416061059)
				local var_262_14 = arg_259_1:FormatText(var_262_13.content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_16 = 28 <= 0 and var_262_12 or var_262_12 * (utf8.len(var_262_14) / 28)

				if (28 <= 0 and var_262_12 or var_262_12 * (utf8.len(var_262_14) / 28)) > 0 and var_262_12 < var_262_16 then
					arg_259_1.talkMaxDuration = var_262_16

					if var_262_16 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_16 + var_262_11
					end
				end

				arg_259_1.text_.text = var_262_14
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061059", "story_v_out_416061.awb") ~= 0 then
					local var_262_17 = manager.audio:GetVoiceLength("story_v_out_416061", "416061059", "story_v_out_416061.awb") / 1000

					if var_262_17 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_17 + var_262_11
					end

					if var_262_13.prefab_name ~= "" and arg_259_1.actors_[var_262_13.prefab_name] ~= nil then
						local var_262_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_13.prefab_name].transform, "story_v_out_416061", "416061059", "story_v_out_416061.awb")

						arg_259_1:RecordAudio("416061059", var_262_18)
						arg_259_1:RecordAudio("416061059", var_262_18)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416061", "416061059", "story_v_out_416061.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416061", "416061059", "story_v_out_416061.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_19 = math.max(var_262_12, arg_259_1.talkMaxDuration)

			if var_262_11 <= arg_259_1.time_ and arg_259_1.time_ < var_262_11 + var_262_19 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_11) / var_262_19

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_11 + var_262_19 and arg_259_1.time_ < var_262_11 + var_262_19 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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
				actorName = "1148_2",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play416061060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416061060
		arg_263_1.duration_ = 5.4

		local var_263_0 = {
			zh = 3.966,
			ja = 5.4
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
				arg_263_0:Play416061061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.45

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(416061060)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 18 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 18)

				if (18 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 18)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061060", "story_v_out_416061.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061060", "story_v_out_416061.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_416061", "416061060", "story_v_out_416061.awb")

						arg_263_1:RecordAudio("416061060", var_266_6)
						arg_263_1:RecordAudio("416061060", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_416061", "416061060", "story_v_out_416061.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_416061", "416061060", "story_v_out_416061.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play416061061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416061061
		arg_267_1.duration_ = 7.33

		local var_267_0 = {
			zh = 5.966,
			ja = 7.333
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416061062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1148"]) and arg_267_1.var_.actorSpriteComps1148 == nil then
				arg_267_1.var_.actorSpriteComps1148 = arg_267_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.125

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1148"]) then
				if arg_267_1.var_.actorSpriteComps1148 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1148"]) and arg_267_1.var_.actorSpriteComps1148 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps1148 = nil
			end

			local var_270_2 = arg_267_1.actors_["1148_2"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1148_2 == nil then
				arg_267_1.var_.actorSpriteComps1148_2 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 0.125

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps1148_2 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps1148_2:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								iter_270_5.color = Color.New(Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_5.color.r, 1, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_5.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1148_2 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps1148_2:ToTable()) do
					if iter_270_7 then
						iter_270_7.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps1148_2 = nil
			end

			local var_270_5 = 0
			local var_270_6 = 0.475

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(416061061)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 19 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 19)

				if (19 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 19)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061061", "story_v_out_416061.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_416061", "416061061", "story_v_out_416061.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_416061", "416061061", "story_v_out_416061.awb")

						arg_267_1:RecordAudio("416061061", var_270_12)
						arg_267_1:RecordAudio("416061061", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_416061", "416061061", "story_v_out_416061.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_416061", "416061061", "story_v_out_416061.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_13 and arg_267_1.time_ < var_270_5 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416061062 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416061062
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play416061063(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1148 = arg_271_1.actors_["1148"].transform.localPosition
				arg_271_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1148", 7)

				for iter_274_0 = 0, arg_271_1.actors_["1148"].transform.childCount - 1 do
					local var_274_0 = arg_271_1.actors_["1148"].transform:GetChild(iter_274_0)

					if var_274_0.name == "" or not string.find(var_274_0.name, "split") then
						var_274_0.gameObject:SetActive(true)
					else
						var_274_0.gameObject:SetActive(false)
					end
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 0) / var_274_1)
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.633333333333333 < arg_271_1.time_ and arg_271_1.time_ <= 0.633333333333333 + arg_274_0 then
				arg_271_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			local var_274_3 = arg_271_1.actors_["1148_2"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1148_2 = var_274_3.localPosition
				var_274_3.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1148_2", 7)

				for iter_274_1 = 0, var_274_3.childCount - 1 do
					local var_274_4 = var_274_3:GetChild(iter_274_1)

					if var_274_4.name == "" or not string.find(var_274_4.name, "split") then
						var_274_4.gameObject:SetActive(true)
					else
						var_274_4.gameObject:SetActive(false)
					end
				end
			end

			local var_274_5 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 then
				var_274_3.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1148_2, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 0) / var_274_5)
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 then
				var_274_3.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_6 = 0
			local var_274_7 = 1.975

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(416061062).content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 79 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_8) / 79)

				if (79 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_8) / 79)) > 0 and var_274_7 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_11 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_11 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_11

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_11 and arg_271_1.time_ < var_274_6 + var_274_11 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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
				actorName = "1148_2",
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
	Play416061063 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416061063
		arg_275_1.duration_ = 14.8

		local var_275_0 = {
			zh = 8.8,
			ja = 14.8
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
			arg_275_1.auto_ = false
		end

		function arg_275_1.playNext_(arg_277_0)
			arg_275_1.onStoryFinished_()
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.6

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1088].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:GetWordFromCfg(416061063)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 24 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 24)

				if (24 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 24)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416061", "416061063", "story_v_out_416061.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_416061", "416061063", "story_v_out_416061.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_416061", "416061063", "story_v_out_416061.awb")

						arg_275_1:RecordAudio("416061063", var_278_6)
						arg_275_1:RecordAudio("416061063", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416061", "416061063", "story_v_out_416061.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416061", "416061063", "story_v_out_416061.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/SS1603"
	},
	voices = {
		"story_v_out_416061.awb"
	}
}
