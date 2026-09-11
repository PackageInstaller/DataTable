return {
	Play117022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I08a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I08a")
				var_4_0.name = "I08a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I08a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I08a

				arg_1_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I08a" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.05

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(117022001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 42 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 42)

				if (42 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 42)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play117022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 117022002
		arg_9_1.duration_ = 5.1

		local var_9_0 = {
			zh = 5.1,
			ja = 4.866
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
				arg_9_0:Play117022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1033"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "1033"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["1033"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_2 = arg_9_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_2 then
					arg_9_1.var_.alphaOldValue1033 = var_12_2.alpha
					arg_9_1.var_.characterEffect1033 = var_12_2
				end

				arg_9_1.var_.alphaOldValue1033 = 0
			end

			local var_12_3 = 0.333333333333333

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 then
				if arg_9_1.var_.characterEffect1033 then
					arg_9_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue1033, 1, (arg_9_1.time_ - 0) / var_12_3)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and arg_9_1.var_.characterEffect1033 then
				arg_9_1.var_.characterEffect1033.alpha = 1
			end

			local var_12_4 = arg_9_1.actors_["1033"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 3)

				for iter_12_2 = 0, var_12_4.childCount - 1 do
					local var_12_5 = var_12_4:GetChild(iter_12_2)

					if var_12_5.name == "split_6" or not string.find(var_12_5.name, "split") then
						var_12_5.gameObject:SetActive(true)
					else
						var_12_5.gameObject:SetActive(false)
					end
				end
			end

			local var_12_6 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 then
				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_9_1.time_ - 0) / var_12_6)
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(0, -420, 0)
			end

			local var_12_7 = arg_9_1.actors_["1033"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps1033 == nil then
				arg_9_1.var_.actorSpriteComps1033 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_8 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.actorSpriteComps1033 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_8), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_8), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_8)))
							else
								local var_12_9 = Mathf.Lerp(iter_12_4.color.r, 1, (arg_9_1.time_ - 0) / var_12_8)

								iter_12_4.color = Color.New(var_12_9, var_12_9, var_12_9)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps1033 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1033 = nil
			end

			local var_12_10 = 0
			local var_12_11 = 0.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(117022002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 27 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 27)

				if (27 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 27)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117022", "117022002", "story_v_out_117022.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_117022", "117022002", "story_v_out_117022.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_117022", "117022002", "story_v_out_117022.awb")

						arg_9_1:RecordAudio("117022002", var_12_17)
						arg_9_1:RecordAudio("117022002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_117022", "117022002", "story_v_out_117022.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_117022", "117022002", "story_v_out_117022.awb")
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
				actorName = "1033",
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
	Play117022003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 117022003
		arg_13_1.duration_ = 5.6

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play117022004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_16_0 = 0.6

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				local var_16_1, var_16_2 = math.modf((arg_13_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_16_2 * 0.13, var_16_2 * 0.13, var_16_2 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				manager.ui.mainCamera.transform.localPosition = arg_13_1.var_.shakeOldPos
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_3 = arg_13_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_3 then
					arg_13_1.var_.alphaOldValue1033 = var_16_3.alpha
					arg_13_1.var_.characterEffect1033 = var_16_3
				end

				arg_13_1.var_.alphaOldValue1033 = 1
			end

			local var_16_4 = 0.333333333333333

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				if arg_13_1.var_.characterEffect1033 then
					arg_13_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue1033, 0, (arg_13_1.time_ - 0) / var_16_4)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and arg_13_1.var_.characterEffect1033 then
				arg_13_1.var_.characterEffect1033.alpha = 0
			end

			local var_16_5 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_5 + 0.6 and arg_13_1.time_ < var_16_5 + 0.6 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			if 0.6 < arg_13_1.time_ and arg_13_1.time_ <= 0.6 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks04", "")
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_7 = 0.6
			local var_16_8 = 1.15

			if 0.6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_9 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_9:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(117022003).content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 46 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_10) / 46)

				if (46 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_10) / 46)) > 0 and var_16_8 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12
					var_16_7 = var_16_7 + 0.3

					if var_16_12 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = var_16_7 + 0.3
			local var_16_14 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_13) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_13 + var_16_14 and arg_13_1.time_ < var_16_13 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play117022004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 117022004
		arg_19_1.duration_ = 2.6

		local var_19_0 = {
			zh = 2.233,
			ja = 2.6
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play117022005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_0 = arg_19_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_0 then
					arg_19_1.var_.alphaOldValue1033 = var_22_0.alpha
					arg_19_1.var_.characterEffect1033 = var_22_0
				end

				arg_19_1.var_.alphaOldValue1033 = 0
			end

			local var_22_1 = 0.333333333333333

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 then
				if arg_19_1.var_.characterEffect1033 then
					arg_19_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_19_1.var_.alphaOldValue1033, 1, (arg_19_1.time_ - 0) / var_22_1)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and arg_19_1.var_.characterEffect1033 then
				arg_19_1.var_.characterEffect1033.alpha = 1
			end

			local var_22_2 = arg_19_1.actors_["1033"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1033 = var_22_2.localPosition
				var_22_2.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1033", 3)

				for iter_22_0 = 0, var_22_2.childCount - 1 do
					local var_22_3 = var_22_2:GetChild(iter_22_0)

					if var_22_3.name == "split_6" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_2.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_19_1.time_ - 0) / var_22_4)
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_22_5 = arg_19_1.actors_["1033"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.actorSpriteComps1033 == nil then
				arg_19_1.var_.actorSpriteComps1033 = var_22_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_6 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.actorSpriteComps1033 then
					for iter_22_1, iter_22_2 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_22_2 then
							if arg_19_1.isInRecall_ then
								iter_22_2.color = Color.New(Mathf.Lerp(iter_22_2.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_6), Mathf.Lerp(iter_22_2.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_6), (Mathf.Lerp(iter_22_2.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_6)))
							else
								local var_22_7 = Mathf.Lerp(iter_22_2.color.r, 1, (arg_19_1.time_ - 0) / var_22_6)

								iter_22_2.color = Color.New(var_22_7, var_22_7, var_22_7)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.actorSpriteComps1033 then
				for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_22_4 then
						iter_22_4.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps1033 = nil
			end

			local var_22_8 = 0
			local var_22_9 = 0.1

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(117022004)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 4 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 4)

				if (4 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 4)) > 0 and var_22_9 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117022", "117022004", "story_v_out_117022.awb") ~= 0 then
					local var_22_14 = manager.audio:GetVoiceLength("story_v_out_117022", "117022004", "story_v_out_117022.awb") / 1000

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end

					if var_22_10.prefab_name ~= "" and arg_19_1.actors_[var_22_10.prefab_name] ~= nil then
						local var_22_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_10.prefab_name].transform, "story_v_out_117022", "117022004", "story_v_out_117022.awb")

						arg_19_1:RecordAudio("117022004", var_22_15)
						arg_19_1:RecordAudio("117022004", var_22_15)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_117022", "117022004", "story_v_out_117022.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_117022", "117022004", "story_v_out_117022.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_16 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_16 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_16

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_16 and arg_19_1.time_ < var_22_8 + var_22_16 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play117022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 117022005
		arg_23_1.duration_ = 9

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play117022006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.bgs_.TI0102 == nil then
				local var_26_0 = Object.Instantiate(arg_23_1.paintGo_)

				var_26_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "TI0102")
				var_26_0.name = "TI0102"
				var_26_0.transform.parent = arg_23_1.stage_.transform
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.bgs_.TI0102 = var_26_0
			end

			if 2 < arg_23_1.time_ and arg_23_1.time_ <= 2 + arg_26_0 then
				local var_26_1 = arg_23_1.bgs_.TI0102

				arg_23_1.bgs_.TI0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_26_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_2 = var_26_1:GetComponent("SpriteRenderer")

				if var_26_2 and var_26_2.sprite then
					local var_26_3 = 2 * (var_26_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_26_1.transform.localScale = Vector3.New(var_26_3 / var_26_2.sprite.bounds.size.y < var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x and var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x or var_26_3 / var_26_2.sprite.bounds.size.y, var_26_3 / var_26_2.sprite.bounds.size.y < var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x and var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x or var_26_3 / var_26_2.sprite.bounds.size.y, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "TI0102" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_4 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_5 = 2

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_5 then
				local var_26_6 = Color.New(0, 0, 0)

				var_26_6.a = Mathf.Lerp(0, 1, (arg_23_1.time_ - var_26_4) / var_26_5)
				arg_23_1.mask_.color = var_26_6
			end

			if arg_23_1.time_ >= var_26_4 + var_26_5 and arg_23_1.time_ < var_26_4 + var_26_5 + arg_26_0 then
				local var_26_7 = Color.New(0, 0, 0)

				var_26_7.a = 1
				arg_23_1.mask_.color = var_26_7
			end

			local var_26_8 = 2

			if 2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_9 = 2

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_9 then
				local var_26_10 = Color.New(0, 0, 0)

				var_26_10.a = Mathf.Lerp(1, 0, (arg_23_1.time_ - var_26_8) / var_26_9)
				arg_23_1.mask_.color = var_26_10
			end

			if arg_23_1.time_ >= var_26_8 + var_26_9 and arg_23_1.time_ < var_26_8 + var_26_9 + arg_26_0 then
				local var_26_11 = Color.New(0, 0, 0)

				arg_23_1.mask_.enabled = false
				var_26_11.a = 0
				arg_23_1.mask_.color = var_26_11
			end

			if 1.98333333333333 < arg_23_1.time_ and arg_23_1.time_ <= 1.98333333333333 + arg_26_0 then
				local var_26_12 = arg_23_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_12 then
					arg_23_1.var_.alphaOldValue1033 = var_26_12.alpha
					arg_23_1.var_.characterEffect1033 = var_26_12
				end

				arg_23_1.var_.alphaOldValue1033 = 1
			end

			local var_26_13 = 0.0166666666666667

			if 1.98333333333333 <= arg_23_1.time_ and arg_23_1.time_ < 1.98333333333333 + var_26_13 then
				if arg_23_1.var_.characterEffect1033 then
					arg_23_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_23_1.var_.alphaOldValue1033, 0, (arg_23_1.time_ - 1.98333333333333) / var_26_13)
				end
			end

			if arg_23_1.time_ >= 1.98333333333333 + var_26_13 and arg_23_1.time_ < 1.98333333333333 + var_26_13 + arg_26_0 and arg_23_1.var_.characterEffect1033 then
				arg_23_1.var_.characterEffect1033.alpha = 0
			end

			local var_26_14 = arg_23_1.bgs_.TI0102.transform

			if 2 < arg_23_1.time_ and arg_23_1.time_ <= 2 + arg_26_0 then
				arg_23_1.var_.moveOldPosTI0102 = var_26_14.localPosition
			end

			local var_26_15 = 0.001

			if 2 <= arg_23_1.time_ and arg_23_1.time_ < 2 + var_26_15 then
				var_26_14.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosTI0102, Vector3.New(-0.5, -1, 1), (arg_23_1.time_ - 2) / var_26_15)
			end

			if arg_23_1.time_ >= 2 + var_26_15 and arg_23_1.time_ < 2 + var_26_15 + arg_26_0 then
				var_26_14.localPosition = Vector3.New(-0.5, -1, 1)
			end

			local var_26_16 = arg_23_1.bgs_.TI0102.transform

			if 2.034 < arg_23_1.time_ and arg_23_1.time_ <= 2.034 + arg_26_0 then
				arg_23_1.var_.moveOldPosTI0102 = var_26_16.localPosition
			end

			local var_26_17 = 2.73333333333333

			if 2.034 <= arg_23_1.time_ and arg_23_1.time_ < 2.034 + var_26_17 then
				var_26_16.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosTI0102, Vector3.New(-0.5, -0.5, 1), (arg_23_1.time_ - 2.034) / var_26_17)
			end

			if arg_23_1.time_ >= 2.034 + var_26_17 and arg_23_1.time_ < 2.034 + var_26_17 + arg_26_0 then
				var_26_16.localPosition = Vector3.New(-0.5, -0.5, 1)
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_18 = 4
			local var_26_19 = 1.075

			if 4 < arg_23_1.time_ and arg_23_1.time_ <= var_26_18 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_20 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_20:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_21 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(117022005).content)

				arg_23_1.text_.text = var_26_21

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_23 = 43 <= 0 and var_26_19 or var_26_19 * (utf8.len(var_26_21) / 43)

				if (43 <= 0 and var_26_19 or var_26_19 * (utf8.len(var_26_21) / 43)) > 0 and var_26_19 < var_26_23 then
					arg_23_1.talkMaxDuration = var_26_23
					var_26_18 = var_26_18 + 0.3

					if var_26_23 + var_26_18 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_23 + var_26_18
					end
				end

				arg_23_1.text_.text = var_26_21
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_24 = var_26_18 + 0.3
			local var_26_25 = math.max(var_26_19, arg_23_1.talkMaxDuration)

			if var_26_18 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_24 + var_26_25 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_24) / var_26_25

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_24 + var_26_25 and arg_23_1.time_ < var_26_24 + var_26_25 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "TI0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.73333333333333,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play117022006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 117022006
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play117022007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(117022006).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 32 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 32)

				if (32 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 32)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play117022007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 117022007
		arg_33_1.duration_ = 7

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play117022008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = arg_33_1.bgs_.TI0102

				arg_33_1.bgs_.TI0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_1 = var_36_0:GetComponent("SpriteRenderer")

				if var_36_1 and var_36_1.sprite then
					local var_36_2 = 2 * (var_36_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_0.transform.localScale = Vector3.New(var_36_2 / var_36_1.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x or var_36_2 / var_36_1.sprite.bounds.size.y, var_36_2 / var_36_1.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x or var_36_2 / var_36_1.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "TI0102" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_3 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_4 = 2

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 then
				local var_36_5 = Color.New(1, 1, 1)

				var_36_5.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_3) / var_36_4)
				arg_33_1.mask_.color = var_36_5
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 then
				local var_36_6 = Color.New(1, 1, 1)

				arg_33_1.mask_.enabled = false
				var_36_6.a = 0
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_7 = 2
			local var_36_8 = 1.075

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_9 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_9:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(117022007).content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 43 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_10) / 43)

				if (43 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_10) / 43)) > 0 and var_36_8 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12
					var_36_7 = var_36_7 + 0.3

					if var_36_12 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = var_36_7 + 0.3
			local var_36_14 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_13 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_13) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_13 + var_36_14 and arg_33_1.time_ < var_36_13 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play117022008 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 117022008
		arg_39_1.duration_ = 2.9

		local var_39_0 = {
			zh = 2,
			ja = 2.9
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
			arg_39_1.auto_ = false
		end

		function arg_39_1.playNext_(arg_41_0)
			arg_39_1.onStoryFinished_()
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.175

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(117022008)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 7 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 7)

				if (7 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 7)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117022", "117022008", "story_v_out_117022.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_117022", "117022008", "story_v_out_117022.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_117022", "117022008", "story_v_out_117022.awb")

						arg_39_1:RecordAudio("117022008", var_42_6)
						arg_39_1:RecordAudio("117022008", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_117022", "117022008", "story_v_out_117022.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_117022", "117022008", "story_v_out_117022.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I08a",
		"TextureConfig/Background/TI0102"
	},
	voices = {
		"story_v_out_117022.awb"
	}
}
