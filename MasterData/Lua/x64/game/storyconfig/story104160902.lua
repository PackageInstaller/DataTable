return {
	Play416092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416092001
		arg_1_1.duration_ = 5.33

		local var_1_0 = {
			zh = 4.766,
			ja = 5.333
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
				arg_1_0:Play416092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.3 and arg_1_1.time_ < 2 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "I14f"

			if arg_1_1.bgs_.I14f == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.I14f

				arg_1_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I14f" then
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

			local var_4_12 = arg_1_1.actors_["1148"].transform

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1148", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_6" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_1_1.time_ - 1.66666666666667) / var_4_14)
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_14 and arg_1_1.time_ < 1.66666666666667 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -429, -180)
			end

			local var_4_15 = arg_1_1.actors_["1148"]

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1148 == nil then
				arg_1_1.var_.actorSpriteComps1148 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.125

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps1148 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.66666666666667) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.66666666666667) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.66666666666667) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_16 and arg_1_1.time_ < 1.66666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1148 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1148 = nil
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1148 = var_4_18.alpha
					arg_1_1.var_.characterEffect1148 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1148 = 0
			end

			local var_4_19 = 0.4

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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_138", "se_story_138_5220109Talk_ambience_stop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_27 = 2
			local var_4_28 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_30 = arg_1_1:GetWordFromCfg(416092001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)

				if (10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)) > 0 and var_4_28 < var_4_33 then
					arg_1_1.talkMaxDuration = var_4_33
					var_4_27 = var_4_27 + 0.3

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_31
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092001", "story_v_out_416092.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_416092", "416092001", "story_v_out_416092.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_416092", "416092001", "story_v_out_416092.awb")

						arg_1_1:RecordAudio("416092001", var_4_35)
						arg_1_1:RecordAudio("416092001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416092", "416092001", "story_v_out_416092.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416092", "416092001", "story_v_out_416092.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_27 + 0.3
			local var_4_37 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
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
	Play416092002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416092002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416092003(arg_9_1)
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

			if 0.633333333333333 < arg_9_1.time_ and arg_9_1.time_ <= 0.633333333333333 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			local var_12_3 = 0
			local var_12_4 = 1.725

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416092002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 69 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 69)

				if (69 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 69)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
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
	Play416092003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416092003
		arg_13_1.duration_ = 2.43

		local var_13_0 = {
			zh = 2.433,
			ja = 2.4
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
				arg_13_0:Play416092004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1148 = arg_13_1.actors_["1148"].transform.localPosition
				arg_13_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1148", 3)

				for iter_16_0 = 0, arg_13_1.actors_["1148"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1148"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_3" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_16_2 = arg_13_1.actors_["1148"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1148 == nil then
				arg_13_1.var_.actorSpriteComps1148 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.125

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps1148 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1148 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1148 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
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

				local var_16_7 = arg_13_1:GetWordFromCfg(416092003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 10 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 10)

				if (10 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 10)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092003", "story_v_out_416092.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092003", "story_v_out_416092.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_416092", "416092003", "story_v_out_416092.awb")

						arg_13_1:RecordAudio("416092003", var_16_12)
						arg_13_1:RecordAudio("416092003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416092", "416092003", "story_v_out_416092.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416092", "416092003", "story_v_out_416092.awb")
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
				actorName = "1148",
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
	Play416092004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416092004
		arg_17_1.duration_ = 2.63

		local var_17_0 = {
			zh = 2.633,
			ja = 2.4
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
				arg_17_0:Play416092005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
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

				local var_20_1 = arg_17_1:GetWordFromCfg(416092004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 10 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 10)

				if (10 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 10)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092004", "story_v_out_416092.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092004", "story_v_out_416092.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_416092", "416092004", "story_v_out_416092.awb")

						arg_17_1:RecordAudio("416092004", var_20_6)
						arg_17_1:RecordAudio("416092004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416092", "416092004", "story_v_out_416092.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416092", "416092004", "story_v_out_416092.awb")
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
	Play416092005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416092005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416092006(arg_21_1)
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

			local var_24_2 = 0
			local var_24_3 = 0.85

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(416092005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 34 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 34)

				if (34 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 34)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
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
	Play416092006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416092006
		arg_25_1.duration_ = 2.33

		local var_25_0 = {
			zh = 2.2,
			ja = 2.333
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
				arg_25_0:Play416092007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = arg_25_1.actors_["1148"].transform.localPosition
				arg_25_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1148", 3)

				for iter_28_0 = 0, arg_25_1.actors_["1148"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1148"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_6" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_28_2 = arg_25_1.actors_["1148"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1148 == nil then
				arg_25_1.var_.actorSpriteComps1148 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.125

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1148 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1148 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1148 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
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

				local var_28_7 = arg_25_1:GetWordFromCfg(416092006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 11 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 11)

				if (11 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 11)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092006", "story_v_out_416092.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092006", "story_v_out_416092.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_416092", "416092006", "story_v_out_416092.awb")

						arg_25_1:RecordAudio("416092006", var_28_12)
						arg_25_1:RecordAudio("416092006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416092", "416092006", "story_v_out_416092.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416092", "416092006", "story_v_out_416092.awb")
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
	Play416092007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416092007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416092008(arg_29_1)
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

			if 0.766666666666667 < arg_29_1.time_ and arg_29_1.time_ <= 0.766666666666667 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_127", "se_story_127_hot", "")
			end

			local var_32_3 = 0
			local var_32_4 = 0.9

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(416092007).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 36 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 36)

				if (36 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 36)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
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
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play416092008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416092008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416092009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(416092008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 48 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 48)

				if (48 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 48)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416092009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416092009
		arg_37_1.duration_ = 3

		local var_37_0 = {
			zh = 2.766,
			ja = 3
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
				arg_37_0:Play416092010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = arg_37_1.actors_["1148"].transform.localPosition
				arg_37_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 3)

				for iter_40_0 = 0, arg_37_1.actors_["1148"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1148"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_3" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
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
								iter_40_2.color = Color.New(Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_2.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_2.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1148 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1148 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(416092009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 10 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 10)

				if (10 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 10)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092009", "story_v_out_416092.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092009", "story_v_out_416092.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_416092", "416092009", "story_v_out_416092.awb")

						arg_37_1:RecordAudio("416092009", var_40_12)
						arg_37_1:RecordAudio("416092009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416092", "416092009", "story_v_out_416092.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416092", "416092009", "story_v_out_416092.awb")
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
	Play416092010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416092010
		arg_41_1.duration_ = 7.43

		local var_41_0 = {
			zh = 3.666,
			ja = 7.433
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
				arg_41_0:Play416092011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1148"]) and arg_41_1.var_.actorSpriteComps1148 == nil then
				arg_41_1.var_.actorSpriteComps1148 = arg_41_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1148"]) then
				if arg_41_1.var_.actorSpriteComps1148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1148"]) and arg_41_1.var_.actorSpriteComps1148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1148 = nil
			end

			local var_44_2 = 0
			local var_44_3 = 0.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_4 = arg_41_1:GetWordFromCfg(416092010)
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092010", "story_v_out_416092.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092010", "story_v_out_416092.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_416092", "416092010", "story_v_out_416092.awb")

						arg_41_1:RecordAudio("416092010", var_44_9)
						arg_41_1:RecordAudio("416092010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416092", "416092010", "story_v_out_416092.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416092", "416092010", "story_v_out_416092.awb")
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
	Play416092011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416092011
		arg_45_1.duration_ = 1.7

		local var_45_0 = {
			zh = 1.7,
			ja = 1.2
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
				arg_45_0:Play416092012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1148"]) and arg_45_1.var_.actorSpriteComps1148 == nil then
				arg_45_1.var_.actorSpriteComps1148 = arg_45_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1148"]) then
				if arg_45_1.var_.actorSpriteComps1148 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 1, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1148"]) and arg_45_1.var_.actorSpriteComps1148 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1148 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
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

				local var_48_4 = arg_45_1:GetWordFromCfg(416092011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 5 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 5)

				if (5 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 5)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092011", "story_v_out_416092.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_416092", "416092011", "story_v_out_416092.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_416092", "416092011", "story_v_out_416092.awb")

						arg_45_1:RecordAudio("416092011", var_48_9)
						arg_45_1:RecordAudio("416092011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416092", "416092011", "story_v_out_416092.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416092", "416092011", "story_v_out_416092.awb")
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
	Play416092012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416092012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play416092013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1148 = arg_49_1.actors_["1148"].transform.localPosition
				arg_49_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1148", 7)

				for iter_52_0 = 0, arg_49_1.actors_["1148"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1148"].transform:GetChild(iter_52_0)

					if var_52_0.name == "split_6" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.5 < arg_49_1.time_ and arg_49_1.time_ <= 0.5 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_138", "se_story_138_footstep", "")
			end

			local var_52_3 = 0
			local var_52_4 = 1.625

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(416092012).content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 65 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 65)

				if (65 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 65)) > 0 and var_52_4 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_8 and arg_49_1.time_ < var_52_3 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play416092013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416092013
		arg_53_1.duration_ = 3.93

		local var_53_0 = {
			zh = 3.233,
			ja = 3.933
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
				arg_53_0:Play416092014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["10123"] == nil then
				local var_56_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10123")

				if not isNil(var_56_0) then
					local var_56_1 = Object.Instantiate(var_56_0, arg_53_1.canvasGo_.transform)

					var_56_1.transform:SetSiblingIndex(1)

					var_56_1.name = "10123"
					var_56_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_53_1.actors_["10123"] = var_56_1

					if arg_53_1.isInRecall_ then
						for iter_56_0, iter_56_1 in ipairs((var_56_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_56_1.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_56_2 = arg_53_1.actors_["10123"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10123 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10123", 3)

				for iter_56_2 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_2)

					if var_56_3.name == "split_6" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_56_5 = arg_53_1.actors_["10123"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps10123 == nil then
				arg_53_1.var_.actorSpriteComps10123 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.125

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps10123 then
					for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_56_4 then
							if arg_53_1.isInRecall_ then
								iter_56_4.color = Color.New(Mathf.Lerp(iter_56_4.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_4.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_4.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_4.color.r, 1, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_4.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps10123 then
				for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_56_6 then
						iter_56_6.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10123 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(416092013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 10 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 10)

				if (10 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 10)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092013", "story_v_out_416092.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092013", "story_v_out_416092.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_416092", "416092013", "story_v_out_416092.awb")

						arg_53_1:RecordAudio("416092013", var_56_15)
						arg_53_1:RecordAudio("416092013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416092", "416092013", "story_v_out_416092.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416092", "416092013", "story_v_out_416092.awb")
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
				actorName = "10123",
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
	Play416092014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416092014
		arg_57_1.duration_ = 5.23

		local var_57_0 = {
			zh = 5.233,
			ja = 4.966
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
				arg_57_0:Play416092015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1148"]) and arg_57_1.var_.actorSpriteComps1148 == nil then
				arg_57_1.var_.actorSpriteComps1148 = arg_57_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1148"]) then
				if arg_57_1.var_.actorSpriteComps1148 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1148"]) and arg_57_1.var_.actorSpriteComps1148 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1148 = nil
			end

			local var_60_2 = arg_57_1.actors_["1148"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1148 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1148", 3)

				for iter_60_4 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_4)

					if var_60_3.name == "split_3" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_60_5 = arg_57_1.actors_["10123"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10123 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10123", 7)

				for iter_60_5 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_5)

					if var_60_6.name == "split_6" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_8 = 0
			local var_60_9 = 0.525

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
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

				local var_60_10 = arg_57_1:GetWordFromCfg(416092014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 21 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 21)

				if (21 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 21)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092014", "story_v_out_416092.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092014", "story_v_out_416092.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_416092", "416092014", "story_v_out_416092.awb")

						arg_57_1:RecordAudio("416092014", var_60_15)
						arg_57_1:RecordAudio("416092014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416092", "416092014", "story_v_out_416092.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416092", "416092014", "story_v_out_416092.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "10123",
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
	Play416092015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416092015
		arg_61_1.duration_ = 5.63

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416092016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_9001
			local var_64_9000

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148 = arg_61_1.actors_["1148"].transform.localPosition
				arg_61_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1148", 7)

				for iter_64_0 = 0, arg_61_1.actors_["1148"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1148"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_2 = arg_61_1.var_.effect21051

				if not arg_61_1.var_.effect21051 then
					var_64_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_64_2.name = "21051"
					arg_61_1.var_.effect21051 = var_64_2
				else
					var_64_2.transform:SetParent(var_64_9001)
				end

				var_64_2.transform.localPosition = Vector3.New(0, -0.32, 1.45)
				var_64_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.233333333333334 < arg_61_1.time_ and arg_61_1.time_ <= 0.233333333333334 + arg_64_0 then
				if arg_61_1.var_.effect21051 then
					Object.Destroy(arg_61_1.var_.effect21051)

					arg_61_1.var_.effect21051 = nil
				end
			end

			if 0.233333333333333 < arg_61_1.time_ and arg_61_1.time_ <= 0.233333333333333 + arg_64_0 then
				local var_64_5 = arg_61_1.var_.effect21052

				if not arg_61_1.var_.effect21052 then
					var_64_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_64_5.name = "21052"
					arg_61_1.var_.effect21052 = var_64_5
				else
					var_64_5.transform:SetParent(var_64_9000)
				end

				var_64_5.transform.localPosition = Vector3.New(0.5, -0.26, 0)
				var_64_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_64_7 = manager.ui.mainCamera.transform

			if 0.466666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 0.466666666666667 + arg_64_0 then
				if arg_61_1.var_.effect21052 then
					Object.Destroy(arg_61_1.var_.effect21052)

					arg_61_1.var_.effect21052 = nil
				end
			end

			local var_64_8 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.var_.shakeOldPos = var_64_7.localPosition
			end

			local var_64_9 = 0.440613901941106

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 then
				local var_64_10, var_64_11 = math.modf((arg_61_1.time_ - var_64_8) / 0.066)

				var_64_7.localPosition = Vector3.New(var_64_11 * 0.13, var_64_11 * 0.13, var_64_11 * 0.13) + arg_61_1.var_.shakeOldPos
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 then
				var_64_7.localPosition = arg_61_1.var_.shakeOldPos
			end

			if 0.1 < arg_61_1.time_ and arg_61_1.time_ <= 0.1 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_13 = 0.633333333333333
			local var_64_14 = 1.525

			if 0.633333333333333 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_15 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_15:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(416092015).content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_18 = 61 <= 0 and var_64_14 or var_64_14 * (utf8.len(var_64_16) / 61)

				if (61 <= 0 and var_64_14 or var_64_14 * (utf8.len(var_64_16) / 61)) > 0 and var_64_14 < var_64_18 then
					arg_61_1.talkMaxDuration = var_64_18
					var_64_13 = var_64_13 + 0.3

					if var_64_18 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_13
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_19 = var_64_13 + 0.3
			local var_64_20 = math.max(var_64_14, arg_61_1.talkMaxDuration)

			if var_64_13 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_19 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_19) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_19 + var_64_20 and arg_61_1.time_ < var_64_19 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
	Play416092016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416092016
		arg_67_1.duration_ = 4.33

		local var_67_0 = {
			zh = 3.166,
			ja = 4.333
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416092017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1148 = arg_67_1.actors_["1148"].transform.localPosition
				arg_67_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1148", 3)

				for iter_70_0 = 0, arg_67_1.actors_["1148"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["1148"].transform:GetChild(iter_70_0)

					if var_70_0.name == "split_6" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_70_2 = arg_67_1.actors_["1148"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1148 == nil then
				arg_67_1.var_.actorSpriteComps1148 = var_70_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_3 = 0.125

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.actorSpriteComps1148 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								iter_70_2.color = Color.New(Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_3), Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_3), (Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_3)))
							else
								local var_70_4 = Mathf.Lerp(iter_70_2.color.r, 1, (arg_67_1.time_ - 0) / var_70_3)

								iter_70_2.color = Color.New(var_70_4, var_70_4, var_70_4)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1148 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_70_4 then
						iter_70_4.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps1148 = nil
			end

			local var_70_5 = 0
			local var_70_6 = 0.275

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:GetWordFromCfg(416092016)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 11 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 11)

				if (11 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 11)) > 0 and var_70_6 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_5
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092016", "story_v_out_416092.awb") ~= 0 then
					local var_70_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092016", "story_v_out_416092.awb") / 1000

					if var_70_11 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_5
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_416092", "416092016", "story_v_out_416092.awb")

						arg_67_1:RecordAudio("416092016", var_70_12)
						arg_67_1:RecordAudio("416092016", var_70_12)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_416092", "416092016", "story_v_out_416092.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_416092", "416092016", "story_v_out_416092.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_13 = math.max(var_70_6, arg_67_1.talkMaxDuration)

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_13 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_5) / var_70_13

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_5 + var_70_13 and arg_67_1.time_ < var_70_5 + var_70_13 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play416092017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416092017
		arg_71_1.duration_ = 8.5

		local var_71_0 = {
			zh = 3.7,
			ja = 8.5
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
				arg_71_0:Play416092018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10123 = arg_71_1.actors_["10123"].transform.localPosition
				arg_71_1.actors_["10123"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10123", 3)

				for iter_74_0 = 0, arg_71_1.actors_["10123"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["10123"].transform:GetChild(iter_74_0)

					if var_74_0.name == "split_6" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["10123"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["10123"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_74_2 = arg_71_1.actors_["10123"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10123 == nil then
				arg_71_1.var_.actorSpriteComps10123 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.125

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps10123 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								iter_74_2.color = Color.New(Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_2.color.r, 1, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_2.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10123 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_74_4 then
						iter_74_4.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps10123 = nil
			end

			local var_74_5 = 0
			local var_74_6 = 0.275

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(416092017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 11 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 11)

				if (11 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 11)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092017", "story_v_out_416092.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092017", "story_v_out_416092.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_416092", "416092017", "story_v_out_416092.awb")

						arg_71_1:RecordAudio("416092017", var_74_12)
						arg_71_1:RecordAudio("416092017", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416092", "416092017", "story_v_out_416092.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416092", "416092017", "story_v_out_416092.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_13 and arg_71_1.time_ < var_74_5 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play416092018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416092018
		arg_75_1.duration_ = 4.63

		local var_75_0 = {
			zh = 4.566,
			ja = 4.633
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
				arg_75_0:Play416092019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1148"]) and arg_75_1.var_.actorSpriteComps1148 == nil then
				arg_75_1.var_.actorSpriteComps1148 = arg_75_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.125

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1148"]) then
				if arg_75_1.var_.actorSpriteComps1148 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 1, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1148"]) and arg_75_1.var_.actorSpriteComps1148 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1148 = nil
			end

			local var_78_2 = arg_75_1.actors_["1148"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1148 = var_78_2.localPosition
				var_78_2.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1148", 4)

				for iter_78_4 = 0, var_78_2.childCount - 1 do
					local var_78_3 = var_78_2:GetChild(iter_78_4)

					if var_78_3.name == "split_3" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_2.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_75_1.time_ - 0) / var_78_4)
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_2.localPosition = Vector3.New(390, -429, -180)
			end

			local var_78_5 = arg_75_1.actors_["10123"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10123 = var_78_5.localPosition
				var_78_5.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10123", 2)

				for iter_78_5 = 0, var_78_5.childCount - 1 do
					local var_78_6 = var_78_5:GetChild(iter_78_5)

					if var_78_6.name == "split_6" or not string.find(var_78_6.name, "split") then
						var_78_6.gameObject:SetActive(true)
					else
						var_78_6.gameObject:SetActive(false)
					end
				end
			end

			local var_78_7 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10123, Vector3.New(-390, -400, 0), (arg_75_1.time_ - 0) / var_78_7)
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_78_8 = arg_75_1.actors_["10123"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_8) and arg_75_1.var_.actorSpriteComps10123 == nil then
				arg_75_1.var_.actorSpriteComps10123 = var_78_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 0.125

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_9 and not isNil(var_78_8) then
				if arg_75_1.var_.actorSpriteComps10123 then
					for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_78_7 then
							if arg_75_1.isInRecall_ then
								iter_78_7.color = Color.New(Mathf.Lerp(iter_78_7.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_9), Mathf.Lerp(iter_78_7.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_9), (Mathf.Lerp(iter_78_7.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_9)))
							else
								local var_78_10 = Mathf.Lerp(iter_78_7.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_9)

								iter_78_7.color = Color.New(var_78_10, var_78_10, var_78_10)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_9 and arg_75_1.time_ < 0 + var_78_9 + arg_78_0 and not isNil(var_78_8) and arg_75_1.var_.actorSpriteComps10123 then
				for iter_78_8, iter_78_9 in pairs(arg_75_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_78_9 then
						iter_78_9.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps10123 = nil
			end

			local var_78_11 = 0
			local var_78_12 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(416092018)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_16 = 18 <= 0 and var_78_12 or var_78_12 * (utf8.len(var_78_14) / 18)

				if (18 <= 0 and var_78_12 or var_78_12 * (utf8.len(var_78_14) / 18)) > 0 and var_78_12 < var_78_16 then
					arg_75_1.talkMaxDuration = var_78_16

					if var_78_16 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_16 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092018", "story_v_out_416092.awb") ~= 0 then
					local var_78_17 = manager.audio:GetVoiceLength("story_v_out_416092", "416092018", "story_v_out_416092.awb") / 1000

					if var_78_17 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_11
					end

					if var_78_13.prefab_name ~= "" and arg_75_1.actors_[var_78_13.prefab_name] ~= nil then
						local var_78_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_13.prefab_name].transform, "story_v_out_416092", "416092018", "story_v_out_416092.awb")

						arg_75_1:RecordAudio("416092018", var_78_18)
						arg_75_1:RecordAudio("416092018", var_78_18)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416092", "416092018", "story_v_out_416092.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416092", "416092018", "story_v_out_416092.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_19 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_19 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_19

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_19 and arg_75_1.time_ < var_78_11 + var_78_19 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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
				actorName = "10123",
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
	Play416092019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416092019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416092020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1148 = arg_79_1.actors_["1148"].transform.localPosition
				arg_79_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1148", 7)

				for iter_82_0 = 0, arg_79_1.actors_["1148"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["1148"].transform:GetChild(iter_82_0)

					if var_82_0.name == "" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_2 = arg_79_1.actors_["10123"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10123 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10123", 7)

				for iter_82_1 = 0, var_82_2.childCount - 1 do
					local var_82_3 = var_82_2:GetChild(iter_82_1)

					if var_82_3.name == "split_6" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_4)
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_5 = 0
			local var_82_6 = 1.55

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(416092019).content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 62 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 62)

				if (62 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 62)) > 0 and var_82_6 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_10 and arg_79_1.time_ < var_82_5 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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
				actorName = "10123",
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
	Play416092020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416092020
		arg_83_1.duration_ = 9.53

		local var_83_0 = {
			zh = 7.066,
			ja = 9.533
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
				arg_83_0:Play416092021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10123 = arg_83_1.actors_["10123"].transform.localPosition
				arg_83_1.actors_["10123"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10123", 3)

				for iter_86_0 = 0, arg_83_1.actors_["10123"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["10123"].transform:GetChild(iter_86_0)

					if var_86_0.name == "split_6" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["10123"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["10123"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_86_2 = arg_83_1.actors_["10123"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10123 == nil then
				arg_83_1.var_.actorSpriteComps10123 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.125

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10123 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								iter_86_2.color = Color.New(Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_2.color.r, 1, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_2.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10123 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps10123 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(416092020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 26 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 26)

				if (26 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 26)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092020", "story_v_out_416092.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092020", "story_v_out_416092.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_416092", "416092020", "story_v_out_416092.awb")

						arg_83_1:RecordAudio("416092020", var_86_12)
						arg_83_1:RecordAudio("416092020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_416092", "416092020", "story_v_out_416092.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_416092", "416092020", "story_v_out_416092.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_13 and arg_83_1.time_ < var_86_5 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416092021
		arg_87_1.duration_ = 4.33

		local var_87_0 = {
			zh = 3,
			ja = 4.333
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
				arg_87_0:Play416092022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.15

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(416092021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 6 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 6)

				if (6 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 6)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092021", "story_v_out_416092.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092021", "story_v_out_416092.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_416092", "416092021", "story_v_out_416092.awb")

						arg_87_1:RecordAudio("416092021", var_90_6)
						arg_87_1:RecordAudio("416092021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_416092", "416092021", "story_v_out_416092.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_416092", "416092021", "story_v_out_416092.awb")
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
	Play416092022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416092022
		arg_91_1.duration_ = 8

		local var_91_0 = {
			zh = 3.433,
			ja = 8
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
				arg_91_0:Play416092023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1148 = arg_91_1.actors_["1148"].transform.localPosition
				arg_91_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1148", 4)

				for iter_94_0 = 0, arg_91_1.actors_["1148"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["1148"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_3" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1148"].transform.localPosition = Vector3.New(390, -429, -180)
			end

			local var_94_2 = arg_91_1.actors_["1148"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1148 == nil then
				arg_91_1.var_.actorSpriteComps1148 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.125

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps1148 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								iter_94_2.color = Color.New(Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_3), Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_3), (Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_3)))
							else
								local var_94_4 = Mathf.Lerp(iter_94_2.color.r, 1, (arg_91_1.time_ - 0) / var_94_3)

								iter_94_2.color = Color.New(var_94_4, var_94_4, var_94_4)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1148 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_94_4 then
						iter_94_4.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps1148 = nil
			end

			local var_94_5 = arg_91_1.actors_["10123"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10123 = var_94_5.localPosition
				var_94_5.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10123", 2)

				for iter_94_5 = 0, var_94_5.childCount - 1 do
					local var_94_6 = var_94_5:GetChild(iter_94_5)

					if var_94_6.name == "split_6" or not string.find(var_94_6.name, "split") then
						var_94_6.gameObject:SetActive(true)
					else
						var_94_6.gameObject:SetActive(false)
					end
				end
			end

			local var_94_7 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				var_94_5.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10123, Vector3.New(-390, -400, 0), (arg_91_1.time_ - 0) / var_94_7)
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				var_94_5.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_94_8 = arg_91_1.actors_["10123"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10123 == nil then
				arg_91_1.var_.actorSpriteComps10123 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.125

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_9 and not isNil(var_94_8) then
				if arg_91_1.var_.actorSpriteComps10123 then
					for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_94_7 then
							if arg_91_1.isInRecall_ then
								iter_94_7.color = Color.New(Mathf.Lerp(iter_94_7.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_9), Mathf.Lerp(iter_94_7.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_9), (Mathf.Lerp(iter_94_7.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_9)))
							else
								local var_94_10 = Mathf.Lerp(iter_94_7.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_9)

								iter_94_7.color = Color.New(var_94_10, var_94_10, var_94_10)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_9 and arg_91_1.time_ < 0 + var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10123 then
				for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_94_9 then
						iter_94_9.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10123 = nil
			end

			local var_94_11 = 0
			local var_94_12 = 0.45

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
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

				local var_94_13 = arg_91_1:GetWordFromCfg(416092022)
				local var_94_14 = arg_91_1:FormatText(var_94_13.content)

				arg_91_1.text_.text = var_94_14

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_16 = 18 <= 0 and var_94_12 or var_94_12 * (utf8.len(var_94_14) / 18)

				if (18 <= 0 and var_94_12 or var_94_12 * (utf8.len(var_94_14) / 18)) > 0 and var_94_12 < var_94_16 then
					arg_91_1.talkMaxDuration = var_94_16

					if var_94_16 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_16 + var_94_11
					end
				end

				arg_91_1.text_.text = var_94_14
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092022", "story_v_out_416092.awb") ~= 0 then
					local var_94_17 = manager.audio:GetVoiceLength("story_v_out_416092", "416092022", "story_v_out_416092.awb") / 1000

					if var_94_17 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_17 + var_94_11
					end

					if var_94_13.prefab_name ~= "" and arg_91_1.actors_[var_94_13.prefab_name] ~= nil then
						local var_94_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_13.prefab_name].transform, "story_v_out_416092", "416092022", "story_v_out_416092.awb")

						arg_91_1:RecordAudio("416092022", var_94_18)
						arg_91_1:RecordAudio("416092022", var_94_18)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_416092", "416092022", "story_v_out_416092.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_416092", "416092022", "story_v_out_416092.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_19 = math.max(var_94_12, arg_91_1.talkMaxDuration)

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_19 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_11) / var_94_19

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_11 + var_94_19 and arg_91_1.time_ < var_94_11 + var_94_19 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play416092023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416092023
		arg_95_1.duration_ = 4.6

		local var_95_0 = {
			zh = 4.1,
			ja = 4.6
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play416092024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.325

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(416092023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 13 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 13)

				if (13 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 13)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092023", "story_v_out_416092.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092023", "story_v_out_416092.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_416092", "416092023", "story_v_out_416092.awb")

						arg_95_1:RecordAudio("416092023", var_98_6)
						arg_95_1:RecordAudio("416092023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_416092", "416092023", "story_v_out_416092.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_416092", "416092023", "story_v_out_416092.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play416092024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416092024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play416092025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1148 = arg_99_1.actors_["1148"].transform.localPosition
				arg_99_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1148", 7)

				for iter_102_0 = 0, arg_99_1.actors_["1148"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["1148"].transform:GetChild(iter_102_0)

					if var_102_0.name == "" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_gun02", "")
			end

			local var_102_3 = arg_99_1.actors_["10123"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10123 = var_102_3.localPosition
				var_102_3.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10123", 7)

				for iter_102_1 = 0, var_102_3.childCount - 1 do
					local var_102_4 = var_102_3:GetChild(iter_102_1)

					if var_102_4.name == "split_6" or not string.find(var_102_4.name, "split") then
						var_102_4.gameObject:SetActive(true)
					else
						var_102_4.gameObject:SetActive(false)
					end
				end
			end

			local var_102_5 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_99_1.time_ - 0) / var_102_5)
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_102_6 = 0
			local var_102_7 = 1.825

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(416092024).content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 73 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_8) / 73)

				if (73 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_8) / 73)) > 0 and var_102_7 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_11 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_11 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_11

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_11 and arg_99_1.time_ < var_102_6 + var_102_11 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play416092025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416092025
		arg_103_1.duration_ = 7.13

		local var_103_0 = {
			zh = 3.7,
			ja = 7.133
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
				arg_103_0:Play416092026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1148 = arg_103_1.actors_["1148"].transform.localPosition
				arg_103_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1148", 3)

				for iter_106_0 = 0, arg_103_1.actors_["1148"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["1148"].transform:GetChild(iter_106_0)

					if var_106_0.name == "split_3" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_106_2 = arg_103_1.actors_["1148"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1148 == nil then
				arg_103_1.var_.actorSpriteComps1148 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 0.125

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps1148 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1148 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_106_4 then
						iter_106_4.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1148 = nil
			end

			local var_106_5 = 0
			local var_106_6 = 0.3

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(416092025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 12 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 12)

				if (12 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 12)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092025", "story_v_out_416092.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092025", "story_v_out_416092.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_416092", "416092025", "story_v_out_416092.awb")

						arg_103_1:RecordAudio("416092025", var_106_12)
						arg_103_1:RecordAudio("416092025", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416092", "416092025", "story_v_out_416092.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416092", "416092025", "story_v_out_416092.awb")
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
				actorName = "1148",
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
	Play416092026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416092026
		arg_107_1.duration_ = 13.37

		local var_107_0 = {
			zh = 9.4,
			ja = 13.366
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
				arg_107_0:Play416092027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1148"]) and arg_107_1.var_.actorSpriteComps1148 == nil then
				arg_107_1.var_.actorSpriteComps1148 = arg_107_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.125

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1148"]) then
				if arg_107_1.var_.actorSpriteComps1148 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1148"]) and arg_107_1.var_.actorSpriteComps1148 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1148 = nil
			end

			local var_110_2 = arg_107_1.actors_["10123"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10123 = var_110_2.localPosition
				var_110_2.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10123", 3)

				for iter_110_4 = 0, var_110_2.childCount - 1 do
					local var_110_3 = var_110_2:GetChild(iter_110_4)

					if var_110_3.name == "split_6" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_107_1.time_ - 0) / var_110_4)
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_110_5 = arg_107_1.actors_["10123"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.actorSpriteComps10123 == nil then
				arg_107_1.var_.actorSpriteComps10123 = var_110_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_6 = 0.125

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 and not isNil(var_110_5) then
				if arg_107_1.var_.actorSpriteComps10123 then
					for iter_110_5, iter_110_6 in pairs(arg_107_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_110_6 then
							if arg_107_1.isInRecall_ then
								iter_110_6.color = Color.New(Mathf.Lerp(iter_110_6.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_6), Mathf.Lerp(iter_110_6.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_6), (Mathf.Lerp(iter_110_6.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_6)))
							else
								local var_110_7 = Mathf.Lerp(iter_110_6.color.r, 1, (arg_107_1.time_ - 0) / var_110_6)

								iter_110_6.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.actorSpriteComps10123 then
				for iter_110_7, iter_110_8 in pairs(arg_107_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_110_8 then
						iter_110_8.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10123 = nil
			end

			local var_110_8 = 0
			local var_110_9 = 0.775

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(416092026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 31 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 31)

				if (31 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 31)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092026", "story_v_out_416092.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092026", "story_v_out_416092.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_416092", "416092026", "story_v_out_416092.awb")

						arg_107_1:RecordAudio("416092026", var_110_15)
						arg_107_1:RecordAudio("416092026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416092", "416092026", "story_v_out_416092.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416092", "416092026", "story_v_out_416092.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416092027
		arg_111_1.duration_ = 4.23

		local var_111_0 = {
			zh = 3.766,
			ja = 4.233
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
				arg_111_0:Play416092028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0.166666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.166666666666667 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_114_0 = 0.433333333333333

			if 0.166666666666667 <= arg_111_1.time_ and arg_111_1.time_ < 0.166666666666667 + var_114_0 then
				local var_114_1, var_114_2 = math.modf((arg_111_1.time_ - 0.166666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_114_2 * 0.13, var_114_2 * 0.13, var_114_2 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= 0.166666666666667 + var_114_0 and arg_111_1.time_ < 0.166666666666667 + var_114_0 + arg_114_0 then
				manager.ui.mainCamera.transform.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_3 = 0
			local var_114_4 = 0.225

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(416092027)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 9 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_6) / 9)

				if (9 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_6) / 9)) > 0 and var_114_4 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_3
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092027", "story_v_out_416092.awb") ~= 0 then
					local var_114_9 = manager.audio:GetVoiceLength("story_v_out_416092", "416092027", "story_v_out_416092.awb") / 1000

					if var_114_9 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_3
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_out_416092", "416092027", "story_v_out_416092.awb")

						arg_111_1:RecordAudio("416092027", var_114_10)
						arg_111_1:RecordAudio("416092027", var_114_10)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416092", "416092027", "story_v_out_416092.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416092", "416092027", "story_v_out_416092.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_11 = math.max(var_114_4, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_11 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_3) / var_114_11

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_11 and arg_111_1.time_ < var_114_3 + var_114_11 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416092028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416092028
		arg_115_1.duration_ = 6.43

		local var_115_0 = {
			zh = 6.433,
			ja = 5.266
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
				arg_115_0:Play416092029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1148"]) and arg_115_1.var_.actorSpriteComps1148 == nil then
				arg_115_1.var_.actorSpriteComps1148 = arg_115_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.125

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1148"]) then
				if arg_115_1.var_.actorSpriteComps1148 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								iter_118_1.color = Color.New(Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_0), Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_0), (Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_0)))
							else
								local var_118_1 = Mathf.Lerp(iter_118_1.color.r, 1, (arg_115_1.time_ - 0) / var_118_0)

								iter_118_1.color = Color.New(var_118_1, var_118_1, var_118_1)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1148"]) and arg_115_1.var_.actorSpriteComps1148 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps1148 = nil
			end

			local var_118_2 = arg_115_1.actors_["1148"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 3)

				for iter_118_4 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_4)

					if var_118_3.name == "split_3" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_118_5 = arg_115_1.actors_["10123"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10123 = var_118_5.localPosition
				var_118_5.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10123", 7)

				for iter_118_5 = 0, var_118_5.childCount - 1 do
					local var_118_6 = var_118_5:GetChild(iter_118_5)

					if var_118_6.name == "split_6" or not string.find(var_118_6.name, "split") then
						var_118_6.gameObject:SetActive(true)
					else
						var_118_6.gameObject:SetActive(false)
					end
				end
			end

			local var_118_7 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_115_1.time_ - 0) / var_118_7)
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_8 = 0
			local var_118_9 = 0.7

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(416092028)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 28 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 28)

				if (28 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 28)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092028", "story_v_out_416092.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092028", "story_v_out_416092.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_416092", "416092028", "story_v_out_416092.awb")

						arg_115_1:RecordAudio("416092028", var_118_15)
						arg_115_1:RecordAudio("416092028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416092", "416092028", "story_v_out_416092.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416092", "416092028", "story_v_out_416092.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play416092029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416092029
		arg_119_1.duration_ = 9.43

		local var_119_0 = {
			zh = 8.766,
			ja = 9.433
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
				arg_119_0:Play416092030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10123 = arg_119_1.actors_["10123"].transform.localPosition
				arg_119_1.actors_["10123"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10123", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10123"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10123"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_6" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10123"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10123"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_122_2 = arg_119_1.actors_["10123"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10123 == nil then
				arg_119_1.var_.actorSpriteComps10123 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.125

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10123 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								iter_122_2.color = Color.New(Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_2.color.r, 1, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_2.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10123 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10123 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.575

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(416092029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 23 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 23)

				if (23 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 23)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092029", "story_v_out_416092.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092029", "story_v_out_416092.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_416092", "416092029", "story_v_out_416092.awb")

						arg_119_1:RecordAudio("416092029", var_122_12)
						arg_119_1:RecordAudio("416092029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416092", "416092029", "story_v_out_416092.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416092", "416092029", "story_v_out_416092.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play416092030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416092030
		arg_123_1.duration_ = 5.67

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416092031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_0 = arg_123_1.var_.effect0902

				if not arg_123_1.var_.effect0902 then
					var_126_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_126_0.name = "0902"
					arg_123_1.var_.effect0902 = var_126_0
				else
					var_126_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_126_0.transform.localPosition = Vector3.New(0, 0, -0.07)
				var_126_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_126_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_126_0, iter_126_1 in ipairs((var_126_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_126_1.transform.localScale = Vector3.New(iter_126_1.transform.localScale.x / var_126_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_126_1.transform.localScale.y / var_126_2, iter_126_1.transform.localScale.z)
				end
			end

			local var_126_4 = manager.ui.mainCamera.transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_4.localPosition
			end

			local var_126_5 = 1

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				local var_126_6, var_126_7 = math.modf((arg_123_1.time_ - 0) / 0.066)

				var_126_4.localPosition = Vector3.New(var_126_7 * 0.13, var_126_7 * 0.13, var_126_7 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = arg_123_1.var_.shakeOldPos
			end

			local var_126_8 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = false

				arg_123_1:SetGaussion(false)
			end

			local var_126_9 = 0.5

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 then
				local var_126_10 = Color.New(1, 1, 1)

				var_126_10.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_8) / var_126_9)
				arg_123_1.mask_.color = var_126_10
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 then
				local var_126_11 = Color.New(1, 1, 1)

				arg_123_1.mask_.enabled = false
				var_126_11.a = 0
				arg_123_1.mask_.color = var_126_11
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_lingguang02", "")
			end

			local var_126_13 = arg_123_1.actors_["10123"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10123 = var_126_13.localPosition
				var_126_13.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10123", 7)

				for iter_126_2 = 0, var_126_13.childCount - 1 do
					local var_126_14 = var_126_13:GetChild(iter_126_2)

					if var_126_14.name == "split_6" or not string.find(var_126_14.name, "split") then
						var_126_14.gameObject:SetActive(true)
					else
						var_126_14.gameObject:SetActive(false)
					end
				end
			end

			local var_126_15 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_15 then
				var_126_13.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 0) / var_126_15)
			end

			if arg_123_1.time_ >= 0 + var_126_15 and arg_123_1.time_ < 0 + var_126_15 + arg_126_0 then
				var_126_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_16 = 0.666666666666667
			local var_126_17 = 1.2

			if 0.666666666666667 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_18 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_18:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_19 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(416092030).content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_21 = 48 <= 0 and var_126_17 or var_126_17 * (utf8.len(var_126_19) / 48)

				if (48 <= 0 and var_126_17 or var_126_17 * (utf8.len(var_126_19) / 48)) > 0 and var_126_17 < var_126_21 then
					arg_123_1.talkMaxDuration = var_126_21
					var_126_16 = var_126_16 + 0.3

					if var_126_21 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_21 + var_126_16
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = var_126_16 + 0.3
			local var_126_23 = math.max(var_126_17, arg_123_1.talkMaxDuration)

			if var_126_16 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_22 + var_126_23 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_22) / var_126_23

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_22 + var_126_23 and arg_123_1.time_ < var_126_22 + var_126_23 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416092031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play416092032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0.433333333333333 < arg_129_1.time_ and arg_129_1.time_ <= 0.433333333333333 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_17", "se_story_17_fireblast", "")
			end

			if 1.23333333333333 < arg_129_1.time_ and arg_129_1.time_ <= 1.23333333333333 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_128", "se_story_128_break", "")
			end

			local var_132_2 = 0
			local var_132_3 = 1.8

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(416092031).content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 72 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_4) / 72)

				if (72 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_4) / 72)) > 0 and var_132_3 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_7 and arg_129_1.time_ < var_132_2 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416092032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416092032
		arg_133_1.duration_ = 5.07

		local var_133_0 = {
			zh = 5.066,
			ja = 3.433
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
				arg_133_0:Play416092033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1148 = arg_133_1.actors_["1148"].transform.localPosition
				arg_133_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1148", 3)

				for iter_136_0 = 0, arg_133_1.actors_["1148"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["1148"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_5" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_136_2 = arg_133_1.actors_["1148"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps1148 == nil then
				arg_133_1.var_.actorSpriteComps1148 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 0.125

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps1148 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps1148 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps1148 = nil
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

				local var_136_7 = arg_133_1:GetWordFromCfg(416092032)
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

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092032", "story_v_out_416092.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092032", "story_v_out_416092.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_416092", "416092032", "story_v_out_416092.awb")

						arg_133_1:RecordAudio("416092032", var_136_12)
						arg_133_1:RecordAudio("416092032", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416092", "416092032", "story_v_out_416092.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416092", "416092032", "story_v_out_416092.awb")
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
	Play416092033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416092033
		arg_137_1.duration_ = 6.93

		local var_137_0 = {
			zh = 6.3,
			ja = 6.933
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
				arg_137_0:Play416092034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1148 = arg_137_1.actors_["1148"].transform.localPosition
				arg_137_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1148", 7)

				for iter_140_0 = 0, arg_137_1.actors_["1148"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1148"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_2 = arg_137_1.actors_["10123"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10123 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10123", 3)

				for iter_140_1 = 0, var_140_2.childCount - 1 do
					local var_140_3 = var_140_2:GetChild(iter_140_1)

					if var_140_3.name == "split_6" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_137_1.time_ - 0) / var_140_4)
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_140_5 = arg_137_1.actors_["10123"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps10123 == nil then
				arg_137_1.var_.actorSpriteComps10123 = var_140_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_6 = 0.125

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.actorSpriteComps10123 then
					for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_140_3 then
							if arg_137_1.isInRecall_ then
								iter_140_3.color = Color.New(Mathf.Lerp(iter_140_3.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_6), Mathf.Lerp(iter_140_3.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_6), (Mathf.Lerp(iter_140_3.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_6)))
							else
								local var_140_7 = Mathf.Lerp(iter_140_3.color.r, 1, (arg_137_1.time_ - 0) / var_140_6)

								iter_140_3.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps10123 then
				for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_140_5 then
						iter_140_5.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10123 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.5

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(416092033)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 20 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 20)

				if (20 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 20)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092033", "story_v_out_416092.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092033", "story_v_out_416092.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_416092", "416092033", "story_v_out_416092.awb")

						arg_137_1:RecordAudio("416092033", var_140_15)
						arg_137_1:RecordAudio("416092033", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416092", "416092033", "story_v_out_416092.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416092", "416092033", "story_v_out_416092.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
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
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416092034
		arg_141_1.duration_ = 3.57

		local var_141_0 = {
			zh = 2.133,
			ja = 3.566
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
				arg_141_0:Play416092035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if arg_141_1.actors_["10108"] == nil then
				local var_144_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_144_0) then
					local var_144_1 = Object.Instantiate(var_144_0, arg_141_1.canvasGo_.transform)

					var_144_1.transform:SetSiblingIndex(1)

					var_144_1.name = "10108"
					var_144_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_141_1.actors_["10108"] = var_144_1

					if arg_141_1.isInRecall_ then
						for iter_144_0, iter_144_1 in ipairs((var_144_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_144_1.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_144_2 = arg_141_1.actors_["10108"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10108 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10108", 4)

				for iter_144_2 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_2)

					if var_144_3.name == "split_3" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_141_1.time_ - 0) / var_144_4)
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_144_5 = arg_141_1.actors_["10108"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10108 == nil then
				arg_141_1.var_.actorSpriteComps10108 = var_144_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_6 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.actorSpriteComps10108 then
					for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_144_4 then
							if arg_141_1.isInRecall_ then
								iter_144_4.color = Color.New(Mathf.Lerp(iter_144_4.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_6), Mathf.Lerp(iter_144_4.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_6), (Mathf.Lerp(iter_144_4.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_6)))
							else
								local var_144_7 = Mathf.Lerp(iter_144_4.color.r, 1, (arg_141_1.time_ - 0) / var_144_6)

								iter_144_4.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10108 then
				for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_144_6 then
						iter_144_6.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10108 = nil
			end

			local var_144_8 = arg_141_1.actors_["10123"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10123 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10123", 2)

				for iter_144_7 = 0, var_144_8.childCount - 1 do
					local var_144_9 = var_144_8:GetChild(iter_144_7)

					if var_144_9.name == "split_6" or not string.find(var_144_9.name, "split") then
						var_144_9.gameObject:SetActive(true)
					else
						var_144_9.gameObject:SetActive(false)
					end
				end
			end

			local var_144_10 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_10 then
				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10123, Vector3.New(-390, -400, 0), (arg_141_1.time_ - 0) / var_144_10)
			end

			if arg_141_1.time_ >= 0 + var_144_10 and arg_141_1.time_ < 0 + var_144_10 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_144_11 = arg_141_1.actors_["10123"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.actorSpriteComps10123 == nil then
				arg_141_1.var_.actorSpriteComps10123 = var_144_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_12 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_12 and not isNil(var_144_11) then
				if arg_141_1.var_.actorSpriteComps10123 then
					for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_144_9 then
							if arg_141_1.isInRecall_ then
								iter_144_9.color = Color.New(Mathf.Lerp(iter_144_9.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_12), Mathf.Lerp(iter_144_9.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_12), (Mathf.Lerp(iter_144_9.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_12)))
							else
								local var_144_13 = Mathf.Lerp(iter_144_9.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_12)

								iter_144_9.color = Color.New(var_144_13, var_144_13, var_144_13)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_12 and arg_141_1.time_ < 0 + var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.actorSpriteComps10123 then
				for iter_144_10, iter_144_11 in pairs(arg_141_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_144_11 then
						iter_144_11.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10123 = nil
			end

			local var_144_14 = 0
			local var_144_15 = 0.175

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_16 = arg_141_1:GetWordFromCfg(416092034)
				local var_144_17 = arg_141_1:FormatText(var_144_16.content)

				arg_141_1.text_.text = var_144_17

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_19 = 7 <= 0 and var_144_15 or var_144_15 * (utf8.len(var_144_17) / 7)

				if (7 <= 0 and var_144_15 or var_144_15 * (utf8.len(var_144_17) / 7)) > 0 and var_144_15 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_14 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_14
					end
				end

				arg_141_1.text_.text = var_144_17
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092034", "story_v_out_416092.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_416092", "416092034", "story_v_out_416092.awb") / 1000

					if var_144_20 + var_144_14 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_14
					end

					if var_144_16.prefab_name ~= "" and arg_141_1.actors_[var_144_16.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_16.prefab_name].transform, "story_v_out_416092", "416092034", "story_v_out_416092.awb")

						arg_141_1:RecordAudio("416092034", var_144_21)
						arg_141_1:RecordAudio("416092034", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416092", "416092034", "story_v_out_416092.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416092", "416092034", "story_v_out_416092.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_15, arg_141_1.talkMaxDuration)

			if var_144_14 <= arg_141_1.time_ and arg_141_1.time_ < var_144_14 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_14) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_14 + var_144_22 and arg_141_1.time_ < var_144_14 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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
				actorName = "10123",
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
	Play416092035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416092035
		arg_145_1.duration_ = 5.67

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play416092036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_9002
			local var_148_9001
			local var_148_9000

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10108 = arg_145_1.actors_["10108"].transform.localPosition
				arg_145_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10108", 7)

				for iter_148_0 = 0, arg_145_1.actors_["10108"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["10108"].transform:GetChild(iter_148_0)

					if var_148_0.name == "" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				local var_148_2 = arg_145_1.var_.effect0903

				if not arg_145_1.var_.effect0903 then
					var_148_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_148_2.name = "0903"
					arg_145_1.var_.effect0903 = var_148_2
				else
					var_148_2.transform:SetParent(var_148_9002)
				end

				var_148_2.transform.localPosition = Vector3.New(-0.74, 0, 13.33)
				var_148_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.666666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 0.666666666666667 + arg_148_0 then
				if arg_145_1.var_.effect0903 then
					Object.Destroy(arg_145_1.var_.effect0903)

					arg_145_1.var_.effect0903 = nil
				end
			end

			if 0.0666666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 0.0666666666666667 + arg_148_0 then
				local var_148_5 = arg_145_1.var_.effect0904

				if not arg_145_1.var_.effect0904 then
					var_148_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_148_5.name = "0904"
					arg_145_1.var_.effect0904 = var_148_5
				else
					var_148_5.transform:SetParent(var_148_9001)
				end

				var_148_5.transform.localPosition = Vector3.New(0.9, 0.5, 11)
				var_148_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.666666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 0.666666666666667 + arg_148_0 then
				if arg_145_1.var_.effect0904 then
					Object.Destroy(arg_145_1.var_.effect0904)

					arg_145_1.var_.effect0904 = nil
				end
			end

			if 0.166666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 0.166666666666667 + arg_148_0 then
				local var_148_8 = arg_145_1.var_.effect0905

				if not arg_145_1.var_.effect0905 then
					var_148_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_148_8.name = "0905"
					arg_145_1.var_.effect0905 = var_148_8
				else
					var_148_8.transform:SetParent(var_148_9000)
				end

				var_148_8.transform.localPosition = Vector3.New(1.79, -1.12, 10)
				var_148_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.666666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 0.666666666666667 + arg_148_0 then
				if arg_145_1.var_.effect0905 then
					Object.Destroy(arg_145_1.var_.effect0905)

					arg_145_1.var_.effect0905 = nil
				end
			end

			local var_148_11 = manager.ui.mainCamera.transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.shakeOldPos = var_148_11.localPosition
			end

			local var_148_12 = 0.463629866872604

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_12 then
				local var_148_13, var_148_14 = math.modf((arg_145_1.time_ - 0) / 0.066)

				var_148_11.localPosition = Vector3.New(var_148_14 * 0.13, var_148_14 * 0.13, var_148_14 * 0.13) + arg_145_1.var_.shakeOldPos
			end

			if arg_145_1.time_ >= 0 + var_148_12 and arg_145_1.time_ < 0 + var_148_12 + arg_148_0 then
				var_148_11.localPosition = arg_145_1.var_.shakeOldPos
			end

			local var_148_15 = arg_145_1.actors_["10123"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10123 = var_148_15.localPosition
				var_148_15.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10123", 7)

				for iter_148_1 = 0, var_148_15.childCount - 1 do
					local var_148_16 = var_148_15:GetChild(iter_148_1)

					if var_148_16.name == "split_6" or not string.find(var_148_16.name, "split") then
						var_148_16.gameObject:SetActive(true)
					else
						var_148_16.gameObject:SetActive(false)
					end
				end
			end

			local var_148_17 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_17 then
				var_148_15.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_145_1.time_ - 0) / var_148_17)
			end

			if arg_145_1.time_ >= 0 + var_148_17 and arg_145_1.time_ < 0 + var_148_17 + arg_148_0 then
				var_148_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_gun", "")
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_19 = 0.666666666666667
			local var_148_20 = 1.25

			if 0.666666666666667 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_21 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_21:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_22 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(416092035).content)

				arg_145_1.text_.text = var_148_22

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_24 = 50 <= 0 and var_148_20 or var_148_20 * (utf8.len(var_148_22) / 50)

				if (50 <= 0 and var_148_20 or var_148_20 * (utf8.len(var_148_22) / 50)) > 0 and var_148_20 < var_148_24 then
					arg_145_1.talkMaxDuration = var_148_24
					var_148_19 = var_148_19 + 0.3

					if var_148_24 + var_148_19 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_19
					end
				end

				arg_145_1.text_.text = var_148_22
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = var_148_19 + 0.3
			local var_148_26 = math.max(var_148_20, arg_145_1.talkMaxDuration)

			if var_148_19 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_25 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_25) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_25 + var_148_26 and arg_145_1.time_ < var_148_25 + var_148_26 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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
				actorName = "10123",
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
	Play416092036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416092036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play416092037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1.3

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(416092036).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 52 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 52)

				if (52 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 52)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play416092037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416092037
		arg_155_1.duration_ = 8.93

		local var_155_0 = {
			zh = 6.566,
			ja = 8.933
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
				arg_155_0:Play416092038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10123 = arg_155_1.actors_["10123"].transform.localPosition
				arg_155_1.actors_["10123"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10123", 3)

				for iter_158_0 = 0, arg_155_1.actors_["10123"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10123"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_6" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10123"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10123"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_158_2 = arg_155_1.actors_["10123"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10123 == nil then
				arg_155_1.var_.actorSpriteComps10123 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.125

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10123 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10123 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10123 = nil
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_138", "se_story_138_footstep", "")
			end

			local var_158_6 = 0
			local var_158_7 = 0.5

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(416092037)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 20 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 20)

				if (20 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 20)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092037", "story_v_out_416092.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_416092", "416092037", "story_v_out_416092.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_416092", "416092037", "story_v_out_416092.awb")

						arg_155_1:RecordAudio("416092037", var_158_13)
						arg_155_1:RecordAudio("416092037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416092", "416092037", "story_v_out_416092.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416092", "416092037", "story_v_out_416092.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play416092038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416092038
		arg_159_1.duration_ = 6.03

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play416092039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 1.03333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 1.03333333333333 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= 1.03333333333333 + 0.3 and arg_159_1.time_ < 1.03333333333333 + 0.3 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_0 = "STwhite"

			if arg_159_1.bgs_.STwhite == nil then
				local var_162_1 = Object.Instantiate(arg_159_1.paintGo_)

				var_162_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_162_0)
				var_162_1.name = var_162_0
				var_162_1.transform.parent = arg_159_1.stage_.transform
				var_162_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.bgs_[var_162_0] = var_162_1
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				local var_162_2 = arg_159_1.bgs_.STwhite

				arg_159_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_162_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_3 = var_162_2:GetComponent("SpriteRenderer")

				if var_162_3 and var_162_3.sprite then
					local var_162_4 = 2 * (var_162_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_162_2.transform.localScale = Vector3.New(var_162_4 / var_162_3.sprite.bounds.size.y < var_162_4 * manager.ui.mainCameraCom_.aspect / var_162_3.sprite.bounds.size.x and var_162_4 * manager.ui.mainCameraCom_.aspect / var_162_3.sprite.bounds.size.x or var_162_4 / var_162_3.sprite.bounds.size.y, var_162_4 / var_162_3.sprite.bounds.size.y < var_162_4 * manager.ui.mainCameraCom_.aspect / var_162_3.sprite.bounds.size.x and var_162_4 * manager.ui.mainCameraCom_.aspect / var_162_3.sprite.bounds.size.x or var_162_4 / var_162_3.sprite.bounds.size.y, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "STwhite" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_5 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_6 = 1.03333333333333

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 then
				local var_162_7 = Color.New(0, 0, 0)

				var_162_7.a = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_5) / var_162_6)
				arg_159_1.mask_.color = var_162_7
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 then
				local var_162_8 = Color.New(0, 0, 0)

				arg_159_1.mask_.enabled = false
				var_162_8.a = 0
				arg_159_1.mask_.color = var_162_8
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				if arg_159_1.var_.effect0902 then
					Object.Destroy(arg_159_1.var_.effect0902)

					arg_159_1.var_.effect0902 = nil
				end
			end

			if 1.46666666666667 < arg_159_1.time_ and arg_159_1.time_ <= 1.46666666666667 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_1076_aoe", "")
			end

			local var_162_11 = arg_159_1.actors_["10123"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10123 = var_162_11.localPosition
				var_162_11.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10123", 7)

				for iter_162_2 = 0, var_162_11.childCount - 1 do
					local var_162_12 = var_162_11:GetChild(iter_162_2)

					if var_162_12.name == "split_6" or not string.find(var_162_12.name, "split") then
						var_162_12.gameObject:SetActive(true)
					else
						var_162_12.gameObject:SetActive(false)
					end
				end
			end

			local var_162_13 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_13 then
				var_162_11.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_159_1.time_ - 0) / var_162_13)
			end

			if arg_159_1.time_ >= 0 + var_162_13 and arg_159_1.time_ < 0 + var_162_13 + arg_162_0 then
				var_162_11.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_14 = 1.03333333333333
			local var_162_15 = 1.85

			if 1.03333333333333 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_16 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_16:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_17 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(416092038).content)

				arg_159_1.text_.text = var_162_17

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_19 = 74 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_17) / 74)

				if (74 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_17) / 74)) > 0 and var_162_15 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19
					var_162_14 = var_162_14 + 0.3

					if var_162_19 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_14
					end
				end

				arg_159_1.text_.text = var_162_17
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_20 = var_162_14 + 0.3
			local var_162_21 = math.max(var_162_15, arg_159_1.talkMaxDuration)

			if var_162_14 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_20 + var_162_21 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_20) / var_162_21

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_20 + var_162_21 and arg_159_1.time_ < var_162_20 + var_162_21 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416092039
		arg_165_1.duration_ = 2.67

		local var_165_0 = {
			zh = 0.999999999999,
			ja = 2.666
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
				arg_165_0:Play416092040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10108_split_3")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(416092039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 5 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 5)

				if (5 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 5)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092039", "story_v_out_416092.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092039", "story_v_out_416092.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_416092", "416092039", "story_v_out_416092.awb")

						arg_165_1:RecordAudio("416092039", var_168_6)
						arg_165_1:RecordAudio("416092039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416092", "416092039", "story_v_out_416092.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416092", "416092039", "story_v_out_416092.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play416092040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416092040
		arg_169_1.duration_ = 3.8

		local var_169_0 = {
			zh = 2.7,
			ja = 3.8
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
				arg_169_0:Play416092041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.275

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148_split_5")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(416092040)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 11 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 11)

				if (11 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 11)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092040", "story_v_out_416092.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092040", "story_v_out_416092.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_416092", "416092040", "story_v_out_416092.awb")

						arg_169_1:RecordAudio("416092040", var_172_6)
						arg_169_1:RecordAudio("416092040", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416092", "416092040", "story_v_out_416092.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416092", "416092040", "story_v_out_416092.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416092041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416092041
		arg_173_1.duration_ = 9

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416092042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= 4 + 0.3 and arg_173_1.time_ < 4 + 0.3 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= 2 + arg_176_0 then
				local var_176_0 = arg_173_1.bgs_.I14f

				arg_173_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_176_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_1 = var_176_0:GetComponent("SpriteRenderer")

				if var_176_1 and var_176_1.sprite then
					local var_176_2 = 2 * (var_176_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_176_0.transform.localScale = Vector3.New(var_176_2 / var_176_1.sprite.bounds.size.y < var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x and var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x or var_176_2 / var_176_1.sprite.bounds.size.y, var_176_2 / var_176_1.sprite.bounds.size.y < var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x and var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x or var_176_2 / var_176_1.sprite.bounds.size.y, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "I14f" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_3 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_4 = 2

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_4 then
				local var_176_5 = Color.New(0, 0, 0)

				var_176_5.a = Mathf.Lerp(0, 1, (arg_173_1.time_ - var_176_3) / var_176_4)
				arg_173_1.mask_.color = var_176_5
			end

			if arg_173_1.time_ >= var_176_3 + var_176_4 and arg_173_1.time_ < var_176_3 + var_176_4 + arg_176_0 then
				local var_176_6 = Color.New(0, 0, 0)

				var_176_6.a = 1
				arg_173_1.mask_.color = var_176_6
			end

			local var_176_7 = 2

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_8 = 2

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 then
				local var_176_9 = Color.New(0, 0, 0)

				var_176_9.a = Mathf.Lerp(1, 0, (arg_173_1.time_ - var_176_7) / var_176_8)
				arg_173_1.mask_.color = var_176_9
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 then
				local var_176_10 = Color.New(0, 0, 0)

				arg_173_1.mask_.enabled = false
				var_176_10.a = 0
				arg_173_1.mask_.color = var_176_10
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_11 = 4
			local var_176_12 = 1.825

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_13 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_13:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_14 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(416092041).content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_16 = 73 <= 0 and var_176_12 or var_176_12 * (utf8.len(var_176_14) / 73)

				if (73 <= 0 and var_176_12 or var_176_12 * (utf8.len(var_176_14) / 73)) > 0 and var_176_12 < var_176_16 then
					arg_173_1.talkMaxDuration = var_176_16
					var_176_11 = var_176_11 + 0.3

					if var_176_16 + var_176_11 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_16 + var_176_11
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_17 = var_176_11 + 0.3
			local var_176_18 = math.max(var_176_12, arg_173_1.talkMaxDuration)

			if var_176_11 + 0.3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_17 + var_176_18 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_17) / var_176_18

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_17 + var_176_18 and arg_173_1.time_ < var_176_17 + var_176_18 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416092042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416092042
		arg_179_1.duration_ = 2.93

		local var_179_0 = {
			zh = 2.033,
			ja = 2.933
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
				arg_179_0:Play416092043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if arg_179_1.actors_["10096"] == nil then
				local var_182_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_182_0) then
					local var_182_1 = Object.Instantiate(var_182_0, arg_179_1.canvasGo_.transform)

					var_182_1.transform:SetSiblingIndex(1)

					var_182_1.name = "10096"
					var_182_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_179_1.actors_["10096"] = var_182_1

					if arg_179_1.isInRecall_ then
						for iter_182_0, iter_182_1 in ipairs((var_182_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_182_1.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_182_2 = arg_179_1.actors_["10096"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10096 = var_182_2.localPosition
				var_182_2.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10096", 3)

				for iter_182_2 = 0, var_182_2.childCount - 1 do
					local var_182_3 = var_182_2:GetChild(iter_182_2)

					if var_182_3.name == "" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_2.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_179_1.time_ - 0) / var_182_4)
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_2.localPosition = Vector3.New(0, -350, -210)
			end

			local var_182_5 = arg_179_1.actors_["10096"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10096 == nil then
				arg_179_1.var_.actorSpriteComps10096 = var_182_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_6 = 0.125

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.actorSpriteComps10096 then
					for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_182_4 then
							if arg_179_1.isInRecall_ then
								iter_182_4.color = Color.New(Mathf.Lerp(iter_182_4.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_6), Mathf.Lerp(iter_182_4.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_6), (Mathf.Lerp(iter_182_4.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_6)))
							else
								local var_182_7 = Mathf.Lerp(iter_182_4.color.r, 1, (arg_179_1.time_ - 0) / var_182_6)

								iter_182_4.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_6 and arg_179_1.time_ < 0 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10096 then
				for iter_182_5, iter_182_6 in pairs(arg_179_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_182_6 then
						iter_182_6.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10096 = nil
			end

			local var_182_8 = 0
			local var_182_9 = 0.225

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1091].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(416092042)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 9 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 9)

				if (9 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 9)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092042", "story_v_out_416092.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092042", "story_v_out_416092.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_416092", "416092042", "story_v_out_416092.awb")

						arg_179_1:RecordAudio("416092042", var_182_15)
						arg_179_1:RecordAudio("416092042", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416092", "416092042", "story_v_out_416092.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416092", "416092042", "story_v_out_416092.awb")
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
				actorName = "10096",
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
	Play416092043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416092043
		arg_183_1.duration_ = 6.6

		local var_183_0 = {
			zh = 4.133,
			ja = 6.6
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
				arg_183_0:Play416092044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10096"]) and arg_183_1.var_.actorSpriteComps10096 == nil then
				arg_183_1.var_.actorSpriteComps10096 = arg_183_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.125

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10096"]) then
				if arg_183_1.var_.actorSpriteComps10096 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10096"]) and arg_183_1.var_.actorSpriteComps10096 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10096 = nil
			end

			local var_186_2 = arg_183_1.actors_["10123"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10123 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10123", 3)

				for iter_186_4 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_4)

					if var_186_3.name == "split_6" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_186_5 = arg_183_1.actors_["10123"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.actorSpriteComps10123 == nil then
				arg_183_1.var_.actorSpriteComps10123 = var_186_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_6 = 0.125

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.actorSpriteComps10123 then
					for iter_186_5, iter_186_6 in pairs(arg_183_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_186_6 then
							if arg_183_1.isInRecall_ then
								iter_186_6.color = Color.New(Mathf.Lerp(iter_186_6.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_6), Mathf.Lerp(iter_186_6.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_6), (Mathf.Lerp(iter_186_6.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_6)))
							else
								local var_186_7 = Mathf.Lerp(iter_186_6.color.r, 1, (arg_183_1.time_ - 0) / var_186_6)

								iter_186_6.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.actorSpriteComps10123 then
				for iter_186_7, iter_186_8 in pairs(arg_183_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_186_8 then
						iter_186_8.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10123 = nil
			end

			local var_186_8 = 0
			local var_186_9 = 0.45

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(416092043)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 18 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 18)

				if (18 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 18)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092043", "story_v_out_416092.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_416092", "416092043", "story_v_out_416092.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_416092", "416092043", "story_v_out_416092.awb")

						arg_183_1:RecordAudio("416092043", var_186_15)
						arg_183_1:RecordAudio("416092043", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416092", "416092043", "story_v_out_416092.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416092", "416092043", "story_v_out_416092.awb")
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
				actorName = "10123",
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
	Play416092044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416092044
		arg_187_1.duration_ = 8.1

		local var_187_0 = {
			zh = 8.1,
			ja = 6.3
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
				arg_187_0:Play416092045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.575

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(416092044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 23 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 23)

				if (23 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 23)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092044", "story_v_out_416092.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092044", "story_v_out_416092.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_416092", "416092044", "story_v_out_416092.awb")

						arg_187_1:RecordAudio("416092044", var_190_6)
						arg_187_1:RecordAudio("416092044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416092", "416092044", "story_v_out_416092.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416092", "416092044", "story_v_out_416092.awb")
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
	Play416092045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416092045
		arg_191_1.duration_ = 4.8

		local var_191_0 = {
			zh = 2.933,
			ja = 4.8
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
				arg_191_0:Play416092046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10096"]) and arg_191_1.var_.actorSpriteComps10096 == nil then
				arg_191_1.var_.actorSpriteComps10096 = arg_191_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.125

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10096"]) then
				if arg_191_1.var_.actorSpriteComps10096 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10096"]) and arg_191_1.var_.actorSpriteComps10096 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10096 = nil
			end

			local var_194_2 = arg_191_1.actors_["10096"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10096 = var_194_2.localPosition
				var_194_2.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10096", 4)

				for iter_194_4 = 0, var_194_2.childCount - 1 do
					local var_194_3 = var_194_2:GetChild(iter_194_4)

					if var_194_3.name == "" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_2.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_191_1.time_ - 0) / var_194_4)
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_2.localPosition = Vector3.New(390, -350, -210)
			end

			local var_194_5 = arg_191_1.actors_["10123"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10123 = var_194_5.localPosition
				var_194_5.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10123", 2)

				for iter_194_5 = 0, var_194_5.childCount - 1 do
					local var_194_6 = var_194_5:GetChild(iter_194_5)

					if var_194_6.name == "split_6" or not string.find(var_194_6.name, "split") then
						var_194_6.gameObject:SetActive(true)
					else
						var_194_6.gameObject:SetActive(false)
					end
				end
			end

			local var_194_7 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				var_194_5.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10123, Vector3.New(-390, -400, 0), (arg_191_1.time_ - 0) / var_194_7)
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				var_194_5.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_194_8 = arg_191_1.actors_["10123"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps10123 == nil then
				arg_191_1.var_.actorSpriteComps10123 = var_194_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_9 = 0.125

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_9 and not isNil(var_194_8) then
				if arg_191_1.var_.actorSpriteComps10123 then
					for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10123:ToTable()) do
						if iter_194_7 then
							if arg_191_1.isInRecall_ then
								iter_194_7.color = Color.New(Mathf.Lerp(iter_194_7.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_9), Mathf.Lerp(iter_194_7.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_9), (Mathf.Lerp(iter_194_7.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_9)))
							else
								local var_194_10 = Mathf.Lerp(iter_194_7.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_9)

								iter_194_7.color = Color.New(var_194_10, var_194_10, var_194_10)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_9 and arg_191_1.time_ < 0 + var_194_9 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps10123 then
				for iter_194_8, iter_194_9 in pairs(arg_191_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_194_9 then
						iter_194_9.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps10123 = nil
			end

			local var_194_11 = 0
			local var_194_12 = 0.375

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_11 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1091].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_13 = arg_191_1:GetWordFromCfg(416092045)
				local var_194_14 = arg_191_1:FormatText(var_194_13.content)

				arg_191_1.text_.text = var_194_14

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_16 = 15 <= 0 and var_194_12 or var_194_12 * (utf8.len(var_194_14) / 15)

				if (15 <= 0 and var_194_12 or var_194_12 * (utf8.len(var_194_14) / 15)) > 0 and var_194_12 < var_194_16 then
					arg_191_1.talkMaxDuration = var_194_16

					if var_194_16 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_16 + var_194_11
					end
				end

				arg_191_1.text_.text = var_194_14
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092045", "story_v_out_416092.awb") ~= 0 then
					local var_194_17 = manager.audio:GetVoiceLength("story_v_out_416092", "416092045", "story_v_out_416092.awb") / 1000

					if var_194_17 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_17 + var_194_11
					end

					if var_194_13.prefab_name ~= "" and arg_191_1.actors_[var_194_13.prefab_name] ~= nil then
						local var_194_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_13.prefab_name].transform, "story_v_out_416092", "416092045", "story_v_out_416092.awb")

						arg_191_1:RecordAudio("416092045", var_194_18)
						arg_191_1:RecordAudio("416092045", var_194_18)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416092", "416092045", "story_v_out_416092.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416092", "416092045", "story_v_out_416092.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_19 = math.max(var_194_12, arg_191_1.talkMaxDuration)

			if var_194_11 <= arg_191_1.time_ and arg_191_1.time_ < var_194_11 + var_194_19 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_11) / var_194_19

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_11 + var_194_19 and arg_191_1.time_ < var_194_11 + var_194_19 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416092046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play416092047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10096 = arg_195_1.actors_["10096"].transform.localPosition
				arg_195_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10096", 7)

				for iter_198_0 = 0, arg_195_1.actors_["10096"].transform.childCount - 1 do
					local var_198_0 = arg_195_1.actors_["10096"].transform:GetChild(iter_198_0)

					if var_198_0.name == "" or not string.find(var_198_0.name, "split") then
						var_198_0.gameObject:SetActive(true)
					else
						var_198_0.gameObject:SetActive(false)
					end
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10096, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_1)
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["10096"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_2 = arg_195_1.actors_["10123"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10123 = var_198_2.localPosition
				var_198_2.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10123", 7)

				for iter_198_1 = 0, var_198_2.childCount - 1 do
					local var_198_3 = var_198_2:GetChild(iter_198_1)

					if var_198_3.name == "split_6" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10123, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_5 = 0
			local var_198_6 = 1.425

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_7 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(416092046).content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 57 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_7) / 57)

				if (57 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_7) / 57)) > 0 and var_198_6 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_5
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_6, arg_195_1.talkMaxDuration)

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_5) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_5 + var_198_10 and arg_195_1.time_ < var_198_5 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10123",
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
	Play416092047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416092047
		arg_199_1.duration_ = 5.77

		local var_199_0 = {
			zh = 5.666,
			ja = 5.766
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
				arg_199_0:Play416092048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10123 = arg_199_1.actors_["10123"].transform.localPosition
				arg_199_1.actors_["10123"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10123", 3)

				for iter_202_0 = 0, arg_199_1.actors_["10123"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["10123"].transform:GetChild(iter_202_0)

					if var_202_0.name == "split_6" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10123"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10123, Vector3.New(0, -400, 0), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10123"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_202_2 = arg_199_1.actors_["10123"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10123 == nil then
				arg_199_1.var_.actorSpriteComps10123 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.125

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10123 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10123:ToTable()) do
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

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10123 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10123:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10123 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 0.45

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(416092047)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 18 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 18)

				if (18 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 18)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092047", "story_v_out_416092.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_416092", "416092047", "story_v_out_416092.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_416092", "416092047", "story_v_out_416092.awb")

						arg_199_1:RecordAudio("416092047", var_202_12)
						arg_199_1:RecordAudio("416092047", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416092", "416092047", "story_v_out_416092.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416092", "416092047", "story_v_out_416092.awb")
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
				actorName = "10123",
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
	Play416092048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416092048
		arg_203_1.duration_ = 6.83

		local var_203_0 = {
			zh = 3.366,
			ja = 6.833
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
			arg_203_1.auto_ = false
		end

		function arg_203_1.playNext_(arg_205_0)
			arg_203_1.onStoryFinished_()
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(416092048)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 12 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 12)

				if (12 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 12)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416092", "416092048", "story_v_out_416092.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_416092", "416092048", "story_v_out_416092.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_416092", "416092048", "story_v_out_416092.awb")

						arg_203_1:RecordAudio("416092048", var_206_6)
						arg_203_1:RecordAudio("416092048", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416092", "416092048", "story_v_out_416092.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416092", "416092048", "story_v_out_416092.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_416092.awb"
	}
}
