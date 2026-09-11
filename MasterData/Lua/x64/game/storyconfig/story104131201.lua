return {
	Play413121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413121001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_4_0.name = "F08i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08i

				arg_1_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08i" then
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

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

			local var_4_14 = 1.9
			local var_4_15 = 1.25

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413121001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 50 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 50)

				if (50 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 50)) > 0 and var_4_15 < var_4_19 then
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
	Play413121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413121002
		arg_9_1.duration_ = 4.73

		local var_9_0 = {
			zh = 4.73266666666667,
			ja = 2.23266666666667
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
				arg_9_0:Play413121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10022"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10022"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10022"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10022"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10022 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10022", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_6" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_12_5 = arg_9_1.actors_["10022"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10022 == nil then
				arg_9_1.var_.actorSpriteComps10022 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10022 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 1, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10022 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue10022 = var_12_8.alpha
					arg_9_1.var_.characterEffect10022 = var_12_8
				end

				arg_9_1.var_.alphaOldValue10022 = 0
			end

			local var_12_9 = 0.233333333333333

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect10022 then
					arg_9_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10022, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10022 then
				arg_9_1.var_.characterEffect10022.alpha = 1
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_10 = 0.366666666666667
			local var_12_11 = 0.425

			if 0.366666666666667 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_12 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_12:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:GetWordFromCfg(413121002)
				local var_12_14 = arg_9_1:FormatText(var_12_13.content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 17 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_14) / 17)

				if (17 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_14) / 17)) > 0 and var_12_11 < var_12_16 then
					arg_9_1.talkMaxDuration = var_12_16
					var_12_10 = var_12_10 + 0.3

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_14
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121002", "story_v_out_413121.awb") ~= 0 then
					local var_12_17 = manager.audio:GetVoiceLength("story_v_out_413121", "413121002", "story_v_out_413121.awb") / 1000

					if var_12_17 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_10
					end

					if var_12_13.prefab_name ~= "" and arg_9_1.actors_[var_12_13.prefab_name] ~= nil then
						local var_12_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_13.prefab_name].transform, "story_v_out_413121", "413121002", "story_v_out_413121.awb")

						arg_9_1:RecordAudio("413121002", var_12_18)
						arg_9_1:RecordAudio("413121002", var_12_18)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413121", "413121002", "story_v_out_413121.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413121", "413121002", "story_v_out_413121.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_19 = var_12_10 + 0.3
			local var_12_20 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_20 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_20

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_20 and arg_9_1.time_ < var_12_19 + var_12_20 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413121003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 413121003
		arg_15_1.duration_ = 2.9

		local var_15_0 = {
			zh = 2.833,
			ja = 2.9
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play413121004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos10022 = arg_15_1.actors_["10022"].transform.localPosition
				arg_15_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10022", 7)

				for iter_18_0 = 0, arg_15_1.actors_["10022"].transform.childCount - 1 do
					local var_18_0 = arg_15_1.actors_["10022"].transform:GetChild(iter_18_0)

					if var_18_0.name == "" or not string.find(var_18_0.name, "split") then
						var_18_0.gameObject:SetActive(true)
					else
						var_18_0.gameObject:SetActive(false)
					end
				end
			end

			local var_18_1 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 then
				arg_15_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_15_1.time_ - 0) / var_18_1)
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 then
				arg_15_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_18_2 = "10093"

			if arg_15_1.actors_["10093"] == nil then
				local var_18_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_18_3) then
					local var_18_4 = Object.Instantiate(var_18_3, arg_15_1.canvasGo_.transform)

					var_18_4.transform:SetSiblingIndex(1)

					var_18_4.name = var_18_2
					var_18_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_[var_18_2] = var_18_4

					if arg_15_1.isInRecall_ then
						for iter_18_1, iter_18_2 in ipairs((var_18_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_18_2.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_5 = arg_15_1.actors_["10093"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos10093 = var_18_5.localPosition
				var_18_5.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10093", 3)

				for iter_18_3 = 0, var_18_5.childCount - 1 do
					local var_18_6 = var_18_5:GetChild(iter_18_3)

					if var_18_6.name == "split_4" or not string.find(var_18_6.name, "split") then
						var_18_6.gameObject:SetActive(true)
					else
						var_18_6.gameObject:SetActive(false)
					end
				end
			end

			local var_18_7 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_15_1.time_ - 0) / var_18_7)
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(0, -345, -245)
			end

			local var_18_8 = arg_15_1.actors_["10022"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_8) and arg_15_1.var_.actorSpriteComps10022 == nil then
				arg_15_1.var_.actorSpriteComps10022 = var_18_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_9 = 2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_9 and not isNil(var_18_8) then
				if arg_15_1.var_.actorSpriteComps10022 then
					for iter_18_4, iter_18_5 in pairs(arg_15_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_18_5 then
							if arg_15_1.isInRecall_ then
								iter_18_5.color = Color.New(Mathf.Lerp(iter_18_5.color.r, arg_15_1.hightColor2.r, (arg_15_1.time_ - 0) / var_18_9), Mathf.Lerp(iter_18_5.color.g, arg_15_1.hightColor2.g, (arg_15_1.time_ - 0) / var_18_9), (Mathf.Lerp(iter_18_5.color.b, arg_15_1.hightColor2.b, (arg_15_1.time_ - 0) / var_18_9)))
							else
								local var_18_10 = Mathf.Lerp(iter_18_5.color.r, 0.5, (arg_15_1.time_ - 0) / var_18_9)

								iter_18_5.color = Color.New(var_18_10, var_18_10, var_18_10)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_9 and arg_15_1.time_ < 0 + var_18_9 + arg_18_0 and not isNil(var_18_8) and arg_15_1.var_.actorSpriteComps10022 then
				for iter_18_6, iter_18_7 in pairs(arg_15_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_18_7 then
						iter_18_7.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_15_1.var_.actorSpriteComps10022 = nil
			end

			local var_18_11 = arg_15_1.actors_["10093"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.actorSpriteComps10093 == nil then
				arg_15_1.var_.actorSpriteComps10093 = var_18_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_12 = 2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_12 and not isNil(var_18_11) then
				if arg_15_1.var_.actorSpriteComps10093 then
					for iter_18_8, iter_18_9 in pairs(arg_15_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_18_9 then
							if arg_15_1.isInRecall_ then
								iter_18_9.color = Color.New(Mathf.Lerp(iter_18_9.color.r, arg_15_1.hightColor1.r, (arg_15_1.time_ - 0) / var_18_12), Mathf.Lerp(iter_18_9.color.g, arg_15_1.hightColor1.g, (arg_15_1.time_ - 0) / var_18_12), (Mathf.Lerp(iter_18_9.color.b, arg_15_1.hightColor1.b, (arg_15_1.time_ - 0) / var_18_12)))
							else
								local var_18_13 = Mathf.Lerp(iter_18_9.color.r, 1, (arg_15_1.time_ - 0) / var_18_12)

								iter_18_9.color = Color.New(var_18_13, var_18_13, var_18_13)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_12 and arg_15_1.time_ < 0 + var_18_12 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.actorSpriteComps10093 then
				for iter_18_10, iter_18_11 in pairs(arg_15_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_18_11 then
						iter_18_11.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_15_1.var_.actorSpriteComps10093 = nil
			end

			local var_18_14 = 0
			local var_18_15 = 0.45

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_14 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_16 = arg_15_1:GetWordFromCfg(413121003)
				local var_18_17 = arg_15_1:FormatText(var_18_16.content)

				arg_15_1.text_.text = var_18_17

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_19 = 18 <= 0 and var_18_15 or var_18_15 * (utf8.len(var_18_17) / 18)

				if (18 <= 0 and var_18_15 or var_18_15 * (utf8.len(var_18_17) / 18)) > 0 and var_18_15 < var_18_19 then
					arg_15_1.talkMaxDuration = var_18_19

					if var_18_19 + var_18_14 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_19 + var_18_14
					end
				end

				arg_15_1.text_.text = var_18_17
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121003", "story_v_out_413121.awb") ~= 0 then
					local var_18_20 = manager.audio:GetVoiceLength("story_v_out_413121", "413121003", "story_v_out_413121.awb") / 1000

					if var_18_20 + var_18_14 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_20 + var_18_14
					end

					if var_18_16.prefab_name ~= "" and arg_15_1.actors_[var_18_16.prefab_name] ~= nil then
						local var_18_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_16.prefab_name].transform, "story_v_out_413121", "413121003", "story_v_out_413121.awb")

						arg_15_1:RecordAudio("413121003", var_18_21)
						arg_15_1:RecordAudio("413121003", var_18_21)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_413121", "413121003", "story_v_out_413121.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_413121", "413121003", "story_v_out_413121.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_22 = math.max(var_18_15, arg_15_1.talkMaxDuration)

			if var_18_14 <= arg_15_1.time_ and arg_15_1.time_ < var_18_14 + var_18_22 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_14) / var_18_22

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_14 + var_18_22 and arg_15_1.time_ < var_18_14 + var_18_22 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play413121004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413121004
		arg_19_1.duration_ = 4.83

		local var_19_0 = {
			zh = 1.999999999999,
			ja = 4.833
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
				arg_19_0:Play413121005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["10092_1"] == nil then
				local var_22_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

				if not isNil(var_22_0) then
					local var_22_1 = Object.Instantiate(var_22_0, arg_19_1.canvasGo_.transform)

					var_22_1.transform:SetSiblingIndex(1)

					var_22_1.name = "10092_1"
					var_22_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_["10092_1"] = var_22_1

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs((var_22_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_2 = arg_19_1.actors_["10092_1"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos10092_1 = var_22_2.localPosition
				var_22_2.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_22_2 = 0, var_22_2.childCount - 1 do
					local var_22_3 = var_22_2:GetChild(iter_22_2)

					if var_22_3.name == "split_1_1" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_2.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_19_1.time_ - 0) / var_22_4)
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_22_5 = arg_19_1.actors_["10093"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.actorSpriteComps10093 == nil then
				arg_19_1.var_.actorSpriteComps10093 = var_22_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_6 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.actorSpriteComps10093 then
					for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_22_4 then
							if arg_19_1.isInRecall_ then
								iter_22_4.color = Color.New(Mathf.Lerp(iter_22_4.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_6), Mathf.Lerp(iter_22_4.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_6), (Mathf.Lerp(iter_22_4.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_6)))
							else
								local var_22_7 = Mathf.Lerp(iter_22_4.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_6)

								iter_22_4.color = Color.New(var_22_7, var_22_7, var_22_7)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.actorSpriteComps10093 then
				for iter_22_5, iter_22_6 in pairs(arg_19_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_22_6 then
						iter_22_6.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps10093 = nil
			end

			local var_22_8 = arg_19_1.actors_["10092_1"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.actorSpriteComps10092_1 == nil then
				arg_19_1.var_.actorSpriteComps10092_1 = var_22_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_9 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 and not isNil(var_22_8) then
				if arg_19_1.var_.actorSpriteComps10092_1 then
					for iter_22_7, iter_22_8 in pairs(arg_19_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_22_8 then
							if arg_19_1.isInRecall_ then
								iter_22_8.color = Color.New(Mathf.Lerp(iter_22_8.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_9), Mathf.Lerp(iter_22_8.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_9), (Mathf.Lerp(iter_22_8.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_9)))
							else
								local var_22_10 = Mathf.Lerp(iter_22_8.color.r, 1, (arg_19_1.time_ - 0) / var_22_9)

								iter_22_8.color = Color.New(var_22_10, var_22_10, var_22_10)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.actorSpriteComps10092_1 then
				for iter_22_9, iter_22_10 in pairs(arg_19_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_22_10 then
						iter_22_10.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_22_11 = arg_19_1.actors_["10093"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos10093 = var_22_11.localPosition
				var_22_11.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("10093", 4)

				for iter_22_11 = 0, var_22_11.childCount - 1 do
					local var_22_12 = var_22_11:GetChild(iter_22_11)

					if var_22_12.name == "" or not string.find(var_22_12.name, "split") then
						var_22_12.gameObject:SetActive(true)
					else
						var_22_12.gameObject:SetActive(false)
					end
				end
			end

			local var_22_13 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_13 then
				var_22_11.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_19_1.time_ - 0) / var_22_13)
			end

			if arg_19_1.time_ >= 0 + var_22_13 and arg_19_1.time_ < 0 + var_22_13 + arg_22_0 then
				var_22_11.localPosition = Vector3.New(390, -345, -245)
			end

			local var_22_14 = 0
			local var_22_15 = 0.275

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_14 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_16 = arg_19_1:GetWordFromCfg(413121004)
				local var_22_17 = arg_19_1:FormatText(var_22_16.content)

				arg_19_1.text_.text = var_22_17

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_19 = 11 <= 0 and var_22_15 or var_22_15 * (utf8.len(var_22_17) / 11)

				if (11 <= 0 and var_22_15 or var_22_15 * (utf8.len(var_22_17) / 11)) > 0 and var_22_15 < var_22_19 then
					arg_19_1.talkMaxDuration = var_22_19

					if var_22_19 + var_22_14 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_14
					end
				end

				arg_19_1.text_.text = var_22_17
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121004", "story_v_out_413121.awb") ~= 0 then
					local var_22_20 = manager.audio:GetVoiceLength("story_v_out_413121", "413121004", "story_v_out_413121.awb") / 1000

					if var_22_20 + var_22_14 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_20 + var_22_14
					end

					if var_22_16.prefab_name ~= "" and arg_19_1.actors_[var_22_16.prefab_name] ~= nil then
						local var_22_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_16.prefab_name].transform, "story_v_out_413121", "413121004", "story_v_out_413121.awb")

						arg_19_1:RecordAudio("413121004", var_22_21)
						arg_19_1:RecordAudio("413121004", var_22_21)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413121", "413121004", "story_v_out_413121.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413121", "413121004", "story_v_out_413121.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_22 = math.max(var_22_15, arg_19_1.talkMaxDuration)

			if var_22_14 <= arg_19_1.time_ and arg_19_1.time_ < var_22_14 + var_22_22 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_14) / var_22_22

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_14 + var_22_22 and arg_19_1.time_ < var_22_14 + var_22_22 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413121005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413121005
		arg_23_1.duration_ = 8

		local var_23_0 = {
			zh = 6.8,
			ja = 8
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play413121006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 1 < arg_23_1.time_ and arg_23_1.time_ <= 1 + arg_26_0 then
				arg_23_1.var_.moveOldPos10093 = arg_23_1.actors_["10093"].transform.localPosition
				arg_23_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10093", 7)

				for iter_26_0 = 0, arg_23_1.actors_["10093"].transform.childCount - 1 do
					local var_26_0 = arg_23_1.actors_["10093"].transform:GetChild(iter_26_0)

					if var_26_0.name == "" or not string.find(var_26_0.name, "split") then
						var_26_0.gameObject:SetActive(true)
					else
						var_26_0.gameObject:SetActive(false)
					end
				end
			end

			local var_26_1 = 0.001

			if 1 <= arg_23_1.time_ and arg_23_1.time_ < 1 + var_26_1 then
				arg_23_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_23_1.time_ - 1) / var_26_1)
			end

			if arg_23_1.time_ >= 1 + var_26_1 and arg_23_1.time_ < 1 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_26_2 = arg_23_1.actors_["10092_1"].transform

			if 1 < arg_23_1.time_ and arg_23_1.time_ <= 1 + arg_26_0 then
				arg_23_1.var_.moveOldPos10092_1 = var_26_2.localPosition
				var_26_2.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_26_1 = 0, var_26_2.childCount - 1 do
					local var_26_3 = var_26_2:GetChild(iter_26_1)

					if var_26_3.name == "" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if 1 <= arg_23_1.time_ and arg_23_1.time_ < 1 + var_26_4 then
				var_26_2.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_23_1.time_ - 1) / var_26_4)
			end

			if arg_23_1.time_ >= 1 + var_26_4 and arg_23_1.time_ < 1 + var_26_4 + arg_26_0 then
				var_26_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_23_1.time_ and arg_23_1.time_ <= 1 + arg_26_0 then
				local var_26_5 = arg_23_1.bgs_.F08i

				arg_23_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_26_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_6 = var_26_5:GetComponent("SpriteRenderer")

				if var_26_6 and var_26_6.sprite then
					local var_26_7 = 2 * (var_26_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_26_5.transform.localScale = Vector3.New(var_26_7 / var_26_6.sprite.bounds.size.y < var_26_7 * manager.ui.mainCameraCom_.aspect / var_26_6.sprite.bounds.size.x and var_26_7 * manager.ui.mainCameraCom_.aspect / var_26_6.sprite.bounds.size.x or var_26_7 / var_26_6.sprite.bounds.size.y, var_26_7 / var_26_6.sprite.bounds.size.y < var_26_7 * manager.ui.mainCameraCom_.aspect / var_26_6.sprite.bounds.size.x and var_26_7 * manager.ui.mainCameraCom_.aspect / var_26_6.sprite.bounds.size.x or var_26_7 / var_26_6.sprite.bounds.size.y, 0)
				end

				for iter_26_2, iter_26_3 in pairs(arg_23_1.bgs_) do
					if iter_26_2 ~= "F08i" then
						iter_26_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_8 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_9 = 1

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_9 then
				local var_26_10 = Color.New(0, 0, 0)

				var_26_10.a = Mathf.Lerp(0, 1, (arg_23_1.time_ - var_26_8) / var_26_9)
				arg_23_1.mask_.color = var_26_10
			end

			if arg_23_1.time_ >= var_26_8 + var_26_9 and arg_23_1.time_ < var_26_8 + var_26_9 + arg_26_0 then
				local var_26_11 = Color.New(0, 0, 0)

				var_26_11.a = 1
				arg_23_1.mask_.color = var_26_11
			end

			local var_26_12 = 1

			if 1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_13 = 1

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_13 then
				local var_26_14 = Color.New(0, 0, 0)

				var_26_14.a = Mathf.Lerp(1, 0, (arg_23_1.time_ - var_26_12) / var_26_13)
				arg_23_1.mask_.color = var_26_14
			end

			if arg_23_1.time_ >= var_26_12 + var_26_13 and arg_23_1.time_ < var_26_12 + var_26_13 + arg_26_0 then
				local var_26_15 = Color.New(0, 0, 0)

				arg_23_1.mask_.enabled = false
				var_26_15.a = 0
				arg_23_1.mask_.color = var_26_15
			end

			local var_26_16 = 1

			arg_23_1.isInRecall_ = false

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				arg_23_1.screenFilterGo_:SetActive(false)

				for iter_26_4, iter_26_5 in pairs(arg_23_1.actors_) do
					for iter_26_6, iter_26_7 in ipairs((iter_26_5:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_26_7.color = iter_26_7.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_26_17 = 0.1

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_17 then
				arg_23_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_23_1.time_ - var_26_16) / var_26_17)
			end

			if arg_23_1.time_ >= var_26_16 + var_26_17 and arg_23_1.time_ < var_26_16 + var_26_17 + arg_26_0 then
				arg_23_1.screenFilterEffect_.weight = 0
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_18 = 2
			local var_26_19 = 0.55

			if 2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_18 + arg_26_0 then
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

				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_21 = arg_23_1:GetWordFromCfg(413121005)
				local var_26_22 = arg_23_1:FormatText(var_26_21.content)

				arg_23_1.text_.text = var_26_22

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_24 = 22 <= 0 and var_26_19 or var_26_19 * (utf8.len(var_26_22) / 22)

				if (22 <= 0 and var_26_19 or var_26_19 * (utf8.len(var_26_22) / 22)) > 0 and var_26_19 < var_26_24 then
					arg_23_1.talkMaxDuration = var_26_24
					var_26_18 = var_26_18 + 0.3

					if var_26_24 + var_26_18 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_24 + var_26_18
					end
				end

				arg_23_1.text_.text = var_26_22
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121005", "story_v_out_413121.awb") ~= 0 then
					local var_26_25 = manager.audio:GetVoiceLength("story_v_out_413121", "413121005", "story_v_out_413121.awb") / 1000

					if var_26_25 + var_26_18 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_25 + var_26_18
					end

					if var_26_21.prefab_name ~= "" and arg_23_1.actors_[var_26_21.prefab_name] ~= nil then
						local var_26_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_21.prefab_name].transform, "story_v_out_413121", "413121005", "story_v_out_413121.awb")

						arg_23_1:RecordAudio("413121005", var_26_26)
						arg_23_1:RecordAudio("413121005", var_26_26)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413121", "413121005", "story_v_out_413121.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413121", "413121005", "story_v_out_413121.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_27 = var_26_18 + 0.3
			local var_26_28 = math.max(var_26_19, arg_23_1.talkMaxDuration)

			if var_26_18 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_27 + var_26_28 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_27) / var_26_28

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_27 + var_26_28 and arg_23_1.time_ < var_26_27 + var_26_28 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play413121006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413121006
		arg_29_1.duration_ = 7.87

		local var_29_0 = {
			zh = 4.933,
			ja = 7.866
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
				arg_29_0:Play413121007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10092_1 = arg_29_1.actors_["10092_1"].transform.localPosition
				arg_29_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10092_1"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10092_1"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_8" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_32_2 = arg_29_1.actors_["10092_1"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10092_1 == nil then
				arg_29_1.var_.actorSpriteComps10092_1 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10092_1 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10092_1 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(413121006)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 22 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 22)

				if (22 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 22)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121006", "story_v_out_413121.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_413121", "413121006", "story_v_out_413121.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_413121", "413121006", "story_v_out_413121.awb")

						arg_29_1:RecordAudio("413121006", var_32_12)
						arg_29_1:RecordAudio("413121006", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413121", "413121006", "story_v_out_413121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413121", "413121006", "story_v_out_413121.awb")
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
				actorName = "10092_1",
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
	Play413121007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413121007
		arg_33_1.duration_ = 4.07

		local var_33_0 = {
			zh = 3.8,
			ja = 4.066
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
				arg_33_0:Play413121008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10092_1"]) and arg_33_1.var_.actorSpriteComps10092_1 == nil then
				arg_33_1.var_.actorSpriteComps10092_1 = arg_33_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10092_1"]) then
				if arg_33_1.var_.actorSpriteComps10092_1 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10092_1"]) and arg_33_1.var_.actorSpriteComps10092_1 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:GetWordFromCfg(413121007)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 19 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 19)

				if (19 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 19)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121007", "story_v_out_413121.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413121", "413121007", "story_v_out_413121.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_413121", "413121007", "story_v_out_413121.awb")

						arg_33_1:RecordAudio("413121007", var_36_9)
						arg_33_1:RecordAudio("413121007", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413121", "413121007", "story_v_out_413121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413121", "413121007", "story_v_out_413121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413121008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413121008
		arg_37_1.duration_ = 5.03

		local var_37_0 = {
			zh = 3.966,
			ja = 5.033
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
				arg_37_0:Play413121009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092_1 = arg_37_1.actors_["10092_1"].transform.localPosition
				arg_37_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_40_0 = 0, arg_37_1.actors_["10092_1"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10092_1"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_5" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_40_2 = arg_37_1.actors_["10092_1"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10092_1 == nil then
				arg_37_1.var_.actorSpriteComps10092_1 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10092_1 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10092_1 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(413121008)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 19 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 19)

				if (19 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 19)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121008", "story_v_out_413121.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413121", "413121008", "story_v_out_413121.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413121", "413121008", "story_v_out_413121.awb")

						arg_37_1:RecordAudio("413121008", var_40_12)
						arg_37_1:RecordAudio("413121008", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413121", "413121008", "story_v_out_413121.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413121", "413121008", "story_v_out_413121.awb")
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
				actorName = "10092_1",
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
	Play413121009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413121009
		arg_41_1.duration_ = 5.87

		local var_41_0 = {
			zh = 5.866,
			ja = 4.4
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
				arg_41_0:Play413121010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092_1 = arg_41_1.actors_["10092_1"].transform.localPosition
				arg_41_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_44_0 = 0, arg_41_1.actors_["10092_1"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10092_1"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_44_2 = arg_41_1.actors_["10092_1"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10092_1 == nil then
				arg_41_1.var_.actorSpriteComps10092_1 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10092_1 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10092_1 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.875

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(413121009)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 35 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 35)

				if (35 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 35)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121009", "story_v_out_413121.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_413121", "413121009", "story_v_out_413121.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_413121", "413121009", "story_v_out_413121.awb")

						arg_41_1:RecordAudio("413121009", var_44_12)
						arg_41_1:RecordAudio("413121009", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413121", "413121009", "story_v_out_413121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413121", "413121009", "story_v_out_413121.awb")
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
				actorName = "10092_1",
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
	Play413121010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413121010
		arg_45_1.duration_ = 6.4

		local var_45_0 = {
			zh = 4.633,
			ja = 6.4
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
				arg_45_0:Play413121011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10092_1"]) and arg_45_1.var_.actorSpriteComps10092_1 == nil then
				arg_45_1.var_.actorSpriteComps10092_1 = arg_45_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10092_1"]) then
				if arg_45_1.var_.actorSpriteComps10092_1 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10092_1"]) and arg_45_1.var_.actorSpriteComps10092_1 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:GetWordFromCfg(413121010)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 26 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 26)

				if (26 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 26)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121010", "story_v_out_413121.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_413121", "413121010", "story_v_out_413121.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_413121", "413121010", "story_v_out_413121.awb")

						arg_45_1:RecordAudio("413121010", var_48_9)
						arg_45_1:RecordAudio("413121010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413121", "413121010", "story_v_out_413121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413121", "413121010", "story_v_out_413121.awb")
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
	Play413121011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413121011
		arg_49_1.duration_ = 8.3

		local var_49_0 = {
			zh = 8.3,
			ja = 7.666
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
				arg_49_0:Play413121012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(413121011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 43 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 43)

				if (43 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 43)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121011", "story_v_out_413121.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_413121", "413121011", "story_v_out_413121.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_413121", "413121011", "story_v_out_413121.awb")

						arg_49_1:RecordAudio("413121011", var_52_6)
						arg_49_1:RecordAudio("413121011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413121", "413121011", "story_v_out_413121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413121", "413121011", "story_v_out_413121.awb")
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
	Play413121012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413121012
		arg_53_1.duration_ = 4.87

		local var_53_0 = {
			zh = 3.866,
			ja = 4.866
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
				arg_53_0:Play413121013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(413121012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 20 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 20)

				if (20 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 20)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121012", "story_v_out_413121.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_413121", "413121012", "story_v_out_413121.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_413121", "413121012", "story_v_out_413121.awb")

						arg_53_1:RecordAudio("413121012", var_56_6)
						arg_53_1:RecordAudio("413121012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413121", "413121012", "story_v_out_413121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413121", "413121012", "story_v_out_413121.awb")
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
	Play413121013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413121013
		arg_57_1.duration_ = 5.13

		local var_57_0 = {
			zh = 5.133,
			ja = 3.033
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
				arg_57_0:Play413121014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10092_1 = arg_57_1.actors_["10092_1"].transform.localPosition
				arg_57_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_60_0 = 0, arg_57_1.actors_["10092_1"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10092_1"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_60_2 = arg_57_1.actors_["10022"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10022 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10022", 3)

				for iter_60_1 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_1)

					if var_60_3.name == "split_6" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_60_5 = arg_57_1.actors_["10092_1"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps10092_1 == nil then
				arg_57_1.var_.actorSpriteComps10092_1 = var_60_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.actorSpriteComps10092_1 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								iter_60_3.color = Color.New(Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_6), Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_6), (Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_6)))
							else
								local var_60_7 = Mathf.Lerp(iter_60_3.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_6)

								iter_60_3.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps10092_1 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_60_5 then
						iter_60_5.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_60_8 = arg_57_1.actors_["10022"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_9 and not isNil(var_60_8) then
				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								iter_60_7.color = Color.New(Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_9), Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_9), (Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_9)))
							else
								local var_60_10 = Mathf.Lerp(iter_60_7.color.r, 1, (arg_57_1.time_ - 0) / var_60_9)

								iter_60_7.color = Color.New(var_60_10, var_60_10, var_60_10)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_9 and arg_57_1.time_ < 0 + var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_9 then
						iter_60_9.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_11 = 0
			local var_60_12 = 0.65

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_13 = arg_57_1:GetWordFromCfg(413121013)
				local var_60_14 = arg_57_1:FormatText(var_60_13.content)

				arg_57_1.text_.text = var_60_14

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 26 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 26)

				if (26 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 26)) > 0 and var_60_12 < var_60_16 then
					arg_57_1.talkMaxDuration = var_60_16

					if var_60_16 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_14
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121013", "story_v_out_413121.awb") ~= 0 then
					local var_60_17 = manager.audio:GetVoiceLength("story_v_out_413121", "413121013", "story_v_out_413121.awb") / 1000

					if var_60_17 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_11
					end

					if var_60_13.prefab_name ~= "" and arg_57_1.actors_[var_60_13.prefab_name] ~= nil then
						local var_60_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_13.prefab_name].transform, "story_v_out_413121", "413121013", "story_v_out_413121.awb")

						arg_57_1:RecordAudio("413121013", var_60_18)
						arg_57_1:RecordAudio("413121013", var_60_18)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413121", "413121013", "story_v_out_413121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413121", "413121013", "story_v_out_413121.awb")
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
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413121014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413121014
		arg_61_1.duration_ = 7.93

		local var_61_0 = {
			zh = 6.7,
			ja = 7.933
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
				arg_61_0:Play413121015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10022"]) and arg_61_1.var_.actorSpriteComps10022 == nil then
				arg_61_1.var_.actorSpriteComps10022 = arg_61_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10022"]) then
				if arg_61_1.var_.actorSpriteComps10022 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10022"]) and arg_61_1.var_.actorSpriteComps10022 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10022 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.8

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:GetWordFromCfg(413121014)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 32 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 32)

				if (32 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 32)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121014", "story_v_out_413121.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_413121", "413121014", "story_v_out_413121.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_413121", "413121014", "story_v_out_413121.awb")

						arg_61_1:RecordAudio("413121014", var_64_9)
						arg_61_1:RecordAudio("413121014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413121", "413121014", "story_v_out_413121.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413121", "413121014", "story_v_out_413121.awb")
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
	Play413121015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413121015
		arg_65_1.duration_ = 4.1

		local var_65_0 = {
			zh = 2.433,
			ja = 4.1
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
				arg_65_0:Play413121016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10092_1 = arg_65_1.actors_["10092_1"].transform.localPosition
				arg_65_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_68_0 = 0, arg_65_1.actors_["10092_1"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10092_1"].transform:GetChild(iter_68_0)

					if var_68_0.name == "" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_68_2 = arg_65_1.actors_["10092_1"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10092_1 == nil then
				arg_65_1.var_.actorSpriteComps10092_1 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10092_1 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10092_1 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_68_5 = arg_65_1.actors_["10022"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10022 = var_68_5.localPosition
				var_68_5.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10022", 7)

				for iter_68_5 = 0, var_68_5.childCount - 1 do
					local var_68_6 = var_68_5:GetChild(iter_68_5)

					if var_68_6.name == "split_3" or not string.find(var_68_6.name, "split") then
						var_68_6.gameObject:SetActive(true)
					else
						var_68_6.gameObject:SetActive(false)
					end
				end
			end

			local var_68_7 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_65_1.time_ - 0) / var_68_7)
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_8 = 0
			local var_68_9 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(413121015)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 13 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 13)

				if (13 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 13)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121015", "story_v_out_413121.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_413121", "413121015", "story_v_out_413121.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_413121", "413121015", "story_v_out_413121.awb")

						arg_65_1:RecordAudio("413121015", var_68_15)
						arg_65_1:RecordAudio("413121015", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413121", "413121015", "story_v_out_413121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413121", "413121015", "story_v_out_413121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413121016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413121016
		arg_69_1.duration_ = 4.33

		local var_69_0 = {
			zh = 2.966,
			ja = 4.333
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
				arg_69_0:Play413121017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092_1 = arg_69_1.actors_["10092_1"].transform.localPosition
				arg_69_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_72_0 = 0, arg_69_1.actors_["10092_1"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10092_1"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_2" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_72_2 = 0
			local var_72_3 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(413121016)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 16 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 16)

				if (16 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 16)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121016", "story_v_out_413121.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_413121", "413121016", "story_v_out_413121.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_413121", "413121016", "story_v_out_413121.awb")

						arg_69_1:RecordAudio("413121016", var_72_9)
						arg_69_1:RecordAudio("413121016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413121", "413121016", "story_v_out_413121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413121", "413121016", "story_v_out_413121.awb")
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
				actorName = "10092_1",
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
	Play413121017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413121017
		arg_73_1.duration_ = 7.77

		local var_73_0 = {
			zh = 4.433,
			ja = 7.766
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
				arg_73_0:Play413121018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10092_1 = arg_73_1.actors_["10092_1"].transform.localPosition
				arg_73_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_76_0 = 0, arg_73_1.actors_["10092_1"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10092_1"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_76_2 = arg_73_1.actors_["10092_1"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10092_1 == nil then
				arg_73_1.var_.actorSpriteComps10092_1 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10092_1 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10092_1 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_76_5 = 0
			local var_76_6 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(413121017)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 27 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 27)

				if (27 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 27)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121017", "story_v_out_413121.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_413121", "413121017", "story_v_out_413121.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_413121", "413121017", "story_v_out_413121.awb")

						arg_73_1:RecordAudio("413121017", var_76_12)
						arg_73_1:RecordAudio("413121017", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413121", "413121017", "story_v_out_413121.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413121", "413121017", "story_v_out_413121.awb")
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
				actorName = "10092_1",
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
	Play413121018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413121018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play413121019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092_1 = arg_77_1.actors_["10092_1"].transform.localPosition
				arg_77_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_80_0 = 0, arg_77_1.actors_["10092_1"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10092_1"].transform:GetChild(iter_80_0)

					if var_80_0.name == "" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_2 = 0
			local var_80_3 = 1.025

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

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(413121018).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 41 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 41)

				if (41 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 41)) > 0 and var_80_3 < var_80_6 then
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

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413121019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413121019
		arg_81_1.duration_ = 4.63

		local var_81_0 = {
			zh = 3.1,
			ja = 4.633
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
				arg_81_0:Play413121020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092_1 = arg_81_1.actors_["10092_1"].transform.localPosition
				arg_81_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_84_0 = 0, arg_81_1.actors_["10092_1"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10092_1"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_84_2 = arg_81_1.actors_["10022"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10022 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10022", 4)

				for iter_84_1 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_1)

					if var_84_3.name == "split_6" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_84_5 = arg_81_1.actors_["10092_1"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10092_1 == nil then
				arg_81_1.var_.actorSpriteComps10092_1 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps10092_1 then
					for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10092_1 then
				for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_84_5 then
						iter_84_5.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_84_8 = arg_81_1.actors_["10022"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10022 == nil then
				arg_81_1.var_.actorSpriteComps10022 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 and not isNil(var_84_8) then
				if arg_81_1.var_.actorSpriteComps10022 then
					for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10022 then
				for iter_84_8, iter_84_9 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_84_9 then
						iter_84_9.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10022 = nil
			end

			local var_84_11 = 0
			local var_84_12 = 0.425

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(413121019)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 17 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 17)

				if (17 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 17)) > 0 and var_84_12 < var_84_16 then
					arg_81_1.talkMaxDuration = var_84_16

					if var_84_16 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121019", "story_v_out_413121.awb") ~= 0 then
					local var_84_17 = manager.audio:GetVoiceLength("story_v_out_413121", "413121019", "story_v_out_413121.awb") / 1000

					if var_84_17 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_11
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_413121", "413121019", "story_v_out_413121.awb")

						arg_81_1:RecordAudio("413121019", var_84_18)
						arg_81_1:RecordAudio("413121019", var_84_18)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413121", "413121019", "story_v_out_413121.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413121", "413121019", "story_v_out_413121.awb")
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
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413121020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413121020
		arg_85_1.duration_ = 6

		local var_85_0 = {
			zh = 2.8,
			ja = 6
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
				arg_85_0:Play413121021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = arg_85_1.actors_["10092_1"].transform.localPosition
				arg_85_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_88_0 = 0, arg_85_1.actors_["10092_1"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10092_1"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_1_1" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_88_2 = arg_85_1.actors_["10092_1"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10092_1 == nil then
				arg_85_1.var_.actorSpriteComps10092_1 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10092_1 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10092_1 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_88_5 = arg_85_1.actors_["10022"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								iter_88_6.color = Color.New(Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_6), Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_6), (Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_6)))
							else
								local var_88_7 = Mathf.Lerp(iter_88_6.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_6)

								iter_88_6.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_8 then
						iter_88_8.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(413121020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 13 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 13)

				if (13 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 13)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121020", "story_v_out_413121.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_413121", "413121020", "story_v_out_413121.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_413121", "413121020", "story_v_out_413121.awb")

						arg_85_1:RecordAudio("413121020", var_88_15)
						arg_85_1:RecordAudio("413121020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413121", "413121020", "story_v_out_413121.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413121", "413121020", "story_v_out_413121.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413121021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413121021
		arg_89_1.duration_ = 3.97

		local var_89_0 = {
			zh = 1.766,
			ja = 3.966
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
				arg_89_0:Play413121022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(413121021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 7 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 7)

				if (7 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 7)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121021", "story_v_out_413121.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413121", "413121021", "story_v_out_413121.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413121", "413121021", "story_v_out_413121.awb")

						arg_89_1:RecordAudio("413121021", var_92_6)
						arg_89_1:RecordAudio("413121021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413121", "413121021", "story_v_out_413121.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413121", "413121021", "story_v_out_413121.awb")
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
	Play413121022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413121022
		arg_93_1.duration_ = 5

		local var_93_0 = {
			zh = 2.3,
			ja = 5
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
				arg_93_0:Play413121023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10092_1"]) and arg_93_1.var_.actorSpriteComps10092_1 == nil then
				arg_93_1.var_.actorSpriteComps10092_1 = arg_93_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10092_1"]) then
				if arg_93_1.var_.actorSpriteComps10092_1 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10092_1"]) and arg_93_1.var_.actorSpriteComps10092_1 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_96_2 = 0
			local var_96_3 = 0.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_4 = arg_93_1:GetWordFromCfg(413121022)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 8 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 8)

				if (8 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 8)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121022", "story_v_out_413121.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_413121", "413121022", "story_v_out_413121.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_413121", "413121022", "story_v_out_413121.awb")

						arg_93_1:RecordAudio("413121022", var_96_9)
						arg_93_1:RecordAudio("413121022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413121", "413121022", "story_v_out_413121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413121", "413121022", "story_v_out_413121.awb")
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

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play413121023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413121023
		arg_97_1.duration_ = 7

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play413121024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092_1 = arg_97_1.actors_["10092_1"].transform.localPosition
				arg_97_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_100_0 = 0, arg_97_1.actors_["10092_1"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10092_1"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_100_2 = arg_97_1.actors_["10022"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10022 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10022", 6)

				for iter_100_1 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_1)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_100_5 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_6 = 1

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 then
				local var_100_7 = Color.New(1, 1, 1)

				var_100_7.a = Mathf.Lerp(0, 1, (arg_97_1.time_ - var_100_5) / var_100_6)
				arg_97_1.mask_.color = var_100_7
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 then
				local var_100_8 = Color.New(1, 1, 1)

				var_100_8.a = 1
				arg_97_1.mask_.color = var_100_8
			end

			local var_100_9 = 1

			if 1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = false

				arg_97_1:SetGaussion(false)
			end

			local var_100_10 = 1

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 then
				local var_100_11 = Color.New(1, 1, 1)

				var_100_11.a = Mathf.Lerp(1, 0, (arg_97_1.time_ - var_100_9) / var_100_10)
				arg_97_1.mask_.color = var_100_11
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 then
				local var_100_12 = Color.New(1, 1, 1)

				arg_97_1.mask_.enabled = false
				var_100_12.a = 0
				arg_97_1.mask_.color = var_100_12
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_13 = 2
			local var_100_14 = 0.925

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_15 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_15:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_16 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(413121023).content)

				arg_97_1.text_.text = var_100_16

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_18 = 37 <= 0 and var_100_14 or var_100_14 * (utf8.len(var_100_16) / 37)

				if (37 <= 0 and var_100_14 or var_100_14 * (utf8.len(var_100_16) / 37)) > 0 and var_100_14 < var_100_18 then
					arg_97_1.talkMaxDuration = var_100_18
					var_100_13 = var_100_13 + 0.3

					if var_100_18 + var_100_13 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_13
					end
				end

				arg_97_1.text_.text = var_100_16
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = var_100_13 + 0.3
			local var_100_20 = math.max(var_100_14, arg_97_1.talkMaxDuration)

			if var_100_13 + 0.3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_19 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_19) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_19 + var_100_20 and arg_97_1.time_ < var_100_19 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413121024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413121024
		arg_103_1.duration_ = 6.5

		local var_103_0 = {
			zh = 4.3,
			ja = 6.5
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
				arg_103_0:Play413121025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10092_1 = arg_103_1.actors_["10092_1"].transform.localPosition
				arg_103_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_106_0 = 0, arg_103_1.actors_["10092_1"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["10092_1"].transform:GetChild(iter_106_0)

					if var_106_0.name == "split_8" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_106_2 = arg_103_1.actors_["10092_1"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps10092_1 == nil then
				arg_103_1.var_.actorSpriteComps10092_1 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps10092_1 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps10092_1 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_106_4 then
						iter_106_4.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_106_5 = 0
			local var_106_6 = 0.55

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(413121024)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 22 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 22)

				if (22 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 22)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121024", "story_v_out_413121.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_413121", "413121024", "story_v_out_413121.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_413121", "413121024", "story_v_out_413121.awb")

						arg_103_1:RecordAudio("413121024", var_106_12)
						arg_103_1:RecordAudio("413121024", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413121", "413121024", "story_v_out_413121.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413121", "413121024", "story_v_out_413121.awb")
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
				actorName = "10092_1",
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
	Play413121025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413121025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play413121026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10092_1 = arg_107_1.actors_["10092_1"].transform.localPosition
				arg_107_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_110_0 = 0, arg_107_1.actors_["10092_1"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10092_1"].transform:GetChild(iter_110_0)

					if var_110_0.name == "" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_110_2 = arg_107_1.actors_["10092_1"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10092_1 == nil then
				arg_107_1.var_.actorSpriteComps10092_1 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps10092_1 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10092_1 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_110_4 then
						iter_110_4.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_110_5 = 0
			local var_110_6 = 1.075

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(413121025).content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 43 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_7) / 43)

				if (43 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_7) / 43)) > 0 and var_110_6 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_10 and arg_107_1.time_ < var_110_5 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413121026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413121026
		arg_111_1.duration_ = 5.83

		local var_111_0 = {
			zh = 4.466,
			ja = 5.833
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
				arg_111_0:Play413121027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10022 = arg_111_1.actors_["10022"].transform.localPosition
				arg_111_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10022", 3)

				for iter_114_0 = 0, arg_111_1.actors_["10022"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["10022"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_6" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_114_2 = arg_111_1.actors_["10022"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10022 == nil then
				arg_111_1.var_.actorSpriteComps10022 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps10022 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10022 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10022 = nil
			end

			local var_114_5 = 0
			local var_114_6 = 0.575

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(413121026)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 23 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 23)

				if (23 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 23)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121026", "story_v_out_413121.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_413121", "413121026", "story_v_out_413121.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_413121", "413121026", "story_v_out_413121.awb")

						arg_111_1:RecordAudio("413121026", var_114_12)
						arg_111_1:RecordAudio("413121026", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413121", "413121026", "story_v_out_413121.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413121", "413121026", "story_v_out_413121.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_13 and arg_111_1.time_ < var_114_5 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413121027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413121027
		arg_115_1.duration_ = 6

		local var_115_0 = {
			zh = 3.866,
			ja = 6
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
				arg_115_0:Play413121028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10022 = arg_115_1.actors_["10022"].transform.localPosition
				arg_115_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10022", 7)

				for iter_118_0 = 0, arg_115_1.actors_["10022"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["10022"].transform:GetChild(iter_118_0)

					if var_118_0.name == "split_3" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_2 = arg_115_1.actors_["10092_1"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10092_1 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_118_1 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_1)

					if var_118_3.name == "split_1_1" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_118_5 = arg_115_1.actors_["10022"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10022 == nil then
				arg_115_1.var_.actorSpriteComps10022 = var_118_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.actorSpriteComps10022 then
					for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_118_3 then
							if arg_115_1.isInRecall_ then
								iter_118_3.color = Color.New(Mathf.Lerp(iter_118_3.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_6), Mathf.Lerp(iter_118_3.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_6), (Mathf.Lerp(iter_118_3.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_6)))
							else
								local var_118_7 = Mathf.Lerp(iter_118_3.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_6)

								iter_118_3.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10022 then
				for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_118_5 then
						iter_118_5.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10022 = nil
			end

			local var_118_8 = arg_115_1.actors_["10092_1"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10092_1 == nil then
				arg_115_1.var_.actorSpriteComps10092_1 = var_118_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_9 and not isNil(var_118_8) then
				if arg_115_1.var_.actorSpriteComps10092_1 then
					for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_118_7 then
							if arg_115_1.isInRecall_ then
								iter_118_7.color = Color.New(Mathf.Lerp(iter_118_7.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_9), Mathf.Lerp(iter_118_7.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_9), (Mathf.Lerp(iter_118_7.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_9)))
							else
								local var_118_10 = Mathf.Lerp(iter_118_7.color.r, 1, (arg_115_1.time_ - 0) / var_118_9)

								iter_118_7.color = Color.New(var_118_10, var_118_10, var_118_10)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_9 and arg_115_1.time_ < 0 + var_118_9 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10092_1 then
				for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_118_9 then
						iter_118_9.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_118_11 = 0
			local var_118_12 = 0.55

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_13 = arg_115_1:GetWordFromCfg(413121027)
				local var_118_14 = arg_115_1:FormatText(var_118_13.content)

				arg_115_1.text_.text = var_118_14

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_16 = 22 <= 0 and var_118_12 or var_118_12 * (utf8.len(var_118_14) / 22)

				if (22 <= 0 and var_118_12 or var_118_12 * (utf8.len(var_118_14) / 22)) > 0 and var_118_12 < var_118_16 then
					arg_115_1.talkMaxDuration = var_118_16

					if var_118_16 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_11
					end
				end

				arg_115_1.text_.text = var_118_14
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121027", "story_v_out_413121.awb") ~= 0 then
					local var_118_17 = manager.audio:GetVoiceLength("story_v_out_413121", "413121027", "story_v_out_413121.awb") / 1000

					if var_118_17 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_11
					end

					if var_118_13.prefab_name ~= "" and arg_115_1.actors_[var_118_13.prefab_name] ~= nil then
						local var_118_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_13.prefab_name].transform, "story_v_out_413121", "413121027", "story_v_out_413121.awb")

						arg_115_1:RecordAudio("413121027", var_118_18)
						arg_115_1:RecordAudio("413121027", var_118_18)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413121", "413121027", "story_v_out_413121.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413121", "413121027", "story_v_out_413121.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_19 = math.max(var_118_12, arg_115_1.talkMaxDuration)

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_19 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_11) / var_118_19

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_11 + var_118_19 and arg_115_1.time_ < var_118_11 + var_118_19 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413121028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413121028
		arg_119_1.duration_ = 8.33

		local var_119_0 = {
			zh = 3.8,
			ja = 8.333
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
				arg_119_0:Play413121029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10092_1 = arg_119_1.actors_["10092_1"].transform.localPosition
				arg_119_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10092_1"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10092_1"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_2" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_122_2 = 0
			local var_122_3 = 0.475

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(413121028)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 19 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 19)

				if (19 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 19)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413121", "413121028", "story_v_out_413121.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_413121", "413121028", "story_v_out_413121.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_413121", "413121028", "story_v_out_413121.awb")

						arg_119_1:RecordAudio("413121028", var_122_9)
						arg_119_1:RecordAudio("413121028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413121", "413121028", "story_v_out_413121.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413121", "413121028", "story_v_out_413121.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413121029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413121029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
			arg_123_1.auto_ = false
		end

		function arg_123_1.playNext_(arg_125_0)
			arg_123_1.onStoryFinished_()
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10092_1 = arg_123_1.actors_["10092_1"].transform.localPosition
				arg_123_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_126_0 = 0, arg_123_1.actors_["10092_1"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10092_1"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_126_2 = arg_123_1.actors_["10022"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10022 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10022", 6)

				for iter_126_1 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_1)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_126_5 = arg_123_1.actors_["10092_1"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10092_1 == nil then
				arg_123_1.var_.actorSpriteComps10092_1 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps10092_1 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								iter_126_3.color = Color.New(Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_3.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_3.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10092_1 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_126_5 then
						iter_126_5.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_126_8 = arg_123_1.actors_["10022"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 and not isNil(var_126_8) then
				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_7 then
							if arg_123_1.isInRecall_ then
								iter_126_7.color = Color.New(Mathf.Lerp(iter_126_7.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_9), Mathf.Lerp(iter_126_7.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_9), (Mathf.Lerp(iter_126_7.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_9)))
							else
								local var_126_10 = Mathf.Lerp(iter_126_7.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_9)

								iter_126_7.color = Color.New(var_126_10, var_126_10, var_126_10)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_8, iter_126_9 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_9 then
						iter_126_9.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_11 = arg_123_1.actors_["10092_1"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_11 then
					arg_123_1.var_.alphaOldValue10092_1 = var_126_11.alpha
					arg_123_1.var_.characterEffect10092_1 = var_126_11
				end

				arg_123_1.var_.alphaOldValue10092_1 = 1
			end

			local var_126_12 = 0.5

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_12 then
				if arg_123_1.var_.characterEffect10092_1 then
					arg_123_1.var_.characterEffect10092_1.alpha = Mathf.Lerp(arg_123_1.var_.alphaOldValue10092_1, 0, (arg_123_1.time_ - 0) / var_126_12)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_12 and arg_123_1.time_ < 0 + var_126_12 + arg_126_0 and arg_123_1.var_.characterEffect10092_1 then
				arg_123_1.var_.characterEffect10092_1.alpha = 0
			end

			local var_126_13 = 0
			local var_126_14 = 1.2

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(413121029).content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 48 <= 0 and var_126_14 or var_126_14 * (utf8.len(var_126_15) / 48)

				if (48 <= 0 and var_126_14 or var_126_14 * (utf8.len(var_126_15) / 48)) > 0 and var_126_14 < var_126_17 then
					arg_123_1.talkMaxDuration = var_126_17

					if var_126_17 + var_126_13 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_13
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_14, arg_123_1.talkMaxDuration)

			if var_126_13 <= arg_123_1.time_ and arg_123_1.time_ < var_126_13 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_13) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_13 + var_126_18 and arg_123_1.time_ < var_126_13 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	assets = {
		"TextureConfig/Background/F08i"
	},
	voices = {
		"story_v_out_413121.awb"
	}
}
