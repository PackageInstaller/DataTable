return {
	Play410142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410142001
		arg_1_1.duration_ = 5

		local var_1_0 = {
			ja = 5,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_1_0:Play410142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST61 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_4_0.name = "ST61"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST61 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST61

				arg_1_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST61" then
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

			local var_4_8 = "1061"

			if arg_1_1.actors_["1061"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_4_9) then
					local var_4_10 = Object.Instantiate(var_4_9, arg_1_1.canvasGo_.transform)

					var_4_10.transform:SetSiblingIndex(1)

					var_4_10.name = var_4_8
					var_4_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_8] = var_4_10

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_11 = arg_1_1.actors_["1061"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1061", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -490, 18)
			end

			local var_4_14 = arg_1_1.actors_["1061"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps1061 == nil then
				arg_1_1.var_.actorSpriteComps1061 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.0339999999999998

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps1061 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 2) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps1061 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1061 = nil
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

			if 0.666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.666666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

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
			local var_4_24 = 0.125

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(410142001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 5 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 5)

				if (5 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 5)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142001", "story_v_out_410142.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_410142", "410142001", "story_v_out_410142.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_410142", "410142001", "story_v_out_410142.awb")

						arg_1_1:RecordAudio("410142001", var_4_31)
						arg_1_1:RecordAudio("410142001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410142", "410142001", "story_v_out_410142.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410142", "410142001", "story_v_out_410142.awb")
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410142002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_map", "")
			end

			local var_12_1 = arg_9_1.actors_["1061"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.actorSpriteComps1061 == nil then
				arg_9_1.var_.actorSpriteComps1061 = var_12_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.actorSpriteComps1061 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								iter_12_1.color = Color.New(Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_2), Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_2), (Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_2)))
							else
								local var_12_3 = Mathf.Lerp(iter_12_1.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_2)

								iter_12_1.color = Color.New(var_12_3, var_12_3, var_12_3)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.actorSpriteComps1061 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1061 = nil
			end

			local var_12_4 = 0
			local var_12_5 = 1.1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(410142002).content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 44 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 44)

				if (44 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 44)) > 0 and var_12_5 < var_12_8 then
					arg_9_1.talkMaxDuration = var_12_8

					if var_12_8 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_6
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_9 and arg_9_1.time_ < var_12_4 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410142003
		arg_13_1.duration_ = 17.4

		local var_13_0 = {
			ja = 17.4,
			CriLanguages = 10.1,
			zh = 10.1
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
				arg_13_0:Play410142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = arg_13_1.actors_["1061"].transform.localPosition
				arg_13_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 2)

				for iter_16_0 = 0, arg_13_1.actors_["1061"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1061"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_16_2 = "1056"

			if arg_13_1.actors_["1056"] == nil then
				local var_16_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_16_3) then
					local var_16_4 = Object.Instantiate(var_16_3, arg_13_1.canvasGo_.transform)

					var_16_4.transform:SetSiblingIndex(1)

					var_16_4.name = var_16_2
					var_16_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_2] = var_16_4

					if arg_13_1.isInRecall_ then
						for iter_16_1, iter_16_2 in ipairs((var_16_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_2.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_5 = arg_13_1.actors_["1056"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1056 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1056", 4)

				for iter_16_3 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_3)

					if var_16_6.name == "" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_16_8 = arg_13_1.actors_["1061"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								iter_16_5.color = Color.New(Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_9), Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_9), (Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_9)))
							else
								local var_16_10 = Mathf.Lerp(iter_16_5.color.r, 1, (arg_13_1.time_ - 0) / var_16_9)

								iter_16_5.color = Color.New(var_16_10, var_16_10, var_16_10)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_7 then
						iter_16_7.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_11 = arg_13_1.actors_["1056"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps1056 == nil then
				arg_13_1.var_.actorSpriteComps1056 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_12 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_12 and not isNil(var_16_11) then
				if arg_13_1.var_.actorSpriteComps1056 then
					for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_16_9 then
							if arg_13_1.isInRecall_ then
								iter_16_9.color = Color.New(Mathf.Lerp(iter_16_9.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_12), Mathf.Lerp(iter_16_9.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_12), (Mathf.Lerp(iter_16_9.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_12)))
							else
								local var_16_13 = Mathf.Lerp(iter_16_9.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_12)

								iter_16_9.color = Color.New(var_16_13, var_16_13, var_16_13)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_12 and arg_13_1.time_ < 0 + var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps1056 then
				for iter_16_10, iter_16_11 in pairs(arg_13_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_16_11 then
						iter_16_11.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps1056 = nil
			end

			local var_16_14 = 0
			local var_16_15 = 1.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_16 = arg_13_1:GetWordFromCfg(410142003)
				local var_16_17 = arg_13_1:FormatText(var_16_16.content)

				arg_13_1.text_.text = var_16_17

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 45 <= 0 and var_16_15 or var_16_15 * (utf8.len(var_16_17) / 45)

				if (45 <= 0 and var_16_15 or var_16_15 * (utf8.len(var_16_17) / 45)) > 0 and var_16_15 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_17
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142003", "story_v_out_410142.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_410142", "410142003", "story_v_out_410142.awb") / 1000

					if var_16_20 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_14
					end

					if var_16_16.prefab_name ~= "" and arg_13_1.actors_[var_16_16.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_16.prefab_name].transform, "story_v_out_410142", "410142003", "story_v_out_410142.awb")

						arg_13_1:RecordAudio("410142003", var_16_21)
						arg_13_1:RecordAudio("410142003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410142", "410142003", "story_v_out_410142.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410142", "410142003", "story_v_out_410142.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_22 and arg_13_1.time_ < var_16_14 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
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
	Play410142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410142004
		arg_17_1.duration_ = 17.73

		local var_17_0 = {
			ja = 17.733,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_17_0:Play410142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061 = arg_17_1.actors_["1061"].transform.localPosition
				arg_17_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1061", 2)

				for iter_20_0 = 0, arg_17_1.actors_["1061"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["1061"].transform:GetChild(iter_20_0)

					if var_20_0.name == "split_2" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_20_2 = arg_17_1.actors_["1061"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1061 == nil then
				arg_17_1.var_.actorSpriteComps1061 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1061 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1061 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1061 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.925

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(410142004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 37 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 37)

				if (37 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 37)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142004", "story_v_out_410142.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142004", "story_v_out_410142.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_410142", "410142004", "story_v_out_410142.awb")

						arg_17_1:RecordAudio("410142004", var_20_12)
						arg_17_1:RecordAudio("410142004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410142", "410142004", "story_v_out_410142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410142", "410142004", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410142005
		arg_21_1.duration_ = 8.5

		local var_21_0 = {
			ja = 8.5,
			CriLanguages = 4.6,
			zh = 4.6
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
				arg_21_0:Play410142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1056 = arg_21_1.actors_["1056"].transform.localPosition
				arg_21_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1056", 4)

				for iter_24_0 = 0, arg_21_1.actors_["1056"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["1056"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_24_2 = arg_21_1.actors_["1056"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1056 == nil then
				arg_21_1.var_.actorSpriteComps1056 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1056 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								iter_24_2.color = Color.New(Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_2.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_2.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1056 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1056 = nil
			end

			local var_24_5 = arg_21_1.actors_["1061"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_6 then
							if arg_21_1.isInRecall_ then
								iter_24_6.color = Color.New(Mathf.Lerp(iter_24_6.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_6.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_6.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_6.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_6.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_7, iter_24_8 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_8 then
						iter_24_8.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(410142005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 17 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 17)

				if (17 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 17)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142005", "story_v_out_410142.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142005", "story_v_out_410142.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_410142", "410142005", "story_v_out_410142.awb")

						arg_21_1:RecordAudio("410142005", var_24_15)
						arg_21_1:RecordAudio("410142005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410142", "410142005", "story_v_out_410142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410142", "410142005", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410142006
		arg_25_1.duration_ = 10.3

		local var_25_0 = {
			ja = 10.3,
			CriLanguages = 5.133,
			zh = 5.133
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
				arg_25_0:Play410142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = arg_25_1.actors_["1061"].transform.localPosition
				arg_25_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 2)

				for iter_28_0 = 0, arg_25_1.actors_["1061"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1061"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_1" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_28_2 = arg_25_1.actors_["1061"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_5 = arg_25_1.actors_["1056"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps1056 == nil then
				arg_25_1.var_.actorSpriteComps1056 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps1056 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_28_6 then
							if arg_25_1.isInRecall_ then
								iter_28_6.color = Color.New(Mathf.Lerp(iter_28_6.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_6), Mathf.Lerp(iter_28_6.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_6), (Mathf.Lerp(iter_28_6.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_6)))
							else
								local var_28_7 = Mathf.Lerp(iter_28_6.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_6)

								iter_28_6.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps1056 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_28_8 then
						iter_28_8.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1056 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(410142006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 22 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 22)

				if (22 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 22)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142006", "story_v_out_410142.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142006", "story_v_out_410142.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_410142", "410142006", "story_v_out_410142.awb")

						arg_25_1:RecordAudio("410142006", var_28_15)
						arg_25_1:RecordAudio("410142006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410142", "410142006", "story_v_out_410142.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410142", "410142006", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410142007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410142008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1056 = arg_29_1.actors_["1056"].transform.localPosition
				arg_29_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1056", 7)

				for iter_32_0 = 0, arg_29_1.actors_["1056"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1056"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1056"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_32_2 = arg_29_1.actors_["1061"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 7)

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
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_32_5 = arg_29_1.actors_["1056"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps1056 == nil then
				arg_29_1.var_.actorSpriteComps1056 = var_32_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.actorSpriteComps1056 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								iter_32_3.color = Color.New(Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_6), Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_6), (Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_6)))
							else
								local var_32_7 = Mathf.Lerp(iter_32_3.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_6)

								iter_32_3.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps1056 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_32_5 then
						iter_32_5.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1056 = nil
			end

			local var_32_8 = arg_29_1.actors_["1061"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 and not isNil(var_32_8) then
				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_32_7 then
							if arg_29_1.isInRecall_ then
								iter_32_7.color = Color.New(Mathf.Lerp(iter_32_7.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_9), Mathf.Lerp(iter_32_7.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_9), (Mathf.Lerp(iter_32_7.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_9)))
							else
								local var_32_10 = Mathf.Lerp(iter_32_7.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_9)

								iter_32_7.color = Color.New(var_32_10, var_32_10, var_32_10)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_9 then
						iter_32_9.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_11 = 0
			local var_32_12 = 0.975

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_13 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(410142007).content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 39 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_13) / 39)

				if (39 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_13) / 39)) > 0 and var_32_12 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_16 and arg_29_1.time_ < var_32_11 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410142008
		arg_33_1.duration_ = 6.9

		local var_33_0 = {
			ja = 6.9,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_33_0:Play410142009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = arg_33_1.actors_["1061"].transform.localPosition
				arg_33_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 3)

				for iter_36_0 = 0, arg_33_1.actors_["1061"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1061"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_2" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_36_2 = arg_33_1.actors_["1061"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(410142008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 19 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 19)

				if (19 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 19)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142008", "story_v_out_410142.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142008", "story_v_out_410142.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410142", "410142008", "story_v_out_410142.awb")

						arg_33_1:RecordAudio("410142008", var_36_12)
						arg_33_1:RecordAudio("410142008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410142", "410142008", "story_v_out_410142.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410142", "410142008", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410142009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410142010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1061"]) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = arg_37_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1061"]) then
				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1061"]) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_2 = 0
			local var_40_3 = 1.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(410142009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 51 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 51)

				if (51 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 51)) > 0 and var_40_3 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_7 and arg_37_1.time_ < var_40_2 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410142010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410142010
		arg_41_1.duration_ = 6.57

		local var_41_0 = {
			ja = 6.566,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_41_0:Play410142011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = arg_41_1.actors_["1061"].transform.localPosition
				arg_41_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 2)

				for iter_44_0 = 0, arg_41_1.actors_["1061"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1061"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_5" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_44_2 = arg_41_1.actors_["1056"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1056 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1056", 4)

				for iter_44_1 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_1)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_44_5 = arg_41_1.actors_["1061"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								iter_44_3.color = Color.New(Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_6), Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_6), (Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_6)))
							else
								local var_44_7 = Mathf.Lerp(iter_44_3.color.r, 1, (arg_41_1.time_ - 0) / var_44_6)

								iter_44_3.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_5 then
						iter_44_5.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_8 = arg_41_1.actors_["1056"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1056 == nil then
				arg_41_1.var_.actorSpriteComps1056 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.actorSpriteComps1056 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								iter_44_7.color = Color.New(Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_7.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_7.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1056 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_44_9 then
						iter_44_9.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1056 = nil
			end

			local var_44_11 = 0
			local var_44_12 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(410142010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 13 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 13)

				if (13 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 13)) > 0 and var_44_12 < var_44_16 then
					arg_41_1.talkMaxDuration = var_44_16

					if var_44_16 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142010", "story_v_out_410142.awb") ~= 0 then
					local var_44_17 = manager.audio:GetVoiceLength("story_v_out_410142", "410142010", "story_v_out_410142.awb") / 1000

					if var_44_17 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_11
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_410142", "410142010", "story_v_out_410142.awb")

						arg_41_1:RecordAudio("410142010", var_44_18)
						arg_41_1:RecordAudio("410142010", var_44_18)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410142", "410142010", "story_v_out_410142.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410142", "410142010", "story_v_out_410142.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_19 and arg_41_1.time_ < var_44_11 + var_44_19 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
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
	Play410142011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410142011
		arg_45_1.duration_ = 3.83

		local var_45_0 = {
			ja = 3.833,
			CriLanguages = 1.766,
			zh = 1.766
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
				arg_45_0:Play410142012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1056 = arg_45_1.actors_["1056"].transform.localPosition
				arg_45_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1056", 4)

				for iter_48_0 = 0, arg_45_1.actors_["1056"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1056"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_1" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_48_2 = arg_45_1.actors_["1056"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1056 == nil then
				arg_45_1.var_.actorSpriteComps1056 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps1056 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_2.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_2.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1056 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1056 = nil
			end

			local var_48_5 = arg_45_1.actors_["1061"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								iter_48_6.color = Color.New(Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_6.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_6.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_8 then
						iter_48_8.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(410142011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 8 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 8)

				if (8 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 8)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142011", "story_v_out_410142.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142011", "story_v_out_410142.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_410142", "410142011", "story_v_out_410142.awb")

						arg_45_1:RecordAudio("410142011", var_48_15)
						arg_45_1:RecordAudio("410142011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410142", "410142011", "story_v_out_410142.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410142", "410142011", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410142012
		arg_49_1.duration_ = 7.67

		local var_49_0 = {
			ja = 1.333,
			CriLanguages = 7.666,
			zh = 7.666
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
				arg_49_0:Play410142013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = arg_49_1.actors_["1061"].transform.localPosition
				arg_49_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 2)

				for iter_52_0 = 0, arg_49_1.actors_["1061"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1061"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_52_2 = arg_49_1.actors_["1061"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_5 = arg_49_1.actors_["1056"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1056 == nil then
				arg_49_1.var_.actorSpriteComps1056 = var_52_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.actorSpriteComps1056 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								iter_52_6.color = Color.New(Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_6), Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_6), (Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_6)))
							else
								local var_52_7 = Mathf.Lerp(iter_52_6.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_6)

								iter_52_6.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1056 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_52_8 then
						iter_52_8.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1056 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(410142012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 2 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 2)

				if (2 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 2)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142012", "story_v_out_410142.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142012", "story_v_out_410142.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_410142", "410142012", "story_v_out_410142.awb")

						arg_49_1:RecordAudio("410142012", var_52_15)
						arg_49_1:RecordAudio("410142012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410142", "410142012", "story_v_out_410142.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410142", "410142012", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410142013
		arg_53_1.duration_ = 2.77

		local var_53_0 = {
			ja = 2.766,
			CriLanguages = 2.633,
			zh = 2.633
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
				arg_53_0:Play410142014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1056 = arg_53_1.actors_["1056"].transform.localPosition
				arg_53_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1056", 4)

				for iter_56_0 = 0, arg_53_1.actors_["1056"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1056"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_1" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_56_2 = arg_53_1.actors_["1056"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1056 == nil then
				arg_53_1.var_.actorSpriteComps1056 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps1056 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1056 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1056 = nil
			end

			local var_56_5 = arg_53_1.actors_["1061"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_6 then
							if arg_53_1.isInRecall_ then
								iter_56_6.color = Color.New(Mathf.Lerp(iter_56_6.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_6.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_6.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_6.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_6.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_8 then
						iter_56_8.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(410142013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 14 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 14)

				if (14 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 14)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142013", "story_v_out_410142.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142013", "story_v_out_410142.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_410142", "410142013", "story_v_out_410142.awb")

						arg_53_1:RecordAudio("410142013", var_56_15)
						arg_53_1:RecordAudio("410142013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410142", "410142013", "story_v_out_410142.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410142", "410142013", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410142014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410142015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1056"]) and arg_57_1.var_.actorSpriteComps1056 == nil then
				arg_57_1.var_.actorSpriteComps1056 = arg_57_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1056"]) then
				if arg_57_1.var_.actorSpriteComps1056 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1056"]) and arg_57_1.var_.actorSpriteComps1056 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1056 = nil
			end

			local var_60_2 = arg_57_1.actors_["1061"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1061 == nil then
				arg_57_1.var_.actorSpriteComps1061 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1061 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1061 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1061 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.7

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

				local var_60_7 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(410142014).content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 28 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 28)

				if (28 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 28)) > 0 and var_60_6 < var_60_9 then
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
	Play410142015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410142015
		arg_61_1.duration_ = 9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410142016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				local var_64_0 = arg_61_1.bgs_.ST61

				arg_61_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_1 = var_64_0:GetComponent("SpriteRenderer")

				if var_64_1 and var_64_1.sprite then
					local var_64_2 = 2 * (var_64_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_0.transform.localScale = Vector3.New(var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST61" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_3 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_4 = 2

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 then
				local var_64_5 = Color.New(0, 0, 0)

				var_64_5.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_3) / var_64_4)
				arg_61_1.mask_.color = var_64_5
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 then
				local var_64_6 = Color.New(0, 0, 0)

				var_64_6.a = 1
				arg_61_1.mask_.color = var_64_6
			end

			local var_64_7 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_8 = 2

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 then
				local var_64_9 = Color.New(0, 0, 0)

				var_64_9.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_7) / var_64_8)
				arg_61_1.mask_.color = var_64_9
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 then
				local var_64_10 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_10.a = 0
				arg_61_1.mask_.color = var_64_10
			end

			local var_64_11 = arg_61_1.actors_["1056"].transform

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				arg_61_1.var_.moveOldPos1056 = var_64_11.localPosition
				var_64_11.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1056", 7)

				for iter_64_2 = 0, var_64_11.childCount - 1 do
					local var_64_12 = var_64_11:GetChild(iter_64_2)

					if var_64_12.name == "split_1" or not string.find(var_64_12.name, "split") then
						var_64_12.gameObject:SetActive(true)
					else
						var_64_12.gameObject:SetActive(false)
					end
				end
			end

			local var_64_13 = 0.001

			if 2 <= arg_61_1.time_ and arg_61_1.time_ < 2 + var_64_13 then
				var_64_11.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_61_1.time_ - 2) / var_64_13)
			end

			if arg_61_1.time_ >= 2 + var_64_13 and arg_61_1.time_ < 2 + var_64_13 + arg_64_0 then
				var_64_11.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_64_14 = arg_61_1.actors_["1061"].transform

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = var_64_14.localPosition
				var_64_14.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 7)

				for iter_64_3 = 0, var_64_14.childCount - 1 do
					local var_64_15 = var_64_14:GetChild(iter_64_3)

					if var_64_15.name == "split_1" or not string.find(var_64_15.name, "split") then
						var_64_15.gameObject:SetActive(true)
					else
						var_64_15.gameObject:SetActive(false)
					end
				end
			end

			local var_64_16 = 0.001

			if 2 <= arg_61_1.time_ and arg_61_1.time_ < 2 + var_64_16 then
				var_64_14.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, Vector3.New(0, -2000, -180), (arg_61_1.time_ - 2) / var_64_16)
			end

			if arg_61_1.time_ >= 2 + var_64_16 and arg_61_1.time_ < 2 + var_64_16 + arg_64_0 then
				var_64_14.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_17 = 4
			local var_64_18 = 1.025

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_19 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_19:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_20 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(410142015).content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 41 <= 0 and var_64_18 or var_64_18 * (utf8.len(var_64_20) / 41)

				if (41 <= 0 and var_64_18 or var_64_18 * (utf8.len(var_64_20) / 41)) > 0 and var_64_18 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22
					var_64_17 = var_64_17 + 0.3

					if var_64_22 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_17
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_23 = var_64_17 + 0.3
			local var_64_24 = math.max(var_64_18, arg_61_1.talkMaxDuration)

			if var_64_17 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_23) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410142016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410142016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play410142017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1061 = arg_67_1.actors_["1061"].transform.localPosition
				arg_67_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1061", 3)

				for iter_70_0 = 0, arg_67_1.actors_["1061"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["1061"].transform:GetChild(iter_70_0)

					if var_70_0.name == "" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_70_2 = arg_67_1.actors_["1061"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1061 == nil then
				arg_67_1.var_.actorSpriteComps1061 = var_70_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_3 = 0.034

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.actorSpriteComps1061 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								iter_70_2.color = Color.New(Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_3), Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_3), (Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_3)))
							else
								local var_70_4 = Mathf.Lerp(iter_70_2.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_3)

								iter_70_2.color = Color.New(var_70_4, var_70_4, var_70_4)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1061 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_70_4 then
						iter_70_4.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1061 = nil
			end

			local var_70_5 = 0
			local var_70_6 = 1.125

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(410142016).content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 45 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_7) / 45)

				if (45 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_7) / 45)) > 0 and var_70_6 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_5
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_6, arg_67_1.talkMaxDuration)

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_5) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_5 + var_70_10 and arg_67_1.time_ < var_70_5 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410142017
		arg_71_1.duration_ = 5.77

		local var_71_0 = {
			ja = 5.766,
			CriLanguages = 1.9,
			zh = 1.9
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
				arg_71_0:Play410142018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1061 = arg_71_1.actors_["1061"].transform.localPosition
				arg_71_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1061", 3)

				for iter_74_0 = 0, arg_71_1.actors_["1061"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["1061"].transform:GetChild(iter_74_0)

					if var_74_0.name == "" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_74_2 = arg_71_1.actors_["1061"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1061 == nil then
				arg_71_1.var_.actorSpriteComps1061 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.034

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps1061 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								iter_74_2.color = Color.New(Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_2.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_2.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1061 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_74_4 then
						iter_74_4.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps1061 = nil
			end

			local var_74_5 = 0
			local var_74_6 = 0.1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_7 = arg_71_1:GetWordFromCfg(410142017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 4 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 4)

				if (4 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 4)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142017", "story_v_out_410142.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142017", "story_v_out_410142.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_410142", "410142017", "story_v_out_410142.awb")

						arg_71_1:RecordAudio("410142017", var_74_12)
						arg_71_1:RecordAudio("410142017", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_410142", "410142017", "story_v_out_410142.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_410142", "410142017", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410142018
		arg_75_1.duration_ = 11.57

		local var_75_0 = {
			ja = 11.566,
			CriLanguages = 6.333,
			zh = 6.333
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
				arg_75_0:Play410142019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1061 = arg_75_1.actors_["1061"].transform.localPosition
				arg_75_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1061", 3)

				for iter_78_0 = 0, arg_75_1.actors_["1061"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["1061"].transform:GetChild(iter_78_0)

					if var_78_0.name == "split_5" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_78_2 = arg_75_1.actors_["1061"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1061 == nil then
				arg_75_1.var_.actorSpriteComps1061 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps1061 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								iter_78_2.color = Color.New(Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_2.color.r, 1, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_2.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1061 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1061 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.8

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(410142018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 32 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 32)

				if (32 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 32)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142018", "story_v_out_410142.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142018", "story_v_out_410142.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_410142", "410142018", "story_v_out_410142.awb")

						arg_75_1:RecordAudio("410142018", var_78_12)
						arg_75_1:RecordAudio("410142018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410142", "410142018", "story_v_out_410142.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410142", "410142018", "story_v_out_410142.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_13 and arg_75_1.time_ < var_78_5 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410142019
		arg_79_1.duration_ = 16.4

		local var_79_0 = {
			ja = 16.4,
			CriLanguages = 5.533,
			zh = 5.533
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
				arg_79_0:Play410142020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1061"]) and arg_79_1.var_.actorSpriteComps1061 == nil then
				arg_79_1.var_.actorSpriteComps1061 = arg_79_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1061"]) then
				if arg_79_1.var_.actorSpriteComps1061 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1061"]) and arg_79_1.var_.actorSpriteComps1061 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1061 = nil
			end

			local var_82_2 = 0
			local var_82_3 = 0.6

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_4 = arg_79_1:GetWordFromCfg(410142019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 24 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 24)

				if (24 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 24)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142019", "story_v_out_410142.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142019", "story_v_out_410142.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_410142", "410142019", "story_v_out_410142.awb")

						arg_79_1:RecordAudio("410142019", var_82_9)
						arg_79_1:RecordAudio("410142019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410142", "410142019", "story_v_out_410142.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410142", "410142019", "story_v_out_410142.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play410142020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410142020
		arg_83_1.duration_ = 14.7

		local var_83_0 = {
			ja = 14.7,
			CriLanguages = 6.1,
			zh = 6.1
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
				arg_83_0:Play410142021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1061 = arg_83_1.actors_["1061"].transform.localPosition
				arg_83_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1061", 3)

				for iter_86_0 = 0, arg_83_1.actors_["1061"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["1061"].transform:GetChild(iter_86_0)

					if var_86_0.name == "split_5" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_86_2 = arg_83_1.actors_["1061"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps1061 == nil then
				arg_83_1.var_.actorSpriteComps1061 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps1061 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps1061 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps1061 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 0.775

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(410142020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 31 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 31)

				if (31 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 31)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142020", "story_v_out_410142.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142020", "story_v_out_410142.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_410142", "410142020", "story_v_out_410142.awb")

						arg_83_1:RecordAudio("410142020", var_86_12)
						arg_83_1:RecordAudio("410142020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410142", "410142020", "story_v_out_410142.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410142", "410142020", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410142021
		arg_87_1.duration_ = 9.57

		local var_87_0 = {
			ja = 9.566,
			CriLanguages = 2.4,
			zh = 2.4
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
				arg_87_0:Play410142022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1061"]) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = arg_87_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_0 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1061"]) then
				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								iter_90_1.color = Color.New(Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_0), Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_0), (Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_0)))
							else
								local var_90_1 = Mathf.Lerp(iter_90_1.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_0)

								iter_90_1.color = Color.New(var_90_1, var_90_1, var_90_1)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1061"]) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			local var_90_2 = 0
			local var_90_3 = 0.2

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_4 = arg_87_1:GetWordFromCfg(410142021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 8 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 8)

				if (8 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 8)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142021", "story_v_out_410142.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142021", "story_v_out_410142.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_410142", "410142021", "story_v_out_410142.awb")

						arg_87_1:RecordAudio("410142021", var_90_9)
						arg_87_1:RecordAudio("410142021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410142", "410142021", "story_v_out_410142.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410142", "410142021", "story_v_out_410142.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play410142022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410142022
		arg_91_1.duration_ = 4.8

		local var_91_0 = {
			ja = 4.8,
			CriLanguages = 2.633,
			zh = 2.633
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
				arg_91_0:Play410142023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1061 = arg_91_1.actors_["1061"].transform.localPosition
				arg_91_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1061", 3)

				for iter_94_0 = 0, arg_91_1.actors_["1061"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["1061"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_5" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_94_2 = arg_91_1.actors_["1061"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1061 == nil then
				arg_91_1.var_.actorSpriteComps1061 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps1061 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1061 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_94_4 then
						iter_94_4.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps1061 = nil
			end

			local var_94_5 = 0
			local var_94_6 = 0.225

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(410142022)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 9 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 9)

				if (9 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 9)) > 0 and var_94_6 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142022", "story_v_out_410142.awb") ~= 0 then
					local var_94_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142022", "story_v_out_410142.awb") / 1000

					if var_94_11 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_5
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_410142", "410142022", "story_v_out_410142.awb")

						arg_91_1:RecordAudio("410142022", var_94_12)
						arg_91_1:RecordAudio("410142022", var_94_12)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410142", "410142022", "story_v_out_410142.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410142", "410142022", "story_v_out_410142.awb")
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

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410142023
		arg_95_1.duration_ = 8.83

		local var_95_0 = {
			ja = 8.833,
			CriLanguages = 6.8,
			zh = 6.8
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
				arg_95_0:Play410142024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1061 = arg_95_1.actors_["1061"].transform.localPosition
				arg_95_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1061", 3)

				for iter_98_0 = 0, arg_95_1.actors_["1061"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1061"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_98_2 = arg_95_1.actors_["1061"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps1061 == nil then
				arg_95_1.var_.actorSpriteComps1061 = var_98_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_3 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.actorSpriteComps1061 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								iter_98_2.color = Color.New(Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_3), Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_3), (Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_3)))
							else
								local var_98_4 = Mathf.Lerp(iter_98_2.color.r, 1, (arg_95_1.time_ - 0) / var_98_3)

								iter_98_2.color = Color.New(var_98_4, var_98_4, var_98_4)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps1061 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_98_4 then
						iter_98_4.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps1061 = nil
			end

			local var_98_5 = 0
			local var_98_6 = 0.825

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(410142023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 33 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 33)

				if (33 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 33)) > 0 and var_98_6 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142023", "story_v_out_410142.awb") ~= 0 then
					local var_98_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142023", "story_v_out_410142.awb") / 1000

					if var_98_11 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_5
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_410142", "410142023", "story_v_out_410142.awb")

						arg_95_1:RecordAudio("410142023", var_98_12)
						arg_95_1:RecordAudio("410142023", var_98_12)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410142", "410142023", "story_v_out_410142.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410142", "410142023", "story_v_out_410142.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_13 and arg_95_1.time_ < var_98_5 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play410142024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410142024
		arg_99_1.duration_ = 1.97

		local var_99_0 = {
			ja = 0.999999999999,
			CriLanguages = 1.966,
			zh = 1.966
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play410142025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1061"]) and arg_99_1.var_.actorSpriteComps1061 == nil then
				arg_99_1.var_.actorSpriteComps1061 = arg_99_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1061"]) then
				if arg_99_1.var_.actorSpriteComps1061 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1061"]) and arg_99_1.var_.actorSpriteComps1061 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps1061 = nil
			end

			local var_102_2 = 0
			local var_102_3 = 0.075

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_4 = arg_99_1:GetWordFromCfg(410142024)
				local var_102_5 = arg_99_1:FormatText(var_102_4.content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 3 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 3)

				if (3 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 3)) > 0 and var_102_3 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_2
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142024", "story_v_out_410142.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142024", "story_v_out_410142.awb") / 1000

					if var_102_8 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_2
					end

					if var_102_4.prefab_name ~= "" and arg_99_1.actors_[var_102_4.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_4.prefab_name].transform, "story_v_out_410142", "410142024", "story_v_out_410142.awb")

						arg_99_1:RecordAudio("410142024", var_102_9)
						arg_99_1:RecordAudio("410142024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410142", "410142024", "story_v_out_410142.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410142", "410142024", "story_v_out_410142.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_3, arg_99_1.talkMaxDuration)

			if var_102_2 <= arg_99_1.time_ and arg_99_1.time_ < var_102_2 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_2) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_2 + var_102_10 and arg_99_1.time_ < var_102_2 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play410142025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410142025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410142026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.075

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(410142025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 43 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 43)

				if (43 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 43)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play410142026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410142026
		arg_107_1.duration_ = 20.2

		local var_107_0 = {
			ja = 20.2,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_107_0:Play410142027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.725

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(410142026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 29 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 29)

				if (29 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 29)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142026", "story_v_out_410142.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_410142", "410142026", "story_v_out_410142.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_410142", "410142026", "story_v_out_410142.awb")

						arg_107_1:RecordAudio("410142026", var_110_6)
						arg_107_1:RecordAudio("410142026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410142", "410142026", "story_v_out_410142.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410142", "410142026", "story_v_out_410142.awb")
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
	Play410142027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410142027
		arg_111_1.duration_ = 6.57

		local var_111_0 = {
			ja = 6.566,
			CriLanguages = 4.6,
			zh = 4.6
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
				arg_111_0:Play410142028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1061 = arg_111_1.actors_["1061"].transform.localPosition
				arg_111_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1061", 3)

				for iter_114_0 = 0, arg_111_1.actors_["1061"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["1061"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_5" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_114_2 = arg_111_1.actors_["1061"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1061 == nil then
				arg_111_1.var_.actorSpriteComps1061 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps1061 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1061 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1061 = nil
			end

			local var_114_5 = 0
			local var_114_6 = 0.425

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(410142027)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 17 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 17)

				if (17 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 17)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142027", "story_v_out_410142.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142027", "story_v_out_410142.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_410142", "410142027", "story_v_out_410142.awb")

						arg_111_1:RecordAudio("410142027", var_114_12)
						arg_111_1:RecordAudio("410142027", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410142", "410142027", "story_v_out_410142.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410142", "410142027", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410142028
		arg_115_1.duration_ = 4.07

		local var_115_0 = {
			ja = 4.066,
			CriLanguages = 1.733,
			zh = 1.733
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
				arg_115_0:Play410142029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1061"]) and arg_115_1.var_.actorSpriteComps1061 == nil then
				arg_115_1.var_.actorSpriteComps1061 = arg_115_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1061"]) then
				if arg_115_1.var_.actorSpriteComps1061 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								iter_118_1.color = Color.New(Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_0), Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_0), (Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_0)))
							else
								local var_118_1 = Mathf.Lerp(iter_118_1.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_0)

								iter_118_1.color = Color.New(var_118_1, var_118_1, var_118_1)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1061"]) and arg_115_1.var_.actorSpriteComps1061 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1061 = nil
			end

			local var_118_2 = 0
			local var_118_3 = 0.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_4 = arg_115_1:GetWordFromCfg(410142028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 3 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 3)

				if (3 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 3)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142028", "story_v_out_410142.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142028", "story_v_out_410142.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_410142", "410142028", "story_v_out_410142.awb")

						arg_115_1:RecordAudio("410142028", var_118_9)
						arg_115_1:RecordAudio("410142028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410142", "410142028", "story_v_out_410142.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410142", "410142028", "story_v_out_410142.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410142029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410142029
		arg_119_1.duration_ = 10.63

		local var_119_0 = {
			ja = 10.633,
			CriLanguages = 5.166,
			zh = 5.166
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
				arg_119_0:Play410142030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1061 = arg_119_1.actors_["1061"].transform.localPosition
				arg_119_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1061", 3)

				for iter_122_0 = 0, arg_119_1.actors_["1061"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["1061"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_122_2 = arg_119_1.actors_["1061"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1061 == nil then
				arg_119_1.var_.actorSpriteComps1061 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps1061 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1061 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1061 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.45

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(410142029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 18 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 18)

				if (18 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 18)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142029", "story_v_out_410142.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142029", "story_v_out_410142.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_410142", "410142029", "story_v_out_410142.awb")

						arg_119_1:RecordAudio("410142029", var_122_12)
						arg_119_1:RecordAudio("410142029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410142", "410142029", "story_v_out_410142.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410142", "410142029", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410142030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play410142031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1061"]) and arg_123_1.var_.actorSpriteComps1061 == nil then
				arg_123_1.var_.actorSpriteComps1061 = arg_123_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1061"]) then
				if arg_123_1.var_.actorSpriteComps1061 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1061"]) and arg_123_1.var_.actorSpriteComps1061 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1061 = nil
			end

			local var_126_2 = 0
			local var_126_3 = 1.025

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(410142030).content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 41 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 41)

				if (41 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 41)) > 0 and var_126_3 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_7 and arg_123_1.time_ < var_126_2 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play410142031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410142031
		arg_127_1.duration_ = 9.83

		local var_127_0 = {
			ja = 9.833,
			CriLanguages = 3.366,
			zh = 3.366
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play410142032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1061 = arg_127_1.actors_["1061"].transform.localPosition
				arg_127_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1061", 3)

				for iter_130_0 = 0, arg_127_1.actors_["1061"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["1061"].transform:GetChild(iter_130_0)

					if var_130_0.name == "split_7" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_130_2 = arg_127_1.actors_["1061"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1061 == nil then
				arg_127_1.var_.actorSpriteComps1061 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps1061 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 1, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1061 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1061 = nil
			end

			local var_130_5 = 0
			local var_130_6 = 0.275

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(410142031)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 11 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 11)

				if (11 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 11)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142031", "story_v_out_410142.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142031", "story_v_out_410142.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_410142", "410142031", "story_v_out_410142.awb")

						arg_127_1:RecordAudio("410142031", var_130_12)
						arg_127_1:RecordAudio("410142031", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410142", "410142031", "story_v_out_410142.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410142", "410142031", "story_v_out_410142.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410142032
		arg_131_1.duration_ = 14.47

		local var_131_0 = {
			ja = 14.466,
			CriLanguages = 5.8,
			zh = 5.8
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
				arg_131_0:Play410142033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1061 = arg_131_1.actors_["1061"].transform.localPosition
				arg_131_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1061", 3)

				for iter_134_0 = 0, arg_131_1.actors_["1061"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["1061"].transform:GetChild(iter_134_0)

					if var_134_0.name == "" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_134_2 = arg_131_1.actors_["1061"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1061 == nil then
				arg_131_1.var_.actorSpriteComps1061 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps1061 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								iter_134_2.color = Color.New(Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_2.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_2.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1061 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps1061 = nil
			end

			local var_134_5 = 0
			local var_134_6 = 0.575

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_7 = arg_131_1:GetWordFromCfg(410142032)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 23 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 23)

				if (23 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 23)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142032", "story_v_out_410142.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142032", "story_v_out_410142.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_410142", "410142032", "story_v_out_410142.awb")

						arg_131_1:RecordAudio("410142032", var_134_12)
						arg_131_1:RecordAudio("410142032", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410142", "410142032", "story_v_out_410142.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410142", "410142032", "story_v_out_410142.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_6, arg_131_1.talkMaxDuration)

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_5) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_5 + var_134_13 and arg_131_1.time_ < var_134_5 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410142033
		arg_135_1.duration_ = 12.6

		local var_135_0 = {
			ja = 12.6,
			CriLanguages = 11.6,
			zh = 11.6
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
				arg_135_0:Play410142034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1061 = arg_135_1.actors_["1061"].transform.localPosition
				arg_135_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1061", 3)

				for iter_138_0 = 0, arg_135_1.actors_["1061"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["1061"].transform:GetChild(iter_138_0)

					if var_138_0.name == "" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_138_2 = arg_135_1.actors_["1061"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1061 == nil then
				arg_135_1.var_.actorSpriteComps1061 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1061 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1061 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1061 = nil
			end

			local var_138_5 = 0
			local var_138_6 = 1.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(410142033)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 54 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 54)

				if (54 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 54)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142033", "story_v_out_410142.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142033", "story_v_out_410142.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_410142", "410142033", "story_v_out_410142.awb")

						arg_135_1:RecordAudio("410142033", var_138_12)
						arg_135_1:RecordAudio("410142033", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410142", "410142033", "story_v_out_410142.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410142", "410142033", "story_v_out_410142.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play410142034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410142034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play410142035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1061 = arg_139_1.actors_["1061"].transform.localPosition
				arg_139_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1061", 3)

				for iter_142_0 = 0, arg_139_1.actors_["1061"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["1061"].transform:GetChild(iter_142_0)

					if var_142_0.name == "" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_142_2 = arg_139_1.actors_["1061"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1061 == nil then
				arg_139_1.var_.actorSpriteComps1061 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1061 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1061 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1061 = nil
			end

			local var_142_5 = manager.ui.mainCamera.transform

			if 0.5 < arg_139_1.time_ and arg_139_1.time_ <= 0.5 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_5.localPosition
			end

			local var_142_6 = 0.5

			if 0.5 <= arg_139_1.time_ and arg_139_1.time_ < 0.5 + var_142_6 then
				local var_142_7, var_142_8 = math.modf((arg_139_1.time_ - 0.5) / 0.066)

				var_142_5.localPosition = Vector3.New(var_142_8 * 0.13, var_142_8 * 0.13, var_142_8 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= 0.5 + var_142_6 and arg_139_1.time_ < 0.5 + var_142_6 + arg_142_0 then
				var_142_5.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_9 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_9 + 1 and arg_139_1.time_ < var_142_9 + 1 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_10 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = false

				arg_139_1:SetGaussion(false)
			end

			local var_142_11 = 0.5

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 then
				local var_142_12 = Color.New(1, 1, 1)

				var_142_12.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_10) / var_142_11)
				arg_139_1.mask_.color = var_142_12
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 then
				local var_142_13 = Color.New(1, 1, 1)

				arg_139_1.mask_.enabled = false
				var_142_13.a = 0
				arg_139_1.mask_.color = var_142_13
			end

			local var_142_14 = manager.ui.mainCamera.transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_14.localPosition
			end

			local var_142_15 = 0.5

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_15 then
				local var_142_16, var_142_17 = math.modf((arg_139_1.time_ - 0) / 0.066)

				var_142_14.localPosition = Vector3.New(var_142_17 * 0.13, var_142_17 * 0.13, var_142_17 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= 0 + var_142_15 and arg_139_1.time_ < 0 + var_142_15 + arg_142_0 then
				var_142_14.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_18 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_18 + 0.5 and arg_139_1.time_ < var_142_18 + 0.5 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_19 = 0
			local var_142_20 = 1.275

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_21 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(410142034).content)

				arg_139_1.text_.text = var_142_21

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_23 = 51 <= 0 and var_142_20 or var_142_20 * (utf8.len(var_142_21) / 51)

				if (51 <= 0 and var_142_20 or var_142_20 * (utf8.len(var_142_21) / 51)) > 0 and var_142_20 < var_142_23 then
					arg_139_1.talkMaxDuration = var_142_23

					if var_142_23 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_19
					end
				end

				arg_139_1.text_.text = var_142_21
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_24 = math.max(var_142_20, arg_139_1.talkMaxDuration)

			if var_142_19 <= arg_139_1.time_ and arg_139_1.time_ < var_142_19 + var_142_24 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_19) / var_142_24

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_19 + var_142_24 and arg_139_1.time_ < var_142_19 + var_142_24 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410142035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play410142036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.625

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(410142035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 25 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 25)

				if (25 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 25)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play410142036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410142036
		arg_147_1.duration_ = 3.9

		local var_147_0 = {
			ja = 3.9,
			CriLanguages = 2.533,
			zh = 2.533
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
				arg_147_0:Play410142037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = arg_147_1.actors_["1061"].transform.localPosition
				arg_147_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 3)

				for iter_150_0 = 0, arg_147_1.actors_["1061"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["1061"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_9" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_150_2 = arg_147_1.actors_["1061"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1061 == nil then
				arg_147_1.var_.actorSpriteComps1061 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps1061 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								iter_150_2.color = Color.New(Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_2.color.r, 1, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_2.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1061 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_150_4 then
						iter_150_4.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1061 = nil
			end

			local var_150_5 = 0
			local var_150_6 = 0.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(410142036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 10 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 10)

				if (10 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 10)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142036", "story_v_out_410142.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142036", "story_v_out_410142.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_410142", "410142036", "story_v_out_410142.awb")

						arg_147_1:RecordAudio("410142036", var_150_12)
						arg_147_1:RecordAudio("410142036", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410142", "410142036", "story_v_out_410142.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410142", "410142036", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410142037
		arg_151_1.duration_ = 5.67

		local var_151_0 = {
			ja = 5.666,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_151_0:Play410142038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1061 = arg_151_1.actors_["1061"].transform.localPosition
				arg_151_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1061", 3)

				for iter_154_0 = 0, arg_151_1.actors_["1061"].transform.childCount - 1 do
					local var_154_0 = arg_151_1.actors_["1061"].transform:GetChild(iter_154_0)

					if var_154_0.name == "" or not string.find(var_154_0.name, "split") then
						var_154_0.gameObject:SetActive(true)
					else
						var_154_0.gameObject:SetActive(false)
					end
				end
			end

			local var_154_1 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				arg_151_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_151_1.time_ - 0) / var_154_1)
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				arg_151_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_154_2 = arg_151_1.actors_["1061"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1061 == nil then
				arg_151_1.var_.actorSpriteComps1061 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps1061 then
					for iter_154_1, iter_154_2 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_154_2 then
							if arg_151_1.isInRecall_ then
								iter_154_2.color = Color.New(Mathf.Lerp(iter_154_2.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_2.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_2.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_2.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_2.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1061 then
				for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_154_4 then
						iter_154_4.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1061 = nil
			end

			local var_154_5 = 0
			local var_154_6 = 0.4

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_7 = arg_151_1:GetWordFromCfg(410142037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 16 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 16)

				if (16 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 16)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142037", "story_v_out_410142.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142037", "story_v_out_410142.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_410142", "410142037", "story_v_out_410142.awb")

						arg_151_1:RecordAudio("410142037", var_154_12)
						arg_151_1:RecordAudio("410142037", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410142", "410142037", "story_v_out_410142.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410142", "410142037", "story_v_out_410142.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play410142038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410142038
		arg_155_1.duration_ = 10.23

		local var_155_0 = {
			ja = 6.8,
			CriLanguages = 10.233,
			zh = 10.233
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
				arg_155_0:Play410142039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1061 = arg_155_1.actors_["1061"].transform.localPosition
				arg_155_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1061", 3)

				for iter_158_0 = 0, arg_155_1.actors_["1061"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["1061"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_5" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_158_2 = arg_155_1.actors_["1061"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1061 == nil then
				arg_155_1.var_.actorSpriteComps1061 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps1061 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1061 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1061 = nil
			end

			local var_158_5 = 0
			local var_158_6 = 1.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(410142038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_10 = 48 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 48)

				if (48 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 48)) > 0 and var_158_6 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142038", "story_v_out_410142.awb") ~= 0 then
					local var_158_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142038", "story_v_out_410142.awb") / 1000

					if var_158_11 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_5
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_410142", "410142038", "story_v_out_410142.awb")

						arg_155_1:RecordAudio("410142038", var_158_12)
						arg_155_1:RecordAudio("410142038", var_158_12)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410142", "410142038", "story_v_out_410142.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410142", "410142038", "story_v_out_410142.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_13 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_13 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_5) / var_158_13

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_5 + var_158_13 and arg_155_1.time_ < var_158_5 + var_158_13 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410142039
		arg_159_1.duration_ = 6.8

		local var_159_0 = {
			ja = 6.8,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_159_0:Play410142040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1061"]) and arg_159_1.var_.actorSpriteComps1061 == nil then
				arg_159_1.var_.actorSpriteComps1061 = arg_159_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1061"]) then
				if arg_159_1.var_.actorSpriteComps1061 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1061"]) and arg_159_1.var_.actorSpriteComps1061 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1061 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 0.6

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_4 = arg_159_1:GetWordFromCfg(410142039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 24 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 24)

				if (24 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 24)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142039", "story_v_out_410142.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142039", "story_v_out_410142.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_410142", "410142039", "story_v_out_410142.awb")

						arg_159_1:RecordAudio("410142039", var_162_9)
						arg_159_1:RecordAudio("410142039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410142", "410142039", "story_v_out_410142.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410142", "410142039", "story_v_out_410142.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play410142040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410142040
		arg_163_1.duration_ = 15.57

		local var_163_0 = {
			ja = 15.566,
			CriLanguages = 10.433,
			zh = 10.433
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
				arg_163_0:Play410142041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1061 = arg_163_1.actors_["1061"].transform.localPosition
				arg_163_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1061", 3)

				for iter_166_0 = 0, arg_163_1.actors_["1061"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1061"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_5" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_166_2 = arg_163_1.actors_["1061"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1061 == nil then
				arg_163_1.var_.actorSpriteComps1061 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps1061 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1061 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1061 = nil
			end

			local var_166_5 = 0
			local var_166_6 = 1.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(410142040)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 52 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 52)

				if (52 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 52)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142040", "story_v_out_410142.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142040", "story_v_out_410142.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_410142", "410142040", "story_v_out_410142.awb")

						arg_163_1:RecordAudio("410142040", var_166_12)
						arg_163_1:RecordAudio("410142040", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410142", "410142040", "story_v_out_410142.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410142", "410142040", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410142041
		arg_167_1.duration_ = 7.77

		local var_167_0 = {
			ja = 7.766,
			CriLanguages = 7.066,
			zh = 7.066
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
				arg_167_0:Play410142042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1061 = arg_167_1.actors_["1061"].transform.localPosition
				arg_167_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1061", 3)

				for iter_170_0 = 0, arg_167_1.actors_["1061"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["1061"].transform:GetChild(iter_170_0)

					if var_170_0.name == "" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_170_2 = arg_167_1.actors_["1061"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1061 == nil then
				arg_167_1.var_.actorSpriteComps1061 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps1061 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								iter_170_2.color = Color.New(Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_2.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_2.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1061 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_170_4 then
						iter_170_4.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1061 = nil
			end

			local var_170_5 = 0
			local var_170_6 = 0.6

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_7 = arg_167_1:GetWordFromCfg(410142041)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 24 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 24)

				if (24 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 24)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142041", "story_v_out_410142.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142041", "story_v_out_410142.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_410142", "410142041", "story_v_out_410142.awb")

						arg_167_1:RecordAudio("410142041", var_170_12)
						arg_167_1:RecordAudio("410142041", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410142", "410142041", "story_v_out_410142.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410142", "410142041", "story_v_out_410142.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play410142042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410142042
		arg_171_1.duration_ = 4.97

		local var_171_0 = {
			ja = 4.966,
			CriLanguages = 3.6,
			zh = 3.6
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
				arg_171_0:Play410142043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061 = arg_171_1.actors_["1061"].transform.localPosition
				arg_171_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1061", 3)

				for iter_174_0 = 0, arg_171_1.actors_["1061"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["1061"].transform:GetChild(iter_174_0)

					if var_174_0.name == "split_1" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_174_2 = arg_171_1.actors_["1061"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1061 == nil then
				arg_171_1.var_.actorSpriteComps1061 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.034

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps1061 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								iter_174_2.color = Color.New(Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_2.color.r, 1, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_2.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1061 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_174_4 then
						iter_174_4.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1061 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 0.375

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(410142042)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 15 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 15)

				if (15 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 15)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142042", "story_v_out_410142.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142042", "story_v_out_410142.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_410142", "410142042", "story_v_out_410142.awb")

						arg_171_1:RecordAudio("410142042", var_174_12)
						arg_171_1:RecordAudio("410142042", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410142", "410142042", "story_v_out_410142.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410142", "410142042", "story_v_out_410142.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410142043
		arg_175_1.duration_ = 4.63

		local var_175_0 = {
			ja = 4.633,
			CriLanguages = 3.733,
			zh = 3.733
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
				arg_175_0:Play410142044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1061"]) and arg_175_1.var_.actorSpriteComps1061 == nil then
				arg_175_1.var_.actorSpriteComps1061 = arg_175_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.034

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1061"]) then
				if arg_175_1.var_.actorSpriteComps1061 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1061"]) and arg_175_1.var_.actorSpriteComps1061 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1061 = nil
			end

			local var_178_2 = 0
			local var_178_3 = 0.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_4 = arg_175_1:GetWordFromCfg(410142043)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 18 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 18)

				if (18 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 18)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142043", "story_v_out_410142.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142043", "story_v_out_410142.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_out_410142", "410142043", "story_v_out_410142.awb")

						arg_175_1:RecordAudio("410142043", var_178_9)
						arg_175_1:RecordAudio("410142043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410142", "410142043", "story_v_out_410142.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410142", "410142043", "story_v_out_410142.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_3, arg_175_1.talkMaxDuration)

			if var_178_2 <= arg_175_1.time_ and arg_175_1.time_ < var_178_2 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_2) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_2 + var_178_10 and arg_175_1.time_ < var_178_2 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play410142044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410142044
		arg_179_1.duration_ = 12.17

		local var_179_0 = {
			ja = 12.166,
			CriLanguages = 9.2,
			zh = 9.2
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
				arg_179_0:Play410142045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.95

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:GetWordFromCfg(410142044)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 38 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 38)

				if (38 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 38)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142044", "story_v_out_410142.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_410142", "410142044", "story_v_out_410142.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_410142", "410142044", "story_v_out_410142.awb")

						arg_179_1:RecordAudio("410142044", var_182_6)
						arg_179_1:RecordAudio("410142044", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410142", "410142044", "story_v_out_410142.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410142", "410142044", "story_v_out_410142.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play410142045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410142045
		arg_183_1.duration_ = 8.1

		local var_183_0 = {
			ja = 8.1,
			CriLanguages = 7.833,
			zh = 7.833
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
				arg_183_0:Play410142046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.bgs_.ST65 == nil then
				local var_186_0 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST65")
				var_186_0.name = "ST65"
				var_186_0.transform.parent = arg_183_1.stage_.transform
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_.ST65 = var_186_0
			end

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				local var_186_1 = arg_183_1.bgs_.ST65

				arg_183_1.bgs_.ST65.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_2 = var_186_1:GetComponent("SpriteRenderer")

				if var_186_2 and var_186_2.sprite then
					local var_186_3 = 2 * (var_186_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_1.transform.localScale = Vector3.New(var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "ST65" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_4 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_5 = 2

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_5 then
				local var_186_6 = Color.New(0, 0, 0)

				var_186_6.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_4) / var_186_5)
				arg_183_1.mask_.color = var_186_6
			end

			if arg_183_1.time_ >= var_186_4 + var_186_5 and arg_183_1.time_ < var_186_4 + var_186_5 + arg_186_0 then
				local var_186_7 = Color.New(0, 0, 0)

				var_186_7.a = 1
				arg_183_1.mask_.color = var_186_7
			end

			local var_186_8 = 2

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_9 = 2

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_9 then
				local var_186_10 = Color.New(0, 0, 0)

				var_186_10.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_8) / var_186_9)
				arg_183_1.mask_.color = var_186_10
			end

			if arg_183_1.time_ >= var_186_8 + var_186_9 and arg_183_1.time_ < var_186_8 + var_186_9 + arg_186_0 then
				local var_186_11 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_11.a = 0
				arg_183_1.mask_.color = var_186_11
			end

			local var_186_12 = arg_183_1.actors_["1061"].transform

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.var_.moveOldPos1061 = var_186_12.localPosition
				var_186_12.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1061", 7)

				for iter_186_2 = 0, var_186_12.childCount - 1 do
					local var_186_13 = var_186_12:GetChild(iter_186_2)

					if var_186_13.name == "" or not string.find(var_186_13.name, "split") then
						var_186_13.gameObject:SetActive(true)
					else
						var_186_13.gameObject:SetActive(false)
					end
				end
			end

			local var_186_14 = 0.001

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_14 then
				var_186_12.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_183_1.time_ - 2) / var_186_14)
			end

			if arg_183_1.time_ >= 2 + var_186_14 and arg_183_1.time_ < 2 + var_186_14 + arg_186_0 then
				var_186_12.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_186_15 = arg_183_1.actors_["1056"].transform

			if 4.00000000000001 < arg_183_1.time_ and arg_183_1.time_ <= 4.00000000000001 + arg_186_0 then
				arg_183_1.var_.moveOldPos1056 = var_186_15.localPosition
				var_186_15.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1056", 3)

				for iter_186_3 = 0, var_186_15.childCount - 1 do
					local var_186_16 = var_186_15:GetChild(iter_186_3)

					if var_186_16.name == "" or not string.find(var_186_16.name, "split") then
						var_186_16.gameObject:SetActive(true)
					else
						var_186_16.gameObject:SetActive(false)
					end
				end
			end

			local var_186_17 = 0.001

			if 4.00000000000001 <= arg_183_1.time_ and arg_183_1.time_ < 4.00000000000001 + var_186_17 then
				var_186_15.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_183_1.time_ - 4.00000000000001) / var_186_17)
			end

			if arg_183_1.time_ >= 4.00000000000001 + var_186_17 and arg_183_1.time_ < 4.00000000000001 + var_186_17 + arg_186_0 then
				var_186_15.localPosition = Vector3.New(0, -350, -180)
			end

			local var_186_18 = arg_183_1.actors_["1061"]

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 and not isNil(var_186_18) and arg_183_1.var_.actorSpriteComps1061 == nil then
				arg_183_1.var_.actorSpriteComps1061 = var_186_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_19 = 0.0339999999999945

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_19 and not isNil(var_186_18) then
				if arg_183_1.var_.actorSpriteComps1061 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								iter_186_5.color = Color.New(Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 2) / var_186_19), Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 2) / var_186_19), (Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 2) / var_186_19)))
							else
								local var_186_20 = Mathf.Lerp(iter_186_5.color.r, 0.5, (arg_183_1.time_ - 2) / var_186_19)

								iter_186_5.color = Color.New(var_186_20, var_186_20, var_186_20)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 2 + var_186_19 and arg_183_1.time_ < 2 + var_186_19 + arg_186_0 and not isNil(var_186_18) and arg_183_1.var_.actorSpriteComps1061 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_186_7 then
						iter_186_7.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps1061 = nil
			end

			local var_186_21 = arg_183_1.actors_["1056"]

			if 4.00000000000001 < arg_183_1.time_ and arg_183_1.time_ <= 4.00000000000001 + arg_186_0 and not isNil(var_186_21) and arg_183_1.var_.actorSpriteComps1056 == nil then
				arg_183_1.var_.actorSpriteComps1056 = var_186_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_22 = 0.034

			if 4.00000000000001 <= arg_183_1.time_ and arg_183_1.time_ < 4.00000000000001 + var_186_22 and not isNil(var_186_21) then
				if arg_183_1.var_.actorSpriteComps1056 then
					for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_186_9 then
							if arg_183_1.isInRecall_ then
								iter_186_9.color = Color.New(Mathf.Lerp(iter_186_9.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 4.00000000000001) / var_186_22), Mathf.Lerp(iter_186_9.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 4.00000000000001) / var_186_22), (Mathf.Lerp(iter_186_9.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 4.00000000000001) / var_186_22)))
							else
								local var_186_23 = Mathf.Lerp(iter_186_9.color.r, 1, (arg_183_1.time_ - 4.00000000000001) / var_186_22)

								iter_186_9.color = Color.New(var_186_23, var_186_23, var_186_23)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 4.00000000000001 + var_186_22 and arg_183_1.time_ < 4.00000000000001 + var_186_22 + arg_186_0 and not isNil(var_186_21) and arg_183_1.var_.actorSpriteComps1056 then
				for iter_186_10, iter_186_11 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_186_11 then
						iter_186_11.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps1056 = nil
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_24 = 4
			local var_186_25 = 0.575

			if 4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_26 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_26:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_27 = arg_183_1:GetWordFromCfg(410142045)
				local var_186_28 = arg_183_1:FormatText(var_186_27.content)

				arg_183_1.text_.text = var_186_28

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_30 = 23 <= 0 and var_186_25 or var_186_25 * (utf8.len(var_186_28) / 23)

				if (23 <= 0 and var_186_25 or var_186_25 * (utf8.len(var_186_28) / 23)) > 0 and var_186_25 < var_186_30 then
					arg_183_1.talkMaxDuration = var_186_30
					var_186_24 = var_186_24 + 0.3

					if var_186_30 + var_186_24 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_30 + var_186_24
					end
				end

				arg_183_1.text_.text = var_186_28
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142045", "story_v_out_410142.awb") ~= 0 then
					local var_186_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142045", "story_v_out_410142.awb") / 1000

					if var_186_31 + var_186_24 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_31 + var_186_24
					end

					if var_186_27.prefab_name ~= "" and arg_183_1.actors_[var_186_27.prefab_name] ~= nil then
						local var_186_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_27.prefab_name].transform, "story_v_out_410142", "410142045", "story_v_out_410142.awb")

						arg_183_1:RecordAudio("410142045", var_186_32)
						arg_183_1:RecordAudio("410142045", var_186_32)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410142", "410142045", "story_v_out_410142.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410142", "410142045", "story_v_out_410142.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_33 = var_186_24 + 0.3
			local var_186_34 = math.max(var_186_25, arg_183_1.talkMaxDuration)

			if var_186_24 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_33 + var_186_34 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_33) / var_186_34

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_33 + var_186_34 and arg_183_1.time_ < var_186_33 + var_186_34 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.00000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play410142046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410142046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410142047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1056 = arg_189_1.actors_["1056"].transform.localPosition
				arg_189_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1056", 4)

				for iter_192_0 = 0, arg_189_1.actors_["1056"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1056"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_2 = arg_189_1.actors_["1061"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1061 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1061", 2)

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
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_192_5 = arg_189_1.actors_["1056"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps1056 == nil then
				arg_189_1.var_.actorSpriteComps1056 = var_192_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_6 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.actorSpriteComps1056 then
					for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_192_3 then
							if arg_189_1.isInRecall_ then
								iter_192_3.color = Color.New(Mathf.Lerp(iter_192_3.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_6), Mathf.Lerp(iter_192_3.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_6), (Mathf.Lerp(iter_192_3.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_6)))
							else
								local var_192_7 = Mathf.Lerp(iter_192_3.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_6)

								iter_192_3.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps1056 then
				for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_192_5 then
						iter_192_5.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps1056 = nil
			end

			local var_192_8 = arg_189_1.actors_["1061"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps1061 == nil then
				arg_189_1.var_.actorSpriteComps1061 = var_192_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 and not isNil(var_192_8) then
				if arg_189_1.var_.actorSpriteComps1061 then
					for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_192_7 then
							if arg_189_1.isInRecall_ then
								iter_192_7.color = Color.New(Mathf.Lerp(iter_192_7.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_9), Mathf.Lerp(iter_192_7.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_9), (Mathf.Lerp(iter_192_7.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_9)))
							else
								local var_192_10 = Mathf.Lerp(iter_192_7.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_9)

								iter_192_7.color = Color.New(var_192_10, var_192_10, var_192_10)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps1061 then
				for iter_192_8, iter_192_9 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_192_9 then
						iter_192_9.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps1061 = nil
			end

			local var_192_11 = 0
			local var_192_12 = 0.925

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(410142046).content)

				arg_189_1.text_.text = var_192_13

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 37 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_13) / 37)

				if (37 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_13) / 37)) > 0 and var_192_12 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_11
					end
				end

				arg_189_1.text_.text = var_192_13
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_12, arg_189_1.talkMaxDuration)

			if var_192_11 <= arg_189_1.time_ and arg_189_1.time_ < var_192_11 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_11) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_11 + var_192_16 and arg_189_1.time_ < var_192_11 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410142047
		arg_193_1.duration_ = 2.37

		local var_193_0 = {
			ja = 2.366,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_193_0:Play410142048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1056 = arg_193_1.actors_["1056"].transform.localPosition
				arg_193_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1056", 4)

				for iter_196_0 = 0, arg_193_1.actors_["1056"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["1056"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_3" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_196_2 = arg_193_1.actors_["1056"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1056 == nil then
				arg_193_1.var_.actorSpriteComps1056 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps1056 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1056 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1056 = nil
			end

			local var_196_5 = 0
			local var_196_6 = 0.15

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(410142047)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 6 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 6)

				if (6 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 6)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142047", "story_v_out_410142.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142047", "story_v_out_410142.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_410142", "410142047", "story_v_out_410142.awb")

						arg_193_1:RecordAudio("410142047", var_196_12)
						arg_193_1:RecordAudio("410142047", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410142", "410142047", "story_v_out_410142.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410142", "410142047", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410142048
		arg_197_1.duration_ = 4.1

		local var_197_0 = {
			ja = 4.1,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_197_0:Play410142049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1061 = arg_197_1.actors_["1061"].transform.localPosition
				arg_197_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1061", 2)

				for iter_200_0 = 0, arg_197_1.actors_["1061"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1061"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_5" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_200_2 = arg_197_1.actors_["1061"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1061 == nil then
				arg_197_1.var_.actorSpriteComps1061 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps1061 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1061 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps1061 = nil
			end

			local var_200_5 = arg_197_1.actors_["1056"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps1056 == nil then
				arg_197_1.var_.actorSpriteComps1056 = var_200_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_6 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.actorSpriteComps1056 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								iter_200_6.color = Color.New(Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_6), Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_6), (Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_6)))
							else
								local var_200_7 = Mathf.Lerp(iter_200_6.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_6)

								iter_200_6.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps1056 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_200_8 then
						iter_200_8.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps1056 = nil
			end

			local var_200_8 = 0
			local var_200_9 = 0.075

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(410142048)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 3 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 3)

				if (3 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 3)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142048", "story_v_out_410142.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142048", "story_v_out_410142.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_410142", "410142048", "story_v_out_410142.awb")

						arg_197_1:RecordAudio("410142048", var_200_15)
						arg_197_1:RecordAudio("410142048", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410142", "410142048", "story_v_out_410142.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410142", "410142048", "story_v_out_410142.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play410142049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410142049
		arg_201_1.duration_ = 5.67

		local var_201_0 = {
			ja = 5.666,
			CriLanguages = 2,
			zh = 2
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
				arg_201_0:Play410142050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1056 = arg_201_1.actors_["1056"].transform.localPosition
				arg_201_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1056", 4)

				for iter_204_0 = 0, arg_201_1.actors_["1056"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["1056"].transform:GetChild(iter_204_0)

					if var_204_0.name == "split_4" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_204_2 = arg_201_1.actors_["1056"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1056 == nil then
				arg_201_1.var_.actorSpriteComps1056 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps1056 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								iter_204_2.color = Color.New(Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_2.color.r, 1, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_2.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1056 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps1056 = nil
			end

			local var_204_5 = arg_201_1.actors_["1061"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps1061 == nil then
				arg_201_1.var_.actorSpriteComps1061 = var_204_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_6 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.actorSpriteComps1061 then
					for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_204_6 then
							if arg_201_1.isInRecall_ then
								iter_204_6.color = Color.New(Mathf.Lerp(iter_204_6.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_6), Mathf.Lerp(iter_204_6.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_6), (Mathf.Lerp(iter_204_6.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_6)))
							else
								local var_204_7 = Mathf.Lerp(iter_204_6.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_6)

								iter_204_6.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps1061 then
				for iter_204_7, iter_204_8 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_204_8 then
						iter_204_8.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1061 = nil
			end

			local var_204_8 = 0
			local var_204_9 = 0.15

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(410142049)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 6 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 6)

				if (6 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 6)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142049", "story_v_out_410142.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142049", "story_v_out_410142.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_410142", "410142049", "story_v_out_410142.awb")

						arg_201_1:RecordAudio("410142049", var_204_15)
						arg_201_1:RecordAudio("410142049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410142", "410142049", "story_v_out_410142.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410142", "410142049", "story_v_out_410142.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_16 and arg_201_1.time_ < var_204_8 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play410142050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410142050
		arg_205_1.duration_ = 7.07

		local var_205_0 = {
			ja = 7.066,
			CriLanguages = 3.966,
			zh = 3.966
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
				arg_205_0:Play410142051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = arg_205_1.actors_["1061"].transform.localPosition
				arg_205_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 2)

				for iter_208_0 = 0, arg_205_1.actors_["1061"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["1061"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_7" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_208_2 = arg_205_1.actors_["1061"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1061 == nil then
				arg_205_1.var_.actorSpriteComps1061 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps1061 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			local var_208_5 = arg_205_1.actors_["1056"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1056 == nil then
				arg_205_1.var_.actorSpriteComps1056 = var_208_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_6 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 and not isNil(var_208_5) then
				if arg_205_1.var_.actorSpriteComps1056 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								iter_208_6.color = Color.New(Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_6), Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_6), (Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_6)))
							else
								local var_208_7 = Mathf.Lerp(iter_208_6.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_6)

								iter_208_6.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1056 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_208_8 then
						iter_208_8.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1056 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.5

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(410142050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 20 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 20)

				if (20 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 20)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142050", "story_v_out_410142.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142050", "story_v_out_410142.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_410142", "410142050", "story_v_out_410142.awb")

						arg_205_1:RecordAudio("410142050", var_208_15)
						arg_205_1:RecordAudio("410142050", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410142", "410142050", "story_v_out_410142.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410142", "410142050", "story_v_out_410142.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410142051
		arg_209_1.duration_ = 11.03

		local var_209_0 = {
			ja = 7.766,
			CriLanguages = 11.033,
			zh = 11.033
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
				arg_209_0:Play410142052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1061 = arg_209_1.actors_["1061"].transform.localPosition
				arg_209_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1061", 2)

				for iter_212_0 = 0, arg_209_1.actors_["1061"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["1061"].transform:GetChild(iter_212_0)

					if var_212_0.name == "split_7" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_212_2 = arg_209_1.actors_["1061"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1061 == nil then
				arg_209_1.var_.actorSpriteComps1061 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps1061 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								iter_212_2.color = Color.New(Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_2.color.r, 1, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_2.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1061 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_212_4 then
						iter_212_4.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1061 = nil
			end

			local var_212_5 = 0
			local var_212_6 = 1.175

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(410142051)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 47 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 47)

				if (47 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 47)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142051", "story_v_out_410142.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142051", "story_v_out_410142.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_410142", "410142051", "story_v_out_410142.awb")

						arg_209_1:RecordAudio("410142051", var_212_12)
						arg_209_1:RecordAudio("410142051", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410142", "410142051", "story_v_out_410142.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410142", "410142051", "story_v_out_410142.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_13 and arg_209_1.time_ < var_212_5 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410142052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410142053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1061"]) and arg_213_1.var_.actorSpriteComps1061 == nil then
				arg_213_1.var_.actorSpriteComps1061 = arg_213_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.034

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1061"]) then
				if arg_213_1.var_.actorSpriteComps1061 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1061"]) and arg_213_1.var_.actorSpriteComps1061 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1061 = nil
			end

			local var_216_2 = arg_213_1.actors_["1056"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1056 == nil then
				arg_213_1.var_.actorSpriteComps1056 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.034

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps1056 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								iter_216_5.color = Color.New(Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_5.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_5.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1056 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_216_7 then
						iter_216_7.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1056 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 0.925

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(410142052).content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 37 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 37)

				if (37 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 37)) > 0 and var_216_6 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_10 and arg_213_1.time_ < var_216_5 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play410142053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410142053
		arg_217_1.duration_ = 6.1

		local var_217_0 = {
			ja = 6.1,
			CriLanguages = 2.866,
			zh = 2.866
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410142054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1061 = arg_217_1.actors_["1061"].transform.localPosition
				arg_217_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1061", 2)

				for iter_220_0 = 0, arg_217_1.actors_["1061"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["1061"].transform:GetChild(iter_220_0)

					if var_220_0.name == "split_1" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_220_2 = arg_217_1.actors_["1061"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps1061 == nil then
				arg_217_1.var_.actorSpriteComps1061 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.034

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps1061 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								iter_220_2.color = Color.New(Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_2.color.r, 1, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_2.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps1061 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_220_4 then
						iter_220_4.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps1061 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 0.225

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(410142053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 9 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 9)

				if (9 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 9)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142053", "story_v_out_410142.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142053", "story_v_out_410142.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_410142", "410142053", "story_v_out_410142.awb")

						arg_217_1:RecordAudio("410142053", var_220_12)
						arg_217_1:RecordAudio("410142053", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410142", "410142053", "story_v_out_410142.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410142", "410142053", "story_v_out_410142.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_13 and arg_217_1.time_ < var_220_5 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play410142054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410142054
		arg_221_1.duration_ = 7.1

		local var_221_0 = {
			ja = 7.1,
			CriLanguages = 6.266,
			zh = 6.266
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play410142055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = arg_221_1.actors_["1056"].transform.localPosition
				arg_221_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 4)

				for iter_224_0 = 0, arg_221_1.actors_["1056"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["1056"].transform:GetChild(iter_224_0)

					if var_224_0.name == "" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_224_2 = arg_221_1.actors_["1056"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1056 == nil then
				arg_221_1.var_.actorSpriteComps1056 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps1056 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 1, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1056 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1056 = nil
			end

			local var_224_5 = arg_221_1.actors_["1061"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps1061 == nil then
				arg_221_1.var_.actorSpriteComps1061 = var_224_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_6 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.actorSpriteComps1061 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								iter_224_6.color = Color.New(Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_6), Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_6), (Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_6)))
							else
								local var_224_7 = Mathf.Lerp(iter_224_6.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_6)

								iter_224_6.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps1061 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_224_8 then
						iter_224_8.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1061 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.9

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(410142054)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 36 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 36)

				if (36 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 36)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142054", "story_v_out_410142.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142054", "story_v_out_410142.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_410142", "410142054", "story_v_out_410142.awb")

						arg_221_1:RecordAudio("410142054", var_224_15)
						arg_221_1:RecordAudio("410142054", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410142", "410142054", "story_v_out_410142.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410142", "410142054", "story_v_out_410142.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play410142055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410142055
		arg_225_1.duration_ = 13.4

		local var_225_0 = {
			ja = 13.4,
			CriLanguages = 8.7,
			zh = 8.7
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play410142056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1056 = arg_225_1.actors_["1056"].transform.localPosition
				arg_225_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1056", 4)

				for iter_228_0 = 0, arg_225_1.actors_["1056"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["1056"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_228_2 = arg_225_1.actors_["1056"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps1056 == nil then
				arg_225_1.var_.actorSpriteComps1056 = var_228_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_3 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.actorSpriteComps1056 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								iter_228_2.color = Color.New(Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_3), Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_3), (Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_3)))
							else
								local var_228_4 = Mathf.Lerp(iter_228_2.color.r, 1, (arg_225_1.time_ - 0) / var_228_3)

								iter_228_2.color = Color.New(var_228_4, var_228_4, var_228_4)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps1056 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_228_4 then
						iter_228_4.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps1056 = nil
			end

			local var_228_5 = 0
			local var_228_6 = 1.15

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:GetWordFromCfg(410142055)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 46 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 46)

				if (46 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 46)) > 0 and var_228_6 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142055", "story_v_out_410142.awb") ~= 0 then
					local var_228_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142055", "story_v_out_410142.awb") / 1000

					if var_228_11 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_5
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_out_410142", "410142055", "story_v_out_410142.awb")

						arg_225_1:RecordAudio("410142055", var_228_12)
						arg_225_1:RecordAudio("410142055", var_228_12)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410142", "410142055", "story_v_out_410142.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410142", "410142055", "story_v_out_410142.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_13 and arg_225_1.time_ < var_228_5 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play410142056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410142056
		arg_229_1.duration_ = 9.07

		local var_229_0 = {
			ja = 9.066,
			CriLanguages = 4.866,
			zh = 4.866
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play410142057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1061 = arg_229_1.actors_["1061"].transform.localPosition
				arg_229_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1061", 2)

				for iter_232_0 = 0, arg_229_1.actors_["1061"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["1061"].transform:GetChild(iter_232_0)

					if var_232_0.name == "split_5" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_232_2 = arg_229_1.actors_["1061"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1061 == nil then
				arg_229_1.var_.actorSpriteComps1061 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps1061 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								iter_232_2.color = Color.New(Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_3), Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_3), (Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_3)))
							else
								local var_232_4 = Mathf.Lerp(iter_232_2.color.r, 1, (arg_229_1.time_ - 0) / var_232_3)

								iter_232_2.color = Color.New(var_232_4, var_232_4, var_232_4)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1061 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_232_4 then
						iter_232_4.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1061 = nil
			end

			local var_232_5 = arg_229_1.actors_["1056"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.actorSpriteComps1056 == nil then
				arg_229_1.var_.actorSpriteComps1056 = var_232_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_6 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_6 and not isNil(var_232_5) then
				if arg_229_1.var_.actorSpriteComps1056 then
					for iter_232_5, iter_232_6 in pairs(arg_229_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_232_6 then
							if arg_229_1.isInRecall_ then
								iter_232_6.color = Color.New(Mathf.Lerp(iter_232_6.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_6), Mathf.Lerp(iter_232_6.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_6), (Mathf.Lerp(iter_232_6.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_6)))
							else
								local var_232_7 = Mathf.Lerp(iter_232_6.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_6)

								iter_232_6.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_6 and arg_229_1.time_ < 0 + var_232_6 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.actorSpriteComps1056 then
				for iter_232_7, iter_232_8 in pairs(arg_229_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_232_8 then
						iter_232_8.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps1056 = nil
			end

			local var_232_8 = 0
			local var_232_9 = 0.4

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(410142056)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 16 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 16)

				if (16 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 16)) > 0 and var_232_9 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142056", "story_v_out_410142.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142056", "story_v_out_410142.awb") / 1000

					if var_232_14 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_8
					end

					if var_232_10.prefab_name ~= "" and arg_229_1.actors_[var_232_10.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_10.prefab_name].transform, "story_v_out_410142", "410142056", "story_v_out_410142.awb")

						arg_229_1:RecordAudio("410142056", var_232_15)
						arg_229_1:RecordAudio("410142056", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410142", "410142056", "story_v_out_410142.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410142", "410142056", "story_v_out_410142.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_16 and arg_229_1.time_ < var_232_8 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play410142057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410142057
		arg_233_1.duration_ = 8.47

		local var_233_0 = {
			ja = 8.466,
			CriLanguages = 6.666,
			zh = 6.666
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
				arg_233_0:Play410142058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1056 = arg_233_1.actors_["1056"].transform.localPosition
				arg_233_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1056", 4)

				for iter_236_0 = 0, arg_233_1.actors_["1056"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["1056"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_236_2 = arg_233_1.actors_["1056"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1056 == nil then
				arg_233_1.var_.actorSpriteComps1056 = var_236_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_3 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.actorSpriteComps1056 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								iter_236_2.color = Color.New(Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_3), Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_3), (Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_3)))
							else
								local var_236_4 = Mathf.Lerp(iter_236_2.color.r, 1, (arg_233_1.time_ - 0) / var_236_3)

								iter_236_2.color = Color.New(var_236_4, var_236_4, var_236_4)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1056 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps1056 = nil
			end

			local var_236_5 = arg_233_1.actors_["1061"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps1061 == nil then
				arg_233_1.var_.actorSpriteComps1061 = var_236_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_6 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.actorSpriteComps1061 then
					for iter_236_5, iter_236_6 in pairs(arg_233_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_236_6 then
							if arg_233_1.isInRecall_ then
								iter_236_6.color = Color.New(Mathf.Lerp(iter_236_6.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_6), Mathf.Lerp(iter_236_6.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_6), (Mathf.Lerp(iter_236_6.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_6)))
							else
								local var_236_7 = Mathf.Lerp(iter_236_6.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_6)

								iter_236_6.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps1061 then
				for iter_236_7, iter_236_8 in pairs(arg_233_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_236_8 then
						iter_236_8.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps1061 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 0.9

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(410142057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 36 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 36)

				if (36 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 36)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142057", "story_v_out_410142.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142057", "story_v_out_410142.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_410142", "410142057", "story_v_out_410142.awb")

						arg_233_1:RecordAudio("410142057", var_236_15)
						arg_233_1:RecordAudio("410142057", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410142", "410142057", "story_v_out_410142.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410142", "410142057", "story_v_out_410142.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play410142058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410142058
		arg_237_1.duration_ = 9.83

		local var_237_0 = {
			ja = 9.833,
			CriLanguages = 8.9,
			zh = 8.9
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
				arg_237_0:Play410142059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1061 = arg_237_1.actors_["1061"].transform.localPosition
				arg_237_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1061", 2)

				for iter_240_0 = 0, arg_237_1.actors_["1061"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["1061"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_240_2 = arg_237_1.actors_["1061"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1061 == nil then
				arg_237_1.var_.actorSpriteComps1061 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps1061 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								iter_240_2.color = Color.New(Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_2.color.r, 1, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_2.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1061 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps1061 = nil
			end

			local var_240_5 = arg_237_1.actors_["1056"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps1056 == nil then
				arg_237_1.var_.actorSpriteComps1056 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps1056 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								iter_240_6.color = Color.New(Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_6), Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_6), (Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_6)))
							else
								local var_240_7 = Mathf.Lerp(iter_240_6.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_6)

								iter_240_6.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps1056 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_240_8 then
						iter_240_8.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps1056 = nil
			end

			local var_240_8 = 0
			local var_240_9 = 0.9

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(410142058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 36 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 36)

				if (36 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 36)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142058", "story_v_out_410142.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142058", "story_v_out_410142.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_410142", "410142058", "story_v_out_410142.awb")

						arg_237_1:RecordAudio("410142058", var_240_15)
						arg_237_1:RecordAudio("410142058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410142", "410142058", "story_v_out_410142.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410142", "410142058", "story_v_out_410142.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play410142059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410142059
		arg_241_1.duration_ = 9.5

		local var_241_0 = {
			ja = 9.5,
			CriLanguages = 9.033,
			zh = 9.033
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
				arg_241_0:Play410142060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1056 = arg_241_1.actors_["1056"].transform.localPosition
				arg_241_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1056", 4)

				for iter_244_0 = 0, arg_241_1.actors_["1056"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["1056"].transform:GetChild(iter_244_0)

					if var_244_0.name == "" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_244_2 = arg_241_1.actors_["1056"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1056 == nil then
				arg_241_1.var_.actorSpriteComps1056 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps1056 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								iter_244_2.color = Color.New(Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_3), Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_3), (Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_3)))
							else
								local var_244_4 = Mathf.Lerp(iter_244_2.color.r, 1, (arg_241_1.time_ - 0) / var_244_3)

								iter_244_2.color = Color.New(var_244_4, var_244_4, var_244_4)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1056 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_244_4 then
						iter_244_4.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1056 = nil
			end

			local var_244_5 = arg_241_1.actors_["1061"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.actorSpriteComps1061 == nil then
				arg_241_1.var_.actorSpriteComps1061 = var_244_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_6 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 and not isNil(var_244_5) then
				if arg_241_1.var_.actorSpriteComps1061 then
					for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_244_6 then
							if arg_241_1.isInRecall_ then
								iter_244_6.color = Color.New(Mathf.Lerp(iter_244_6.color.r, arg_241_1.hightColor2.r, (arg_241_1.time_ - 0) / var_244_6), Mathf.Lerp(iter_244_6.color.g, arg_241_1.hightColor2.g, (arg_241_1.time_ - 0) / var_244_6), (Mathf.Lerp(iter_244_6.color.b, arg_241_1.hightColor2.b, (arg_241_1.time_ - 0) / var_244_6)))
							else
								local var_244_7 = Mathf.Lerp(iter_244_6.color.r, 0.5, (arg_241_1.time_ - 0) / var_244_6)

								iter_244_6.color = Color.New(var_244_7, var_244_7, var_244_7)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.actorSpriteComps1061 then
				for iter_244_7, iter_244_8 in pairs(arg_241_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_244_8 then
						iter_244_8.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps1061 = nil
			end

			local var_244_8 = 0
			local var_244_9 = 0.9

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_10 = arg_241_1:GetWordFromCfg(410142059)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 36 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 36)

				if (36 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 36)) > 0 and var_244_9 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142059", "story_v_out_410142.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142059", "story_v_out_410142.awb") / 1000

					if var_244_14 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_8
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_out_410142", "410142059", "story_v_out_410142.awb")

						arg_241_1:RecordAudio("410142059", var_244_15)
						arg_241_1:RecordAudio("410142059", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410142", "410142059", "story_v_out_410142.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410142", "410142059", "story_v_out_410142.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_16 and arg_241_1.time_ < var_244_8 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play410142060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410142060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410142061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1061"]) and arg_245_1.var_.actorSpriteComps1061 == nil then
				arg_245_1.var_.actorSpriteComps1061 = arg_245_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 0.034

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1061"]) then
				if arg_245_1.var_.actorSpriteComps1061 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								iter_248_1.color = Color.New(Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_0), Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_0), (Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_0)))
							else
								local var_248_1 = Mathf.Lerp(iter_248_1.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_0)

								iter_248_1.color = Color.New(var_248_1, var_248_1, var_248_1)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1061"]) and arg_245_1.var_.actorSpriteComps1061 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps1061 = nil
			end

			local var_248_2 = arg_245_1.actors_["1056"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1056 == nil then
				arg_245_1.var_.actorSpriteComps1056 = var_248_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_3 = 0.034

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.actorSpriteComps1056 then
					for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_248_5 then
							if arg_245_1.isInRecall_ then
								iter_248_5.color = Color.New(Mathf.Lerp(iter_248_5.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_3), Mathf.Lerp(iter_248_5.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_3), (Mathf.Lerp(iter_248_5.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_3)))
							else
								local var_248_4 = Mathf.Lerp(iter_248_5.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_3)

								iter_248_5.color = Color.New(var_248_4, var_248_4, var_248_4)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1056 then
				for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_248_7 then
						iter_248_7.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps1056 = nil
			end

			local var_248_5 = 0
			local var_248_6 = 1.225

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_7 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(410142060).content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 49 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_7) / 49)

				if (49 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_7) / 49)) > 0 and var_248_6 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_6, arg_245_1.talkMaxDuration)

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_5) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_5 + var_248_10 and arg_245_1.time_ < var_248_5 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410142061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410142061
		arg_249_1.duration_ = 4.3

		local var_249_0 = {
			ja = 4.3,
			CriLanguages = 1.633,
			zh = 1.633
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
				arg_249_0:Play410142062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1056 = arg_249_1.actors_["1056"].transform.localPosition
				arg_249_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1056", 3)

				for iter_252_0 = 0, arg_249_1.actors_["1056"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["1056"].transform:GetChild(iter_252_0)

					if var_252_0.name == "" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_252_2 = arg_249_1.actors_["1061"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1061 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1061", 7)

				for iter_252_1 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_1)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_252_5 = arg_249_1.actors_["1056"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1056 == nil then
				arg_249_1.var_.actorSpriteComps1056 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps1056 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								iter_252_3.color = Color.New(Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_3.color.r, 1, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_3.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1056 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_252_5 then
						iter_252_5.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1056 = nil
			end

			local var_252_8 = arg_249_1.actors_["1061"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_9 and not isNil(var_252_8) then
				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								iter_252_7.color = Color.New(Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_9), Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_9), (Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_9)))
							else
								local var_252_10 = Mathf.Lerp(iter_252_7.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_9)

								iter_252_7.color = Color.New(var_252_10, var_252_10, var_252_10)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_9 and arg_249_1.time_ < 0 + var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_9 then
						iter_252_9.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_11 = 0
			local var_252_12 = 0.175

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_13 = arg_249_1:GetWordFromCfg(410142061)
				local var_252_14 = arg_249_1:FormatText(var_252_13.content)

				arg_249_1.text_.text = var_252_14

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_16 = 7 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 7)

				if (7 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 7)) > 0 and var_252_12 < var_252_16 then
					arg_249_1.talkMaxDuration = var_252_16

					if var_252_16 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_16 + var_252_11
					end
				end

				arg_249_1.text_.text = var_252_14
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142061", "story_v_out_410142.awb") ~= 0 then
					local var_252_17 = manager.audio:GetVoiceLength("story_v_out_410142", "410142061", "story_v_out_410142.awb") / 1000

					if var_252_17 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_17 + var_252_11
					end

					if var_252_13.prefab_name ~= "" and arg_249_1.actors_[var_252_13.prefab_name] ~= nil then
						local var_252_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_13.prefab_name].transform, "story_v_out_410142", "410142061", "story_v_out_410142.awb")

						arg_249_1:RecordAudio("410142061", var_252_18)
						arg_249_1:RecordAudio("410142061", var_252_18)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410142", "410142061", "story_v_out_410142.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410142", "410142061", "story_v_out_410142.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_19 = math.max(var_252_12, arg_249_1.talkMaxDuration)

			if var_252_11 <= arg_249_1.time_ and arg_249_1.time_ < var_252_11 + var_252_19 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_11) / var_252_19

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_11 + var_252_19 and arg_249_1.time_ < var_252_11 + var_252_19 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play410142062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410142062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410142063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1056 = arg_253_1.actors_["1056"].transform.localPosition
				arg_253_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1056", 2)

				for iter_256_0 = 0, arg_253_1.actors_["1056"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1056"].transform:GetChild(iter_256_0)

					if var_256_0.name == "" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_256_2 = "10061"

			if arg_253_1.actors_["10061"] == nil then
				local var_256_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10061")

				if not isNil(var_256_3) then
					local var_256_4 = Object.Instantiate(var_256_3, arg_253_1.canvasGo_.transform)

					var_256_4.transform:SetSiblingIndex(1)

					var_256_4.name = var_256_2
					var_256_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_253_1.actors_[var_256_2] = var_256_4

					if arg_253_1.isInRecall_ then
						for iter_256_1, iter_256_2 in ipairs((var_256_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_256_2.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_256_5 = arg_253_1.actors_["10061"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10061 = var_256_5.localPosition
				var_256_5.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10061", 4)

				for iter_256_3 = 0, var_256_5.childCount - 1 do
					local var_256_6 = var_256_5:GetChild(iter_256_3)

					if var_256_6.name == "" or not string.find(var_256_6.name, "split") then
						var_256_6.gameObject:SetActive(true)
					else
						var_256_6.gameObject:SetActive(false)
					end
				end
			end

			local var_256_7 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				var_256_5.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_253_1.time_ - 0) / var_256_7)
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				var_256_5.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_256_8 = arg_253_1.actors_["1056"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps1056 == nil then
				arg_253_1.var_.actorSpriteComps1056 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_9 and not isNil(var_256_8) then
				if arg_253_1.var_.actorSpriteComps1056 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_9), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_9), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_9)))
							else
								local var_256_10 = Mathf.Lerp(iter_256_5.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_9)

								iter_256_5.color = Color.New(var_256_10, var_256_10, var_256_10)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_9 and arg_253_1.time_ < 0 + var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps1056 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1056 = nil
			end

			local var_256_11 = arg_253_1.actors_["10061"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_11) and arg_253_1.var_.actorSpriteComps10061 == nil then
				arg_253_1.var_.actorSpriteComps10061 = var_256_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_12 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_12 and not isNil(var_256_11) then
				if arg_253_1.var_.actorSpriteComps10061 then
					for iter_256_8, iter_256_9 in pairs(arg_253_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_256_9 then
							if arg_253_1.isInRecall_ then
								iter_256_9.color = Color.New(Mathf.Lerp(iter_256_9.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_12), Mathf.Lerp(iter_256_9.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_12), (Mathf.Lerp(iter_256_9.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_12)))
							else
								local var_256_13 = Mathf.Lerp(iter_256_9.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_12)

								iter_256_9.color = Color.New(var_256_13, var_256_13, var_256_13)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_12 and arg_253_1.time_ < 0 + var_256_12 + arg_256_0 and not isNil(var_256_11) and arg_253_1.var_.actorSpriteComps10061 then
				for iter_256_10, iter_256_11 in pairs(arg_253_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_256_11 then
						iter_256_11.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps10061 = nil
			end

			local var_256_14 = 0
			local var_256_15 = 0.8

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_16 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(410142062).content)

				arg_253_1.text_.text = var_256_16

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_18 = 32 <= 0 and var_256_15 or var_256_15 * (utf8.len(var_256_16) / 32)

				if (32 <= 0 and var_256_15 or var_256_15 * (utf8.len(var_256_16) / 32)) > 0 and var_256_15 < var_256_18 then
					arg_253_1.talkMaxDuration = var_256_18

					if var_256_18 + var_256_14 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_18 + var_256_14
					end
				end

				arg_253_1.text_.text = var_256_16
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_19 = math.max(var_256_15, arg_253_1.talkMaxDuration)

			if var_256_14 <= arg_253_1.time_ and arg_253_1.time_ < var_256_14 + var_256_19 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_14) / var_256_19

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_14 + var_256_19 and arg_253_1.time_ < var_256_14 + var_256_19 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10061",
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
	Play410142063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410142063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410142064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.775

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(410142063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 31 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 31)

				if (31 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 31)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play410142064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410142064
		arg_261_1.duration_ = 6.93

		local var_261_0 = {
			ja = 6.933,
			CriLanguages = 3.1,
			zh = 3.1
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
				arg_261_0:Play410142065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10061 = arg_261_1.actors_["10061"].transform.localPosition
				arg_261_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10061", 4)

				for iter_264_0 = 0, arg_261_1.actors_["10061"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10061"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_5" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_264_2 = arg_261_1.actors_["10061"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10061 == nil then
				arg_261_1.var_.actorSpriteComps10061 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10061 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10061 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10061 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.25

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(410142064)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 10 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 10)

				if (10 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 10)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142064", "story_v_out_410142.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142064", "story_v_out_410142.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_410142", "410142064", "story_v_out_410142.awb")

						arg_261_1:RecordAudio("410142064", var_264_12)
						arg_261_1:RecordAudio("410142064", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410142", "410142064", "story_v_out_410142.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410142", "410142064", "story_v_out_410142.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_13 and arg_261_1.time_ < var_264_5 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play410142065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410142065
		arg_265_1.duration_ = 7.93

		local var_265_0 = {
			ja = 7.8,
			CriLanguages = 7.933,
			zh = 7.933
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
				arg_265_0:Play410142066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1056 = arg_265_1.actors_["1056"].transform.localPosition
				arg_265_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1056", 2)

				for iter_268_0 = 0, arg_265_1.actors_["1056"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["1056"].transform:GetChild(iter_268_0)

					if var_268_0.name == "split_1" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_268_2 = arg_265_1.actors_["1056"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1056 == nil then
				arg_265_1.var_.actorSpriteComps1056 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps1056 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								iter_268_2.color = Color.New(Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_2.color.r, 1, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_2.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1056 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1056 = nil
			end

			local var_268_5 = arg_265_1.actors_["10061"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps10061 == nil then
				arg_265_1.var_.actorSpriteComps10061 = var_268_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_6 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.actorSpriteComps10061 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								iter_268_6.color = Color.New(Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_6), Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_6), (Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_6)))
							else
								local var_268_7 = Mathf.Lerp(iter_268_6.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_6)

								iter_268_6.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps10061 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_268_8 then
						iter_268_8.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10061 = nil
			end

			local var_268_8 = 0
			local var_268_9 = 1.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(410142065)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 42 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 42)

				if (42 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 42)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142065", "story_v_out_410142.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142065", "story_v_out_410142.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_410142", "410142065", "story_v_out_410142.awb")

						arg_265_1:RecordAudio("410142065", var_268_15)
						arg_265_1:RecordAudio("410142065", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410142", "410142065", "story_v_out_410142.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410142", "410142065", "story_v_out_410142.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play410142066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410142066
		arg_269_1.duration_ = 9.97

		local var_269_0 = {
			ja = 9.966,
			CriLanguages = 6.3,
			zh = 6.3
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
				arg_269_0:Play410142067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10061 = arg_269_1.actors_["10061"].transform.localPosition
				arg_269_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10061", 4)

				for iter_272_0 = 0, arg_269_1.actors_["10061"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["10061"].transform:GetChild(iter_272_0)

					if var_272_0.name == "" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_272_2 = arg_269_1.actors_["1061"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1061 = var_272_2.localPosition
				var_272_2.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1061", 2)

				for iter_272_1 = 0, var_272_2.childCount - 1 do
					local var_272_3 = var_272_2:GetChild(iter_272_1)

					if var_272_3.name == "" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_2.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_269_1.time_ - 0) / var_272_4)
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_2.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_272_5 = arg_269_1.actors_["1056"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1056 = var_272_5.localPosition
				var_272_5.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1056", 7)

				for iter_272_2 = 0, var_272_5.childCount - 1 do
					local var_272_6 = var_272_5:GetChild(iter_272_2)

					if var_272_6.name == "" or not string.find(var_272_6.name, "split") then
						var_272_6.gameObject:SetActive(true)
					else
						var_272_6.gameObject:SetActive(false)
					end
				end
			end

			local var_272_7 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				var_272_5.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_269_1.time_ - 0) / var_272_7)
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				var_272_5.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_272_8 = arg_269_1.actors_["10061"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10061 == nil then
				arg_269_1.var_.actorSpriteComps10061 = var_272_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_9 and not isNil(var_272_8) then
				if arg_269_1.var_.actorSpriteComps10061 then
					for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_272_4 then
							if arg_269_1.isInRecall_ then
								iter_272_4.color = Color.New(Mathf.Lerp(iter_272_4.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_9), Mathf.Lerp(iter_272_4.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_9), (Mathf.Lerp(iter_272_4.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_9)))
							else
								local var_272_10 = Mathf.Lerp(iter_272_4.color.r, 1, (arg_269_1.time_ - 0) / var_272_9)

								iter_272_4.color = Color.New(var_272_10, var_272_10, var_272_10)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_9 and arg_269_1.time_ < 0 + var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10061 then
				for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_272_6 then
						iter_272_6.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10061 = nil
			end

			local var_272_11 = arg_269_1.actors_["1061"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_12 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_12 and not isNil(var_272_11) then
				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_8 then
							if arg_269_1.isInRecall_ then
								iter_272_8.color = Color.New(Mathf.Lerp(iter_272_8.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_12), Mathf.Lerp(iter_272_8.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_12), (Mathf.Lerp(iter_272_8.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_12)))
							else
								local var_272_13 = Mathf.Lerp(iter_272_8.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_12)

								iter_272_8.color = Color.New(var_272_13, var_272_13, var_272_13)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_12 and arg_269_1.time_ < 0 + var_272_12 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_9, iter_272_10 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_10 then
						iter_272_10.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_14 = arg_269_1.actors_["1056"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.actorSpriteComps1056 == nil then
				arg_269_1.var_.actorSpriteComps1056 = var_272_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_15 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_15 and not isNil(var_272_14) then
				if arg_269_1.var_.actorSpriteComps1056 then
					for iter_272_11, iter_272_12 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_272_12 then
							if arg_269_1.isInRecall_ then
								iter_272_12.color = Color.New(Mathf.Lerp(iter_272_12.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_15), Mathf.Lerp(iter_272_12.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_15), (Mathf.Lerp(iter_272_12.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_15)))
							else
								local var_272_16 = Mathf.Lerp(iter_272_12.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_15)

								iter_272_12.color = Color.New(var_272_16, var_272_16, var_272_16)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_15 and arg_269_1.time_ < 0 + var_272_15 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.actorSpriteComps1056 then
				for iter_272_13, iter_272_14 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_272_14 then
						iter_272_14.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1056 = nil
			end

			local var_272_17 = 0
			local var_272_18 = 0.525

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_17 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_19 = arg_269_1:GetWordFromCfg(410142066)
				local var_272_20 = arg_269_1:FormatText(var_272_19.content)

				arg_269_1.text_.text = var_272_20

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_22 = 21 <= 0 and var_272_18 or var_272_18 * (utf8.len(var_272_20) / 21)

				if (21 <= 0 and var_272_18 or var_272_18 * (utf8.len(var_272_20) / 21)) > 0 and var_272_18 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_17 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_17
					end
				end

				arg_269_1.text_.text = var_272_20
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142066", "story_v_out_410142.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142066", "story_v_out_410142.awb") / 1000

					if var_272_23 + var_272_17 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_17
					end

					if var_272_19.prefab_name ~= "" and arg_269_1.actors_[var_272_19.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_19.prefab_name].transform, "story_v_out_410142", "410142066", "story_v_out_410142.awb")

						arg_269_1:RecordAudio("410142066", var_272_24)
						arg_269_1:RecordAudio("410142066", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410142", "410142066", "story_v_out_410142.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410142", "410142066", "story_v_out_410142.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_18, arg_269_1.talkMaxDuration)

			if var_272_17 <= arg_269_1.time_ and arg_269_1.time_ < var_272_17 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_17) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_17 + var_272_25 and arg_269_1.time_ < var_272_17 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play410142067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410142067
		arg_273_1.duration_ = 8.07

		local var_273_0 = {
			ja = 8.066,
			CriLanguages = 2.266,
			zh = 2.266
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
				arg_273_0:Play410142068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061 = arg_273_1.actors_["1061"].transform.localPosition
				arg_273_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1061", 2)

				for iter_276_0 = 0, arg_273_1.actors_["1061"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["1061"].transform:GetChild(iter_276_0)

					if var_276_0.name == "split_5" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_276_2 = arg_273_1.actors_["1061"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								iter_276_2.color = Color.New(Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_2.color.r, 1, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_2.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_5 = arg_273_1.actors_["10061"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps10061 == nil then
				arg_273_1.var_.actorSpriteComps10061 = var_276_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_6 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_6 and not isNil(var_276_5) then
				if arg_273_1.var_.actorSpriteComps10061 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								iter_276_6.color = Color.New(Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_6), Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_6), (Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_6)))
							else
								local var_276_7 = Mathf.Lerp(iter_276_6.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_6)

								iter_276_6.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_6 and arg_273_1.time_ < 0 + var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps10061 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_276_8 then
						iter_276_8.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10061 = nil
			end

			local var_276_8 = 0
			local var_276_9 = 0.175

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(410142067)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 7 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 7)

				if (7 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 7)) > 0 and var_276_9 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142067", "story_v_out_410142.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142067", "story_v_out_410142.awb") / 1000

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_410142", "410142067", "story_v_out_410142.awb")

						arg_273_1:RecordAudio("410142067", var_276_15)
						arg_273_1:RecordAudio("410142067", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410142", "410142067", "story_v_out_410142.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410142", "410142067", "story_v_out_410142.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_16 and arg_273_1.time_ < var_276_8 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play410142068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410142068
		arg_277_1.duration_ = 13.43

		local var_277_0 = {
			ja = 13.433,
			CriLanguages = 7.866,
			zh = 7.866
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
				arg_277_0:Play410142069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1056 = arg_277_1.actors_["1056"].transform.localPosition
				arg_277_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1056", 2)

				for iter_280_0 = 0, arg_277_1.actors_["1056"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["1056"].transform:GetChild(iter_280_0)

					if var_280_0.name == "" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_280_2 = arg_277_1.actors_["1061"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = var_280_2.localPosition
				var_280_2.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 7)

				for iter_280_1 = 0, var_280_2.childCount - 1 do
					local var_280_3 = var_280_2:GetChild(iter_280_1)

					if var_280_3.name == "" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				var_280_2.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_277_1.time_ - 0) / var_280_4)
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				var_280_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_280_5 = arg_277_1.actors_["1056"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.actorSpriteComps1056 == nil then
				arg_277_1.var_.actorSpriteComps1056 = var_280_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_6 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_6 and not isNil(var_280_5) then
				if arg_277_1.var_.actorSpriteComps1056 then
					for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_280_3 then
							if arg_277_1.isInRecall_ then
								iter_280_3.color = Color.New(Mathf.Lerp(iter_280_3.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_6), Mathf.Lerp(iter_280_3.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_6), (Mathf.Lerp(iter_280_3.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_6)))
							else
								local var_280_7 = Mathf.Lerp(iter_280_3.color.r, 1, (arg_277_1.time_ - 0) / var_280_6)

								iter_280_3.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_6 and arg_277_1.time_ < 0 + var_280_6 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.actorSpriteComps1056 then
				for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_280_5 then
						iter_280_5.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps1056 = nil
			end

			local var_280_8 = arg_277_1.actors_["1061"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_9 and not isNil(var_280_8) then
				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_7 then
							if arg_277_1.isInRecall_ then
								iter_280_7.color = Color.New(Mathf.Lerp(iter_280_7.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_9), Mathf.Lerp(iter_280_7.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_9), (Mathf.Lerp(iter_280_7.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_9)))
							else
								local var_280_10 = Mathf.Lerp(iter_280_7.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_9)

								iter_280_7.color = Color.New(var_280_10, var_280_10, var_280_10)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_9 and arg_277_1.time_ < 0 + var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_8, iter_280_9 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_9 then
						iter_280_9.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_11 = 0
			local var_280_12 = 1.075

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_13 = arg_277_1:GetWordFromCfg(410142068)
				local var_280_14 = arg_277_1:FormatText(var_280_13.content)

				arg_277_1.text_.text = var_280_14

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_16 = 43 <= 0 and var_280_12 or var_280_12 * (utf8.len(var_280_14) / 43)

				if (43 <= 0 and var_280_12 or var_280_12 * (utf8.len(var_280_14) / 43)) > 0 and var_280_12 < var_280_16 then
					arg_277_1.talkMaxDuration = var_280_16

					if var_280_16 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_11
					end
				end

				arg_277_1.text_.text = var_280_14
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142068", "story_v_out_410142.awb") ~= 0 then
					local var_280_17 = manager.audio:GetVoiceLength("story_v_out_410142", "410142068", "story_v_out_410142.awb") / 1000

					if var_280_17 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_17 + var_280_11
					end

					if var_280_13.prefab_name ~= "" and arg_277_1.actors_[var_280_13.prefab_name] ~= nil then
						local var_280_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_13.prefab_name].transform, "story_v_out_410142", "410142068", "story_v_out_410142.awb")

						arg_277_1:RecordAudio("410142068", var_280_18)
						arg_277_1:RecordAudio("410142068", var_280_18)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410142", "410142068", "story_v_out_410142.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410142", "410142068", "story_v_out_410142.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_19 = math.max(var_280_12, arg_277_1.talkMaxDuration)

			if var_280_11 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_19 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_11) / var_280_19

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_11 + var_280_19 and arg_277_1.time_ < var_280_11 + var_280_19 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play410142069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410142069
		arg_281_1.duration_ = 6.33

		local var_281_0 = {
			ja = 6.333,
			CriLanguages = 4.233,
			zh = 4.233
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
				arg_281_0:Play410142070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1056 = arg_281_1.actors_["1056"].transform.localPosition
				arg_281_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1056", 2)

				for iter_284_0 = 0, arg_281_1.actors_["1056"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["1056"].transform:GetChild(iter_284_0)

					if var_284_0.name == "" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_284_2 = arg_281_1.actors_["1056"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1056 == nil then
				arg_281_1.var_.actorSpriteComps1056 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps1056 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								iter_284_2.color = Color.New(Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_2.color.r, 1, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_2.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1056 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps1056 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.525

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(410142069)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 21 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 21)

				if (21 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 21)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142069", "story_v_out_410142.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142069", "story_v_out_410142.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_410142", "410142069", "story_v_out_410142.awb")

						arg_281_1:RecordAudio("410142069", var_284_12)
						arg_281_1:RecordAudio("410142069", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410142", "410142069", "story_v_out_410142.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410142", "410142069", "story_v_out_410142.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play410142070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410142070
		arg_285_1.duration_ = 9.2

		local var_285_0 = {
			ja = 9.2,
			CriLanguages = 8.3,
			zh = 7.533
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
				arg_285_0:Play410142071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10061 = arg_285_1.actors_["10061"].transform.localPosition
				arg_285_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10061", 4)

				for iter_288_0 = 0, arg_285_1.actors_["10061"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["10061"].transform:GetChild(iter_288_0)

					if var_288_0.name == "" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_288_2 = arg_285_1.actors_["10061"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps10061 == nil then
				arg_285_1.var_.actorSpriteComps10061 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps10061 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								iter_288_2.color = Color.New(Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_3), Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_3), (Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_3)))
							else
								local var_288_4 = Mathf.Lerp(iter_288_2.color.r, 1, (arg_285_1.time_ - 0) / var_288_3)

								iter_288_2.color = Color.New(var_288_4, var_288_4, var_288_4)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps10061 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_288_4 then
						iter_288_4.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10061 = nil
			end

			local var_288_5 = arg_285_1.actors_["1056"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1056 == nil then
				arg_285_1.var_.actorSpriteComps1056 = var_288_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_6 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.actorSpriteComps1056 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								iter_288_6.color = Color.New(Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_6), Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_6), (Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_6)))
							else
								local var_288_7 = Mathf.Lerp(iter_288_6.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_6)

								iter_288_6.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1056 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_288_8 then
						iter_288_8.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1056 = nil
			end

			local var_288_8 = 0
			local var_288_9 = 0.975

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(410142070)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 39 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 39)

				if (39 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 39)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142070", "story_v_out_410142.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142070", "story_v_out_410142.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_410142", "410142070", "story_v_out_410142.awb")

						arg_285_1:RecordAudio("410142070", var_288_15)
						arg_285_1:RecordAudio("410142070", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410142", "410142070", "story_v_out_410142.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410142", "410142070", "story_v_out_410142.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_16 and arg_285_1.time_ < var_288_8 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play410142071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410142071
		arg_289_1.duration_ = 1.33

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410142072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1056 = arg_289_1.actors_["1056"].transform.localPosition
				arg_289_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1056", 2)

				for iter_292_0 = 0, arg_289_1.actors_["1056"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["1056"].transform:GetChild(iter_292_0)

					if var_292_0.name == "split_3" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1056, Vector3.New(-390, -350, -180), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1056"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_292_2 = arg_289_1.actors_["1056"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1056 == nil then
				arg_289_1.var_.actorSpriteComps1056 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps1056 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								iter_292_2.color = Color.New(Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_2.color.r, 1, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_2.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1056 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps1056 = nil
			end

			local var_292_5 = arg_289_1.actors_["10061"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps10061 == nil then
				arg_289_1.var_.actorSpriteComps10061 = var_292_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_6 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.actorSpriteComps10061 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								iter_292_6.color = Color.New(Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_6), Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_6), (Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_6)))
							else
								local var_292_7 = Mathf.Lerp(iter_292_6.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_6)

								iter_292_6.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps10061 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_292_8 then
						iter_292_8.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps10061 = nil
			end

			local var_292_8 = 0
			local var_292_9 = 0.075

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(410142071)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 3 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 3)

				if (3 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 3)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142071", "story_v_out_410142.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142071", "story_v_out_410142.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_out_410142", "410142071", "story_v_out_410142.awb")

						arg_289_1:RecordAudio("410142071", var_292_15)
						arg_289_1:RecordAudio("410142071", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410142", "410142071", "story_v_out_410142.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410142", "410142071", "story_v_out_410142.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_16 and arg_289_1.time_ < var_292_8 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play410142072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410142072
		arg_293_1.duration_ = 10.9

		local var_293_0 = {
			ja = 10.9,
			CriLanguages = 6.733,
			zh = 6.733
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
				arg_293_0:Play410142073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10061 = arg_293_1.actors_["10061"].transform.localPosition
				arg_293_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10061", 4)

				for iter_296_0 = 0, arg_293_1.actors_["10061"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["10061"].transform:GetChild(iter_296_0)

					if var_296_0.name == "" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10061, Vector3.New(390, -517.5, -100), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["10061"].transform.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_296_2 = arg_293_1.actors_["10061"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10061 == nil then
				arg_293_1.var_.actorSpriteComps10061 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps10061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								iter_296_2.color = Color.New(Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_2.color.r, 1, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_2.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps10061 = nil
			end

			local var_296_5 = arg_293_1.actors_["1056"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.actorSpriteComps1056 == nil then
				arg_293_1.var_.actorSpriteComps1056 = var_296_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_6 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_6 and not isNil(var_296_5) then
				if arg_293_1.var_.actorSpriteComps1056 then
					for iter_296_5, iter_296_6 in pairs(arg_293_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_296_6 then
							if arg_293_1.isInRecall_ then
								iter_296_6.color = Color.New(Mathf.Lerp(iter_296_6.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_6), Mathf.Lerp(iter_296_6.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_6), (Mathf.Lerp(iter_296_6.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_6)))
							else
								local var_296_7 = Mathf.Lerp(iter_296_6.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_6)

								iter_296_6.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_6 and arg_293_1.time_ < 0 + var_296_6 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.actorSpriteComps1056 then
				for iter_296_7, iter_296_8 in pairs(arg_293_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_296_8 then
						iter_296_8.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps1056 = nil
			end

			local var_296_8 = 0
			local var_296_9 = 0.7

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(410142072)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 28 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 28)

				if (28 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 28)) > 0 and var_296_9 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142072", "story_v_out_410142.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142072", "story_v_out_410142.awb") / 1000

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_out_410142", "410142072", "story_v_out_410142.awb")

						arg_293_1:RecordAudio("410142072", var_296_15)
						arg_293_1:RecordAudio("410142072", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410142", "410142072", "story_v_out_410142.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410142", "410142072", "story_v_out_410142.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_16 and arg_293_1.time_ < var_296_8 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play410142073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410142073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410142074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10061"]) and arg_297_1.var_.actorSpriteComps10061 == nil then
				arg_297_1.var_.actorSpriteComps10061 = arg_297_1.actors_["10061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10061"]) then
				if arg_297_1.var_.actorSpriteComps10061 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10061"]) and arg_297_1.var_.actorSpriteComps10061 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps10061 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.725

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(410142073).content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_6 = 29 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 29)

				if (29 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 29)) > 0 and var_300_3 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_7 and arg_297_1.time_ < var_300_2 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play410142074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410142074
		arg_301_1.duration_ = 9.17

		local var_301_0 = {
			ja = 9.166,
			CriLanguages = 8.466,
			zh = 8.466
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
				arg_301_0:Play410142075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 3 < arg_301_1.time_ and arg_301_1.time_ <= 3 + arg_304_0 then
				local var_304_0 = arg_301_1.bgs_.ST61

				arg_301_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_304_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_1 = var_304_0:GetComponent("SpriteRenderer")

				if var_304_1 and var_304_1.sprite then
					local var_304_2 = 2 * (var_304_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_304_0.transform.localScale = Vector3.New(var_304_2 / var_304_1.sprite.bounds.size.y < var_304_2 * manager.ui.mainCameraCom_.aspect / var_304_1.sprite.bounds.size.x and var_304_2 * manager.ui.mainCameraCom_.aspect / var_304_1.sprite.bounds.size.x or var_304_2 / var_304_1.sprite.bounds.size.y, var_304_2 / var_304_1.sprite.bounds.size.y < var_304_2 * manager.ui.mainCameraCom_.aspect / var_304_1.sprite.bounds.size.x and var_304_2 * manager.ui.mainCameraCom_.aspect / var_304_1.sprite.bounds.size.x or var_304_2 / var_304_1.sprite.bounds.size.y, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "ST61" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_3 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_4 = 3

			if var_304_3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_3 + var_304_4 then
				local var_304_5 = Color.New(0, 0, 0)

				var_304_5.a = Mathf.Lerp(0, 1, (arg_301_1.time_ - var_304_3) / var_304_4)
				arg_301_1.mask_.color = var_304_5
			end

			if arg_301_1.time_ >= var_304_3 + var_304_4 and arg_301_1.time_ < var_304_3 + var_304_4 + arg_304_0 then
				local var_304_6 = Color.New(0, 0, 0)

				var_304_6.a = 1
				arg_301_1.mask_.color = var_304_6
			end

			local var_304_7 = 3

			if 3 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_8 = 3

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_8 then
				local var_304_9 = Color.New(0, 0, 0)

				var_304_9.a = Mathf.Lerp(1, 0, (arg_301_1.time_ - var_304_7) / var_304_8)
				arg_301_1.mask_.color = var_304_9
			end

			if arg_301_1.time_ >= var_304_7 + var_304_8 and arg_301_1.time_ < var_304_7 + var_304_8 + arg_304_0 then
				local var_304_10 = Color.New(0, 0, 0)

				arg_301_1.mask_.enabled = false
				var_304_10.a = 0
				arg_301_1.mask_.color = var_304_10
			end

			local var_304_11 = arg_301_1.actors_["1056"].transform

			if 5.8 < arg_301_1.time_ and arg_301_1.time_ <= 5.8 + arg_304_0 then
				arg_301_1.var_.moveOldPos1056 = var_304_11.localPosition
				var_304_11.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1056", 4)

				for iter_304_2 = 0, var_304_11.childCount - 1 do
					local var_304_12 = var_304_11:GetChild(iter_304_2)

					if var_304_12.name == "split_3" or not string.find(var_304_12.name, "split") then
						var_304_12.gameObject:SetActive(true)
					else
						var_304_12.gameObject:SetActive(false)
					end
				end
			end

			local var_304_13 = 0.001

			if 5.8 <= arg_301_1.time_ and arg_301_1.time_ < 5.8 + var_304_13 then
				var_304_11.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_301_1.time_ - 5.8) / var_304_13)
			end

			if arg_301_1.time_ >= 5.8 + var_304_13 and arg_301_1.time_ < 5.8 + var_304_13 + arg_304_0 then
				var_304_11.localPosition = Vector3.New(390, -350, -180)
			end

			local var_304_14 = arg_301_1.actors_["1061"].transform

			if 5.8 < arg_301_1.time_ and arg_301_1.time_ <= 5.8 + arg_304_0 then
				arg_301_1.var_.moveOldPos1061 = var_304_14.localPosition
				var_304_14.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1061", 2)

				for iter_304_3 = 0, var_304_14.childCount - 1 do
					local var_304_15 = var_304_14:GetChild(iter_304_3)

					if var_304_15.name == "" or not string.find(var_304_15.name, "split") then
						var_304_15.gameObject:SetActive(true)
					else
						var_304_15.gameObject:SetActive(false)
					end
				end
			end

			local var_304_16 = 0.001

			if 5.8 <= arg_301_1.time_ and arg_301_1.time_ < 5.8 + var_304_16 then
				var_304_14.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_301_1.time_ - 5.8) / var_304_16)
			end

			if arg_301_1.time_ >= 5.8 + var_304_16 and arg_301_1.time_ < 5.8 + var_304_16 + arg_304_0 then
				var_304_14.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_304_17 = arg_301_1.actors_["1056"]

			if 5.8 < arg_301_1.time_ and arg_301_1.time_ <= 5.8 + arg_304_0 and not isNil(var_304_17) and arg_301_1.var_.actorSpriteComps1056 == nil then
				arg_301_1.var_.actorSpriteComps1056 = var_304_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_18 = 0.0339999999999998

			if 5.8 <= arg_301_1.time_ and arg_301_1.time_ < 5.8 + var_304_18 and not isNil(var_304_17) then
				if arg_301_1.var_.actorSpriteComps1056 then
					for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_304_5 then
							if arg_301_1.isInRecall_ then
								iter_304_5.color = Color.New(Mathf.Lerp(iter_304_5.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 5.8) / var_304_18), Mathf.Lerp(iter_304_5.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 5.8) / var_304_18), (Mathf.Lerp(iter_304_5.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 5.8) / var_304_18)))
							else
								local var_304_19 = Mathf.Lerp(iter_304_5.color.r, 1, (arg_301_1.time_ - 5.8) / var_304_18)

								iter_304_5.color = Color.New(var_304_19, var_304_19, var_304_19)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 5.8 + var_304_18 and arg_301_1.time_ < 5.8 + var_304_18 + arg_304_0 and not isNil(var_304_17) and arg_301_1.var_.actorSpriteComps1056 then
				for iter_304_6, iter_304_7 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_304_7 then
						iter_304_7.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps1056 = nil
			end

			local var_304_20 = arg_301_1.actors_["1061"]

			if 5.8 < arg_301_1.time_ and arg_301_1.time_ <= 5.8 + arg_304_0 and not isNil(var_304_20) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_21 = 0.034

			if 5.8 <= arg_301_1.time_ and arg_301_1.time_ < 5.8 + var_304_21 and not isNil(var_304_20) then
				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_8, iter_304_9 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_9 then
							if arg_301_1.isInRecall_ then
								iter_304_9.color = Color.New(Mathf.Lerp(iter_304_9.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 5.8) / var_304_21), Mathf.Lerp(iter_304_9.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 5.8) / var_304_21), (Mathf.Lerp(iter_304_9.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 5.8) / var_304_21)))
							else
								local var_304_22 = Mathf.Lerp(iter_304_9.color.r, 0.5, (arg_301_1.time_ - 5.8) / var_304_21)

								iter_304_9.color = Color.New(var_304_22, var_304_22, var_304_22)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 5.8 + var_304_21 and arg_301_1.time_ < 5.8 + var_304_21 + arg_304_0 and not isNil(var_304_20) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_10, iter_304_11 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_11 then
						iter_304_11.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_23 = arg_301_1.actors_["1056"].transform

			if 2.966 < arg_301_1.time_ and arg_301_1.time_ <= 2.966 + arg_304_0 then
				arg_301_1.var_.moveOldPos1056 = var_304_23.localPosition
				var_304_23.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1056", 7)

				for iter_304_12 = 0, var_304_23.childCount - 1 do
					local var_304_24 = var_304_23:GetChild(iter_304_12)

					if var_304_24.name == "split_3" or not string.find(var_304_24.name, "split") then
						var_304_24.gameObject:SetActive(true)
					else
						var_304_24.gameObject:SetActive(false)
					end
				end
			end

			local var_304_25 = 0.001

			if 2.966 <= arg_301_1.time_ and arg_301_1.time_ < 2.966 + var_304_25 then
				var_304_23.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_301_1.time_ - 2.966) / var_304_25)
			end

			if arg_301_1.time_ >= 2.966 + var_304_25 and arg_301_1.time_ < 2.966 + var_304_25 + arg_304_0 then
				var_304_23.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_304_26 = arg_301_1.actors_["10061"].transform

			if 2.966 < arg_301_1.time_ and arg_301_1.time_ <= 2.966 + arg_304_0 then
				arg_301_1.var_.moveOldPos10061 = var_304_26.localPosition
				var_304_26.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10061", 7)

				for iter_304_13 = 0, var_304_26.childCount - 1 do
					local var_304_27 = var_304_26:GetChild(iter_304_13)

					if var_304_27.name == "" or not string.find(var_304_27.name, "split") then
						var_304_27.gameObject:SetActive(true)
					else
						var_304_27.gameObject:SetActive(false)
					end
				end
			end

			local var_304_28 = 0.001

			if 2.966 <= arg_301_1.time_ and arg_301_1.time_ < 2.966 + var_304_28 then
				var_304_26.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10061, Vector3.New(0, -2000, -100), (arg_301_1.time_ - 2.966) / var_304_28)
			end

			if arg_301_1.time_ >= 2.966 + var_304_28 and arg_301_1.time_ < 2.966 + var_304_28 + arg_304_0 then
				var_304_26.localPosition = Vector3.New(0, -2000, -100)
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_29 = 6
			local var_304_30 = 0.275

			if 6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_29 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_31 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_31:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_32 = arg_301_1:GetWordFromCfg(410142074)
				local var_304_33 = arg_301_1:FormatText(var_304_32.content)

				arg_301_1.text_.text = var_304_33

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_35 = 11 <= 0 and var_304_30 or var_304_30 * (utf8.len(var_304_33) / 11)

				if (11 <= 0 and var_304_30 or var_304_30 * (utf8.len(var_304_33) / 11)) > 0 and var_304_30 < var_304_35 then
					arg_301_1.talkMaxDuration = var_304_35
					var_304_29 = var_304_29 + 0.3

					if var_304_35 + var_304_29 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_35 + var_304_29
					end
				end

				arg_301_1.text_.text = var_304_33
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142074", "story_v_out_410142.awb") ~= 0 then
					local var_304_36 = manager.audio:GetVoiceLength("story_v_out_410142", "410142074", "story_v_out_410142.awb") / 1000

					if var_304_36 + var_304_29 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_36 + var_304_29
					end

					if var_304_32.prefab_name ~= "" and arg_301_1.actors_[var_304_32.prefab_name] ~= nil then
						local var_304_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_32.prefab_name].transform, "story_v_out_410142", "410142074", "story_v_out_410142.awb")

						arg_301_1:RecordAudio("410142074", var_304_37)
						arg_301_1:RecordAudio("410142074", var_304_37)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410142", "410142074", "story_v_out_410142.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410142", "410142074", "story_v_out_410142.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_38 = var_304_29 + 0.3
			local var_304_39 = math.max(var_304_30, arg_301_1.talkMaxDuration)

			if var_304_29 + 0.3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_38 + var_304_39 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_38) / var_304_39

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_38 + var_304_39 and arg_301_1.time_ < var_304_38 + var_304_39 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play410142075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 410142075
		arg_307_1.duration_ = 9.57

		local var_307_0 = {
			ja = 9.566,
			CriLanguages = 4.833,
			zh = 4.833
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
				arg_307_0:Play410142076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1061 = arg_307_1.actors_["1061"].transform.localPosition
				arg_307_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1061", 2)

				for iter_310_0 = 0, arg_307_1.actors_["1061"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["1061"].transform:GetChild(iter_310_0)

					if var_310_0.name == "split_2" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_310_2 = arg_307_1.actors_["1056"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1056 == nil then
				arg_307_1.var_.actorSpriteComps1056 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 0.0339999999999998

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps1056 then
					for iter_310_1, iter_310_2 in pairs(arg_307_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_310_2 then
							if arg_307_1.isInRecall_ then
								iter_310_2.color = Color.New(Mathf.Lerp(iter_310_2.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_3), Mathf.Lerp(iter_310_2.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_3), (Mathf.Lerp(iter_310_2.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_3)))
							else
								local var_310_4 = Mathf.Lerp(iter_310_2.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_3)

								iter_310_2.color = Color.New(var_310_4, var_310_4, var_310_4)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1056 then
				for iter_310_3, iter_310_4 in pairs(arg_307_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_310_4 then
						iter_310_4.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps1056 = nil
			end

			local var_310_5 = arg_307_1.actors_["1061"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.actorSpriteComps1061 == nil then
				arg_307_1.var_.actorSpriteComps1061 = var_310_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_6 = 0.034

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_6 and not isNil(var_310_5) then
				if arg_307_1.var_.actorSpriteComps1061 then
					for iter_310_5, iter_310_6 in pairs(arg_307_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_310_6 then
							if arg_307_1.isInRecall_ then
								iter_310_6.color = Color.New(Mathf.Lerp(iter_310_6.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 0) / var_310_6), Mathf.Lerp(iter_310_6.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 0) / var_310_6), (Mathf.Lerp(iter_310_6.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 0) / var_310_6)))
							else
								local var_310_7 = Mathf.Lerp(iter_310_6.color.r, 1, (arg_307_1.time_ - 0) / var_310_6)

								iter_310_6.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_6 and arg_307_1.time_ < 0 + var_310_6 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.actorSpriteComps1061 then
				for iter_310_7, iter_310_8 in pairs(arg_307_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_310_8 then
						iter_310_8.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps1061 = nil
			end

			local var_310_8 = 0
			local var_310_9 = 0.675

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(410142075)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_13 = 27 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 27)

				if (27 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 27)) > 0 and var_310_9 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142075", "story_v_out_410142.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142075", "story_v_out_410142.awb") / 1000

					if var_310_14 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_8
					end

					if var_310_10.prefab_name ~= "" and arg_307_1.actors_[var_310_10.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_10.prefab_name].transform, "story_v_out_410142", "410142075", "story_v_out_410142.awb")

						arg_307_1:RecordAudio("410142075", var_310_15)
						arg_307_1:RecordAudio("410142075", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_410142", "410142075", "story_v_out_410142.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_410142", "410142075", "story_v_out_410142.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_16 and arg_307_1.time_ < var_310_8 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play410142076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 410142076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play410142077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1056"]) and arg_311_1.var_.actorSpriteComps1056 == nil then
				arg_311_1.var_.actorSpriteComps1056 = arg_311_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.0339999999999998

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1056"]) then
				if arg_311_1.var_.actorSpriteComps1056 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1056"]) and arg_311_1.var_.actorSpriteComps1056 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps1056 = nil
			end

			local var_314_2 = arg_311_1.actors_["1061"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps1061 == nil then
				arg_311_1.var_.actorSpriteComps1061 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 0.034

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps1061 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								iter_314_5.color = Color.New(Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_5.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_5.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps1061 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_314_7 then
						iter_314_7.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps1061 = nil
			end

			local var_314_5 = 0
			local var_314_6 = 0.925

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(410142076).content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 37 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_7) / 37)

				if (37 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_7) / 37)) > 0 and var_314_6 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_10 and arg_311_1.time_ < var_314_5 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play410142077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 410142077
		arg_315_1.duration_ = 13.33

		local var_315_0 = {
			ja = 13.333,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_315_0:Play410142078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1061 = arg_315_1.actors_["1061"].transform.localPosition
				arg_315_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1061", 2)

				for iter_318_0 = 0, arg_315_1.actors_["1061"].transform.childCount - 1 do
					local var_318_0 = arg_315_1.actors_["1061"].transform:GetChild(iter_318_0)

					if var_318_0.name == "split_1" or not string.find(var_318_0.name, "split") then
						var_318_0.gameObject:SetActive(true)
					else
						var_318_0.gameObject:SetActive(false)
					end
				end
			end

			local var_318_1 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 then
				arg_315_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_315_1.time_ - 0) / var_318_1)
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 then
				arg_315_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_318_2 = arg_315_1.actors_["1061"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps1061 == nil then
				arg_315_1.var_.actorSpriteComps1061 = var_318_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_3 = 0.034

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.actorSpriteComps1061 then
					for iter_318_1, iter_318_2 in pairs(arg_315_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_318_2 then
							if arg_315_1.isInRecall_ then
								iter_318_2.color = Color.New(Mathf.Lerp(iter_318_2.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_3), Mathf.Lerp(iter_318_2.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_3), (Mathf.Lerp(iter_318_2.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_3)))
							else
								local var_318_4 = Mathf.Lerp(iter_318_2.color.r, 1, (arg_315_1.time_ - 0) / var_318_3)

								iter_318_2.color = Color.New(var_318_4, var_318_4, var_318_4)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps1061 then
				for iter_318_3, iter_318_4 in pairs(arg_315_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_318_4 then
						iter_318_4.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps1061 = nil
			end

			local var_318_5 = 0
			local var_318_6 = 0.875

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_7 = arg_315_1:GetWordFromCfg(410142077)
				local var_318_8 = arg_315_1:FormatText(var_318_7.content)

				arg_315_1.text_.text = var_318_8

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 35 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 35)

				if (35 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 35)) > 0 and var_318_6 < var_318_10 then
					arg_315_1.talkMaxDuration = var_318_10

					if var_318_10 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_8
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142077", "story_v_out_410142.awb") ~= 0 then
					local var_318_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142077", "story_v_out_410142.awb") / 1000

					if var_318_11 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_5
					end

					if var_318_7.prefab_name ~= "" and arg_315_1.actors_[var_318_7.prefab_name] ~= nil then
						local var_318_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_7.prefab_name].transform, "story_v_out_410142", "410142077", "story_v_out_410142.awb")

						arg_315_1:RecordAudio("410142077", var_318_12)
						arg_315_1:RecordAudio("410142077", var_318_12)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_410142", "410142077", "story_v_out_410142.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_410142", "410142077", "story_v_out_410142.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_13 and arg_315_1.time_ < var_318_5 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play410142078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 410142078
		arg_319_1.duration_ = 7.83

		local var_319_0 = {
			ja = 7.833,
			CriLanguages = 5.2,
			zh = 5.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play410142079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1056 = arg_319_1.actors_["1056"].transform.localPosition
				arg_319_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1056", 4)

				for iter_322_0 = 0, arg_319_1.actors_["1056"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["1056"].transform:GetChild(iter_322_0)

					if var_322_0.name == "split_4" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_322_2 = arg_319_1.actors_["1056"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps1056 == nil then
				arg_319_1.var_.actorSpriteComps1056 = var_322_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_3 = 0.034

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.actorSpriteComps1056 then
					for iter_322_1, iter_322_2 in pairs(arg_319_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_322_2 then
							if arg_319_1.isInRecall_ then
								iter_322_2.color = Color.New(Mathf.Lerp(iter_322_2.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_3), Mathf.Lerp(iter_322_2.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_3), (Mathf.Lerp(iter_322_2.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_3)))
							else
								local var_322_4 = Mathf.Lerp(iter_322_2.color.r, 1, (arg_319_1.time_ - 0) / var_322_3)

								iter_322_2.color = Color.New(var_322_4, var_322_4, var_322_4)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps1056 then
				for iter_322_3, iter_322_4 in pairs(arg_319_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_322_4 then
						iter_322_4.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps1056 = nil
			end

			local var_322_5 = arg_319_1.actors_["1061"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps1061 == nil then
				arg_319_1.var_.actorSpriteComps1061 = var_322_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_6 = 0.034

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_6 and not isNil(var_322_5) then
				if arg_319_1.var_.actorSpriteComps1061 then
					for iter_322_5, iter_322_6 in pairs(arg_319_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_322_6 then
							if arg_319_1.isInRecall_ then
								iter_322_6.color = Color.New(Mathf.Lerp(iter_322_6.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_6), Mathf.Lerp(iter_322_6.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_6), (Mathf.Lerp(iter_322_6.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_6)))
							else
								local var_322_7 = Mathf.Lerp(iter_322_6.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_6)

								iter_322_6.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_6 and arg_319_1.time_ < 0 + var_322_6 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps1061 then
				for iter_322_7, iter_322_8 in pairs(arg_319_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_322_8 then
						iter_322_8.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps1061 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 0.525

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(410142078)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 21 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 21)

				if (21 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 21)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142078", "story_v_out_410142.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142078", "story_v_out_410142.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_410142", "410142078", "story_v_out_410142.awb")

						arg_319_1:RecordAudio("410142078", var_322_15)
						arg_319_1:RecordAudio("410142078", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_410142", "410142078", "story_v_out_410142.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_410142", "410142078", "story_v_out_410142.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play410142079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 410142079
		arg_323_1.duration_ = 14.73

		local var_323_0 = {
			ja = 14.733,
			CriLanguages = 11.133,
			zh = 11.133
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play410142080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1061 = arg_323_1.actors_["1061"].transform.localPosition
				arg_323_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1061", 2)

				for iter_326_0 = 0, arg_323_1.actors_["1061"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["1061"].transform:GetChild(iter_326_0)

					if var_326_0.name == "split_5" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_326_2 = arg_323_1.actors_["1061"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps1061 == nil then
				arg_323_1.var_.actorSpriteComps1061 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 0.034

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps1061 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 1, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps1061 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps1061 = nil
			end

			local var_326_5 = arg_323_1.actors_["1056"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.actorSpriteComps1056 == nil then
				arg_323_1.var_.actorSpriteComps1056 = var_326_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_6 = 0.0339999999999998

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 and not isNil(var_326_5) then
				if arg_323_1.var_.actorSpriteComps1056 then
					for iter_326_5, iter_326_6 in pairs(arg_323_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_326_6 then
							if arg_323_1.isInRecall_ then
								iter_326_6.color = Color.New(Mathf.Lerp(iter_326_6.color.r, arg_323_1.hightColor2.r, (arg_323_1.time_ - 0) / var_326_6), Mathf.Lerp(iter_326_6.color.g, arg_323_1.hightColor2.g, (arg_323_1.time_ - 0) / var_326_6), (Mathf.Lerp(iter_326_6.color.b, arg_323_1.hightColor2.b, (arg_323_1.time_ - 0) / var_326_6)))
							else
								local var_326_7 = Mathf.Lerp(iter_326_6.color.r, 0.5, (arg_323_1.time_ - 0) / var_326_6)

								iter_326_6.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.actorSpriteComps1056 then
				for iter_326_7, iter_326_8 in pairs(arg_323_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_326_8 then
						iter_326_8.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps1056 = nil
			end

			local var_326_8 = 0
			local var_326_9 = 1.275

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(410142079)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 51 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 51)

				if (51 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 51)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142079", "story_v_out_410142.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142079", "story_v_out_410142.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_410142", "410142079", "story_v_out_410142.awb")

						arg_323_1:RecordAudio("410142079", var_326_15)
						arg_323_1:RecordAudio("410142079", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_410142", "410142079", "story_v_out_410142.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_410142", "410142079", "story_v_out_410142.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play410142080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 410142080
		arg_327_1.duration_ = 2.33

		local var_327_0 = {
			ja = 2.333,
			CriLanguages = 1.4,
			zh = 1.4
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
				arg_327_0:Play410142081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1056 = arg_327_1.actors_["1056"].transform.localPosition
				arg_327_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1056", 4)

				for iter_330_0 = 0, arg_327_1.actors_["1056"].transform.childCount - 1 do
					local var_330_0 = arg_327_1.actors_["1056"].transform:GetChild(iter_330_0)

					if var_330_0.name == "split_3" or not string.find(var_330_0.name, "split") then
						var_330_0.gameObject:SetActive(true)
					else
						var_330_0.gameObject:SetActive(false)
					end
				end
			end

			local var_330_1 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 then
				arg_327_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_327_1.time_ - 0) / var_330_1)
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 then
				arg_327_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_330_2 = arg_327_1.actors_["1056"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.actorSpriteComps1056 == nil then
				arg_327_1.var_.actorSpriteComps1056 = var_330_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_3 = 0.034

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.actorSpriteComps1056 then
					for iter_330_1, iter_330_2 in pairs(arg_327_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_330_2 then
							if arg_327_1.isInRecall_ then
								iter_330_2.color = Color.New(Mathf.Lerp(iter_330_2.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_3), Mathf.Lerp(iter_330_2.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_3), (Mathf.Lerp(iter_330_2.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_3)))
							else
								local var_330_4 = Mathf.Lerp(iter_330_2.color.r, 1, (arg_327_1.time_ - 0) / var_330_3)

								iter_330_2.color = Color.New(var_330_4, var_330_4, var_330_4)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.actorSpriteComps1056 then
				for iter_330_3, iter_330_4 in pairs(arg_327_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_330_4 then
						iter_330_4.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps1056 = nil
			end

			local var_330_5 = arg_327_1.actors_["1061"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.actorSpriteComps1061 == nil then
				arg_327_1.var_.actorSpriteComps1061 = var_330_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_6 = 0.034

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_6 and not isNil(var_330_5) then
				if arg_327_1.var_.actorSpriteComps1061 then
					for iter_330_5, iter_330_6 in pairs(arg_327_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_330_6 then
							if arg_327_1.isInRecall_ then
								iter_330_6.color = Color.New(Mathf.Lerp(iter_330_6.color.r, arg_327_1.hightColor2.r, (arg_327_1.time_ - 0) / var_330_6), Mathf.Lerp(iter_330_6.color.g, arg_327_1.hightColor2.g, (arg_327_1.time_ - 0) / var_330_6), (Mathf.Lerp(iter_330_6.color.b, arg_327_1.hightColor2.b, (arg_327_1.time_ - 0) / var_330_6)))
							else
								local var_330_7 = Mathf.Lerp(iter_330_6.color.r, 0.5, (arg_327_1.time_ - 0) / var_330_6)

								iter_330_6.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_6 and arg_327_1.time_ < 0 + var_330_6 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.actorSpriteComps1061 then
				for iter_330_7, iter_330_8 in pairs(arg_327_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_330_8 then
						iter_330_8.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_327_1.var_.actorSpriteComps1061 = nil
			end

			local var_330_8 = 0
			local var_330_9 = 0.075

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(410142080)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 3 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 3)

				if (3 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 3)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142080", "story_v_out_410142.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142080", "story_v_out_410142.awb") / 1000

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_410142", "410142080", "story_v_out_410142.awb")

						arg_327_1:RecordAudio("410142080", var_330_15)
						arg_327_1:RecordAudio("410142080", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_410142", "410142080", "story_v_out_410142.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_410142", "410142080", "story_v_out_410142.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410142081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 410142081
		arg_331_1.duration_ = 7.3

		local var_331_0 = {
			ja = 7.3,
			CriLanguages = 2.5,
			zh = 2.5
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play410142082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1061 = arg_331_1.actors_["1061"].transform.localPosition
				arg_331_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1061", 2)

				for iter_334_0 = 0, arg_331_1.actors_["1061"].transform.childCount - 1 do
					local var_334_0 = arg_331_1.actors_["1061"].transform:GetChild(iter_334_0)

					if var_334_0.name == "" or not string.find(var_334_0.name, "split") then
						var_334_0.gameObject:SetActive(true)
					else
						var_334_0.gameObject:SetActive(false)
					end
				end
			end

			local var_334_1 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 then
				arg_331_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_331_1.time_ - 0) / var_334_1)
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 then
				arg_331_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_334_2 = arg_331_1.actors_["1061"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps1061 == nil then
				arg_331_1.var_.actorSpriteComps1061 = var_334_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_3 = 0.034

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 and not isNil(var_334_2) then
				if arg_331_1.var_.actorSpriteComps1061 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_334_2 then
							if arg_331_1.isInRecall_ then
								iter_334_2.color = Color.New(Mathf.Lerp(iter_334_2.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_3), Mathf.Lerp(iter_334_2.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_3), (Mathf.Lerp(iter_334_2.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_3)))
							else
								local var_334_4 = Mathf.Lerp(iter_334_2.color.r, 1, (arg_331_1.time_ - 0) / var_334_3)

								iter_334_2.color = Color.New(var_334_4, var_334_4, var_334_4)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps1061 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_334_4 then
						iter_334_4.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps1061 = nil
			end

			local var_334_5 = arg_331_1.actors_["1056"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps1056 == nil then
				arg_331_1.var_.actorSpriteComps1056 = var_334_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_6 = 0.0339999999999998

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_6 and not isNil(var_334_5) then
				if arg_331_1.var_.actorSpriteComps1056 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_334_6 then
							if arg_331_1.isInRecall_ then
								iter_334_6.color = Color.New(Mathf.Lerp(iter_334_6.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_6), Mathf.Lerp(iter_334_6.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_6), (Mathf.Lerp(iter_334_6.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_6)))
							else
								local var_334_7 = Mathf.Lerp(iter_334_6.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_6)

								iter_334_6.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_6 and arg_331_1.time_ < 0 + var_334_6 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps1056 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_334_8 then
						iter_334_8.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps1056 = nil
			end

			local var_334_8 = 0
			local var_334_9 = 0.325

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(410142081)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 13 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 13)

				if (13 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 13)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142081", "story_v_out_410142.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142081", "story_v_out_410142.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_410142", "410142081", "story_v_out_410142.awb")

						arg_331_1:RecordAudio("410142081", var_334_15)
						arg_331_1:RecordAudio("410142081", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_410142", "410142081", "story_v_out_410142.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_410142", "410142081", "story_v_out_410142.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_16 and arg_331_1.time_ < var_334_8 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 410142082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play410142083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1056 = arg_335_1.actors_["1056"].transform.localPosition
				arg_335_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1056", 7)

				for iter_338_0 = 0, arg_335_1.actors_["1056"].transform.childCount - 1 do
					local var_338_0 = arg_335_1.actors_["1056"].transform:GetChild(iter_338_0)

					if var_338_0.name == "" or not string.find(var_338_0.name, "split") then
						var_338_0.gameObject:SetActive(true)
					else
						var_338_0.gameObject:SetActive(false)
					end
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_335_1.time_ - 0) / var_338_1)
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["1056"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_338_2 = arg_335_1.actors_["1061"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1061 = var_338_2.localPosition
				var_338_2.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1061", 7)

				for iter_338_1 = 0, var_338_2.childCount - 1 do
					local var_338_3 = var_338_2:GetChild(iter_338_1)

					if var_338_3.name == "" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				var_338_2.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_335_1.time_ - 0) / var_338_4)
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				var_338_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_338_5 = arg_335_1.actors_["1056"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.actorSpriteComps1056 == nil then
				arg_335_1.var_.actorSpriteComps1056 = var_338_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_6 = 0.034

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_6 and not isNil(var_338_5) then
				if arg_335_1.var_.actorSpriteComps1056 then
					for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_338_3 then
							if arg_335_1.isInRecall_ then
								iter_338_3.color = Color.New(Mathf.Lerp(iter_338_3.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_6), Mathf.Lerp(iter_338_3.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_6), (Mathf.Lerp(iter_338_3.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_6)))
							else
								local var_338_7 = Mathf.Lerp(iter_338_3.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_6)

								iter_338_3.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_6 and arg_335_1.time_ < 0 + var_338_6 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.actorSpriteComps1056 then
				for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_338_5 then
						iter_338_5.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps1056 = nil
			end

			local var_338_8 = arg_335_1.actors_["1061"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps1061 == nil then
				arg_335_1.var_.actorSpriteComps1061 = var_338_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_9 = 0.034

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_9 and not isNil(var_338_8) then
				if arg_335_1.var_.actorSpriteComps1061 then
					for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_338_7 then
							if arg_335_1.isInRecall_ then
								iter_338_7.color = Color.New(Mathf.Lerp(iter_338_7.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_9), Mathf.Lerp(iter_338_7.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_9), (Mathf.Lerp(iter_338_7.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_9)))
							else
								local var_338_10 = Mathf.Lerp(iter_338_7.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_9)

								iter_338_7.color = Color.New(var_338_10, var_338_10, var_338_10)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_9 and arg_335_1.time_ < 0 + var_338_9 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps1061 then
				for iter_338_8, iter_338_9 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_338_9 then
						iter_338_9.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps1061 = nil
			end

			local var_338_11 = 0
			local var_338_12 = 1.175

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_11 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_13 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(410142082).content)

				arg_335_1.text_.text = var_338_13

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_15 = 47 <= 0 and var_338_12 or var_338_12 * (utf8.len(var_338_13) / 47)

				if (47 <= 0 and var_338_12 or var_338_12 * (utf8.len(var_338_13) / 47)) > 0 and var_338_12 < var_338_15 then
					arg_335_1.talkMaxDuration = var_338_15

					if var_338_15 + var_338_11 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_15 + var_338_11
					end
				end

				arg_335_1.text_.text = var_338_13
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_12, arg_335_1.talkMaxDuration)

			if var_338_11 <= arg_335_1.time_ and arg_335_1.time_ < var_338_11 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_11) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_11 + var_338_16 and arg_335_1.time_ < var_338_11 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 410142083
		arg_339_1.duration_ = 10.5

		local var_339_0 = {
			ja = 7.766,
			CriLanguages = 10.5,
			zh = 10.5
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
				arg_339_0:Play410142084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1061 = arg_339_1.actors_["1061"].transform.localPosition
				arg_339_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1061", 3)

				for iter_342_0 = 0, arg_339_1.actors_["1061"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["1061"].transform:GetChild(iter_342_0)

					if var_342_0.name == "split_7" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_342_2 = arg_339_1.actors_["1061"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps1061 == nil then
				arg_339_1.var_.actorSpriteComps1061 = var_342_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_3 = 0.034

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 and not isNil(var_342_2) then
				if arg_339_1.var_.actorSpriteComps1061 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								iter_342_2.color = Color.New(Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_3), Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_3), (Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_3)))
							else
								local var_342_4 = Mathf.Lerp(iter_342_2.color.r, 1, (arg_339_1.time_ - 0) / var_342_3)

								iter_342_2.color = Color.New(var_342_4, var_342_4, var_342_4)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps1061 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_342_4 then
						iter_342_4.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps1061 = nil
			end

			local var_342_5 = 0
			local var_342_6 = 1.15

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(410142083)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 46 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 46)

				if (46 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 46)) > 0 and var_342_6 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142083", "story_v_out_410142.awb") ~= 0 then
					local var_342_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142083", "story_v_out_410142.awb") / 1000

					if var_342_11 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_5
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_410142", "410142083", "story_v_out_410142.awb")

						arg_339_1:RecordAudio("410142083", var_342_12)
						arg_339_1:RecordAudio("410142083", var_342_12)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_410142", "410142083", "story_v_out_410142.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_410142", "410142083", "story_v_out_410142.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_13 and arg_339_1.time_ < var_342_5 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play410142084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 410142084
		arg_343_1.duration_ = 11.17

		local var_343_0 = {
			ja = 11.166,
			CriLanguages = 10.966,
			zh = 10.966
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play410142085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1061 = arg_343_1.actors_["1061"].transform.localPosition
				arg_343_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1061", 3)

				for iter_346_0 = 0, arg_343_1.actors_["1061"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["1061"].transform:GetChild(iter_346_0)

					if var_346_0.name == "split_7" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_346_2 = arg_343_1.actors_["1061"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps1061 == nil then
				arg_343_1.var_.actorSpriteComps1061 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 0.034

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps1061 then
					for iter_346_1, iter_346_2 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_346_2 then
							if arg_343_1.isInRecall_ then
								iter_346_2.color = Color.New(Mathf.Lerp(iter_346_2.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_2.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_2.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_2.color.r, 1, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_2.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps1061 then
				for iter_346_3, iter_346_4 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_346_4 then
						iter_346_4.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps1061 = nil
			end

			local var_346_5 = 0
			local var_346_6 = 1.05

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_7 = arg_343_1:GetWordFromCfg(410142084)
				local var_346_8 = arg_343_1:FormatText(var_346_7.content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 43 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 43)

				if (43 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 43)) > 0 and var_346_6 < var_346_10 then
					arg_343_1.talkMaxDuration = var_346_10

					if var_346_10 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142084", "story_v_out_410142.awb") ~= 0 then
					local var_346_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142084", "story_v_out_410142.awb") / 1000

					if var_346_11 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_5
					end

					if var_346_7.prefab_name ~= "" and arg_343_1.actors_[var_346_7.prefab_name] ~= nil then
						local var_346_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_7.prefab_name].transform, "story_v_out_410142", "410142084", "story_v_out_410142.awb")

						arg_343_1:RecordAudio("410142084", var_346_12)
						arg_343_1:RecordAudio("410142084", var_346_12)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_410142", "410142084", "story_v_out_410142.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_410142", "410142084", "story_v_out_410142.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_13 and arg_343_1.time_ < var_346_5 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 410142085
		arg_347_1.duration_ = 7.17

		local var_347_0 = {
			ja = 6.633,
			CriLanguages = 7.166,
			zh = 7.166
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
				arg_347_0:Play410142086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1061 = arg_347_1.actors_["1061"].transform.localPosition
				arg_347_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("1061", 3)

				for iter_350_0 = 0, arg_347_1.actors_["1061"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["1061"].transform:GetChild(iter_350_0)

					if var_350_0.name == "split_7" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_350_2 = arg_347_1.actors_["1061"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps1061 == nil then
				arg_347_1.var_.actorSpriteComps1061 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 0.034

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps1061 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								iter_350_2.color = Color.New(Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_2.color.r, 1, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_2.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps1061 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_350_4 then
						iter_350_4.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps1061 = nil
			end

			local var_350_5 = 0
			local var_350_6 = 0.425

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(410142085)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 17 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 17)

				if (17 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 17)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142085", "story_v_out_410142.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142085", "story_v_out_410142.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_410142", "410142085", "story_v_out_410142.awb")

						arg_347_1:RecordAudio("410142085", var_350_12)
						arg_347_1:RecordAudio("410142085", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_410142", "410142085", "story_v_out_410142.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_410142", "410142085", "story_v_out_410142.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play410142086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 410142086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play410142087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1061"]) and arg_351_1.var_.actorSpriteComps1061 == nil then
				arg_351_1.var_.actorSpriteComps1061 = arg_351_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.034

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1061"]) then
				if arg_351_1.var_.actorSpriteComps1061 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 0.5, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1061"]) and arg_351_1.var_.actorSpriteComps1061 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_351_1.var_.actorSpriteComps1061 = nil
			end

			local var_354_2 = 0
			local var_354_3 = 1.15

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(410142086).content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 46 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_4) / 46)

				if (46 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_4) / 46)) > 0 and var_354_3 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_7 and arg_351_1.time_ < var_354_2 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play410142087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 410142087
		arg_355_1.duration_ = 4.2

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play410142088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if arg_355_1.bgs_.STblack == nil then
				local var_358_0 = Object.Instantiate(arg_355_1.paintGo_)

				var_358_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_358_0.name = "STblack"
				var_358_0.transform.parent = arg_355_1.stage_.transform
				var_358_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_355_1.bgs_.STblack = var_358_0
			end

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 then
				local var_358_1 = arg_355_1.bgs_.STblack

				arg_355_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_358_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_358_2 = var_358_1:GetComponent("SpriteRenderer")

				if var_358_2 and var_358_2.sprite then
					local var_358_3 = 2 * (var_358_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_358_1.transform.localScale = Vector3.New(var_358_3 / var_358_2.sprite.bounds.size.y < var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x and var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x or var_358_3 / var_358_2.sprite.bounds.size.y, var_358_3 / var_358_2.sprite.bounds.size.y < var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x and var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x or var_358_3 / var_358_2.sprite.bounds.size.y, 0)
				end

				for iter_358_0, iter_358_1 in pairs(arg_355_1.bgs_) do
					if iter_358_0 ~= "STblack" then
						iter_358_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_358_4 = 0

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_5 = 2

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_5 then
				local var_358_6 = Color.New(0, 0, 0)

				var_358_6.a = Mathf.Lerp(0, 1, (arg_355_1.time_ - var_358_4) / var_358_5)
				arg_355_1.mask_.color = var_358_6
			end

			if arg_355_1.time_ >= var_358_4 + var_358_5 and arg_355_1.time_ < var_358_4 + var_358_5 + arg_358_0 then
				local var_358_7 = Color.New(0, 0, 0)

				var_358_7.a = 1
				arg_355_1.mask_.color = var_358_7
			end

			local var_358_8 = 2

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_9 = 2

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_9 then
				local var_358_10 = Color.New(0, 0, 0)

				var_358_10.a = Mathf.Lerp(1, 0, (arg_355_1.time_ - var_358_8) / var_358_9)
				arg_355_1.mask_.color = var_358_10
			end

			if arg_355_1.time_ >= var_358_8 + var_358_9 and arg_355_1.time_ < var_358_8 + var_358_9 + arg_358_0 then
				local var_358_11 = Color.New(0, 0, 0)

				arg_355_1.mask_.enabled = false
				var_358_11.a = 0
				arg_355_1.mask_.color = var_358_11
			end

			local var_358_12 = arg_355_1.actors_["1061"].transform

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 then
				arg_355_1.var_.moveOldPos1061 = var_358_12.localPosition
				var_358_12.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("1061", 7)

				for iter_358_2 = 0, var_358_12.childCount - 1 do
					local var_358_13 = var_358_12:GetChild(iter_358_2)

					if var_358_13.name == "" or not string.find(var_358_13.name, "split") then
						var_358_13.gameObject:SetActive(true)
					else
						var_358_13.gameObject:SetActive(false)
					end
				end
			end

			local var_358_14 = 0.001

			if 2 <= arg_355_1.time_ and arg_355_1.time_ < 2 + var_358_14 then
				var_358_12.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_355_1.time_ - 2) / var_358_14)
			end

			if arg_355_1.time_ >= 2 + var_358_14 and arg_355_1.time_ < 2 + var_358_14 + arg_358_0 then
				var_358_12.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_358_15 = arg_355_1.actors_["1061"]

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 and not isNil(var_358_15) and arg_355_1.var_.actorSpriteComps1061 == nil then
				arg_355_1.var_.actorSpriteComps1061 = var_358_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_16 = 0.034

			if 2 <= arg_355_1.time_ and arg_355_1.time_ < 2 + var_358_16 and not isNil(var_358_15) then
				if arg_355_1.var_.actorSpriteComps1061 then
					for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_358_4 then
							if arg_355_1.isInRecall_ then
								iter_358_4.color = Color.New(Mathf.Lerp(iter_358_4.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 2) / var_358_16), Mathf.Lerp(iter_358_4.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 2) / var_358_16), (Mathf.Lerp(iter_358_4.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 2) / var_358_16)))
							else
								local var_358_17 = Mathf.Lerp(iter_358_4.color.r, 0.5, (arg_355_1.time_ - 2) / var_358_16)

								iter_358_4.color = Color.New(var_358_17, var_358_17, var_358_17)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 2 + var_358_16 and arg_355_1.time_ < 2 + var_358_16 + arg_358_0 and not isNil(var_358_15) and arg_355_1.var_.actorSpriteComps1061 then
				for iter_358_5, iter_358_6 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_358_6 then
						iter_358_6.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps1061 = nil
			end

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 then
				arg_355_1.fswbg_:SetActive(true)
				arg_355_1.dialog_:SetActive(false)

				arg_355_1.fswtw_.percent = 0
				arg_355_1.fswt_.text = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(410142087).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.fswt_)

				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_355_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_355_1.fswtw_:SetDirty()

				arg_355_1.typewritterCharCountI18N = 0

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_18 = 4

			if 4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_18 + arg_358_0 then
				arg_355_1.var_.oldValueTypewriter = arg_355_1.fswtw_.percent

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_19 = 3
			local var_358_20 = 0.2
			local var_358_21, var_358_22 = arg_355_1:GetPercentByPara(arg_355_1:FormatText(arg_355_1:GetWordFromCfg(410142087).content), 1)

			if var_358_18 < arg_355_1.time_ and arg_355_1.time_ <= var_358_18 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				local var_358_23 = var_358_19 <= 0 and var_358_20 or var_358_20 * ((var_358_22 - arg_355_1.typewritterCharCountI18N) / var_358_19)

				if (var_358_19 <= 0 and var_358_20 or var_358_20 * ((var_358_22 - arg_355_1.typewritterCharCountI18N) / var_358_19)) > 0 and var_358_20 < var_358_23 then
					arg_355_1.talkMaxDuration = var_358_23

					if var_358_23 + var_358_18 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_18
					end
				end
			end

			local var_358_24 = math.max(0.2, arg_355_1.talkMaxDuration)

			if var_358_18 <= arg_355_1.time_ and arg_355_1.time_ < var_358_18 + var_358_24 then
				arg_355_1.fswtw_.percent = Mathf.Lerp(arg_355_1.var_.oldValueTypewriter, var_358_21, (arg_355_1.time_ - var_358_18) / var_358_24)
				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_355_1.fswtw_:SetDirty()
			end

			if arg_355_1.time_ >= var_358_18 + var_358_24 and arg_355_1.time_ < var_358_18 + var_358_24 + arg_358_0 then
				arg_355_1.fswtw_.percent = var_358_21

				arg_355_1.fswtw_:SetDirty()
				arg_355_1:ShowNextGo(true)

				arg_355_1.typewritterCharCountI18N = var_358_22
			end

			if 4 < arg_355_1.time_ and arg_355_1.time_ <= 4 + arg_358_0 then
				local var_358_25 = arg_355_1.fswbg_.transform:Find("textbox/adapt/content") or arg_355_1.fswbg_.transform:Find("textbox/content")
				local var_358_26 = arg_355_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_358_27 = var_358_25:GetComponent("RectTransform")

				var_358_25:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_358_27.offsetMin = Vector2.New(0, 0)
				var_358_27.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play410142088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 410142088
		arg_359_1.duration_ = 9.83

		local var_359_0 = {
			ja = 9.833,
			CriLanguages = 5.3,
			zh = 5.3
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
				arg_359_0:Play410142089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if arg_359_1.bgs_.L01f == nil then
				local var_362_0 = Object.Instantiate(arg_359_1.paintGo_)

				var_362_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_362_0.name = "L01f"
				var_362_0.transform.parent = arg_359_1.stage_.transform
				var_362_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.bgs_.L01f = var_362_0
			end

			if 2 < arg_359_1.time_ and arg_359_1.time_ <= 2 + arg_362_0 then
				local var_362_1 = arg_359_1.bgs_.L01f

				arg_359_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_362_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_362_2 = var_362_1:GetComponent("SpriteRenderer")

				if var_362_2 and var_362_2.sprite then
					local var_362_3 = 2 * (var_362_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_362_1.transform.localScale = Vector3.New(var_362_3 / var_362_2.sprite.bounds.size.y < var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x and var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x or var_362_3 / var_362_2.sprite.bounds.size.y, var_362_3 / var_362_2.sprite.bounds.size.y < var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x and var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x or var_362_3 / var_362_2.sprite.bounds.size.y, 0)
				end

				for iter_362_0, iter_362_1 in pairs(arg_359_1.bgs_) do
					if iter_362_0 ~= "L01f" then
						iter_362_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_362_4 = 0

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_5 = 2

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_5 then
				local var_362_6 = Color.New(0, 0, 0)

				var_362_6.a = Mathf.Lerp(0, 1, (arg_359_1.time_ - var_362_4) / var_362_5)
				arg_359_1.mask_.color = var_362_6
			end

			if arg_359_1.time_ >= var_362_4 + var_362_5 and arg_359_1.time_ < var_362_4 + var_362_5 + arg_362_0 then
				local var_362_7 = Color.New(0, 0, 0)

				var_362_7.a = 1
				arg_359_1.mask_.color = var_362_7
			end

			local var_362_8 = 2

			if 2 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_9 = 2

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_9 then
				local var_362_10 = Color.New(0, 0, 0)

				var_362_10.a = Mathf.Lerp(1, 0, (arg_359_1.time_ - var_362_8) / var_362_9)
				arg_359_1.mask_.color = var_362_10
			end

			if arg_359_1.time_ >= var_362_8 + var_362_9 and arg_359_1.time_ < var_362_8 + var_362_9 + arg_362_0 then
				local var_362_11 = Color.New(0, 0, 0)

				arg_359_1.mask_.enabled = false
				var_362_11.a = 0
				arg_359_1.mask_.color = var_362_11
			end

			local var_362_12 = arg_359_1.actors_["1056"].transform

			if 4 < arg_359_1.time_ and arg_359_1.time_ <= 4 + arg_362_0 then
				arg_359_1.var_.moveOldPos1056 = var_362_12.localPosition
				var_362_12.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("1056", 4)

				for iter_362_2 = 0, var_362_12.childCount - 1 do
					local var_362_13 = var_362_12:GetChild(iter_362_2)

					if var_362_13.name == "split_4" or not string.find(var_362_13.name, "split") then
						var_362_13.gameObject:SetActive(true)
					else
						var_362_13.gameObject:SetActive(false)
					end
				end
			end

			local var_362_14 = 0.001

			if 4 <= arg_359_1.time_ and arg_359_1.time_ < 4 + var_362_14 then
				var_362_12.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_359_1.time_ - 4) / var_362_14)
			end

			if arg_359_1.time_ >= 4 + var_362_14 and arg_359_1.time_ < 4 + var_362_14 + arg_362_0 then
				var_362_12.localPosition = Vector3.New(390, -350, -180)
			end

			local var_362_15 = arg_359_1.actors_["1061"].transform

			if 4 < arg_359_1.time_ and arg_359_1.time_ <= 4 + arg_362_0 then
				arg_359_1.var_.moveOldPos1061 = var_362_15.localPosition
				var_362_15.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("1061", 2)

				for iter_362_3 = 0, var_362_15.childCount - 1 do
					local var_362_16 = var_362_15:GetChild(iter_362_3)

					if var_362_16.name == "" or not string.find(var_362_16.name, "split") then
						var_362_16.gameObject:SetActive(true)
					else
						var_362_16.gameObject:SetActive(false)
					end
				end
			end

			local var_362_17 = 0.001

			if 4 <= arg_359_1.time_ and arg_359_1.time_ < 4 + var_362_17 then
				var_362_15.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_359_1.time_ - 4) / var_362_17)
			end

			if arg_359_1.time_ >= 4 + var_362_17 and arg_359_1.time_ < 4 + var_362_17 + arg_362_0 then
				var_362_15.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_362_18 = arg_359_1.actors_["1056"]

			if 4 < arg_359_1.time_ and arg_359_1.time_ <= 4 + arg_362_0 and not isNil(var_362_18) and arg_359_1.var_.actorSpriteComps1056 == nil then
				arg_359_1.var_.actorSpriteComps1056 = var_362_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_19 = 0.034

			if 4 <= arg_359_1.time_ and arg_359_1.time_ < 4 + var_362_19 and not isNil(var_362_18) then
				if arg_359_1.var_.actorSpriteComps1056 then
					for iter_362_4, iter_362_5 in pairs(arg_359_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_362_5 then
							if arg_359_1.isInRecall_ then
								iter_362_5.color = Color.New(Mathf.Lerp(iter_362_5.color.r, arg_359_1.hightColor1.r, (arg_359_1.time_ - 4) / var_362_19), Mathf.Lerp(iter_362_5.color.g, arg_359_1.hightColor1.g, (arg_359_1.time_ - 4) / var_362_19), (Mathf.Lerp(iter_362_5.color.b, arg_359_1.hightColor1.b, (arg_359_1.time_ - 4) / var_362_19)))
							else
								local var_362_20 = Mathf.Lerp(iter_362_5.color.r, 1, (arg_359_1.time_ - 4) / var_362_19)

								iter_362_5.color = Color.New(var_362_20, var_362_20, var_362_20)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 4 + var_362_19 and arg_359_1.time_ < 4 + var_362_19 + arg_362_0 and not isNil(var_362_18) and arg_359_1.var_.actorSpriteComps1056 then
				for iter_362_6, iter_362_7 in pairs(arg_359_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_362_7 then
						iter_362_7.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_359_1.var_.actorSpriteComps1056 = nil
			end

			local var_362_21 = arg_359_1.actors_["1061"]

			if 4 < arg_359_1.time_ and arg_359_1.time_ <= 4 + arg_362_0 and not isNil(var_362_21) and arg_359_1.var_.actorSpriteComps1061 == nil then
				arg_359_1.var_.actorSpriteComps1061 = var_362_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_22 = 0.034

			if 4 <= arg_359_1.time_ and arg_359_1.time_ < 4 + var_362_22 and not isNil(var_362_21) then
				if arg_359_1.var_.actorSpriteComps1061 then
					for iter_362_8, iter_362_9 in pairs(arg_359_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_362_9 then
							if arg_359_1.isInRecall_ then
								iter_362_9.color = Color.New(Mathf.Lerp(iter_362_9.color.r, arg_359_1.hightColor2.r, (arg_359_1.time_ - 4) / var_362_22), Mathf.Lerp(iter_362_9.color.g, arg_359_1.hightColor2.g, (arg_359_1.time_ - 4) / var_362_22), (Mathf.Lerp(iter_362_9.color.b, arg_359_1.hightColor2.b, (arg_359_1.time_ - 4) / var_362_22)))
							else
								local var_362_23 = Mathf.Lerp(iter_362_9.color.r, 0.5, (arg_359_1.time_ - 4) / var_362_22)

								iter_362_9.color = Color.New(var_362_23, var_362_23, var_362_23)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 4 + var_362_22 and arg_359_1.time_ < 4 + var_362_22 + arg_362_0 and not isNil(var_362_21) and arg_359_1.var_.actorSpriteComps1061 then
				for iter_362_10, iter_362_11 in pairs(arg_359_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_362_11 then
						iter_362_11.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_359_1.var_.actorSpriteComps1061 = nil
			end

			if 2 < arg_359_1.time_ and arg_359_1.time_ <= 2 + arg_362_0 then
				arg_359_1.fswbg_:SetActive(false)
				arg_359_1.dialog_:SetActive(false)
				SetActive(arg_359_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_359_1:ShowNextGo(false)
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_24 = 4
			local var_362_25 = 0.15

			if 4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_24 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_26 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_26:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_27 = arg_359_1:GetWordFromCfg(410142088)
				local var_362_28 = arg_359_1:FormatText(var_362_27.content)

				arg_359_1.text_.text = var_362_28

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_30 = 6 <= 0 and var_362_25 or var_362_25 * (utf8.len(var_362_28) / 6)

				if (6 <= 0 and var_362_25 or var_362_25 * (utf8.len(var_362_28) / 6)) > 0 and var_362_25 < var_362_30 then
					arg_359_1.talkMaxDuration = var_362_30
					var_362_24 = var_362_24 + 0.3

					if var_362_30 + var_362_24 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_30 + var_362_24
					end
				end

				arg_359_1.text_.text = var_362_28
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142088", "story_v_out_410142.awb") ~= 0 then
					local var_362_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142088", "story_v_out_410142.awb") / 1000

					if var_362_31 + var_362_24 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_31 + var_362_24
					end

					if var_362_27.prefab_name ~= "" and arg_359_1.actors_[var_362_27.prefab_name] ~= nil then
						local var_362_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_27.prefab_name].transform, "story_v_out_410142", "410142088", "story_v_out_410142.awb")

						arg_359_1:RecordAudio("410142088", var_362_32)
						arg_359_1:RecordAudio("410142088", var_362_32)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_410142", "410142088", "story_v_out_410142.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_410142", "410142088", "story_v_out_410142.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_33 = var_362_24 + 0.3
			local var_362_34 = math.max(var_362_25, arg_359_1.talkMaxDuration)

			if var_362_24 + 0.3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_33 + var_362_34 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_33) / var_362_34

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_33 + var_362_34 and arg_359_1.time_ < var_362_33 + var_362_34 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play410142089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 410142089
		arg_365_1.duration_ = 5.33

		local var_365_0 = {
			ja = 5.333,
			CriLanguages = 5,
			zh = 5
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play410142090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1061 = arg_365_1.actors_["1061"].transform.localPosition
				arg_365_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1061", 2)

				for iter_368_0 = 0, arg_365_1.actors_["1061"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["1061"].transform:GetChild(iter_368_0)

					if var_368_0.name == "" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_368_2 = arg_365_1.actors_["1061"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1061 == nil then
				arg_365_1.var_.actorSpriteComps1061 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 0.034

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps1061 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								iter_368_2.color = Color.New(Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, (arg_365_1.time_ - 0) / var_368_3), Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, (arg_365_1.time_ - 0) / var_368_3), (Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, (arg_365_1.time_ - 0) / var_368_3)))
							else
								local var_368_4 = Mathf.Lerp(iter_368_2.color.r, 1, (arg_365_1.time_ - 0) / var_368_3)

								iter_368_2.color = Color.New(var_368_4, var_368_4, var_368_4)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1061 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_368_4 then
						iter_368_4.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps1061 = nil
			end

			local var_368_5 = arg_365_1.actors_["1056"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps1056 == nil then
				arg_365_1.var_.actorSpriteComps1056 = var_368_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_6 = 0.034

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_6 and not isNil(var_368_5) then
				if arg_365_1.var_.actorSpriteComps1056 then
					for iter_368_5, iter_368_6 in pairs(arg_365_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_368_6 then
							if arg_365_1.isInRecall_ then
								iter_368_6.color = Color.New(Mathf.Lerp(iter_368_6.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_6), Mathf.Lerp(iter_368_6.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_6), (Mathf.Lerp(iter_368_6.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_6)))
							else
								local var_368_7 = Mathf.Lerp(iter_368_6.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_6)

								iter_368_6.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_6 and arg_365_1.time_ < 0 + var_368_6 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps1056 then
				for iter_368_7, iter_368_8 in pairs(arg_365_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_368_8 then
						iter_368_8.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps1056 = nil
			end

			local var_368_8 = 0
			local var_368_9 = 0.6

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:GetWordFromCfg(410142089)
				local var_368_11 = arg_365_1:FormatText(var_368_10.content)

				arg_365_1.text_.text = var_368_11

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_13 = 24 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 24)

				if (24 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 24)) > 0 and var_368_9 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_11
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142089", "story_v_out_410142.awb") ~= 0 then
					local var_368_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142089", "story_v_out_410142.awb") / 1000

					if var_368_14 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_8
					end

					if var_368_10.prefab_name ~= "" and arg_365_1.actors_[var_368_10.prefab_name] ~= nil then
						local var_368_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_10.prefab_name].transform, "story_v_out_410142", "410142089", "story_v_out_410142.awb")

						arg_365_1:RecordAudio("410142089", var_368_15)
						arg_365_1:RecordAudio("410142089", var_368_15)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_410142", "410142089", "story_v_out_410142.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_410142", "410142089", "story_v_out_410142.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_16 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_16 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_16

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_16 and arg_365_1.time_ < var_368_8 + var_368_16 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play410142090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 410142090
		arg_369_1.duration_ = 5.87

		local var_369_0 = {
			ja = 5.866,
			CriLanguages = 4.5,
			zh = 4.5
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play410142091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1056 = arg_369_1.actors_["1056"].transform.localPosition
				arg_369_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1056", 4)

				for iter_372_0 = 0, arg_369_1.actors_["1056"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["1056"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_3" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_372_2 = arg_369_1.actors_["1056"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1056 == nil then
				arg_369_1.var_.actorSpriteComps1056 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.034

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps1056 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								iter_372_2.color = Color.New(Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_2.color.r, 1, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_2.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1056 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps1056 = nil
			end

			local var_372_5 = arg_369_1.actors_["1061"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps1061 == nil then
				arg_369_1.var_.actorSpriteComps1061 = var_372_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 0.034

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_6 and not isNil(var_372_5) then
				if arg_369_1.var_.actorSpriteComps1061 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_372_6 then
							if arg_369_1.isInRecall_ then
								iter_372_6.color = Color.New(Mathf.Lerp(iter_372_6.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_6), Mathf.Lerp(iter_372_6.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_6), (Mathf.Lerp(iter_372_6.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_6)))
							else
								local var_372_7 = Mathf.Lerp(iter_372_6.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_6)

								iter_372_6.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_6 and arg_369_1.time_ < 0 + var_372_6 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps1061 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_372_8 then
						iter_372_8.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps1061 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.6

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_10 = arg_369_1:GetWordFromCfg(410142090)
				local var_372_11 = arg_369_1:FormatText(var_372_10.content)

				arg_369_1.text_.text = var_372_11

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 24 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 24)

				if (24 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 24)) > 0 and var_372_9 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_11
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142090", "story_v_out_410142.awb") ~= 0 then
					local var_372_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142090", "story_v_out_410142.awb") / 1000

					if var_372_14 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_8
					end

					if var_372_10.prefab_name ~= "" and arg_369_1.actors_[var_372_10.prefab_name] ~= nil then
						local var_372_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_10.prefab_name].transform, "story_v_out_410142", "410142090", "story_v_out_410142.awb")

						arg_369_1:RecordAudio("410142090", var_372_15)
						arg_369_1:RecordAudio("410142090", var_372_15)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_410142", "410142090", "story_v_out_410142.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_410142", "410142090", "story_v_out_410142.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_16 and arg_369_1.time_ < var_372_8 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play410142091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 410142091
		arg_373_1.duration_ = 5.4

		local var_373_0 = {
			ja = 5.4,
			CriLanguages = 2.566,
			zh = 2.566
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play410142092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1061 = arg_373_1.actors_["1061"].transform.localPosition
				arg_373_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1061", 2)

				for iter_376_0 = 0, arg_373_1.actors_["1061"].transform.childCount - 1 do
					local var_376_0 = arg_373_1.actors_["1061"].transform:GetChild(iter_376_0)

					if var_376_0.name == "" or not string.find(var_376_0.name, "split") then
						var_376_0.gameObject:SetActive(true)
					else
						var_376_0.gameObject:SetActive(false)
					end
				end
			end

			local var_376_1 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_1 then
				arg_373_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_373_1.time_ - 0) / var_376_1)
			end

			if arg_373_1.time_ >= 0 + var_376_1 and arg_373_1.time_ < 0 + var_376_1 + arg_376_0 then
				arg_373_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_376_2 = arg_373_1.actors_["1061"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1061 == nil then
				arg_373_1.var_.actorSpriteComps1061 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.034

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps1061 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_376_2 then
							if arg_373_1.isInRecall_ then
								iter_376_2.color = Color.New(Mathf.Lerp(iter_376_2.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_3), Mathf.Lerp(iter_376_2.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_3), (Mathf.Lerp(iter_376_2.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_3)))
							else
								local var_376_4 = Mathf.Lerp(iter_376_2.color.r, 1, (arg_373_1.time_ - 0) / var_376_3)

								iter_376_2.color = Color.New(var_376_4, var_376_4, var_376_4)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1061 then
				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_376_4 then
						iter_376_4.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps1061 = nil
			end

			local var_376_5 = arg_373_1.actors_["1056"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps1056 == nil then
				arg_373_1.var_.actorSpriteComps1056 = var_376_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_6 = 0.034

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_6 and not isNil(var_376_5) then
				if arg_373_1.var_.actorSpriteComps1056 then
					for iter_376_5, iter_376_6 in pairs(arg_373_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_376_6 then
							if arg_373_1.isInRecall_ then
								iter_376_6.color = Color.New(Mathf.Lerp(iter_376_6.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_6), Mathf.Lerp(iter_376_6.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_6), (Mathf.Lerp(iter_376_6.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_6)))
							else
								local var_376_7 = Mathf.Lerp(iter_376_6.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_6)

								iter_376_6.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_6 and arg_373_1.time_ < 0 + var_376_6 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps1056 then
				for iter_376_7, iter_376_8 in pairs(arg_373_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_376_8 then
						iter_376_8.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps1056 = nil
			end

			local var_376_8 = 0
			local var_376_9 = 0.35

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_10 = arg_373_1:GetWordFromCfg(410142091)
				local var_376_11 = arg_373_1:FormatText(var_376_10.content)

				arg_373_1.text_.text = var_376_11

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_13 = 14 <= 0 and var_376_9 or var_376_9 * (utf8.len(var_376_11) / 14)

				if (14 <= 0 and var_376_9 or var_376_9 * (utf8.len(var_376_11) / 14)) > 0 and var_376_9 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_8
					end
				end

				arg_373_1.text_.text = var_376_11
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142091", "story_v_out_410142.awb") ~= 0 then
					local var_376_14 = manager.audio:GetVoiceLength("story_v_out_410142", "410142091", "story_v_out_410142.awb") / 1000

					if var_376_14 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_8
					end

					if var_376_10.prefab_name ~= "" and arg_373_1.actors_[var_376_10.prefab_name] ~= nil then
						local var_376_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_10.prefab_name].transform, "story_v_out_410142", "410142091", "story_v_out_410142.awb")

						arg_373_1:RecordAudio("410142091", var_376_15)
						arg_373_1:RecordAudio("410142091", var_376_15)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_410142", "410142091", "story_v_out_410142.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_410142", "410142091", "story_v_out_410142.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_9, arg_373_1.talkMaxDuration)

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_8) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_8 + var_376_16 and arg_373_1.time_ < var_376_8 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play410142092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 410142092
		arg_377_1.duration_ = 9.3

		local var_377_0 = {
			ja = 7.266,
			CriLanguages = 9.3,
			zh = 9.3
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play410142093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1061 = arg_377_1.actors_["1061"].transform.localPosition
				arg_377_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1061", 2)

				for iter_380_0 = 0, arg_377_1.actors_["1061"].transform.childCount - 1 do
					local var_380_0 = arg_377_1.actors_["1061"].transform:GetChild(iter_380_0)

					if var_380_0.name == "split_5" or not string.find(var_380_0.name, "split") then
						var_380_0.gameObject:SetActive(true)
					else
						var_380_0.gameObject:SetActive(false)
					end
				end
			end

			local var_380_1 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_1 then
				arg_377_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_377_1.time_ - 0) / var_380_1)
			end

			if arg_377_1.time_ >= 0 + var_380_1 and arg_377_1.time_ < 0 + var_380_1 + arg_380_0 then
				arg_377_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_380_2 = arg_377_1.actors_["1061"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps1061 == nil then
				arg_377_1.var_.actorSpriteComps1061 = var_380_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_3 = 0.034

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 and not isNil(var_380_2) then
				if arg_377_1.var_.actorSpriteComps1061 then
					for iter_380_1, iter_380_2 in pairs(arg_377_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_380_2 then
							if arg_377_1.isInRecall_ then
								iter_380_2.color = Color.New(Mathf.Lerp(iter_380_2.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_3), Mathf.Lerp(iter_380_2.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_3), (Mathf.Lerp(iter_380_2.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_3)))
							else
								local var_380_4 = Mathf.Lerp(iter_380_2.color.r, 1, (arg_377_1.time_ - 0) / var_380_3)

								iter_380_2.color = Color.New(var_380_4, var_380_4, var_380_4)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps1061 then
				for iter_380_3, iter_380_4 in pairs(arg_377_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_380_4 then
						iter_380_4.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps1061 = nil
			end

			local var_380_5 = 0
			local var_380_6 = 0.95

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:GetWordFromCfg(410142092)
				local var_380_8 = arg_377_1:FormatText(var_380_7.content)

				arg_377_1.text_.text = var_380_8

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 38 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 38)

				if (38 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 38)) > 0 and var_380_6 < var_380_10 then
					arg_377_1.talkMaxDuration = var_380_10

					if var_380_10 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_8
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142092", "story_v_out_410142.awb") ~= 0 then
					local var_380_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142092", "story_v_out_410142.awb") / 1000

					if var_380_11 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_11 + var_380_5
					end

					if var_380_7.prefab_name ~= "" and arg_377_1.actors_[var_380_7.prefab_name] ~= nil then
						local var_380_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_7.prefab_name].transform, "story_v_out_410142", "410142092", "story_v_out_410142.awb")

						arg_377_1:RecordAudio("410142092", var_380_12)
						arg_377_1:RecordAudio("410142092", var_380_12)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_410142", "410142092", "story_v_out_410142.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_410142", "410142092", "story_v_out_410142.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_13 = math.max(var_380_6, arg_377_1.talkMaxDuration)

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_13 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_5) / var_380_13

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_5 + var_380_13 and arg_377_1.time_ < var_380_5 + var_380_13 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play410142093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 410142093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play410142094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1056 = arg_381_1.actors_["1056"].transform.localPosition
				arg_381_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1056", 7)

				for iter_384_0 = 0, arg_381_1.actors_["1056"].transform.childCount - 1 do
					local var_384_0 = arg_381_1.actors_["1056"].transform:GetChild(iter_384_0)

					if var_384_0.name == "" or not string.find(var_384_0.name, "split") then
						var_384_0.gameObject:SetActive(true)
					else
						var_384_0.gameObject:SetActive(false)
					end
				end
			end

			local var_384_1 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				arg_381_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_381_1.time_ - 0) / var_384_1)
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 then
				arg_381_1.actors_["1056"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_384_2 = arg_381_1.actors_["1061"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1061 = var_384_2.localPosition
				var_384_2.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1061", 7)

				for iter_384_1 = 0, var_384_2.childCount - 1 do
					local var_384_3 = var_384_2:GetChild(iter_384_1)

					if var_384_3.name == "" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				var_384_2.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_381_1.time_ - 0) / var_384_4)
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				var_384_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_384_5 = arg_381_1.actors_["1056"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.actorSpriteComps1056 == nil then
				arg_381_1.var_.actorSpriteComps1056 = var_384_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_6 = 0.034

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_6 and not isNil(var_384_5) then
				if arg_381_1.var_.actorSpriteComps1056 then
					for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_384_3 then
							if arg_381_1.isInRecall_ then
								iter_384_3.color = Color.New(Mathf.Lerp(iter_384_3.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_6), Mathf.Lerp(iter_384_3.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_6), (Mathf.Lerp(iter_384_3.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_6)))
							else
								local var_384_7 = Mathf.Lerp(iter_384_3.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_6)

								iter_384_3.color = Color.New(var_384_7, var_384_7, var_384_7)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_6 and arg_381_1.time_ < 0 + var_384_6 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.actorSpriteComps1056 then
				for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_384_5 then
						iter_384_5.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1056 = nil
			end

			local var_384_8 = arg_381_1.actors_["1061"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_8) and arg_381_1.var_.actorSpriteComps1061 == nil then
				arg_381_1.var_.actorSpriteComps1061 = var_384_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_9 = 0.034

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_9 and not isNil(var_384_8) then
				if arg_381_1.var_.actorSpriteComps1061 then
					for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_384_7 then
							if arg_381_1.isInRecall_ then
								iter_384_7.color = Color.New(Mathf.Lerp(iter_384_7.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_9), Mathf.Lerp(iter_384_7.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_9), (Mathf.Lerp(iter_384_7.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_9)))
							else
								local var_384_10 = Mathf.Lerp(iter_384_7.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_9)

								iter_384_7.color = Color.New(var_384_10, var_384_10, var_384_10)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_9 and arg_381_1.time_ < 0 + var_384_9 + arg_384_0 and not isNil(var_384_8) and arg_381_1.var_.actorSpriteComps1061 then
				for iter_384_8, iter_384_9 in pairs(arg_381_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_384_9 then
						iter_384_9.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1061 = nil
			end

			local var_384_11 = 0
			local var_384_12 = 0.95

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_11 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_13 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(410142093).content)

				arg_381_1.text_.text = var_384_13

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_15 = 38 <= 0 and var_384_12 or var_384_12 * (utf8.len(var_384_13) / 38)

				if (38 <= 0 and var_384_12 or var_384_12 * (utf8.len(var_384_13) / 38)) > 0 and var_384_12 < var_384_15 then
					arg_381_1.talkMaxDuration = var_384_15

					if var_384_15 + var_384_11 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_15 + var_384_11
					end
				end

				arg_381_1.text_.text = var_384_13
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_12, arg_381_1.talkMaxDuration)

			if var_384_11 <= arg_381_1.time_ and arg_381_1.time_ < var_384_11 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_11) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_11 + var_384_16 and arg_381_1.time_ < var_384_11 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play410142094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 410142094
		arg_385_1.duration_ = 13.83

		local var_385_0 = {
			ja = 2.3,
			CriLanguages = 13.833,
			zh = 13.833
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play410142095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1061 = arg_385_1.actors_["1061"].transform.localPosition
				arg_385_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1061", 3)

				for iter_388_0 = 0, arg_385_1.actors_["1061"].transform.childCount - 1 do
					local var_388_0 = arg_385_1.actors_["1061"].transform:GetChild(iter_388_0)

					if var_388_0.name == "" or not string.find(var_388_0.name, "split") then
						var_388_0.gameObject:SetActive(true)
					else
						var_388_0.gameObject:SetActive(false)
					end
				end
			end

			local var_388_1 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_1 then
				arg_385_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_385_1.time_ - 0) / var_388_1)
			end

			if arg_385_1.time_ >= 0 + var_388_1 and arg_385_1.time_ < 0 + var_388_1 + arg_388_0 then
				arg_385_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_388_2 = arg_385_1.actors_["1061"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps1061 == nil then
				arg_385_1.var_.actorSpriteComps1061 = var_388_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_3 = 0.034

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.actorSpriteComps1061 then
					for iter_388_1, iter_388_2 in pairs(arg_385_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_388_2 then
							if arg_385_1.isInRecall_ then
								iter_388_2.color = Color.New(Mathf.Lerp(iter_388_2.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_3), Mathf.Lerp(iter_388_2.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_3), (Mathf.Lerp(iter_388_2.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_3)))
							else
								local var_388_4 = Mathf.Lerp(iter_388_2.color.r, 1, (arg_385_1.time_ - 0) / var_388_3)

								iter_388_2.color = Color.New(var_388_4, var_388_4, var_388_4)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps1061 then
				for iter_388_3, iter_388_4 in pairs(arg_385_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_388_4 then
						iter_388_4.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps1061 = nil
			end

			local var_388_5 = 0
			local var_388_6 = 0.05

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:GetWordFromCfg(410142094)
				local var_388_8 = arg_385_1:FormatText(var_388_7.content)

				arg_385_1.text_.text = var_388_8

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 2 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 2)

				if (2 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 2)) > 0 and var_388_6 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_8
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142094", "story_v_out_410142.awb") ~= 0 then
					local var_388_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142094", "story_v_out_410142.awb") / 1000

					if var_388_11 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_11 + var_388_5
					end

					if var_388_7.prefab_name ~= "" and arg_385_1.actors_[var_388_7.prefab_name] ~= nil then
						local var_388_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_7.prefab_name].transform, "story_v_out_410142", "410142094", "story_v_out_410142.awb")

						arg_385_1:RecordAudio("410142094", var_388_12)
						arg_385_1:RecordAudio("410142094", var_388_12)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_410142", "410142094", "story_v_out_410142.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_410142", "410142094", "story_v_out_410142.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_13 and arg_385_1.time_ < var_388_5 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play410142095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 410142095
		arg_389_1.duration_ = 10.9

		local var_389_0 = {
			ja = 10.9,
			CriLanguages = 5.4,
			zh = 5.4
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play410142096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1061 = arg_389_1.actors_["1061"].transform.localPosition
				arg_389_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1061", 3)

				for iter_392_0 = 0, arg_389_1.actors_["1061"].transform.childCount - 1 do
					local var_392_0 = arg_389_1.actors_["1061"].transform:GetChild(iter_392_0)

					if var_392_0.name == "split_2" or not string.find(var_392_0.name, "split") then
						var_392_0.gameObject:SetActive(true)
					else
						var_392_0.gameObject:SetActive(false)
					end
				end
			end

			local var_392_1 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_1 then
				arg_389_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_389_1.time_ - 0) / var_392_1)
			end

			if arg_389_1.time_ >= 0 + var_392_1 and arg_389_1.time_ < 0 + var_392_1 + arg_392_0 then
				arg_389_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_392_2 = arg_389_1.actors_["1061"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps1061 == nil then
				arg_389_1.var_.actorSpriteComps1061 = var_392_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_3 = 0.034

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.actorSpriteComps1061 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								iter_392_2.color = Color.New(Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_3), Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_3), (Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_3)))
							else
								local var_392_4 = Mathf.Lerp(iter_392_2.color.r, 1, (arg_389_1.time_ - 0) / var_392_3)

								iter_392_2.color = Color.New(var_392_4, var_392_4, var_392_4)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps1061 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_392_4 then
						iter_392_4.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps1061 = nil
			end

			local var_392_5 = 0
			local var_392_6 = 0.55

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:GetWordFromCfg(410142095)
				local var_392_8 = arg_389_1:FormatText(var_392_7.content)

				arg_389_1.text_.text = var_392_8

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 22 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 22)

				if (22 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 22)) > 0 and var_392_6 < var_392_10 then
					arg_389_1.talkMaxDuration = var_392_10

					if var_392_10 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_8
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142095", "story_v_out_410142.awb") ~= 0 then
					local var_392_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142095", "story_v_out_410142.awb") / 1000

					if var_392_11 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_11 + var_392_5
					end

					if var_392_7.prefab_name ~= "" and arg_389_1.actors_[var_392_7.prefab_name] ~= nil then
						local var_392_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_7.prefab_name].transform, "story_v_out_410142", "410142095", "story_v_out_410142.awb")

						arg_389_1:RecordAudio("410142095", var_392_12)
						arg_389_1:RecordAudio("410142095", var_392_12)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_410142", "410142095", "story_v_out_410142.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_410142", "410142095", "story_v_out_410142.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_13 and arg_389_1.time_ < var_392_5 + var_392_13 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play410142096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 410142096
		arg_393_1.duration_ = 11.07

		local var_393_0 = {
			ja = 11.066,
			CriLanguages = 7.6,
			zh = 7.6
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play410142097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1061 = arg_393_1.actors_["1061"].transform.localPosition
				arg_393_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1061", 3)

				for iter_396_0 = 0, arg_393_1.actors_["1061"].transform.childCount - 1 do
					local var_396_0 = arg_393_1.actors_["1061"].transform:GetChild(iter_396_0)

					if var_396_0.name == "split_2" or not string.find(var_396_0.name, "split") then
						var_396_0.gameObject:SetActive(true)
					else
						var_396_0.gameObject:SetActive(false)
					end
				end
			end

			local var_396_1 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_1 then
				arg_393_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_393_1.time_ - 0) / var_396_1)
			end

			if arg_393_1.time_ >= 0 + var_396_1 and arg_393_1.time_ < 0 + var_396_1 + arg_396_0 then
				arg_393_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_396_2 = arg_393_1.actors_["1061"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1061 == nil then
				arg_393_1.var_.actorSpriteComps1061 = var_396_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_3 = 0.034

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_3 and not isNil(var_396_2) then
				if arg_393_1.var_.actorSpriteComps1061 then
					for iter_396_1, iter_396_2 in pairs(arg_393_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_396_2 then
							if arg_393_1.isInRecall_ then
								iter_396_2.color = Color.New(Mathf.Lerp(iter_396_2.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_3), Mathf.Lerp(iter_396_2.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_3), (Mathf.Lerp(iter_396_2.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_3)))
							else
								local var_396_4 = Mathf.Lerp(iter_396_2.color.r, 1, (arg_393_1.time_ - 0) / var_396_3)

								iter_396_2.color = Color.New(var_396_4, var_396_4, var_396_4)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_3 and arg_393_1.time_ < 0 + var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1061 then
				for iter_396_3, iter_396_4 in pairs(arg_393_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_396_4 then
						iter_396_4.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1061 = nil
			end

			local var_396_5 = 0
			local var_396_6 = 0.675

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_7 = arg_393_1:GetWordFromCfg(410142096)
				local var_396_8 = arg_393_1:FormatText(var_396_7.content)

				arg_393_1.text_.text = var_396_8

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 27 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 27)

				if (27 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 27)) > 0 and var_396_6 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_8
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142096", "story_v_out_410142.awb") ~= 0 then
					local var_396_11 = manager.audio:GetVoiceLength("story_v_out_410142", "410142096", "story_v_out_410142.awb") / 1000

					if var_396_11 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_5
					end

					if var_396_7.prefab_name ~= "" and arg_393_1.actors_[var_396_7.prefab_name] ~= nil then
						local var_396_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_7.prefab_name].transform, "story_v_out_410142", "410142096", "story_v_out_410142.awb")

						arg_393_1:RecordAudio("410142096", var_396_12)
						arg_393_1:RecordAudio("410142096", var_396_12)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_410142", "410142096", "story_v_out_410142.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_410142", "410142096", "story_v_out_410142.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_6, arg_393_1.talkMaxDuration)

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_5) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_5 + var_396_13 and arg_393_1.time_ < var_396_5 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play410142097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 410142097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play410142098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1061"]) and arg_397_1.var_.actorSpriteComps1061 == nil then
				arg_397_1.var_.actorSpriteComps1061 = arg_397_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.034

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1061"]) then
				if arg_397_1.var_.actorSpriteComps1061 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								iter_400_1.color = Color.New(Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_0), Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_0), (Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_0)))
							else
								local var_400_1 = Mathf.Lerp(iter_400_1.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_0)

								iter_400_1.color = Color.New(var_400_1, var_400_1, var_400_1)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1061"]) and arg_397_1.var_.actorSpriteComps1061 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1061 = nil
			end

			local var_400_2 = 0
			local var_400_3 = 0.575

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(410142097).content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 23 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 23)

				if (23 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 23)) > 0 and var_400_3 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_7 and arg_397_1.time_ < var_400_2 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play410142098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 410142098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
			arg_401_1.auto_ = false
		end

		function arg_401_1.playNext_(arg_403_0)
			arg_401_1.onStoryFinished_()
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.85

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(410142098).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 34 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 34)

				if (34 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 34)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST65",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L01f"
	},
	voices = {
		"story_v_out_410142.awb"
	}
}
