return {
	Play416112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416112001
		arg_1_1.duration_ = 11.23

		local var_1_0 = {
			zh = 7.699999999999,
			ja = 11.232999999999
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
				arg_1_0:Play416112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I13h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13h")
				var_4_0.name = "I13h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I13h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I13h

				arg_1_1.bgs_.I13h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I13h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "10122"

			if arg_1_1.actors_["10122"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

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

			local var_4_12 = arg_1_1.actors_["10122"].transform

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10122 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10122", 3)

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
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_1_1.time_ - 1.66666666666667) / var_4_14)
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_14 and arg_1_1.time_ < 1.66666666666667 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -380, -100)
			end

			local var_4_15 = arg_1_1.actors_["10122"]

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10122 == nil then
				arg_1_1.var_.actorSpriteComps10122 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.125

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10122 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_1_1.time_ >= 1.66666666666667 + var_4_16 and arg_1_1.time_ < 1.66666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10122 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10122 = nil
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10122"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10122 = var_4_18.alpha
					arg_1_1.var_.characterEffect10122 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10122 = 0
			end

			local var_4_19 = 0.4

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_19 then
				if arg_1_1.var_.characterEffect10122 then
					arg_1_1.var_.characterEffect10122.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10122, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_19 and arg_1_1.time_ < 1.66666666666667 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10122 then
				arg_1_1.var_.characterEffect10122.alpha = 1
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 1.999999999999
			local var_4_27 = 0.525

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(416112001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 21 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 21)

				if (21 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 21)) > 0 and var_4_27 < var_4_32 then
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

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112001", "story_v_out_416112.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_416112", "416112001", "story_v_out_416112.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_416112", "416112001", "story_v_out_416112.awb")

						arg_1_1:RecordAudio("416112001", var_4_34)
						arg_1_1:RecordAudio("416112001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416112", "416112001", "story_v_out_416112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416112", "416112001", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416112002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416112003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10122"]) and arg_9_1.var_.actorSpriteComps10122 == nil then
				arg_9_1.var_.actorSpriteComps10122 = arg_9_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.125

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10122"]) then
				if arg_9_1.var_.actorSpriteComps10122 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10122"]) and arg_9_1.var_.actorSpriteComps10122 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10122 = nil
			end

			if 0.6 < arg_9_1.time_ and arg_9_1.time_ <= 0.6 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			local var_12_3 = 0
			local var_12_4 = 1.6

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

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416112002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 64 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 64)

				if (64 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 64)) > 0 and var_12_4 < var_12_7 then
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

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play416112003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416112003
		arg_13_1.duration_ = 4.7

		local var_13_0 = {
			zh = 4.7,
			ja = 4.466
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
				arg_13_0:Play416112004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10122"]) and arg_13_1.var_.actorSpriteComps10122 == nil then
				arg_13_1.var_.actorSpriteComps10122 = arg_13_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.125

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10122"]) then
				if arg_13_1.var_.actorSpriteComps10122 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10122"]) and arg_13_1.var_.actorSpriteComps10122 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10122 = nil
			end

			local var_16_2 = arg_13_1.actors_["10122"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10122 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10122", 3)

				for iter_16_4 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_4)

					if var_16_3.name == "split_2" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_16_5 = 0
			local var_16_6 = 0.475

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

				local var_16_7 = arg_13_1:GetWordFromCfg(416112003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 19 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 19)

				if (19 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 19)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112003", "story_v_out_416112.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112003", "story_v_out_416112.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_416112", "416112003", "story_v_out_416112.awb")

						arg_13_1:RecordAudio("416112003", var_16_12)
						arg_13_1:RecordAudio("416112003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416112", "416112003", "story_v_out_416112.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416112", "416112003", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416112004
		arg_17_1.duration_ = 4.53

		local var_17_0 = {
			zh = 2.4,
			ja = 4.533
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
				arg_17_0:Play416112005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10122"]) and arg_17_1.var_.actorSpriteComps10122 == nil then
				arg_17_1.var_.actorSpriteComps10122 = arg_17_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10122"]) then
				if arg_17_1.var_.actorSpriteComps10122 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 1, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10122"]) and arg_17_1.var_.actorSpriteComps10122 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10122 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
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

				local var_20_4 = arg_17_1:GetWordFromCfg(416112004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 14 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 14)

				if (14 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 14)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112004", "story_v_out_416112.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112004", "story_v_out_416112.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_416112", "416112004", "story_v_out_416112.awb")

						arg_17_1:RecordAudio("416112004", var_20_9)
						arg_17_1:RecordAudio("416112004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416112", "416112004", "story_v_out_416112.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416112", "416112004", "story_v_out_416112.awb")
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
	Play416112005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416112005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416112006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10122 = arg_21_1.actors_["10122"].transform.localPosition
				arg_21_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10122", 7)

				for iter_24_0 = 0, arg_21_1.actors_["10122"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10122"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10122"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_2 = 0
			local var_24_3 = 1.7

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

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(416112005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 68 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 68)

				if (68 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 68)) > 0 and var_24_3 < var_24_6 then
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
				actorName = "10122",
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
	Play416112006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416112006
		arg_25_1.duration_ = 6.43

		local var_25_0 = {
			zh = 4.1,
			ja = 6.433
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
				arg_25_0:Play416112007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10122 = arg_25_1.actors_["10122"].transform.localPosition
				arg_25_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10122", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10122"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10122"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_4" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10122"].transform.localPosition = Vector3.New(0, -380, -100)
			end

			local var_28_2 = arg_25_1.actors_["10122"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10122 == nil then
				arg_25_1.var_.actorSpriteComps10122 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.125

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10122 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10122 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10122 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.4

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

				local var_28_7 = arg_25_1:GetWordFromCfg(416112006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 16 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 16)

				if (16 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 16)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112006", "story_v_out_416112.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112006", "story_v_out_416112.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_416112", "416112006", "story_v_out_416112.awb")

						arg_25_1:RecordAudio("416112006", var_28_12)
						arg_25_1:RecordAudio("416112006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416112", "416112006", "story_v_out_416112.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416112", "416112006", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416112007
		arg_29_1.duration_ = 13.8

		local var_29_0 = {
			zh = 6.933,
			ja = 13.8
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
				arg_29_0:Play416112008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10122 = arg_29_1.actors_["10122"].transform.localPosition
				arg_29_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10122", 2)

				for iter_32_0 = 0, arg_29_1.actors_["10122"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10122"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10122"].transform.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_32_2 = arg_29_1.actors_["10122"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10122 == nil then
				arg_29_1.var_.actorSpriteComps10122 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10122 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10122 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10122 = nil
			end

			local var_32_5 = "10108"

			if arg_29_1.actors_["10108"] == nil then
				local var_32_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_32_6) then
					local var_32_7 = Object.Instantiate(var_32_6, arg_29_1.canvasGo_.transform)

					var_32_7.transform:SetSiblingIndex(1)

					var_32_7.name = var_32_5
					var_32_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_5] = var_32_7

					if arg_29_1.isInRecall_ then
						for iter_32_5, iter_32_6 in ipairs((var_32_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_6.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_8 = arg_29_1.actors_["10108"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10108 == nil then
				arg_29_1.var_.actorSpriteComps10108 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 and not isNil(var_32_8) then
				if arg_29_1.var_.actorSpriteComps10108 then
					for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_32_8 then
							if arg_29_1.isInRecall_ then
								iter_32_8.color = Color.New(Mathf.Lerp(iter_32_8.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_9), Mathf.Lerp(iter_32_8.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_9), (Mathf.Lerp(iter_32_8.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_9)))
							else
								local var_32_10 = Mathf.Lerp(iter_32_8.color.r, 1, (arg_29_1.time_ - 0) / var_32_9)

								iter_32_8.color = Color.New(var_32_10, var_32_10, var_32_10)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10108 then
				for iter_32_9, iter_32_10 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_32_10 then
						iter_32_10.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10108 = nil
			end

			local var_32_11 = arg_29_1.actors_["10108"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10108 = var_32_11.localPosition
				var_32_11.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10108", 4)

				for iter_32_11 = 0, var_32_11.childCount - 1 do
					local var_32_12 = var_32_11:GetChild(iter_32_11)

					if var_32_12.name == "" or not string.find(var_32_12.name, "split") then
						var_32_12.gameObject:SetActive(true)
					else
						var_32_12.gameObject:SetActive(false)
					end
				end
			end

			local var_32_13 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_13 then
				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_29_1.time_ - 0) / var_32_13)
			end

			if arg_29_1.time_ >= 0 + var_32_13 and arg_29_1.time_ < 0 + var_32_13 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_32_14 = 0
			local var_32_15 = 0.6

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
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

				local var_32_16 = arg_29_1:GetWordFromCfg(416112007)
				local var_32_17 = arg_29_1:FormatText(var_32_16.content)

				arg_29_1.text_.text = var_32_17

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_19 = 24 <= 0 and var_32_15 or var_32_15 * (utf8.len(var_32_17) / 24)

				if (24 <= 0 and var_32_15 or var_32_15 * (utf8.len(var_32_17) / 24)) > 0 and var_32_15 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_14
					end
				end

				arg_29_1.text_.text = var_32_17
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112007", "story_v_out_416112.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_416112", "416112007", "story_v_out_416112.awb") / 1000

					if var_32_20 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_14
					end

					if var_32_16.prefab_name ~= "" and arg_29_1.actors_[var_32_16.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_16.prefab_name].transform, "story_v_out_416112", "416112007", "story_v_out_416112.awb")

						arg_29_1:RecordAudio("416112007", var_32_21)
						arg_29_1:RecordAudio("416112007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416112", "416112007", "story_v_out_416112.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416112", "416112007", "story_v_out_416112.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_15, arg_29_1.talkMaxDuration)

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_14) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_14 + var_32_22 and arg_29_1.time_ < var_32_14 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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

		arg_29_1:InitPlayNodeList()
	end,
	Play416112008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416112008
		arg_33_1.duration_ = 4.93

		local var_33_0 = {
			zh = 4.933,
			ja = 3.1
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
				arg_33_0:Play416112009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10122"]) and arg_33_1.var_.actorSpriteComps10122 == nil then
				arg_33_1.var_.actorSpriteComps10122 = arg_33_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10122"]) then
				if arg_33_1.var_.actorSpriteComps10122 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10122"]) and arg_33_1.var_.actorSpriteComps10122 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10122 = nil
			end

			local var_36_2 = arg_33_1.actors_["10122"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10122 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10122", 3)

				for iter_36_4 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_4)

					if var_36_3.name == "split_6" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_36_5 = arg_33_1.actors_["10108"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10108 = var_36_5.localPosition
				var_36_5.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10108", 7)

				for iter_36_5 = 0, var_36_5.childCount - 1 do
					local var_36_6 = var_36_5:GetChild(iter_36_5)

					if var_36_6.name == "" or not string.find(var_36_6.name, "split") then
						var_36_6.gameObject:SetActive(true)
					else
						var_36_6.gameObject:SetActive(false)
					end
				end
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_7)
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_8 = 0
			local var_36_9 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
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

				local var_36_10 = arg_33_1:GetWordFromCfg(416112008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 19 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 19)

				if (19 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 19)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112008", "story_v_out_416112.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_416112", "416112008", "story_v_out_416112.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_416112", "416112008", "story_v_out_416112.awb")

						arg_33_1:RecordAudio("416112008", var_36_15)
						arg_33_1:RecordAudio("416112008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416112", "416112008", "story_v_out_416112.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416112", "416112008", "story_v_out_416112.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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

		arg_33_1:InitPlayNodeList()
	end,
	Play416112009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416112009
		arg_37_1.duration_ = 8

		local var_37_0 = {
			zh = 3.966,
			ja = 8
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
				arg_37_0:Play416112010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10122"]) and arg_37_1.var_.actorSpriteComps10122 == nil then
				arg_37_1.var_.actorSpriteComps10122 = arg_37_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10122"]) then
				if arg_37_1.var_.actorSpriteComps10122 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10122"]) and arg_37_1.var_.actorSpriteComps10122 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10122 = nil
			end

			local var_40_2 = 0
			local var_40_3 = 0.45

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_37_1.callingController_:SetSelectedState("calling")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_4 = arg_37_1:GetWordFromCfg(416112009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 18 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 18)

				if (18 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 18)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112009", "story_v_out_416112.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112009", "story_v_out_416112.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_416112", "416112009", "story_v_out_416112.awb")

						arg_37_1:RecordAudio("416112009", var_40_9)
						arg_37_1:RecordAudio("416112009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416112", "416112009", "story_v_out_416112.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416112", "416112009", "story_v_out_416112.awb")
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
	Play416112010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416112010
		arg_41_1.duration_ = 8.13

		local var_41_0 = {
			zh = 5,
			ja = 8.133
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
				arg_41_0:Play416112011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10122"]) and arg_41_1.var_.actorSpriteComps10122 == nil then
				arg_41_1.var_.actorSpriteComps10122 = arg_41_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10122"]) then
				if arg_41_1.var_.actorSpriteComps10122 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10122"]) and arg_41_1.var_.actorSpriteComps10122 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10122 = nil
			end

			local var_44_2 = arg_41_1.actors_["10122"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10122 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10122", 3)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "split_2" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_44_5 = 0
			local var_44_6 = 0.625

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(416112010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 25 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 25)

				if (25 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 25)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112010", "story_v_out_416112.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112010", "story_v_out_416112.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_416112", "416112010", "story_v_out_416112.awb")

						arg_41_1:RecordAudio("416112010", var_44_12)
						arg_41_1:RecordAudio("416112010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416112", "416112010", "story_v_out_416112.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416112", "416112010", "story_v_out_416112.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_13 and arg_41_1.time_ < var_44_5 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play416112011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416112011
		arg_45_1.duration_ = 7.13

		local var_45_0 = {
			zh = 5.266,
			ja = 7.133
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
				arg_45_0:Play416112012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10122"]) and arg_45_1.var_.actorSpriteComps10122 == nil then
				arg_45_1.var_.actorSpriteComps10122 = arg_45_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10122"]) then
				if arg_45_1.var_.actorSpriteComps10122 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10122"]) and arg_45_1.var_.actorSpriteComps10122 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10122 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_45_1.callingController_:SetSelectedState("calling")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:GetWordFromCfg(416112011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 23 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 23)

				if (23 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 23)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112011", "story_v_out_416112.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112011", "story_v_out_416112.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_416112", "416112011", "story_v_out_416112.awb")

						arg_45_1:RecordAudio("416112011", var_48_9)
						arg_45_1:RecordAudio("416112011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416112", "416112011", "story_v_out_416112.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416112", "416112011", "story_v_out_416112.awb")
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
	Play416112012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416112012
		arg_49_1.duration_ = 11.07

		local var_49_0 = {
			zh = 5.9,
			ja = 11.066
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
				arg_49_0:Play416112013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.825

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
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_49_1.callingController_:SetSelectedState("calling")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(416112012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 33)

				if (33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 33)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112012", "story_v_out_416112.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_416112", "416112012", "story_v_out_416112.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_416112", "416112012", "story_v_out_416112.awb")

						arg_49_1:RecordAudio("416112012", var_52_6)
						arg_49_1:RecordAudio("416112012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416112", "416112012", "story_v_out_416112.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416112", "416112012", "story_v_out_416112.awb")
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
	Play416112013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416112013
		arg_53_1.duration_ = 7.4

		local var_53_0 = {
			zh = 4.4,
			ja = 7.4
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
				arg_53_0:Play416112014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10122"]) and arg_53_1.var_.actorSpriteComps10122 == nil then
				arg_53_1.var_.actorSpriteComps10122 = arg_53_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.125

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10122"]) then
				if arg_53_1.var_.actorSpriteComps10122 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 1, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10122"]) and arg_53_1.var_.actorSpriteComps10122 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10122 = nil
			end

			local var_56_2 = arg_53_1.actors_["10122"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10122 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10122", 3)

				for iter_56_4 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_4)

					if var_56_3.name == "split_1" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_56_5 = 0
			local var_56_6 = 0.5

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

				local var_56_7 = arg_53_1:GetWordFromCfg(416112013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 20 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 20)

				if (20 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 20)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112013", "story_v_out_416112.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112013", "story_v_out_416112.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_416112", "416112013", "story_v_out_416112.awb")

						arg_53_1:RecordAudio("416112013", var_56_12)
						arg_53_1:RecordAudio("416112013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416112", "416112013", "story_v_out_416112.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416112", "416112013", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416112014
		arg_57_1.duration_ = 5.57

		local var_57_0 = {
			zh = 3.533,
			ja = 5.566
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
				arg_57_0:Play416112015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10122 = arg_57_1.actors_["10122"].transform.localPosition
				arg_57_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10122", 3)

				for iter_60_0 = 0, arg_57_1.actors_["10122"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10122"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_1" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10122"].transform.localPosition = Vector3.New(0, -380, -100)
			end

			local var_60_2 = 0
			local var_60_3 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
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

				local var_60_4 = arg_57_1:GetWordFromCfg(416112014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 20 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 20)

				if (20 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 20)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112014", "story_v_out_416112.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112014", "story_v_out_416112.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_416112", "416112014", "story_v_out_416112.awb")

						arg_57_1:RecordAudio("416112014", var_60_9)
						arg_57_1:RecordAudio("416112014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416112", "416112014", "story_v_out_416112.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416112", "416112014", "story_v_out_416112.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play416112015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416112015
		arg_61_1.duration_ = 7.1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416112016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10122"]) and arg_61_1.var_.actorSpriteComps10122 == nil then
				arg_61_1.var_.actorSpriteComps10122 = arg_61_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.125

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10122"]) then
				if arg_61_1.var_.actorSpriteComps10122 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10122"]) and arg_61_1.var_.actorSpriteComps10122 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10122 = nil
			end

			if 6.1 < arg_61_1.time_ and arg_61_1.time_ <= 6.1 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_Signalinterrupt", "")
			end

			local var_64_3 = 0
			local var_64_4 = 0.55

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_61_1.callingController_:SetSelectedState("calling")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_5 = arg_61_1:GetWordFromCfg(416112015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 22 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_6) / 22)

				if (22 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_6) / 22)) > 0 and var_64_4 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112015", "story_v_out_416112.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_416112", "416112015", "story_v_out_416112.awb") / 1000

					if var_64_9 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_3
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_416112", "416112015", "story_v_out_416112.awb")

						arg_61_1:RecordAudio("416112015", var_64_10)
						arg_61_1:RecordAudio("416112015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416112", "416112015", "story_v_out_416112.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416112", "416112015", "story_v_out_416112.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_11 and arg_61_1.time_ < var_64_3 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416112016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416112016
		arg_65_1.duration_ = 4.13

		local var_65_0 = {
			zh = 4.133,
			ja = 3.7
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
				arg_65_0:Play416112017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10122"]) and arg_65_1.var_.actorSpriteComps10122 == nil then
				arg_65_1.var_.actorSpriteComps10122 = arg_65_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.125

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10122"]) then
				if arg_65_1.var_.actorSpriteComps10122 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10122"]) and arg_65_1.var_.actorSpriteComps10122 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10122 = nil
			end

			local var_68_2 = arg_65_1.actors_["10122"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10122 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10122", 3)

				for iter_68_4 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_4)

					if var_68_3.name == "split_1" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_68_5 = 0
			local var_68_6 = 0.525

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
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

				local var_68_7 = arg_65_1:GetWordFromCfg(416112016)
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

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112016", "story_v_out_416112.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112016", "story_v_out_416112.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_416112", "416112016", "story_v_out_416112.awb")

						arg_65_1:RecordAudio("416112016", var_68_12)
						arg_65_1:RecordAudio("416112016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416112", "416112016", "story_v_out_416112.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416112", "416112016", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416112017
		arg_69_1.duration_ = 4.4

		local var_69_0 = {
			zh = 4.4,
			ja = 4.133
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
				arg_69_0:Play416112018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10122 = arg_69_1.actors_["10122"].transform.localPosition
				arg_69_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10122", 3)

				for iter_72_0 = 0, arg_69_1.actors_["10122"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10122"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_1" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10122"].transform.localPosition = Vector3.New(0, -380, -100)
			end

			local var_72_2 = 0
			local var_72_3 = 0.575

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

				local var_72_4 = arg_69_1:GetWordFromCfg(416112017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 23 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 23)

				if (23 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 23)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112017", "story_v_out_416112.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112017", "story_v_out_416112.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_416112", "416112017", "story_v_out_416112.awb")

						arg_69_1:RecordAudio("416112017", var_72_9)
						arg_69_1:RecordAudio("416112017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416112", "416112017", "story_v_out_416112.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416112", "416112017", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416112018
		arg_73_1.duration_ = 4.4

		local var_73_0 = {
			zh = 2.6,
			ja = 4.4
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
				arg_73_0:Play416112019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10122 = arg_73_1.actors_["10122"].transform.localPosition
				arg_73_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10122", 7)

				for iter_76_0 = 0, arg_73_1.actors_["10122"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10122"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_3" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10122"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_2 = "10109"

			if arg_73_1.actors_["10109"] == nil then
				local var_76_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_76_3) then
					local var_76_4 = Object.Instantiate(var_76_3, arg_73_1.canvasGo_.transform)

					var_76_4.transform:SetSiblingIndex(1)

					var_76_4.name = var_76_2
					var_76_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_73_1.actors_[var_76_2] = var_76_4

					if arg_73_1.isInRecall_ then
						for iter_76_1, iter_76_2 in ipairs((var_76_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_76_2.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_76_5 = arg_73_1.actors_["10109"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10109 = var_76_5.localPosition
				var_76_5.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10109", 3)

				for iter_76_3 = 0, var_76_5.childCount - 1 do
					local var_76_6 = var_76_5:GetChild(iter_76_3)

					if var_76_6.name == "" or not string.find(var_76_6.name, "split") then
						var_76_6.gameObject:SetActive(true)
					else
						var_76_6.gameObject:SetActive(false)
					end
				end
			end

			local var_76_7 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_73_1.time_ - 0) / var_76_7)
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_76_8 = arg_73_1.actors_["10109"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10109 == nil then
				arg_73_1.var_.actorSpriteComps10109 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.125

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 and not isNil(var_76_8) then
				if arg_73_1.var_.actorSpriteComps10109 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								iter_76_5.color = Color.New(Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_9), Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_9), (Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_9)))
							else
								local var_76_10 = Mathf.Lerp(iter_76_5.color.r, 1, (arg_73_1.time_ - 0) / var_76_9)

								iter_76_5.color = Color.New(var_76_10, var_76_10, var_76_10)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10109 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_76_7 then
						iter_76_7.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10109 = nil
			end

			local var_76_11 = 0
			local var_76_12 = 0.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(416112018)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 7 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 7)

				if (7 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 7)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112018", "story_v_out_416112.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_416112", "416112018", "story_v_out_416112.awb") / 1000

					if var_76_17 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_11
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_416112", "416112018", "story_v_out_416112.awb")

						arg_73_1:RecordAudio("416112018", var_76_18)
						arg_73_1:RecordAudio("416112018", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416112", "416112018", "story_v_out_416112.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416112", "416112018", "story_v_out_416112.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_19 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_19 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_19

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_19 and arg_73_1.time_ < var_76_11 + var_76_19 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_73_1:InitPlayNodeList()
	end,
	Play416112019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416112019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play416112020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10109"]) and arg_77_1.var_.actorSpriteComps10109 == nil then
				arg_77_1.var_.actorSpriteComps10109 = arg_77_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.125

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10109"]) then
				if arg_77_1.var_.actorSpriteComps10109 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10109"]) and arg_77_1.var_.actorSpriteComps10109 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10109 = nil
			end

			local var_80_2 = 0
			local var_80_3 = 1.275

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(416112019).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 51 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 51)

				if (51 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 51)) > 0 and var_80_3 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_7 and arg_77_1.time_ < var_80_2 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play416112020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416112020
		arg_81_1.duration_ = 6

		local var_81_0 = {
			zh = 2.8,
			ja = 6
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
				arg_81_0:Play416112021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10122 = arg_81_1.actors_["10122"].transform.localPosition
				arg_81_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10122", 4)

				for iter_84_0 = 0, arg_81_1.actors_["10122"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10122"].transform:GetChild(iter_84_0)

					if var_84_0.name == "split_3" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10122"].transform.localPosition = Vector3.New(390, -380, -100)
			end

			local var_84_2 = arg_81_1.actors_["10109"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10109 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

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
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10109, Vector3.New(-390, -346.2, -390), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(-390, -346.2, -390)
			end

			local var_84_5 = arg_81_1.actors_["10109"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10109 == nil then
				arg_81_1.var_.actorSpriteComps10109 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 0.125

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps10109 then
					for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_84_3 then
							if arg_81_1.isInRecall_ then
								iter_84_3.color = Color.New(Mathf.Lerp(iter_84_3.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_3.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_3.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_3.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_3.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10109 then
				for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_84_5 then
						iter_84_5.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10109 = nil
			end

			local var_84_8 = arg_81_1.actors_["10122"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10122 == nil then
				arg_81_1.var_.actorSpriteComps10122 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 0.125

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 and not isNil(var_84_8) then
				if arg_81_1.var_.actorSpriteComps10122 then
					for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_84_7 then
							if arg_81_1.isInRecall_ then
								iter_84_7.color = Color.New(Mathf.Lerp(iter_84_7.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_9), Mathf.Lerp(iter_84_7.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_9), (Mathf.Lerp(iter_84_7.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_9)))
							else
								local var_84_10 = Mathf.Lerp(iter_84_7.color.r, 1, (arg_81_1.time_ - 0) / var_84_9)

								iter_84_7.color = Color.New(var_84_10, var_84_10, var_84_10)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10122 then
				for iter_84_8, iter_84_9 in pairs(arg_81_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_84_9 then
						iter_84_9.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10122 = nil
			end

			local var_84_11 = 0
			local var_84_12 = 0.3

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(416112020)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 12 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 12)

				if (12 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 12)) > 0 and var_84_12 < var_84_16 then
					arg_81_1.talkMaxDuration = var_84_16

					if var_84_16 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112020", "story_v_out_416112.awb") ~= 0 then
					local var_84_17 = manager.audio:GetVoiceLength("story_v_out_416112", "416112020", "story_v_out_416112.awb") / 1000

					if var_84_17 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_11
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_416112", "416112020", "story_v_out_416112.awb")

						arg_81_1:RecordAudio("416112020", var_84_18)
						arg_81_1:RecordAudio("416112020", var_84_18)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416112", "416112020", "story_v_out_416112.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416112", "416112020", "story_v_out_416112.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_19 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_19 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_19

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_19 and arg_81_1.time_ < var_84_11 + var_84_19 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_81_1:InitPlayNodeList()
	end,
	Play416112021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416112021
		arg_85_1.duration_ = 11.9

		local var_85_0 = {
			zh = 6.566,
			ja = 11.9
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
				arg_85_0:Play416112022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10109"]) and arg_85_1.var_.actorSpriteComps10109 == nil then
				arg_85_1.var_.actorSpriteComps10109 = arg_85_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10109"]) then
				if arg_85_1.var_.actorSpriteComps10109 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10109"]) and arg_85_1.var_.actorSpriteComps10109 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10109 = nil
			end

			local var_88_2 = arg_85_1.actors_["10122"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10122 == nil then
				arg_85_1.var_.actorSpriteComps10122 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10122 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10122 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10122 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(416112021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 22 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 22)

				if (22 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 22)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112021", "story_v_out_416112.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112021", "story_v_out_416112.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416112", "416112021", "story_v_out_416112.awb")

						arg_85_1:RecordAudio("416112021", var_88_12)
						arg_85_1:RecordAudio("416112021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416112", "416112021", "story_v_out_416112.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416112", "416112021", "story_v_out_416112.awb")
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
	Play416112022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416112022
		arg_89_1.duration_ = 8.2

		local var_89_0 = {
			zh = 4.8,
			ja = 8.2
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
				arg_89_0:Play416112023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(416112022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 12 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 12)

				if (12 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 12)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112022", "story_v_out_416112.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_416112", "416112022", "story_v_out_416112.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_416112", "416112022", "story_v_out_416112.awb")

						arg_89_1:RecordAudio("416112022", var_92_6)
						arg_89_1:RecordAudio("416112022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416112", "416112022", "story_v_out_416112.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416112", "416112022", "story_v_out_416112.awb")
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
	Play416112023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416112023
		arg_93_1.duration_ = 4.17

		local var_93_0 = {
			zh = 4.166,
			ja = 3.866
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
				arg_93_0:Play416112024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10109"]) and arg_93_1.var_.actorSpriteComps10109 == nil then
				arg_93_1.var_.actorSpriteComps10109 = arg_93_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.125

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10109"]) then
				if arg_93_1.var_.actorSpriteComps10109 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10109"]) and arg_93_1.var_.actorSpriteComps10109 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10109 = nil
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_127", "se_story_127_noise", "")
			end

			local var_96_3 = 0
			local var_96_4 = 0.575

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_93_1.callingController_:SetSelectedState("calling")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_5 = arg_93_1:GetWordFromCfg(416112023)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_8 = 23 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 23)

				if (23 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 23)) > 0 and var_96_4 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112023", "story_v_out_416112.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_out_416112", "416112023", "story_v_out_416112.awb") / 1000

					if var_96_9 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_3
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_out_416112", "416112023", "story_v_out_416112.awb")

						arg_93_1:RecordAudio("416112023", var_96_10)
						arg_93_1:RecordAudio("416112023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416112", "416112023", "story_v_out_416112.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416112", "416112023", "story_v_out_416112.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_11 and arg_93_1.time_ < var_96_3 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play416112024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416112024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416112025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_9000

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			if arg_97_1.time_ >= 0 + 0.566666666666666 and arg_97_1.time_ < 0 + 0.566666666666666 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_0 = arg_97_1.actors_["10122"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10122 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10122", 7)

				for iter_100_0 = 0, var_100_0.childCount - 1 do
					local var_100_1 = var_100_0:GetChild(iter_100_0)

					if var_100_1.name == "" or not string.find(var_100_1.name, "split") then
						var_100_1.gameObject:SetActive(true)
					else
						var_100_1.gameObject:SetActive(false)
					end
				end
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_2)
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_3 = arg_97_1.actors_["10109"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10109 = var_100_3.localPosition
				var_100_3.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10109", 7)

				for iter_100_1 = 0, var_100_3.childCount - 1 do
					local var_100_4 = var_100_3:GetChild(iter_100_1)

					if var_100_4.name == "" or not string.find(var_100_4.name, "split") then
						var_100_4.gameObject:SetActive(true)
					else
						var_100_4.gameObject:SetActive(false)
					end
				end
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_5)
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				local var_100_6 = arg_97_1.var_.effect12024

				if not arg_97_1.var_.effect12024 then
					var_100_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), manager.ui.mainCamera.transform)
					var_100_6.name = "12024"
					arg_97_1.var_.effect12024 = var_100_6
				else
					var_100_6.transform:SetParent(var_100_9000)
				end

				var_100_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_100_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:AudioAction("stop", "effect", "se_story_127", "se_story_127_noise", "")
			end

			local var_100_9 = 0
			local var_100_10 = 1.65

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_11 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(416112024).content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 66 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_11) / 66)

				if (66 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_11) / 66)) > 0 and var_100_10 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_9) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_9 + var_100_14 and arg_97_1.time_ < var_100_9 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_97_1:InitPlayNodeList()
	end,
	Play416112025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416112025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play416112026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.9

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(416112025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 76 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 76)

				if (76 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 76)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416112026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416112026
		arg_105_1.duration_ = 4.6

		local var_105_0 = {
			zh = 4.066,
			ja = 4.6
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
				arg_105_0:Play416112027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10122 = arg_105_1.actors_["10122"].transform.localPosition
				arg_105_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10122", 3)

				for iter_108_0 = 0, arg_105_1.actors_["10122"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10122"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_3" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10122"].transform.localPosition = Vector3.New(0, -380, -100)
			end

			local var_108_2 = arg_105_1.actors_["10122"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10122 == nil then
				arg_105_1.var_.actorSpriteComps10122 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 0.125

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10122 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10122 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10122 = nil
			end

			local var_108_5 = 0
			local var_108_6 = 0.3

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

				local var_108_7 = arg_105_1:GetWordFromCfg(416112026)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 12 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 12)

				if (12 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 12)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112026", "story_v_out_416112.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112026", "story_v_out_416112.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_416112", "416112026", "story_v_out_416112.awb")

						arg_105_1:RecordAudio("416112026", var_108_12)
						arg_105_1:RecordAudio("416112026", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_416112", "416112026", "story_v_out_416112.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_416112", "416112026", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416112027
		arg_109_1.duration_ = 3.5

		local var_109_0 = {
			zh = 1.366,
			ja = 3.5
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
				arg_109_0:Play416112028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10122"]) and arg_109_1.var_.actorSpriteComps10122 == nil then
				arg_109_1.var_.actorSpriteComps10122 = arg_109_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.125

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10122"]) then
				if arg_109_1.var_.actorSpriteComps10122 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10122"]) and arg_109_1.var_.actorSpriteComps10122 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps10122 = nil
			end

			local var_112_2 = 0
			local var_112_3 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10108_split_5")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_4 = arg_109_1:GetWordFromCfg(416112027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 5 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 5)

				if (5 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 5)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112027", "story_v_out_416112.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112027", "story_v_out_416112.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_416112", "416112027", "story_v_out_416112.awb")

						arg_109_1:RecordAudio("416112027", var_112_9)
						arg_109_1:RecordAudio("416112027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416112", "416112027", "story_v_out_416112.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416112", "416112027", "story_v_out_416112.awb")
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
	Play416112028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416112028
		arg_113_1.duration_ = 4.4

		local var_113_0 = {
			zh = 2.7,
			ja = 4.4
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
				arg_113_0:Play416112029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10122"]) and arg_113_1.var_.actorSpriteComps10122 == nil then
				arg_113_1.var_.actorSpriteComps10122 = arg_113_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.125

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10122"]) then
				if arg_113_1.var_.actorSpriteComps10122 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10122"]) and arg_113_1.var_.actorSpriteComps10122 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10122 = nil
			end

			local var_116_2 = 0
			local var_116_3 = 0.35

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

				local var_116_4 = arg_113_1:GetWordFromCfg(416112028)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 14 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 14)

				if (14 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 14)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112028", "story_v_out_416112.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_416112", "416112028", "story_v_out_416112.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_out_416112", "416112028", "story_v_out_416112.awb")

						arg_113_1:RecordAudio("416112028", var_116_9)
						arg_113_1:RecordAudio("416112028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416112", "416112028", "story_v_out_416112.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416112", "416112028", "story_v_out_416112.awb")
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
	Play416112029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416112029
		arg_117_1.duration_ = 3

		local var_117_0 = {
			zh = 3,
			ja = 2.566
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
				arg_117_0:Play416112030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.25

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

				local var_120_1 = arg_117_1:GetWordFromCfg(416112029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 10 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 10)

				if (10 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 10)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112029", "story_v_out_416112.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_416112", "416112029", "story_v_out_416112.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_416112", "416112029", "story_v_out_416112.awb")

						arg_117_1:RecordAudio("416112029", var_120_6)
						arg_117_1:RecordAudio("416112029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416112", "416112029", "story_v_out_416112.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416112", "416112029", "story_v_out_416112.awb")
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
	Play416112030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416112030
		arg_121_1.duration_ = 8.37

		local var_121_0 = {
			zh = 4.866,
			ja = 8.366
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
				arg_121_0:Play416112031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10122 = arg_121_1.actors_["10122"].transform.localPosition
				arg_121_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10122", 7)

				for iter_124_0 = 0, arg_121_1.actors_["10122"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10122"].transform:GetChild(iter_124_0)

					if var_124_0.name == "split_6" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10122"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_2 = arg_121_1.actors_["10109"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10109 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10109", 3)

				for iter_124_1 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_1)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_124_5 = arg_121_1.actors_["10109"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10109 == nil then
				arg_121_1.var_.actorSpriteComps10109 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 0.125

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps10109 then
					for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_124_3 then
							if arg_121_1.isInRecall_ then
								iter_124_3.color = Color.New(Mathf.Lerp(iter_124_3.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_3.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_3.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_3.color.r, 1, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_3.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10109 then
				for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_124_5 then
						iter_124_5.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10109 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.35

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(416112030)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 14 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 14)

				if (14 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 14)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112030", "story_v_out_416112.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_416112", "416112030", "story_v_out_416112.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_416112", "416112030", "story_v_out_416112.awb")

						arg_121_1:RecordAudio("416112030", var_124_15)
						arg_121_1:RecordAudio("416112030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416112", "416112030", "story_v_out_416112.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416112", "416112030", "story_v_out_416112.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_121_1:InitPlayNodeList()
	end,
	Play416112031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416112031
		arg_125_1.duration_ = 5.1

		local var_125_0 = {
			zh = 4.933,
			ja = 5.1
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
				arg_125_0:Play416112032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10122 = arg_125_1.actors_["10122"].transform.localPosition
				arg_125_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10122", 4)

				for iter_128_0 = 0, arg_125_1.actors_["10122"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["10122"].transform:GetChild(iter_128_0)

					if var_128_0.name == "split_1" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["10122"].transform.localPosition = Vector3.New(390, -380, -100)
			end

			local var_128_2 = arg_125_1.actors_["10122"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10122 == nil then
				arg_125_1.var_.actorSpriteComps10122 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps10122 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10122 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_128_4 then
						iter_128_4.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps10122 = nil
			end

			local var_128_5 = arg_125_1.actors_["10109"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10109 = var_128_5.localPosition
				var_128_5.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10109", 2)

				for iter_128_5 = 0, var_128_5.childCount - 1 do
					local var_128_6 = var_128_5:GetChild(iter_128_5)

					if var_128_6.name == "" or not string.find(var_128_6.name, "split") then
						var_128_6.gameObject:SetActive(true)
					else
						var_128_6.gameObject:SetActive(false)
					end
				end
			end

			local var_128_7 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10109, Vector3.New(-390, -346.2, -395), (arg_125_1.time_ - 0) / var_128_7)
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(-390, -346.2, -395)
			end

			local var_128_8 = arg_125_1.actors_["10109"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10109 == nil then
				arg_125_1.var_.actorSpriteComps10109 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.actorSpriteComps10109 then
					for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_128_7 then
							if arg_125_1.isInRecall_ then
								iter_128_7.color = Color.New(Mathf.Lerp(iter_128_7.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_9), Mathf.Lerp(iter_128_7.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_9), (Mathf.Lerp(iter_128_7.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_9)))
							else
								local var_128_10 = Mathf.Lerp(iter_128_7.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_9)

								iter_128_7.color = Color.New(var_128_10, var_128_10, var_128_10)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10109 then
				for iter_128_8, iter_128_9 in pairs(arg_125_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_128_9 then
						iter_128_9.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10109 = nil
			end

			local var_128_11 = 0
			local var_128_12 = 0.6

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
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

				local var_128_13 = arg_125_1:GetWordFromCfg(416112031)
				local var_128_14 = arg_125_1:FormatText(var_128_13.content)

				arg_125_1.text_.text = var_128_14

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 24 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_14) / 24)

				if (24 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_14) / 24)) > 0 and var_128_12 < var_128_16 then
					arg_125_1.talkMaxDuration = var_128_16

					if var_128_16 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_14
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112031", "story_v_out_416112.awb") ~= 0 then
					local var_128_17 = manager.audio:GetVoiceLength("story_v_out_416112", "416112031", "story_v_out_416112.awb") / 1000

					if var_128_17 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_11
					end

					if var_128_13.prefab_name ~= "" and arg_125_1.actors_[var_128_13.prefab_name] ~= nil then
						local var_128_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_13.prefab_name].transform, "story_v_out_416112", "416112031", "story_v_out_416112.awb")

						arg_125_1:RecordAudio("416112031", var_128_18)
						arg_125_1:RecordAudio("416112031", var_128_18)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416112", "416112031", "story_v_out_416112.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416112", "416112031", "story_v_out_416112.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_19 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_19 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_19

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_19 and arg_125_1.time_ < var_128_11 + var_128_19 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_125_1:InitPlayNodeList()
	end,
	Play416112032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416112032
		arg_129_1.duration_ = 6.8

		local var_129_0 = {
			zh = 4.466,
			ja = 6.8
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
				arg_129_0:Play416112033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10109"]) and arg_129_1.var_.actorSpriteComps10109 == nil then
				arg_129_1.var_.actorSpriteComps10109 = arg_129_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.125

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10109"]) then
				if arg_129_1.var_.actorSpriteComps10109 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 1, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10109"]) and arg_129_1.var_.actorSpriteComps10109 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10109 = nil
			end

			local var_132_2 = arg_129_1.actors_["10122"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10122 == nil then
				arg_129_1.var_.actorSpriteComps10122 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.125

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps10122 then
					for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_132_5 then
							if arg_129_1.isInRecall_ then
								iter_132_5.color = Color.New(Mathf.Lerp(iter_132_5.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_5.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_5.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_5.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_5.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10122 then
				for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_132_7 then
						iter_132_7.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps10122 = nil
			end

			local var_132_5 = 0
			local var_132_6 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(416112032)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 14 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 14)

				if (14 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 14)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112032", "story_v_out_416112.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112032", "story_v_out_416112.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_416112", "416112032", "story_v_out_416112.awb")

						arg_129_1:RecordAudio("416112032", var_132_12)
						arg_129_1:RecordAudio("416112032", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416112", "416112032", "story_v_out_416112.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416112", "416112032", "story_v_out_416112.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416112033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416112033
		arg_133_1.duration_ = 10.77

		local var_133_0 = {
			zh = 6.3,
			ja = 10.766
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
				arg_133_0:Play416112034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk03", "")
			end

			local var_136_1 = 0
			local var_136_2 = 0.375

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(416112033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 15 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 15)

				if (15 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 15)) > 0 and var_136_2 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112033", "story_v_out_416112.awb") ~= 0 then
					local var_136_7 = manager.audio:GetVoiceLength("story_v_out_416112", "416112033", "story_v_out_416112.awb") / 1000

					if var_136_7 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_1
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_416112", "416112033", "story_v_out_416112.awb")

						arg_133_1:RecordAudio("416112033", var_136_8)
						arg_133_1:RecordAudio("416112033", var_136_8)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416112", "416112033", "story_v_out_416112.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416112", "416112033", "story_v_out_416112.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_9 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_9 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_9

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_9 and arg_133_1.time_ < var_136_1 + var_136_9 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play416112034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416112034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play416112035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10122 = arg_137_1.actors_["10122"].transform.localPosition
				arg_137_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10122", 7)

				for iter_140_0 = 0, arg_137_1.actors_["10122"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10122"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_6" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10122"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_2 = arg_137_1.actors_["10109"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10109 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10109", 7)

				for iter_140_1 = 0, var_140_2.childCount - 1 do
					local var_140_3 = var_140_2:GetChild(iter_140_1)

					if var_140_3.name == "" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_137_1.time_ - 0) / var_140_4)
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_5 = 0
			local var_140_6 = 1.725

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(416112034).content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 69 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 69)

				if (69 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 69)) > 0 and var_140_6 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_10 and arg_137_1.time_ < var_140_5 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_137_1:InitPlayNodeList()
	end,
	Play416112035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416112035
		arg_141_1.duration_ = 2.43

		local var_141_0 = {
			zh = 2.433,
			ja = 2.266
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
				arg_141_0:Play416112036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10122 = arg_141_1.actors_["10122"].transform.localPosition
				arg_141_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10122", 3)

				for iter_144_0 = 0, arg_141_1.actors_["10122"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10122"].transform:GetChild(iter_144_0)

					if var_144_0.name == "split_3" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10122"].transform.localPosition = Vector3.New(0, -380, -100)
			end

			local var_144_2 = arg_141_1.actors_["10122"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10122 == nil then
				arg_141_1.var_.actorSpriteComps10122 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.125

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps10122 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10122 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10122 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.35

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

				local var_144_7 = arg_141_1:GetWordFromCfg(416112035)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 14 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 14)

				if (14 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 14)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112035", "story_v_out_416112.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112035", "story_v_out_416112.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_416112", "416112035", "story_v_out_416112.awb")

						arg_141_1:RecordAudio("416112035", var_144_12)
						arg_141_1:RecordAudio("416112035", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416112", "416112035", "story_v_out_416112.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416112", "416112035", "story_v_out_416112.awb")
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
				actorName = "10122",
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
	Play416112036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416112036
		arg_145_1.duration_ = 8.47

		local var_145_0 = {
			zh = 6.9,
			ja = 8.466
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
				arg_145_0:Play416112037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10109 = arg_145_1.actors_["10109"].transform.localPosition
				arg_145_1.actors_["10109"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10109", 3)

				for iter_148_0 = 0, arg_145_1.actors_["10109"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["10109"].transform:GetChild(iter_148_0)

					if var_148_0.name == "" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["10109"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10109, Vector3.New(0, -346.2, -395), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["10109"].transform.localPosition = Vector3.New(0, -346.2, -395)
			end

			local var_148_2 = arg_145_1.actors_["10109"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10109 == nil then
				arg_145_1.var_.actorSpriteComps10109 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.125

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps10109 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps10109:ToTable()) do
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

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10109 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps10109 = nil
			end

			local var_148_5 = 0
			local var_148_6 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:GetWordFromCfg(416112036)
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

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112036", "story_v_out_416112.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_416112", "416112036", "story_v_out_416112.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_416112", "416112036", "story_v_out_416112.awb")

						arg_145_1:RecordAudio("416112036", var_148_12)
						arg_145_1:RecordAudio("416112036", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416112", "416112036", "story_v_out_416112.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416112", "416112036", "story_v_out_416112.awb")
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
				actorName = "10109",
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
	Play416112037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416112037
		arg_149_1.duration_ = 5.7

		local var_149_0 = {
			zh = 4.233,
			ja = 5.7
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
				arg_149_0:Play416112038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.25

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(416112037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 10 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 10)

				if (10 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 10)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416112", "416112037", "story_v_out_416112.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_416112", "416112037", "story_v_out_416112.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_416112", "416112037", "story_v_out_416112.awb")

						arg_149_1:RecordAudio("416112037", var_152_6)
						arg_149_1:RecordAudio("416112037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416112", "416112037", "story_v_out_416112.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416112", "416112037", "story_v_out_416112.awb")
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
	Play416112038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416112038
		arg_153_1.duration_ = 5.53

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
			arg_153_1.auto_ = false
		end

		function arg_153_1.playNext_(arg_155_0)
			arg_153_1.onStoryFinished_()
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0.333333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 0.333333333333333 + arg_156_0 then
				arg_153_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_156_0 = 0.2

			if 0.333333333333333 <= arg_153_1.time_ and arg_153_1.time_ < 0.333333333333333 + var_156_0 then
				local var_156_1, var_156_2 = math.modf((arg_153_1.time_ - 0.333333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_156_2 * 0.13, var_156_2 * 0.13, var_156_2 * 0.13) + arg_153_1.var_.shakeOldPos
			end

			if arg_153_1.time_ >= 0.333333333333333 + var_156_0 and arg_153_1.time_ < 0.333333333333333 + var_156_0 + arg_156_0 then
				manager.ui.mainCamera.transform.localPosition = arg_153_1.var_.shakeOldPos
			end

			local var_156_3 = arg_153_1.actors_["10122"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10122 = var_156_3.localPosition
				var_156_3.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10122", 7)

				for iter_156_0 = 0, var_156_3.childCount - 1 do
					local var_156_4 = var_156_3:GetChild(iter_156_0)

					if var_156_4.name == "split_6" or not string.find(var_156_4.name, "split") then
						var_156_4.gameObject:SetActive(true)
					else
						var_156_4.gameObject:SetActive(false)
					end
				end
			end

			local var_156_5 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_153_1.time_ - 0) / var_156_5)
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_6 = arg_153_1.actors_["10109"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10109 = var_156_6.localPosition
				var_156_6.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10109", 7)

				for iter_156_1 = 0, var_156_6.childCount - 1 do
					local var_156_7 = var_156_6:GetChild(iter_156_1)

					if var_156_7.name == "" or not string.find(var_156_7.name, "split") then
						var_156_7.gameObject:SetActive(true)
					else
						var_156_7.gameObject:SetActive(false)
					end
				end
			end

			local var_156_8 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_8 then
				var_156_6.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_153_1.time_ - 0) / var_156_8)
			end

			if arg_153_1.time_ >= 0 + var_156_8 and arg_153_1.time_ < 0 + var_156_8 + arg_156_0 then
				var_156_6.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_9 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = false

				arg_153_1:SetGaussion(false)
			end

			local var_156_10 = 0.333333333333333

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 then
				local var_156_11 = Color.New(1, 1, 1)

				var_156_11.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_9) / var_156_10)
				arg_153_1.mask_.color = var_156_11
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 then
				local var_156_12 = Color.New(1, 1, 1)

				arg_153_1.mask_.enabled = false
				var_156_12.a = 0
				arg_153_1.mask_.color = var_156_12
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_139", "se_story_139_monstersmash02", "")
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_14 = 0.533333333333333
			local var_156_15 = 1.5

			if 0.533333333333333 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_16 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_16:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_17 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(416112038).content)

				arg_153_1.text_.text = var_156_17

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_19 = 60 <= 0 and var_156_15 or var_156_15 * (utf8.len(var_156_17) / 60)

				if (60 <= 0 and var_156_15 or var_156_15 * (utf8.len(var_156_17) / 60)) > 0 and var_156_15 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19
					var_156_14 = var_156_14 + 0.3

					if var_156_19 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_14
					end
				end

				arg_153_1.text_.text = var_156_17
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_20 = var_156_14 + 0.3
			local var_156_21 = math.max(var_156_15, arg_153_1.talkMaxDuration)

			if var_156_14 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_20 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_20) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_20 + var_156_21 and arg_153_1.time_ < var_156_20 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_153_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13h"
	},
	voices = {
		"story_v_out_416112.awb"
	}
}
