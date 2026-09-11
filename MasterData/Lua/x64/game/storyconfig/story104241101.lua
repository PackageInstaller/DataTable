return {
	Play424111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0115a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115a")
				var_4_0.name = "ST0115a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0115a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0115a

				arg_1_1.bgs_.ST0115a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0115a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_146", "se_story_146_wind02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(424111001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 11 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 11)

				if (11 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 11)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424111002
		arg_9_1.duration_ = 8.3

		local var_9_0 = {
			zh = 5.833,
			ja = 8.3
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
				arg_9_0:Play424111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10155"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10155"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10155"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10155"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10155 == nil then
				arg_9_1.var_.actorSpriteComps10155 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10155 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								iter_12_3.color = Color.New(Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_3.color.r, 1, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_3.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10155 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10155 = nil
			end

			local var_12_5 = arg_9_1.actors_["10155"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10155 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10155", 3)

				for iter_12_6 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_6)

					if var_12_6.name == "split_6" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-40, -390, -250)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["10155"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue10155 = var_12_8.alpha
					arg_9_1.var_.characterEffect10155 = var_12_8
				end

				arg_9_1.var_.alphaOldValue10155 = 0
			end

			local var_12_9 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect10155 then
					arg_9_1.var_.characterEffect10155.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10155, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10155 then
				arg_9_1.var_.characterEffect10155.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(424111002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 13 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 13)

				if (13 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 13)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111002", "story_v_out_424111.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_424111", "424111002", "story_v_out_424111.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_424111", "424111002", "story_v_out_424111.awb")

						arg_9_1:RecordAudio("424111002", var_12_17)
						arg_9_1:RecordAudio("424111002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424111", "424111002", "story_v_out_424111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424111", "424111002", "story_v_out_424111.awb")
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
				actorName = "10155",
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
	Play424111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10155"]) and arg_13_1.var_.actorSpriteComps10155 == nil then
				arg_13_1.var_.actorSpriteComps10155 = arg_13_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10155"]) then
				if arg_13_1.var_.actorSpriteComps10155 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10155"]) and arg_13_1.var_.actorSpriteComps10155 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10155 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 1.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_4 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(424111003).content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 51 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 51)

				if (51 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 51)) > 0 and var_16_3 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_7 and arg_13_1.time_ < var_16_2 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play424111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424111004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play424111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(424111004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 58 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 58)

				if (58 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 58)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play424111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424111005
		arg_21_1.duration_ = 4.3

		local var_21_0 = {
			zh = 3.7,
			ja = 4.3
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
				arg_21_0:Play424111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.475

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(424111005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 19 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 19)

				if (19 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 19)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111005", "story_v_out_424111.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111005", "story_v_out_424111.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_424111", "424111005", "story_v_out_424111.awb")

						arg_21_1:RecordAudio("424111005", var_24_6)
						arg_21_1:RecordAudio("424111005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424111", "424111005", "story_v_out_424111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424111", "424111005", "story_v_out_424111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play424111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424111006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play424111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(424111006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 19)

				if (19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 19)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play424111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424111007
		arg_29_1.duration_ = 16.57

		local var_29_0 = {
			zh = 8.333,
			ja = 16.566
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
				arg_29_0:Play424111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10155"]) and arg_29_1.var_.actorSpriteComps10155 == nil then
				arg_29_1.var_.actorSpriteComps10155 = arg_29_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10155"]) then
				if arg_29_1.var_.actorSpriteComps10155 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10155"]) and arg_29_1.var_.actorSpriteComps10155 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10155 = nil
			end

			local var_32_2 = arg_29_1.actors_["10155"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10155 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10155", 3)

				for iter_32_4 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_4)

					if var_32_3.name == "split_6" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_32_5 = 0
			local var_32_6 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(424111007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 23 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 23)

				if (23 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 23)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111007", "story_v_out_424111.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111007", "story_v_out_424111.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_424111", "424111007", "story_v_out_424111.awb")

						arg_29_1:RecordAudio("424111007", var_32_12)
						arg_29_1:RecordAudio("424111007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_424111", "424111007", "story_v_out_424111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_424111", "424111007", "story_v_out_424111.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play424111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424111008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play424111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10155"]) and arg_33_1.var_.actorSpriteComps10155 == nil then
				arg_33_1.var_.actorSpriteComps10155 = arg_33_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10155"]) then
				if arg_33_1.var_.actorSpriteComps10155 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10155"]) and arg_33_1.var_.actorSpriteComps10155 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10155 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.7

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(424111008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 28 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 28)

				if (28 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 28)) > 0 and var_36_3 < var_36_6 then
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

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play424111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424111009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play424111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10155 = arg_37_1.actors_["10155"].transform.localPosition
				arg_37_1.actors_["10155"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10155", 7)

				for iter_40_0 = 0, arg_37_1.actors_["10155"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10155"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10155"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10155"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_2 = 0
			local var_40_3 = 1.5

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

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(424111009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 60 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 60)

				if (60 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 60)) > 0 and var_40_3 < var_40_6 then
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

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424111010
		arg_41_1.duration_ = 6.27

		local var_41_0 = {
			zh = 3.933,
			ja = 6.266
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
				arg_41_0:Play424111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10155"]) and arg_41_1.var_.actorSpriteComps10155 == nil then
				arg_41_1.var_.actorSpriteComps10155 = arg_41_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10155"]) then
				if arg_41_1.var_.actorSpriteComps10155 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10155"]) and arg_41_1.var_.actorSpriteComps10155 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10155 = nil
			end

			local var_44_2 = arg_41_1.actors_["10155"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10155 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10155", 2)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "split_6" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_44_5 = 0
			local var_44_6 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(424111010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 13 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 13)

				if (13 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 13)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111010", "story_v_out_424111.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111010", "story_v_out_424111.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_424111", "424111010", "story_v_out_424111.awb")

						arg_41_1:RecordAudio("424111010", var_44_12)
						arg_41_1:RecordAudio("424111010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_424111", "424111010", "story_v_out_424111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_424111", "424111010", "story_v_out_424111.awb")
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
				actorName = "10155",
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
	Play424111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424111011
		arg_45_1.duration_ = 4.23

		local var_45_0 = {
			zh = 3.433,
			ja = 4.233
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
				arg_45_0:Play424111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["1094"] == nil then
				local var_48_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_48_0) then
					local var_48_1 = Object.Instantiate(var_48_0, arg_45_1.canvasGo_.transform)

					var_48_1.transform:SetSiblingIndex(1)

					var_48_1.name = "1094"
					var_48_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_45_1.actors_["1094"] = var_48_1

					if arg_45_1.isInRecall_ then
						for iter_48_0, iter_48_1 in ipairs((var_48_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_48_1.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_48_2 = arg_45_1.actors_["1094"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1094 == nil then
				arg_45_1.var_.actorSpriteComps1094 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps1094 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								iter_48_3.color = Color.New(Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_3.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_3.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1094 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_48_5 then
						iter_48_5.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1094 = nil
			end

			local var_48_5 = arg_45_1.actors_["10155"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10155 == nil then
				arg_45_1.var_.actorSpriteComps10155 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps10155 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								iter_48_7.color = Color.New(Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_7.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_7.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10155 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_48_9 then
						iter_48_9.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10155 = nil
			end

			local var_48_8 = arg_45_1.actors_["1094"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1094 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1094", 4)

				for iter_48_10 = 0, var_48_8.childCount - 1 do
					local var_48_9 = var_48_8:GetChild(iter_48_10)

					if var_48_9.name == "" or not string.find(var_48_9.name, "split") then
						var_48_9.gameObject:SetActive(true)
					else
						var_48_9.gameObject:SetActive(false)
					end
				end
			end

			local var_48_10 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_10 then
				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_45_1.time_ - 0) / var_48_10)
			end

			if arg_45_1.time_ >= 0 + var_48_10 and arg_45_1.time_ < 0 + var_48_10 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_48_11 = 0
			local var_48_12 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(424111011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 11 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 11)

				if (11 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 11)) > 0 and var_48_12 < var_48_16 then
					arg_45_1.talkMaxDuration = var_48_16

					if var_48_16 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111011", "story_v_out_424111.awb") ~= 0 then
					local var_48_17 = manager.audio:GetVoiceLength("story_v_out_424111", "424111011", "story_v_out_424111.awb") / 1000

					if var_48_17 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_11
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_424111", "424111011", "story_v_out_424111.awb")

						arg_45_1:RecordAudio("424111011", var_48_18)
						arg_45_1:RecordAudio("424111011", var_48_18)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424111", "424111011", "story_v_out_424111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424111", "424111011", "story_v_out_424111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_19 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_19 and arg_45_1.time_ < var_48_11 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424111012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play424111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1094"]) and arg_49_1.var_.actorSpriteComps1094 == nil then
				arg_49_1.var_.actorSpriteComps1094 = arg_49_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1094"]) then
				if arg_49_1.var_.actorSpriteComps1094 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1094"]) and arg_49_1.var_.actorSpriteComps1094 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1094 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.975

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(424111012).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 39 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 39)

				if (39 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 39)) > 0 and var_52_3 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_7 and arg_49_1.time_ < var_52_2 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play424111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424111013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play424111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1094 = arg_53_1.actors_["1094"].transform.localPosition
				arg_53_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1094", 7)

				for iter_56_0 = 0, arg_53_1.actors_["1094"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1094"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_2 = arg_53_1.actors_["10155"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10155 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10155", 7)

				for iter_56_1 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_1)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_53_1.time_ and arg_53_1.time_ <= 0.1 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data01", "")
			end

			local var_56_6 = 0
			local var_56_7 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(424111013).content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 33 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_8) / 33)

				if (33 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_8) / 33)) > 0 and var_56_7 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_11 and arg_53_1.time_ < var_56_6 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424111014
		arg_57_1.duration_ = 9

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play424111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.bgs_.ST0116a == nil then
				local var_60_0 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116a")
				var_60_0.name = "ST0116a"
				var_60_0.transform.parent = arg_57_1.stage_.transform
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_.ST0116a = var_60_0
			end

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				local var_60_1 = arg_57_1.bgs_.ST0116a

				arg_57_1.bgs_.ST0116a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_2 = var_60_1:GetComponent("SpriteRenderer")

				if var_60_2 and var_60_2.sprite then
					local var_60_3 = 2 * (var_60_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_1.transform.localScale = Vector3.New(var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST0116a" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_4 = 3.999999999999

			if 3.999999999999 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_4 + 0.3 and arg_57_1.time_ < var_60_4 + 0.3 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_5 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_6 = 2

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 then
				local var_60_7 = Color.New(0, 0, 0)

				var_60_7.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_5) / var_60_6)
				arg_57_1.mask_.color = var_60_7
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 then
				local var_60_8 = Color.New(0, 0, 0)

				var_60_8.a = 1
				arg_57_1.mask_.color = var_60_8
			end

			local var_60_9 = 2

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_10 = 2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 then
				local var_60_11 = Color.New(0, 0, 0)

				var_60_11.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_9) / var_60_10)
				arg_57_1.mask_.color = var_60_11
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 then
				local var_60_12 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_12.a = 0
				arg_57_1.mask_.color = var_60_12
			end

			if 0.233333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.233333333333333 + arg_60_0 then
				arg_57_1:AudioAction("stop", "effect", "se_story_146", "se_story_146_wind02", "")
			end

			if 1.66666666666667 < arg_57_1.time_ and arg_57_1.time_ <= 1.66666666666667 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_15 = 3.999999999999
			local var_60_16 = 1.4

			if 3.999999999999 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_17 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_17:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(424111014).content)

				arg_57_1.text_.text = var_60_18

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 56 <= 0 and var_60_16 or var_60_16 * (utf8.len(var_60_18) / 56)

				if (56 <= 0 and var_60_16 or var_60_16 * (utf8.len(var_60_18) / 56)) > 0 and var_60_16 < var_60_20 then
					arg_57_1.talkMaxDuration = var_60_20
					var_60_15 = var_60_15 + 0.3

					if var_60_20 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_18
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = var_60_15 + 0.3
			local var_60_22 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_22 and arg_57_1.time_ < var_60_21 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play424111015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 424111015
		arg_63_1.duration_ = 1.17

		local var_63_0 = {
			zh = 1,
			ja = 1.166
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play424111016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1094"]) and arg_63_1.var_.actorSpriteComps1094 == nil then
				arg_63_1.var_.actorSpriteComps1094 = arg_63_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1094"]) then
				if arg_63_1.var_.actorSpriteComps1094 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 1, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1094"]) and arg_63_1.var_.actorSpriteComps1094 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps1094 = nil
			end

			local var_66_2 = arg_63_1.actors_["1094"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1094 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1094", 3)

				for iter_66_4 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_4)

					if var_66_3.name == "split_1" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(0, -335, -230)
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_5 = arg_63_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_66_5 then
					arg_63_1.var_.alphaOldValue1094 = var_66_5.alpha
					arg_63_1.var_.characterEffect1094 = var_66_5
				end

				arg_63_1.var_.alphaOldValue1094 = 0
			end

			local var_66_6 = 0.5

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 then
				if arg_63_1.var_.characterEffect1094 then
					arg_63_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_63_1.var_.alphaOldValue1094, 1, (arg_63_1.time_ - 0) / var_66_6)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and arg_63_1.var_.characterEffect1094 then
				arg_63_1.var_.characterEffect1094.alpha = 1
			end

			local var_66_7 = 0
			local var_66_8 = 0.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_9 = arg_63_1:GetWordFromCfg(424111015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_12 = 3 <= 0 and var_66_8 or var_66_8 * (utf8.len(var_66_10) / 3)

				if (3 <= 0 and var_66_8 or var_66_8 * (utf8.len(var_66_10) / 3)) > 0 and var_66_8 < var_66_12 then
					arg_63_1.talkMaxDuration = var_66_12

					if var_66_12 + var_66_7 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_7
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111015", "story_v_out_424111.awb") ~= 0 then
					local var_66_13 = manager.audio:GetVoiceLength("story_v_out_424111", "424111015", "story_v_out_424111.awb") / 1000

					if var_66_13 + var_66_7 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_7
					end

					if var_66_9.prefab_name ~= "" and arg_63_1.actors_[var_66_9.prefab_name] ~= nil then
						local var_66_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_9.prefab_name].transform, "story_v_out_424111", "424111015", "story_v_out_424111.awb")

						arg_63_1:RecordAudio("424111015", var_66_14)
						arg_63_1:RecordAudio("424111015", var_66_14)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_424111", "424111015", "story_v_out_424111.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_424111", "424111015", "story_v_out_424111.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_15 = math.max(var_66_8, arg_63_1.talkMaxDuration)

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_15 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_7) / var_66_15

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_7 + var_66_15 and arg_63_1.time_ < var_66_7 + var_66_15 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play424111016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 424111016
		arg_67_1.duration_ = 1.8

		local var_67_0 = {
			zh = 1.8,
			ja = 1.7
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
				arg_67_0:Play424111017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1094"]) and arg_67_1.var_.actorSpriteComps1094 == nil then
				arg_67_1.var_.actorSpriteComps1094 = arg_67_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1094"]) then
				if arg_67_1.var_.actorSpriteComps1094 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								iter_70_1.color = Color.New(Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_0), Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_0), (Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_0)))
							else
								local var_70_1 = Mathf.Lerp(iter_70_1.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_0)

								iter_70_1.color = Color.New(var_70_1, var_70_1, var_70_1)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1094"]) and arg_67_1.var_.actorSpriteComps1094 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1094 = nil
			end

			local var_70_2 = 0
			local var_70_3 = 0.2

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_4 = arg_67_1:GetWordFromCfg(424111016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 8 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 8)

				if (8 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 8)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111016", "story_v_out_424111.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111016", "story_v_out_424111.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_424111", "424111016", "story_v_out_424111.awb")

						arg_67_1:RecordAudio("424111016", var_70_9)
						arg_67_1:RecordAudio("424111016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_424111", "424111016", "story_v_out_424111.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_424111", "424111016", "story_v_out_424111.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play424111017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 424111017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play424111018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094 = arg_71_1.actors_["1094"].transform.localPosition
				arg_71_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1094", 7)

				for iter_74_0 = 0, arg_71_1.actors_["1094"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["1094"].transform:GetChild(iter_74_0)

					if var_74_0.name == "" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_74_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_4 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_4

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_4
						arg_71_1.bgmTxt2_.text = var_74_4
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.35 < arg_71_1.time_ and arg_71_1.time_ <= 0.35 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle.awb")

				local var_74_7 = manager.audio:GetAudioName("bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_7 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_7

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_7
						arg_71_1.bgmTxt2_.text = var_74_7
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_8 = 0
			local var_74_9 = 1.35

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(424111017).content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 54 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_10) / 54)

				if (54 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_10) / 54)) > 0 and var_74_9 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_13 and arg_71_1.time_ < var_74_8 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424111018
		arg_77_1.duration_ = 6.73

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play424111019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_9000

			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= 0.5 + arg_80_0 then
				local var_80_0 = arg_77_1.var_.effectchidunhongzha1

				if not arg_77_1.var_.effectchidunhongzha1 then
					var_80_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_80_0.name = "chidunhongzha1"
					arg_77_1.var_.effectchidunhongzha1 = var_80_0
				else
					var_80_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_80_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_80_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_80_0, iter_80_1 in ipairs((var_80_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_80_1.transform.localScale = Vector3.New(iter_80_1.transform.localScale.x / var_80_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_80_1.transform.localScale.y / var_80_2, iter_80_1.transform.localScale.z)
				end
			end

			if 2.5 < arg_77_1.time_ and arg_77_1.time_ <= 2.5 + arg_80_0 then
				if arg_77_1.var_.effectchidunhongzha1 then
					Object.Destroy(arg_77_1.var_.effectchidunhongzha1)

					arg_77_1.var_.effectchidunhongzha1 = nil
				end
			end

			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= 0.5 + arg_80_0 then
				local var_80_5 = arg_77_1.var_.effectchidunhongzha2

				if not arg_77_1.var_.effectchidunhongzha2 then
					var_80_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan_violet"), manager.ui.mainCamera.transform)
					var_80_5.name = "chidunhongzha2"
					arg_77_1.var_.effectchidunhongzha2 = var_80_5
				else
					var_80_5.transform:SetParent(var_80_9000)
				end

				var_80_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_80_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_80_2, iter_80_3 in ipairs((var_80_5.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_80_3.transform.localScale = Vector3.New(iter_80_3.transform.localScale.x / var_80_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_80_3.transform.localScale.y / var_80_7, iter_80_3.transform.localScale.z)
				end
			end

			local var_80_9 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_9 + 1.83333333333333 and arg_77_1.time_ < var_80_9 + 1.83333333333333 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			if 0.1 < arg_77_1.time_ and arg_77_1.time_ <= 0.1 + arg_80_0 then
				arg_77_1:AudioAction("play", "effect", "se_story_16", "se_story_16_energy02", "")
			end

			local var_80_11 = "ST0117"

			if arg_77_1.bgs_.ST0117 == nil then
				local var_80_12 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_11)
				var_80_12.name = var_80_11
				var_80_12.transform.parent = arg_77_1.stage_.transform
				var_80_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_11] = var_80_12
			end

			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= 0.5 + arg_80_0 then
				local var_80_13 = arg_77_1.bgs_.ST0117

				arg_77_1.bgs_.ST0117.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_14 = var_80_13:GetComponent("SpriteRenderer")

				if var_80_14 and var_80_14.sprite then
					local var_80_15 = 2 * (var_80_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_13.transform.localScale = Vector3.New(var_80_15 / var_80_14.sprite.bounds.size.y < var_80_15 * manager.ui.mainCameraCom_.aspect / var_80_14.sprite.bounds.size.x and var_80_15 * manager.ui.mainCameraCom_.aspect / var_80_14.sprite.bounds.size.x or var_80_15 / var_80_14.sprite.bounds.size.y, var_80_15 / var_80_14.sprite.bounds.size.y < var_80_15 * manager.ui.mainCameraCom_.aspect / var_80_14.sprite.bounds.size.x and var_80_15 * manager.ui.mainCameraCom_.aspect / var_80_14.sprite.bounds.size.x or var_80_15 / var_80_14.sprite.bounds.size.y, 0)
				end

				for iter_80_4, iter_80_5 in pairs(arg_77_1.bgs_) do
					if iter_80_4 ~= "ST0117" then
						iter_80_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_16 = 1.73333333333333
			local var_80_17 = 1.45

			if 1.73333333333333 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_18 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_18:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_19 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(424111018).content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_21 = 58 <= 0 and var_80_17 or var_80_17 * (utf8.len(var_80_19) / 58)

				if (58 <= 0 and var_80_17 or var_80_17 * (utf8.len(var_80_19) / 58)) > 0 and var_80_17 < var_80_21 then
					arg_77_1.talkMaxDuration = var_80_21
					var_80_16 = var_80_16 + 0.3

					if var_80_21 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_21 + var_80_16
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = var_80_16 + 0.3
			local var_80_23 = math.max(var_80_17, arg_77_1.talkMaxDuration)

			if var_80_16 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_22 + var_80_23 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_22) / var_80_23

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_22 + var_80_23 and arg_77_1.time_ < var_80_22 + var_80_23 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 25,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/LeftRight_Shake",
				duration = 1.5,
				amplitudeGain = 0.8,
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play424111019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 424111019
		arg_83_1.duration_ = 9

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play424111020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 4 < arg_83_1.time_ and arg_83_1.time_ <= 4 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			if arg_83_1.time_ >= 4 + 0.3 and arg_83_1.time_ < 4 + 0.3 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			local var_86_0 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_1 = 2

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_1 then
				local var_86_2 = Color.New(0, 0, 0)

				var_86_2.a = Mathf.Lerp(0, 1, (arg_83_1.time_ - var_86_0) / var_86_1)
				arg_83_1.mask_.color = var_86_2
			end

			if arg_83_1.time_ >= var_86_0 + var_86_1 and arg_83_1.time_ < var_86_0 + var_86_1 + arg_86_0 then
				local var_86_3 = Color.New(0, 0, 0)

				var_86_3.a = 1
				arg_83_1.mask_.color = var_86_3
			end

			local var_86_4 = 2

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_5 = 2

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_5 then
				local var_86_6 = Color.New(0, 0, 0)

				var_86_6.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_4) / var_86_5)
				arg_83_1.mask_.color = var_86_6
			end

			if arg_83_1.time_ >= var_86_4 + var_86_5 and arg_83_1.time_ < var_86_4 + var_86_5 + arg_86_0 then
				local var_86_7 = Color.New(0, 0, 0)

				arg_83_1.mask_.enabled = false
				var_86_7.a = 0
				arg_83_1.mask_.color = var_86_7
			end

			if 0.233333333333333 < arg_83_1.time_ and arg_83_1.time_ <= 0.233333333333333 + arg_86_0 then
				arg_83_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if 1.63333333333333 < arg_83_1.time_ and arg_83_1.time_ <= 1.63333333333333 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone", "")
			end

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= 2 + arg_86_0 then
				if arg_83_1.var_.effectchidunhongzha2 then
					Object.Destroy(arg_83_1.var_.effectchidunhongzha2)

					arg_83_1.var_.effectchidunhongzha2 = nil
				end
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_11 = 4
			local var_86_12 = 0.95

			if 4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_13 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_13:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_14 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(424111019).content)

				arg_83_1.text_.text = var_86_14

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_16 = 29 <= 0 and var_86_12 or var_86_12 * (utf8.len(var_86_14) / 29)

				if (29 <= 0 and var_86_12 or var_86_12 * (utf8.len(var_86_14) / 29)) > 0 and var_86_12 < var_86_16 then
					arg_83_1.talkMaxDuration = var_86_16
					var_86_11 = var_86_11 + 0.3

					if var_86_16 + var_86_11 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_16 + var_86_11
					end
				end

				arg_83_1.text_.text = var_86_14
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_17 = var_86_11 + 0.3
			local var_86_18 = math.max(var_86_12, arg_83_1.talkMaxDuration)

			if var_86_11 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_18 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_17) / var_86_18

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_17 + var_86_18 and arg_83_1.time_ < var_86_17 + var_86_18 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play424111020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424111020
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play424111021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.375

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(424111020).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 55 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 55)

				if (55 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 55)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play424111021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424111021
		arg_93_1.duration_ = 4.27

		local var_93_0 = {
			zh = 2.166,
			ja = 4.266
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
				arg_93_0:Play424111022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 == nil then
				arg_93_1.var_.actorSpriteComps1094 = arg_93_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1094"]) then
				if arg_93_1.var_.actorSpriteComps1094 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 1, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1094 = nil
			end

			local var_96_2 = arg_93_1.actors_["1094"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1094 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1094", 3)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "split_3" then
						var_96_3:SetAsLastSibling()
						var_96_3.gameObject:SetActive(true)

						arg_93_1.var_.actorSpriteSplit1094 = var_96_3.gameObject:GetComponent(typeof(Image))

						arg_93_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_93_1.time_ - 0) / var_96_4)

				if arg_93_1.var_.actorSpriteSplit1094 ~= nil then
					arg_93_1.var_.actorSpriteSplit1094:SetAlpha((arg_93_1.time_ - 0) / var_96_4)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -335, -230)

				if arg_93_1.var_.actorSpriteSplit1094 ~= nil then
					arg_93_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_96_5 = 0
			local var_96_6 = 0.25

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(424111021)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 10 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 10)

				if (10 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 10)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111021", "story_v_out_424111.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111021", "story_v_out_424111.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_424111", "424111021", "story_v_out_424111.awb")

						arg_93_1:RecordAudio("424111021", var_96_12)
						arg_93_1:RecordAudio("424111021", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_424111", "424111021", "story_v_out_424111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_424111", "424111021", "story_v_out_424111.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play424111022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424111022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play424111023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1094"]) and arg_97_1.var_.actorSpriteComps1094 == nil then
				arg_97_1.var_.actorSpriteComps1094 = arg_97_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1094"]) then
				if arg_97_1.var_.actorSpriteComps1094 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1094"]) and arg_97_1.var_.actorSpriteComps1094 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1094 = nil
			end

			local var_100_2 = arg_97_1.actors_["1094"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 7)

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
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_97_1.time_ and arg_97_1.time_ <= 0.034 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_launcher", "")
			end

			local var_100_6 = 0
			local var_100_7 = 1.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(424111022).content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 46 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 46)

				if (46 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 46)) > 0 and var_100_7 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_11 and arg_97_1.time_ < var_100_6 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 424111023
		arg_101_1.duration_ = 6

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play424111024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_9002
			local var_104_9001
			local var_104_9000

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_0 = arg_101_1.var_.effectshennengdanyu46

				if not arg_101_1.var_.effectshennengdanyu46 then
					var_104_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), manager.ui.mainCamera.transform)
					var_104_0.name = "shennengdanyu46"
					arg_101_1.var_.effectshennengdanyu46 = var_104_0
				else
					var_104_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_104_0.transform.localPosition = Vector3.New(0, 0, -0.2)
				var_104_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_104_0, iter_104_1 in ipairs((var_104_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_104_1.transform.localScale = Vector3.New(iter_104_1.transform.localScale.x / var_104_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_104_1.transform.localScale.y / var_104_2, iter_104_1.transform.localScale.z)
				end
			end

			local var_104_4 = manager.ui.mainCamera.transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.shakeOldPos = var_104_4.localPosition
			end

			local var_104_5 = 1.5

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				local var_104_6, var_104_7 = math.modf((arg_101_1.time_ - 0) / 0.066)

				var_104_4.localPosition = Vector3.New(var_104_7 * 0.13, var_104_7 * 0.13, var_104_7 * 0.13) + arg_101_1.var_.shakeOldPos
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = arg_101_1.var_.shakeOldPos
			end

			if 0.2 < arg_101_1.time_ and arg_101_1.time_ <= 0.2 + arg_104_0 then
				local var_104_8 = arg_101_1.var_.effectzisehuoyan8

				if not arg_101_1.var_.effectzisehuoyan8 then
					var_104_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_104_8.name = "zisehuoyan8"
					arg_101_1.var_.effectzisehuoyan8 = var_104_8
				else
					var_104_8.transform:SetParent(var_104_9002)
				end

				var_104_8.transform.localPosition = Vector3.New(0.37, 1.21, -1)
				var_104_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_104_2, iter_104_3 in ipairs((var_104_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_104_3.transform.localScale = Vector3.New(iter_104_3.transform.localScale.x / var_104_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_104_3.transform.localScale.y / var_104_10, iter_104_3.transform.localScale.z)
				end
			end

			if 0.5 < arg_101_1.time_ and arg_101_1.time_ <= 0.5 + arg_104_0 then
				local var_104_12 = arg_101_1.var_.effectzisehuoyan9

				if not arg_101_1.var_.effectzisehuoyan9 then
					var_104_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_104_12.name = "zisehuoyan9"
					arg_101_1.var_.effectzisehuoyan9 = var_104_12
				else
					var_104_12.transform:SetParent(var_104_9001)
				end

				var_104_12.transform.localPosition = Vector3.New(1.09, 1, -1.5)
				var_104_12.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_14 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_104_4, iter_104_5 in ipairs((var_104_12.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_104_5.transform.localScale = Vector3.New(iter_104_5.transform.localScale.x / var_104_14 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_104_5.transform.localScale.y / var_104_14, iter_104_5.transform.localScale.z)
				end
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_16 = arg_101_1.var_.effectzisehuoyan10

				if not arg_101_1.var_.effectzisehuoyan10 then
					var_104_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_104_16.name = "zisehuoyan10"
					arg_101_1.var_.effectzisehuoyan10 = var_104_16
				else
					var_104_16.transform:SetParent(var_104_9000)
				end

				var_104_16.transform.localPosition = Vector3.New(-0.56, -0.48, -0.8)
				var_104_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_104_6, iter_104_7 in ipairs((var_104_16.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_104_7.transform.localScale = Vector3.New(iter_104_7.transform.localScale.x / var_104_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_104_7.transform.localScale.y / var_104_18, iter_104_7.transform.localScale.z)
				end
			end

			if 2.66666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 2.66666666666667 + arg_104_0 then
				if arg_101_1.var_.effectzisehuoyan8 then
					Object.Destroy(arg_101_1.var_.effectzisehuoyan8)

					arg_101_1.var_.effectzisehuoyan8 = nil
				end
			end

			if 2.66666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 2.66666666666667 + arg_104_0 then
				if arg_101_1.var_.effectzisehuoyan9 then
					Object.Destroy(arg_101_1.var_.effectzisehuoyan9)

					arg_101_1.var_.effectzisehuoyan9 = nil
				end
			end

			if 2.66666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 2.66666666666667 + arg_104_0 then
				if arg_101_1.var_.effectzisehuoyan10 then
					Object.Destroy(arg_101_1.var_.effectzisehuoyan10)

					arg_101_1.var_.effectzisehuoyan10 = nil
				end
			end

			local var_104_23 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_23 + 1.5 and arg_101_1.time_ < var_104_23 + 1.5 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle02", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_25 = 1
			local var_104_26 = 1.2

			if 1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_27 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_27:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_28 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(424111023).content)

				arg_101_1.text_.text = var_104_28

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_30 = 48 <= 0 and var_104_26 or var_104_26 * (utf8.len(var_104_28) / 48)

				if (48 <= 0 and var_104_26 or var_104_26 * (utf8.len(var_104_28) / 48)) > 0 and var_104_26 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30
					var_104_25 = var_104_25 + 0.3

					if var_104_30 + var_104_25 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_25
					end
				end

				arg_101_1.text_.text = var_104_28
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_31 = var_104_25 + 0.3
			local var_104_32 = math.max(var_104_26, arg_101_1.talkMaxDuration)

			if var_104_25 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_31 + var_104_32 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_31) / var_104_32

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_31 + var_104_32 and arg_101_1.time_ < var_104_31 + var_104_32 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play424111024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424111024
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play424111025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0.7 < arg_107_1.time_ and arg_107_1.time_ <= 0.7 + arg_110_0 then
				arg_107_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_thunder", "")
			end

			local var_110_1 = 0
			local var_110_2 = 1.15

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(424111024).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 46 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 46)

				if (46 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 46)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play424111025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424111025
		arg_111_1.duration_ = 3.33

		local var_111_0 = {
			zh = 3.233,
			ja = 3.333
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
				arg_111_0:Play424111026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.25

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_6")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(424111025)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 10 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 10)

				if (10 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 10)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111025", "story_v_out_424111.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111025", "story_v_out_424111.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_424111", "424111025", "story_v_out_424111.awb")

						arg_111_1:RecordAudio("424111025", var_114_6)
						arg_111_1:RecordAudio("424111025", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_424111", "424111025", "story_v_out_424111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_424111", "424111025", "story_v_out_424111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play424111026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424111026
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play424111027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10155"]) and arg_115_1.var_.actorSpriteComps10155 == nil then
				arg_115_1.var_.actorSpriteComps10155 = arg_115_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10155"]) then
				if arg_115_1.var_.actorSpriteComps10155 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10155"]) and arg_115_1.var_.actorSpriteComps10155 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10155 = nil
			end

			local var_118_2 = 0
			local var_118_3 = 0.15

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_4 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(424111026).content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_6 = 6 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_4) / 6)

				if (6 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_4) / 6)) > 0 and var_118_3 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_7 and arg_115_1.time_ < var_118_2 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play424111027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424111027
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play424111028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10155 = arg_119_1.actors_["10155"].transform.localPosition
				arg_119_1.actors_["10155"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10155", 7)

				for iter_122_0 = 0, arg_119_1.actors_["10155"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10155"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10155"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10155"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_2 = 0
			local var_122_3 = 1.525

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(424111027).content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 61 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 61)

				if (61 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 61)) > 0 and var_122_3 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_7 and arg_119_1.time_ < var_122_2 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424111028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play424111029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.725

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(424111028).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 69 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 69)

				if (69 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 69)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play424111029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424111029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424111030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.525

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(424111029).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 21 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 21)

				if (21 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 21)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424111030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424111030
		arg_131_1.duration_ = 1

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play424111031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1094"]) and arg_131_1.var_.actorSpriteComps1094 == nil then
				arg_131_1.var_.actorSpriteComps1094 = arg_131_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1094"]) then
				if arg_131_1.var_.actorSpriteComps1094 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 1, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1094"]) and arg_131_1.var_.actorSpriteComps1094 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1094 = nil
			end

			local var_134_2 = arg_131_1.actors_["1094"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1094 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1094", 3)

				for iter_134_4 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_4)

					if var_134_3.name == "split_3" then
						var_134_3:SetAsLastSibling()
						var_134_3.gameObject:SetActive(true)

						arg_131_1.var_.actorSpriteSplit1094 = var_134_3.gameObject:GetComponent(typeof(Image))

						arg_131_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_131_1.time_ - 0) / var_134_4)

				if arg_131_1.var_.actorSpriteSplit1094 ~= nil then
					arg_131_1.var_.actorSpriteSplit1094:SetAlpha((arg_131_1.time_ - 0) / var_134_4)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, -335, -230)

				if arg_131_1.var_.actorSpriteSplit1094 ~= nil then
					arg_131_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_134_5 = 0
			local var_134_6 = 0.05

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(424111030)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 2 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 2)

				if (2 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 2)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111030", "story_v_out_424111.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111030", "story_v_out_424111.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_424111", "424111030", "story_v_out_424111.awb")

						arg_131_1:RecordAudio("424111030", var_134_12)
						arg_131_1:RecordAudio("424111030", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424111", "424111030", "story_v_out_424111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424111", "424111030", "story_v_out_424111.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play424111031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424111031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play424111032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1094"]) and arg_135_1.var_.actorSpriteComps1094 == nil then
				arg_135_1.var_.actorSpriteComps1094 = arg_135_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1094"]) then
				if arg_135_1.var_.actorSpriteComps1094 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1094"]) and arg_135_1.var_.actorSpriteComps1094 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1094 = nil
			end

			local var_138_2 = arg_135_1.actors_["1094"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1094 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1094", 7)

				for iter_138_4 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_4)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_135_1.time_ and arg_135_1.time_ <= 0.2 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_launcher", "")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_138_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_135_1.bgmTxt_.text ~= var_138_8 and arg_135_1.bgmTxt_.text ~= "" then
						if arg_135_1.bgmTxt2_.text ~= "" then
							arg_135_1.bgmTxt_.text = arg_135_1.bgmTxt2_.text
						end

						arg_135_1.bgmTxt2_.text = var_138_8

						arg_135_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_135_1.bgmTxt_.text = var_138_8
						arg_135_1.bgmTxt2_.text = var_138_8
					end

					if arg_135_1.bgmTimer then
						arg_135_1.bgmTimer:Stop()

						arg_135_1.bgmTimer = nil
					end

					if arg_135_1.settingData.show_music_name == 1 then
						arg_135_1.musicController:SetSelectedState("show")
						arg_135_1.musicAnimator_:Play("open", 0, 0)

						if arg_135_1.settingData.music_time ~= 0 then
							arg_135_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_135_1.settingData.music_time), function()
								if arg_135_1 == nil or isNil(arg_135_1.bgmTxt_) then
									return
								end

								arg_135_1.musicController:SetSelectedState("hide")
								arg_135_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_138_9 = 0
			local var_138_10 = 1.075

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_11 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(424111031).content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 43 <= 0 and var_138_10 or var_138_10 * (utf8.len(var_138_11) / 43)

				if (43 <= 0 and var_138_10 or var_138_10 * (utf8.len(var_138_11) / 43)) > 0 and var_138_10 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_9 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_9
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_10, arg_135_1.talkMaxDuration)

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_9) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_9 + var_138_14 and arg_135_1.time_ < var_138_9 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 424111032
		arg_140_1.duration_ = 3

		local var_140_0 = {
			zh = 2.4,
			ja = 3
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play424111033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1094"]) and arg_140_1.var_.actorSpriteComps1094 == nil then
				arg_140_1.var_.actorSpriteComps1094 = arg_140_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1094"]) then
				if arg_140_1.var_.actorSpriteComps1094 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 1, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1094"]) and arg_140_1.var_.actorSpriteComps1094 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1094 = nil
			end

			local var_143_2 = arg_140_1.actors_["1094"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1094 = var_143_2.localPosition
				var_143_2.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1094", 3)

				for iter_143_4 = 0, var_143_2.childCount - 1 do
					local var_143_3 = var_143_2:GetChild(iter_143_4)

					if var_143_3.name == "split_3" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_2.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_140_1.time_ - 0) / var_143_4)
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_2.localPosition = Vector3.New(0, -335, -230)
			end

			if 0.034 < arg_140_1.time_ and arg_140_1.time_ <= 0.034 + arg_143_0 then
				arg_140_1:AudioAction("play", "music", "bgm_activity_4_6_story_hel", "bgm_activity_4_6_story_hel", "bgm_activity_4_6_story_hel.awb")

				local var_143_7 = manager.audio:GetAudioName("bgm_activity_4_6_story_hel", "bgm_activity_4_6_story_hel")

				if "" ~= "" then
					if arg_140_1.bgmTxt_.text ~= var_143_7 and arg_140_1.bgmTxt_.text ~= "" then
						if arg_140_1.bgmTxt2_.text ~= "" then
							arg_140_1.bgmTxt_.text = arg_140_1.bgmTxt2_.text
						end

						arg_140_1.bgmTxt2_.text = var_143_7

						arg_140_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_140_1.bgmTxt_.text = var_143_7
						arg_140_1.bgmTxt2_.text = var_143_7
					end

					if arg_140_1.bgmTimer then
						arg_140_1.bgmTimer:Stop()

						arg_140_1.bgmTimer = nil
					end

					if arg_140_1.settingData.show_music_name == 1 then
						arg_140_1.musicController:SetSelectedState("show")
						arg_140_1.musicAnimator_:Play("open", 0, 0)

						if arg_140_1.settingData.music_time ~= 0 then
							arg_140_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_140_1.settingData.music_time), function()
								if arg_140_1 == nil or isNil(arg_140_1.bgmTxt_) then
									return
								end

								arg_140_1.musicController:SetSelectedState("hide")
								arg_140_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_143_8 = 0
			local var_143_9 = 0.225

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(424111032)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 9 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 9)

				if (9 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 9)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111032", "story_v_out_424111.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_424111", "424111032", "story_v_out_424111.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_424111", "424111032", "story_v_out_424111.awb")

						arg_140_1:RecordAudio("424111032", var_143_15)
						arg_140_1:RecordAudio("424111032", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_424111", "424111032", "story_v_out_424111.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_424111", "424111032", "story_v_out_424111.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play424111033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 424111033
		arg_145_1.duration_ = 6.6

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play424111034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0.966 < arg_145_1.time_ and arg_145_1.time_ <= 0.966 + arg_148_0 and not isNil(arg_145_1.actors_["1094"]) and arg_145_1.var_.actorSpriteComps1094 == nil then
				arg_145_1.var_.actorSpriteComps1094 = arg_145_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.034

			if 0.966 <= arg_145_1.time_ and arg_145_1.time_ < 0.966 + var_148_0 and not isNil(arg_145_1.actors_["1094"]) then
				if arg_145_1.var_.actorSpriteComps1094 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0.966) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0.966) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0.966) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 0.5, (arg_145_1.time_ - 0.966) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0.966 + var_148_0 and arg_145_1.time_ < 0.966 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1094"]) and arg_145_1.var_.actorSpriteComps1094 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps1094 = nil
			end

			local var_148_2 = arg_145_1.actors_["1094"].transform

			if 0.966 < arg_145_1.time_ and arg_145_1.time_ <= 0.966 + arg_148_0 then
				arg_145_1.var_.moveOldPos1094 = var_148_2.localPosition
				var_148_2.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1094", 7)

				for iter_148_4 = 0, var_148_2.childCount - 1 do
					local var_148_3 = var_148_2:GetChild(iter_148_4)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if 0.966 <= arg_145_1.time_ and arg_145_1.time_ < 0.966 + var_148_4 then
				var_148_2.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_145_1.time_ - 0.966) / var_148_4)
			end

			if arg_145_1.time_ >= 0.966 + var_148_4 and arg_145_1.time_ < 0.966 + var_148_4 + arg_148_0 then
				var_148_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_148_5 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_6 = 1

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 then
				local var_148_7 = Color.New(1, 1, 1)

				var_148_7.a = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_5) / var_148_6)
				arg_145_1.mask_.color = var_148_7
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 then
				local var_148_8 = Color.New(1, 1, 1)

				var_148_8.a = 1
				arg_145_1.mask_.color = var_148_8
			end

			local var_148_9 = 1

			if 1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_10 = 1

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_10 then
				local var_148_11 = Color.New(1, 1, 1)

				var_148_11.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_9) / var_148_10)
				arg_145_1.mask_.color = var_148_11
			end

			if arg_145_1.time_ >= var_148_9 + var_148_10 and arg_145_1.time_ < var_148_9 + var_148_10 + arg_148_0 then
				local var_148_12 = Color.New(1, 1, 1)

				arg_145_1.mask_.enabled = false
				var_148_12.a = 0
				arg_145_1.mask_.color = var_148_12
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion02", "")
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_14 = 1.6
			local var_148_15 = 1.375

			if 1.6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_16 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_16:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_17 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(424111033).content)

				arg_145_1.text_.text = var_148_17

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_19 = 55 <= 0 and var_148_15 or var_148_15 * (utf8.len(var_148_17) / 55)

				if (55 <= 0 and var_148_15 or var_148_15 * (utf8.len(var_148_17) / 55)) > 0 and var_148_15 < var_148_19 then
					arg_145_1.talkMaxDuration = var_148_19
					var_148_14 = var_148_14 + 0.3

					if var_148_19 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_19 + var_148_14
					end
				end

				arg_145_1.text_.text = var_148_17
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = var_148_14 + 0.3
			local var_148_21 = math.max(var_148_15, arg_145_1.talkMaxDuration)

			if var_148_14 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_20 + var_148_21 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_20) / var_148_21

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_20 + var_148_21 and arg_145_1.time_ < var_148_20 + var_148_21 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play424111034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424111034
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play424111035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.9

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

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(424111034).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 36 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 36)

				if (36 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 36)) > 0 and var_154_0 < var_154_3 then
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
	Play424111035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424111035
		arg_155_1.duration_ = 5.2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play424111036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_0 = arg_155_1.var_.effectchushouzhuizhu1

				if not arg_155_1.var_.effectchushouzhuizhu1 then
					var_158_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), manager.ui.mainCamera.transform)
					var_158_0.name = "chushouzhuizhu1"
					arg_155_1.var_.effectchushouzhuizhu1 = var_158_0
				else
					var_158_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_158_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_158_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_158_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_158_0, iter_158_1 in ipairs((var_158_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_158_1.transform.localScale = Vector3.New(iter_158_1.transform.localScale.x / var_158_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_158_1.transform.localScale.y / var_158_2, iter_158_1.transform.localScale.z)
				end
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_145", "se_story_145_rock", "")
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_5 = 0.2
			local var_158_6 = 1.25

			if 0.2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_7 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_7:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(424111035).content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_10 = 50 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 50)

				if (50 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 50)) > 0 and var_158_6 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10
					var_158_5 = var_158_5 + 0.3

					if var_158_10 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = var_158_5 + 0.3
			local var_158_12 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_11) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_11 + var_158_12 and arg_155_1.time_ < var_158_11 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 25,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/HeavyAttack_Shake",
				duration = 0.8,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play424111036 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 424111036
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play424111037(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.125

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(424111036).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 5 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 5)

				if (5 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 5)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play424111037 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 424111037
		arg_165_1.duration_ = 5.17

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play424111038(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0.166666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.166666666666667 + arg_168_0 then
				local var_168_0 = arg_165_1.var_.effectdiaozhuanqiangkou1

				if not arg_165_1.var_.effectdiaozhuanqiangkou1 then
					var_168_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_168_0.name = "diaozhuanqiangkou1"
					arg_165_1.var_.effectdiaozhuanqiangkou1 = var_168_0
				else
					var_168_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_168_0.transform.localPosition = Vector3.New(0, -0.5, 0)
				var_168_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_168_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_168_0, iter_168_1 in ipairs((var_168_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_168_1.transform.localScale = Vector3.New(iter_168_1.transform.localScale.x / var_168_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_168_1.transform.localScale.y / var_168_2, iter_168_1.transform.localScale.z)
				end
			end

			local var_168_4 = manager.ui.mainCamera.transform

			if 0.166666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.166666666666667 + arg_168_0 then
				arg_165_1.var_.shakeOldPos = var_168_4.localPosition
			end

			local var_168_5 = 0.3

			if 0.166666666666667 <= arg_165_1.time_ and arg_165_1.time_ < 0.166666666666667 + var_168_5 then
				local var_168_6, var_168_7 = math.modf((arg_165_1.time_ - 0.166666666666667) / 0.066)

				var_168_4.localPosition = Vector3.New(var_168_7 * 0.13, var_168_7 * 0.13, var_168_7 * 0.13) + arg_165_1.var_.shakeOldPos
			end

			if arg_165_1.time_ >= 0.166666666666667 + var_168_5 and arg_165_1.time_ < 0.166666666666667 + var_168_5 + arg_168_0 then
				var_168_4.localPosition = arg_165_1.var_.shakeOldPos
			end

			local var_168_8 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			if arg_165_1.time_ >= var_168_8 + 0.166666666666667 and arg_165_1.time_ < var_168_8 + 0.166666666666667 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.166666666666667 + arg_168_0 then
				arg_165_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_10 = 0.166666666666667
			local var_168_11 = 1.425

			if 0.166666666666667 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_12 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_12:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_13 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(424111037).content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 57 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 57)

				if (57 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 57)) > 0 and var_168_11 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15
					var_168_10 = var_168_10 + 0.3

					if var_168_15 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = var_168_10 + 0.3
			local var_168_17 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_16) / var_168_17

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play424111038 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424111038
		arg_171_1.duration_ = 3.57

		local var_171_0 = {
			zh = 3.333,
			ja = 3.566
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
				arg_171_0:Play424111039(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.3

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10153_split_5")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(424111038)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 12 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 12)

				if (12 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 12)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111038", "story_v_out_424111.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111038", "story_v_out_424111.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_424111", "424111038", "story_v_out_424111.awb")

						arg_171_1:RecordAudio("424111038", var_174_6)
						arg_171_1:RecordAudio("424111038", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_424111", "424111038", "story_v_out_424111.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_424111", "424111038", "story_v_out_424111.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424111039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424111039
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play424111040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if arg_175_1.actors_["1029"] == nil then
				local var_178_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_178_0) then
					local var_178_1 = Object.Instantiate(var_178_0, arg_175_1.canvasGo_.transform)

					var_178_1.transform:SetSiblingIndex(1)

					var_178_1.name = "1029"
					var_178_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_175_1.actors_["1029"] = var_178_1

					if arg_175_1.isInRecall_ then
						for iter_178_0, iter_178_1 in ipairs((var_178_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_178_1.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_178_2 = arg_175_1.actors_["1029"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1029 == nil then
				arg_175_1.var_.actorSpriteComps1029 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1029 then
					for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_178_3 then
							if arg_175_1.isInRecall_ then
								iter_178_3.color = Color.New(Mathf.Lerp(iter_178_3.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_3.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_3.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_3.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_3.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1029 then
				for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_178_5 then
						iter_178_5.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1029 = nil
			end

			local var_178_5 = arg_175_1.actors_["1029"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1029 = var_178_5.localPosition
				var_178_5.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1029", 7)

				for iter_178_6 = 0, var_178_5.childCount - 1 do
					local var_178_6 = var_178_5:GetChild(iter_178_6)

					if var_178_6.name == "" or not string.find(var_178_6.name, "split") then
						var_178_6.gameObject:SetActive(true)
					else
						var_178_6.gameObject:SetActive(false)
					end
				end
			end

			local var_178_7 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1029, Vector3.New(0, -2000, -140), (arg_175_1.time_ - 0) / var_178_7)
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0.034 < arg_175_1.time_ and arg_175_1.time_ <= 0.034 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story_145", "se_story_145_star_movement_wobble02", "")
			end

			local var_178_9 = 0
			local var_178_10 = 1.1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_11 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(424111039).content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 44 <= 0 and var_178_10 or var_178_10 * (utf8.len(var_178_11) / 44)

				if (44 <= 0 and var_178_10 or var_178_10 * (utf8.len(var_178_11) / 44)) > 0 and var_178_10 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_9 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_9
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_10, arg_175_1.talkMaxDuration)

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_9) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_9 + var_178_14 and arg_175_1.time_ < var_178_9 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play424111040 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424111040
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424111041(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.225

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(424111040).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 9 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 9)

				if (9 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 9)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play424111041 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424111041
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play424111042(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.05

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(424111041).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 2 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 2)

				if (2 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 2)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play424111042 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424111042
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play424111043(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0.475 < arg_187_1.time_ and arg_187_1.time_ <= 0.475 + arg_190_0 then
				arg_187_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tear", "")
			end

			local var_190_1 = 0
			local var_190_2 = 1.475

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(424111042).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 59 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 59)

				if (59 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 59)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play424111043 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424111043
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play424111044(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.225

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(424111043).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 49 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 49)

				if (49 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 49)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play424111044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424111044
		arg_195_1.duration_ = 3.33

		local var_195_0 = {
			zh = 2.5,
			ja = 3.333
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
				arg_195_0:Play424111045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.25

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(424111044)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 10 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 10)

				if (10 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 10)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111044", "story_v_out_424111.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111044", "story_v_out_424111.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_424111", "424111044", "story_v_out_424111.awb")

						arg_195_1:RecordAudio("424111044", var_198_6)
						arg_195_1:RecordAudio("424111044", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424111", "424111044", "story_v_out_424111.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424111", "424111044", "story_v_out_424111.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play424111045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424111045
		arg_199_1.duration_ = 3.6

		local var_199_0 = {
			zh = 3.233,
			ja = 3.6
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
				arg_199_0:Play424111046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if arg_199_1.actors_["10153"] == nil then
				local var_202_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_202_0) then
					local var_202_1 = Object.Instantiate(var_202_0, arg_199_1.canvasGo_.transform)

					var_202_1.transform:SetSiblingIndex(1)

					var_202_1.name = "10153"
					var_202_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_199_1.actors_["10153"] = var_202_1

					if arg_199_1.isInRecall_ then
						for iter_202_0, iter_202_1 in ipairs((var_202_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_202_1.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_202_2 = arg_199_1.actors_["10153"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10153 == nil then
				arg_199_1.var_.actorSpriteComps10153 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10153 then
					for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_202_3 then
							if arg_199_1.isInRecall_ then
								iter_202_3.color = Color.New(Mathf.Lerp(iter_202_3.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_3.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_3.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_3.color.r, 1, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_3.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10153 then
				for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_202_5 then
						iter_202_5.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10153 = nil
			end

			local var_202_5 = arg_199_1.actors_["10153"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10153 = var_202_5.localPosition
				var_202_5.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10153", 3)

				for iter_202_6 = 0, var_202_5.childCount - 1 do
					local var_202_6 = var_202_5:GetChild(iter_202_6)

					if var_202_6.name == "" or not string.find(var_202_6.name, "split") then
						var_202_6.gameObject:SetActive(true)
					else
						var_202_6.gameObject:SetActive(false)
					end
				end
			end

			local var_202_7 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				var_202_5.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_199_1.time_ - 0) / var_202_7)
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				var_202_5.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_202_8 = 0
			local var_202_9 = 0.35

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(424111045)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 14 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 14)

				if (14 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 14)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111045", "story_v_out_424111.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_424111", "424111045", "story_v_out_424111.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_424111", "424111045", "story_v_out_424111.awb")

						arg_199_1:RecordAudio("424111045", var_202_15)
						arg_199_1:RecordAudio("424111045", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_424111", "424111045", "story_v_out_424111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_424111", "424111045", "story_v_out_424111.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 424111046
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play424111047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10153"]) and arg_203_1.var_.actorSpriteComps10153 == nil then
				arg_203_1.var_.actorSpriteComps10153 = arg_203_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10153"]) then
				if arg_203_1.var_.actorSpriteComps10153 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10153"]) and arg_203_1.var_.actorSpriteComps10153 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps10153 = nil
			end

			local var_206_2 = 0
			local var_206_3 = 0.35

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_4 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(424111046).content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 14 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 14)

				if (14 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 14)) > 0 and var_206_3 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_7 and arg_203_1.time_ < var_206_2 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play424111047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424111047
		arg_207_1.duration_ = 3.53

		local var_207_0 = {
			zh = 3.533,
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
				arg_207_0:Play424111048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.5

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(424111047)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 20 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 20)

				if (20 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 20)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111047", "story_v_out_424111.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111047", "story_v_out_424111.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_424111", "424111047", "story_v_out_424111.awb")

						arg_207_1:RecordAudio("424111047", var_210_6)
						arg_207_1:RecordAudio("424111047", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_424111", "424111047", "story_v_out_424111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_424111", "424111047", "story_v_out_424111.awb")
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
	Play424111048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424111048
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play424111049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_9000

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10153 = arg_211_1.actors_["10153"].transform.localPosition
				arg_211_1.actors_["10153"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10153", 7)

				for iter_214_0 = 0, arg_211_1.actors_["10153"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["10153"].transform:GetChild(iter_214_0)

					if var_214_0.name == "" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["10153"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_211_1.time_ - 0) / var_214_1)
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["10153"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				local var_214_2 = arg_211_1.var_.effecthainenghudun1

				if not arg_211_1.var_.effecthainenghudun1 then
					var_214_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_red_in"), manager.ui.mainCamera.transform)
					var_214_2.name = "hainenghudun1"
					arg_211_1.var_.effecthainenghudun1 = var_214_2
				else
					var_214_2.transform:SetParent(var_214_9000)
				end

				var_214_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_214_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_214_4 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_214_1, iter_214_2 in ipairs((var_214_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_214_2.transform.localScale = Vector3.New(iter_214_2.transform.localScale.x / var_214_4 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_214_2.transform.localScale.y / var_214_4, iter_214_2.transform.localScale.z)
				end
			end

			local var_214_6 = 0
			local var_214_7 = 1.55

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(424111048).content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 62 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 62)

				if (62 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 62)) > 0 and var_214_7 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_11 and arg_211_1.time_ < var_214_6 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424111049
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play424111050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_9000

			if 0.133333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 0.133333333333333 + arg_218_0 then
				local var_218_0 = arg_215_1.var_.effectshennengguangzhu1

				if not arg_215_1.var_.effectshennengguangzhu1 then
					var_218_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue"), manager.ui.mainCamera.transform)
					var_218_0.name = "shennengguangzhu1"
					arg_215_1.var_.effectshennengguangzhu1 = var_218_0
				else
					var_218_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_218_0.transform.localPosition = Vector3.New(0, 0.43, -4.5)
				var_218_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_218_0, iter_218_1 in ipairs((var_218_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_218_1.transform.localScale = Vector3.New(iter_218_1.transform.localScale.x / var_218_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_218_1.transform.localScale.y / var_218_2, iter_218_1.transform.localScale.z)
				end
			end

			if 1.13333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 1.13333333333333 + arg_218_0 then
				if arg_215_1.var_.effectshennengguangzhu1 then
					Object.Destroy(arg_215_1.var_.effectshennengguangzhu1)

					arg_215_1.var_.effectshennengguangzhu1 = nil
				end
			end

			local var_218_5 = manager.ui.mainCamera.transform

			if 0.133333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 0.133333333333333 + arg_218_0 then
				arg_215_1.var_.shakeOldPos = var_218_5.localPosition
			end

			local var_218_6 = 0.4

			if 0.133333333333333 <= arg_215_1.time_ and arg_215_1.time_ < 0.133333333333333 + var_218_6 then
				local var_218_7, var_218_8 = math.modf((arg_215_1.time_ - 0.133333333333333) / 0.066)

				var_218_5.localPosition = Vector3.New(var_218_8 * 0.13, var_218_8 * 0.13, var_218_8 * 0.13) + arg_215_1.var_.shakeOldPos
			end

			if arg_215_1.time_ >= 0.133333333333333 + var_218_6 and arg_215_1.time_ < 0.133333333333333 + var_218_6 + arg_218_0 then
				var_218_5.localPosition = arg_215_1.var_.shakeOldPos
			end

			if 0.133333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 0.133333333333333 + arg_218_0 then
				local var_218_9 = arg_215_1.var_.effectshennengguangzhu2

				if not arg_215_1.var_.effectshennengguangzhu2 then
					var_218_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfalldi"), manager.ui.mainCamera.transform)
					var_218_9.name = "shennengguangzhu2"
					arg_215_1.var_.effectshennengguangzhu2 = var_218_9
				else
					var_218_9.transform:SetParent(var_218_9000)
				end

				var_218_9.transform.localPosition = Vector3.New(0, 0.43, -4.5)
				var_218_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_218_2, iter_218_3 in ipairs((var_218_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_218_3.transform.localScale = Vector3.New(iter_218_3.transform.localScale.x / var_218_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_218_3.transform.localScale.y / var_218_11, iter_218_3.transform.localScale.z)
				end
			end

			if 3.13333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 3.13333333333333 + arg_218_0 then
				if arg_215_1.var_.effectshennengguangzhu2 then
					Object.Destroy(arg_215_1.var_.effectshennengguangzhu2)

					arg_215_1.var_.effectshennengguangzhu2 = nil
				end
			end

			local var_218_14 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_14 + 0.533333333333333 and arg_215_1.time_ < var_218_14 + 0.533333333333333 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			if 0.1 < arg_215_1.time_ and arg_215_1.time_ <= 0.1 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_146", "se_story_146_laser01", "")
			end

			local var_218_16 = 0
			local var_218_17 = 1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_18 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_18:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_19 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(424111049).content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_21 = 40 <= 0 and var_218_17 or var_218_17 * (utf8.len(var_218_19) / 40)

				if (40 <= 0 and var_218_17 or var_218_17 * (utf8.len(var_218_19) / 40)) > 0 and var_218_17 < var_218_21 then
					arg_215_1.talkMaxDuration = var_218_21
					var_218_16 = var_218_16 + 0.3

					if var_218_21 + var_218_16 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_21 + var_218_16
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = var_218_16 + 0.3
			local var_218_23 = math.max(var_218_17, arg_215_1.talkMaxDuration)

			if var_218_16 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_22 + var_218_23 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_22) / var_218_23

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_22 + var_218_23 and arg_215_1.time_ < var_218_22 + var_218_23 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play424111050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 424111050
		arg_221_1.duration_ = 2

		local var_221_0 = {
			zh = 1.133,
			ja = 2
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
				arg_221_0:Play424111051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(424111050)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 4 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 4)

				if (4 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 4)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111050", "story_v_out_424111.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111050", "story_v_out_424111.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_424111", "424111050", "story_v_out_424111.awb")

						arg_221_1:RecordAudio("424111050", var_224_6)
						arg_221_1:RecordAudio("424111050", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_424111", "424111050", "story_v_out_424111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_424111", "424111050", "story_v_out_424111.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play424111051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 424111051
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play424111052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_146", "se_story_146_roar01", "")
			end

			local var_228_1 = 0
			local var_228_2 = 0.15

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1409].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(424111051).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 6 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 6)

				if (6 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 6)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play424111052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 424111052
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play424111053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(424111052).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 44 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 44)

				if (44 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 44)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play424111053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 424111053
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play424111054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.125

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(424111053).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 45 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 45)

				if (45 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 45)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play424111054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 424111054
		arg_237_1.duration_ = 5.33

		local var_237_0 = {
			zh = 2.766,
			ja = 5.333
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
				arg_237_0:Play424111055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.225

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_2 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_2:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_6")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(424111054)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 9 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_4) / 9)

				if (9 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_4) / 9)) > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6
					var_240_0 = var_240_0 + 0.3

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111054", "story_v_out_424111.awb") ~= 0 then
					local var_240_7 = manager.audio:GetVoiceLength("story_v_out_424111", "424111054", "story_v_out_424111.awb") / 1000

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_424111", "424111054", "story_v_out_424111.awb")

						arg_237_1:RecordAudio("424111054", var_240_8)
						arg_237_1:RecordAudio("424111054", var_240_8)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_424111", "424111054", "story_v_out_424111.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_424111", "424111054", "story_v_out_424111.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = var_240_0 + 0.3
			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_9) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_9 + var_240_10 and arg_237_1.time_ < var_240_9 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play424111055 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424111055
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play424111056(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10155"]) and arg_243_1.var_.actorSpriteComps10155 == nil then
				arg_243_1.var_.actorSpriteComps10155 = arg_243_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10155"]) then
				if arg_243_1.var_.actorSpriteComps10155 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10155"]) and arg_243_1.var_.actorSpriteComps10155 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps10155 = nil
			end

			local var_246_2 = 0
			local var_246_3 = 0.45

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_4 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(424111055).content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 18 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 18)

				if (18 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 18)) > 0 and var_246_3 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_7 and arg_243_1.time_ < var_246_2 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play424111056 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424111056
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play424111057(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10155 = arg_247_1.actors_["10155"].transform.localPosition
				arg_247_1.actors_["10155"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10155", 7)

				for iter_250_0 = 0, arg_247_1.actors_["10155"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["10155"].transform:GetChild(iter_250_0)

					if var_250_0.name == "" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["10155"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["10155"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_247_1.time_ and arg_247_1.time_ <= 0.166666666666667 + arg_250_0 then
				arg_247_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun07", "")
			end

			local var_250_3 = 0
			local var_250_4 = 0.875

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_5 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(424111056).content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 35 <= 0 and var_250_4 or var_250_4 * (utf8.len(var_250_5) / 35)

				if (35 <= 0 and var_250_4 or var_250_4 * (utf8.len(var_250_5) / 35)) > 0 and var_250_4 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_3 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_3
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_4, arg_247_1.talkMaxDuration)

			if var_250_3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_3 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_3) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_3 + var_250_8 and arg_247_1.time_ < var_250_3 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424111057
		arg_251_1.duration_ = 6.37

		local var_251_0 = {
			zh = 5.933,
			ja = 6.366
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
				arg_251_0:Play424111058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10153"]) and arg_251_1.var_.actorSpriteComps10153 == nil then
				arg_251_1.var_.actorSpriteComps10153 = arg_251_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10153"]) then
				if arg_251_1.var_.actorSpriteComps10153 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10153"]) and arg_251_1.var_.actorSpriteComps10153 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps10153 = nil
			end

			local var_254_2 = arg_251_1.actors_["10153"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10153 = var_254_2.localPosition
				var_254_2.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10153", 2)

				for iter_254_4 = 0, var_254_2.childCount - 1 do
					local var_254_3 = var_254_2:GetChild(iter_254_4)

					if var_254_3.name == "split_3" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_2.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_251_1.time_ - 0) / var_254_4)
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_254_5 = 0
			local var_254_6 = 0.6

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(424111057)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 24 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 24)

				if (24 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 24)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111057", "story_v_out_424111.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111057", "story_v_out_424111.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_424111", "424111057", "story_v_out_424111.awb")

						arg_251_1:RecordAudio("424111057", var_254_12)
						arg_251_1:RecordAudio("424111057", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_424111", "424111057", "story_v_out_424111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_424111", "424111057", "story_v_out_424111.awb")
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
				actorName = "10153",
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
	Play424111058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424111058
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play424111059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10153"]) and arg_255_1.var_.actorSpriteComps10153 == nil then
				arg_255_1.var_.actorSpriteComps10153 = arg_255_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10153"]) then
				if arg_255_1.var_.actorSpriteComps10153 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10153"]) and arg_255_1.var_.actorSpriteComps10153 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps10153 = nil
			end

			if 0.45 < arg_255_1.time_ and arg_255_1.time_ <= 0.45 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			local var_258_3 = 0
			local var_258_4 = 1.45

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_5 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(424111058).content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 58 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 58)

				if (58 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 58)) > 0 and var_258_4 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_3
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_4, arg_255_1.talkMaxDuration)

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_3) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_3 + var_258_8 and arg_255_1.time_ < var_258_3 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play424111059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424111059
		arg_259_1.duration_ = 10.53

		local var_259_0 = {
			zh = 8.066,
			ja = 10.533
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
				arg_259_0:Play424111060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1094"]) and arg_259_1.var_.actorSpriteComps1094 == nil then
				arg_259_1.var_.actorSpriteComps1094 = arg_259_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1094"]) then
				if arg_259_1.var_.actorSpriteComps1094 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 1, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1094"]) and arg_259_1.var_.actorSpriteComps1094 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps1094 = nil
			end

			local var_262_2 = arg_259_1.actors_["1094"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1094 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1094", 4)

				for iter_262_4 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_4)

					if var_262_3.name == "split_3" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_259_1.time_ - 0) / var_262_4)
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_262_5 = 0
			local var_262_6 = 0.725

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(424111059)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 29 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 29)

				if (29 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 29)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111059", "story_v_out_424111.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111059", "story_v_out_424111.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_424111", "424111059", "story_v_out_424111.awb")

						arg_259_1:RecordAudio("424111059", var_262_12)
						arg_259_1:RecordAudio("424111059", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_424111", "424111059", "story_v_out_424111.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_424111", "424111059", "story_v_out_424111.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_13 and arg_259_1.time_ < var_262_5 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424111060
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play424111061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1094"]) and arg_263_1.var_.actorSpriteComps1094 == nil then
				arg_263_1.var_.actorSpriteComps1094 = arg_263_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1094"]) then
				if arg_263_1.var_.actorSpriteComps1094 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1094"]) and arg_263_1.var_.actorSpriteComps1094 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps1094 = nil
			end

			local var_266_2 = 0
			local var_266_3 = 0.825

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

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(424111060).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 33 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 33)

				if (33 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 33)) > 0 and var_266_3 < var_266_6 then
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

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play424111061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424111061
		arg_267_1.duration_ = 6.67

		local var_267_0 = {
			zh = 5.833,
			ja = 6.666
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
				arg_267_0:Play424111062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10153"]) and arg_267_1.var_.actorSpriteComps10153 == nil then
				arg_267_1.var_.actorSpriteComps10153 = arg_267_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10153"]) then
				if arg_267_1.var_.actorSpriteComps10153 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10153"]) and arg_267_1.var_.actorSpriteComps10153 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps10153 = nil
			end

			local var_270_2 = arg_267_1.actors_["10153"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10153 = var_270_2.localPosition
				var_270_2.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10153", 2)

				for iter_270_4 = 0, var_270_2.childCount - 1 do
					local var_270_3 = var_270_2:GetChild(iter_270_4)

					if var_270_3.name == "split_1" then
						var_270_3:SetAsLastSibling()
						var_270_3.gameObject:SetActive(true)

						arg_267_1.var_.actorSpriteSplit10153 = var_270_3.gameObject:GetComponent(typeof(Image))

						arg_267_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_270_4 = 0.5

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_2.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_267_1.time_ - 0) / var_270_4)

				if arg_267_1.var_.actorSpriteSplit10153 ~= nil then
					arg_267_1.var_.actorSpriteSplit10153:SetAlpha((arg_267_1.time_ - 0) / var_270_4)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_267_1.var_.actorSpriteSplit10153 ~= nil then
					arg_267_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_270_5 = 0
			local var_270_6 = 0.725

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(424111061)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 29 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 29)

				if (29 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 29)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111061", "story_v_out_424111.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111061", "story_v_out_424111.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_424111", "424111061", "story_v_out_424111.awb")

						arg_267_1:RecordAudio("424111061", var_270_12)
						arg_267_1:RecordAudio("424111061", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_424111", "424111061", "story_v_out_424111.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_424111", "424111061", "story_v_out_424111.awb")
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

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play424111062 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424111062
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424111063(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["10153"]) and arg_271_1.var_.actorSpriteComps10153 == nil then
				arg_271_1.var_.actorSpriteComps10153 = arg_271_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["10153"]) then
				if arg_271_1.var_.actorSpriteComps10153 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["10153"]) and arg_271_1.var_.actorSpriteComps10153 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps10153 = nil
			end

			local var_274_2 = arg_271_1.actors_["10153"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10153 = var_274_2.localPosition
				var_274_2.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10153", 7)

				for iter_274_4 = 0, var_274_2.childCount - 1 do
					local var_274_3 = var_274_2:GetChild(iter_274_4)

					if var_274_3.name == "" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_2.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 0) / var_274_4)
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_5 = arg_271_1.actors_["1094"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1094 = var_274_5.localPosition
				var_274_5.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1094", 7)

				for iter_274_5 = 0, var_274_5.childCount - 1 do
					local var_274_6 = var_274_5:GetChild(iter_274_5)

					if var_274_6.name == "" or not string.find(var_274_6.name, "split") then
						var_274_6.gameObject:SetActive(true)
					else
						var_274_6.gameObject:SetActive(false)
					end
				end
			end

			local var_274_7 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				var_274_5.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 0) / var_274_7)
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				var_274_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_8 = 0
			local var_274_9 = 0.9

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(424111062).content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_12 = 36 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_10) / 36)

				if (36 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_10) / 36)) > 0 and var_274_9 < var_274_12 then
					arg_271_1.talkMaxDuration = var_274_12

					if var_274_12 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_13 and arg_271_1.time_ < var_274_8 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111063 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 424111063
		arg_275_1.duration_ = 2.17

		local var_275_0 = {
			zh = 2.166,
			ja = 1.966
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
				arg_275_0:Play424111064(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.2

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:GetWordFromCfg(424111063)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 8 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 8)

				if (8 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 8)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111063", "story_v_out_424111.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111063", "story_v_out_424111.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_424111", "424111063", "story_v_out_424111.awb")

						arg_275_1:RecordAudio("424111063", var_278_6)
						arg_275_1:RecordAudio("424111063", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_424111", "424111063", "story_v_out_424111.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_424111", "424111063", "story_v_out_424111.awb")
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
	Play424111064 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 424111064
		arg_279_1.duration_ = 2.37

		local var_279_0 = {
			zh = 2.166,
			ja = 2.366
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
				arg_279_0:Play424111065(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10153"]) and arg_279_1.var_.actorSpriteComps10153 == nil then
				arg_279_1.var_.actorSpriteComps10153 = arg_279_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10153"]) then
				if arg_279_1.var_.actorSpriteComps10153 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10153"]) and arg_279_1.var_.actorSpriteComps10153 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10153 = nil
			end

			local var_282_2 = arg_279_1.actors_["10153"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10153 = var_282_2.localPosition
				var_282_2.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10153", 3)

				for iter_282_4 = 0, var_282_2.childCount - 1 do
					local var_282_3 = var_282_2:GetChild(iter_282_4)

					if var_282_3.name == "split_1" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_2.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_279_1.time_ - 0) / var_282_4)
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_282_5 = 0
			local var_282_6 = 0.275

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(424111064)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 11 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 11)

				if (11 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 11)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111064", "story_v_out_424111.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111064", "story_v_out_424111.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_424111", "424111064", "story_v_out_424111.awb")

						arg_279_1:RecordAudio("424111064", var_282_12)
						arg_279_1:RecordAudio("424111064", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_424111", "424111064", "story_v_out_424111.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_424111", "424111064", "story_v_out_424111.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_13 and arg_279_1.time_ < var_282_5 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play424111065 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 424111065
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play424111066(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10153"]) and arg_283_1.var_.actorSpriteComps10153 == nil then
				arg_283_1.var_.actorSpriteComps10153 = arg_283_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10153"]) then
				if arg_283_1.var_.actorSpriteComps10153 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10153"]) and arg_283_1.var_.actorSpriteComps10153 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps10153 = nil
			end

			local var_286_2 = arg_283_1.actors_["10153"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10153 = var_286_2.localPosition
				var_286_2.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10153", 7)

				for iter_286_4 = 0, var_286_2.childCount - 1 do
					local var_286_3 = var_286_2:GetChild(iter_286_4)

					if var_286_3.name == "" or not string.find(var_286_3.name, "split") then
						var_286_3.gameObject:SetActive(true)
					else
						var_286_3.gameObject:SetActive(false)
					end
				end
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_2.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_283_1.time_ - 0) / var_286_4)
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_5 = manager.ui.mainCamera.transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.shakeOldPos = var_286_5.localPosition
			end

			local var_286_6 = 1

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_6 then
				local var_286_7, var_286_8 = math.modf((arg_283_1.time_ - 0) / 0.066)

				var_286_5.localPosition = Vector3.New(var_286_8 * 0.13, var_286_8 * 0.13, var_286_8 * 0.13) + arg_283_1.var_.shakeOldPos
			end

			if arg_283_1.time_ >= 0 + var_286_6 and arg_283_1.time_ < 0 + var_286_6 + arg_286_0 then
				var_286_5.localPosition = arg_283_1.var_.shakeOldPos
			end

			local var_286_9 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= var_286_9 + 1 and arg_283_1.time_ < var_286_9 + 1 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_286_11 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_11 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= var_286_11 + 0.966666666666667 and arg_283_1.time_ < var_286_11 + 0.966666666666667 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_12 = 0
			local var_286_13 = 0.975

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_12 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_14 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(424111065).content)

				arg_283_1.text_.text = var_286_14

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_16 = 39 <= 0 and var_286_13 or var_286_13 * (utf8.len(var_286_14) / 39)

				if (39 <= 0 and var_286_13 or var_286_13 * (utf8.len(var_286_14) / 39)) > 0 and var_286_13 < var_286_16 then
					arg_283_1.talkMaxDuration = var_286_16

					if var_286_16 + var_286_12 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_12
					end
				end

				arg_283_1.text_.text = var_286_14
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_17 = math.max(var_286_13, arg_283_1.talkMaxDuration)

			if var_286_12 <= arg_283_1.time_ and arg_283_1.time_ < var_286_12 + var_286_17 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_12) / var_286_17

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_12 + var_286_17 and arg_283_1.time_ < var_286_12 + var_286_17 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111066 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 424111066
		arg_287_1.duration_ = 4.37

		local var_287_0 = {
			zh = 4.366,
			ja = 4.233
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
				arg_287_0:Play424111067(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10153"]) and arg_287_1.var_.actorSpriteComps10153 == nil then
				arg_287_1.var_.actorSpriteComps10153 = arg_287_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10153"]) then
				if arg_287_1.var_.actorSpriteComps10153 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10153"]) and arg_287_1.var_.actorSpriteComps10153 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps10153 = nil
			end

			local var_290_2 = arg_287_1.actors_["10153"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10153 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10153", 3)

				for iter_290_4 = 0, var_290_2.childCount - 1 do
					local var_290_3 = var_290_2:GetChild(iter_290_4)

					if var_290_3.name == "split_3" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_287_1.time_ - 0) / var_290_4)
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_290_5 = 0
			local var_290_6 = 0.4

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(424111066)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 16 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 16)

				if (16 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 16)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111066", "story_v_out_424111.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111066", "story_v_out_424111.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_424111", "424111066", "story_v_out_424111.awb")

						arg_287_1:RecordAudio("424111066", var_290_12)
						arg_287_1:RecordAudio("424111066", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_424111", "424111066", "story_v_out_424111.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_424111", "424111066", "story_v_out_424111.awb")
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play424111067 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 424111067
		arg_291_1.duration_ = 6.97

		local var_291_0 = {
			zh = 6.4,
			ja = 6.966
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
				arg_291_0:Play424111068(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_9000

			if arg_291_1.bgs_.SS2403 == nil then
				local var_294_0 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2403")
				var_294_0.name = "SS2403"
				var_294_0.transform.parent = arg_291_1.stage_.transform
				var_294_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_.SS2403 = var_294_0
			end

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				local var_294_1 = arg_291_1.bgs_.SS2403

				arg_291_1.bgs_.SS2403.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_2 = var_294_1:GetComponent("SpriteRenderer")

				if var_294_2 and var_294_2.sprite then
					local var_294_3 = 2 * (var_294_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_1.transform.localScale = Vector3.New(var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "SS2403" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_4 = 4

			if 4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			if arg_291_1.time_ >= var_294_4 + 0.3 and arg_291_1.time_ < var_294_4 + 0.3 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			local var_294_5 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_6 = 2

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_6 then
				local var_294_7 = Color.New(0, 0, 0)

				var_294_7.a = Mathf.Lerp(0, 1, (arg_291_1.time_ - var_294_5) / var_294_6)
				arg_291_1.mask_.color = var_294_7
			end

			if arg_291_1.time_ >= var_294_5 + var_294_6 and arg_291_1.time_ < var_294_5 + var_294_6 + arg_294_0 then
				local var_294_8 = Color.New(0, 0, 0)

				var_294_8.a = 1
				arg_291_1.mask_.color = var_294_8
			end

			local var_294_9 = 2

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_10 = 2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 then
				local var_294_11 = Color.New(0, 0, 0)

				var_294_11.a = Mathf.Lerp(1, 0, (arg_291_1.time_ - var_294_9) / var_294_10)
				arg_291_1.mask_.color = var_294_11
			end

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 then
				local var_294_12 = Color.New(0, 0, 0)

				arg_291_1.mask_.enabled = false
				var_294_12.a = 0
				arg_291_1.mask_.color = var_294_12
			end

			local var_294_13 = arg_291_1.actors_["10153"]

			if 1.966 < arg_291_1.time_ and arg_291_1.time_ <= 1.966 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.actorSpriteComps10153 == nil then
				arg_291_1.var_.actorSpriteComps10153 = var_294_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_14 = 0.034

			if 1.966 <= arg_291_1.time_ and arg_291_1.time_ < 1.966 + var_294_14 and not isNil(var_294_13) then
				if arg_291_1.var_.actorSpriteComps10153 then
					for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_294_3 then
							if arg_291_1.isInRecall_ then
								iter_294_3.color = Color.New(Mathf.Lerp(iter_294_3.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 1.966) / var_294_14), Mathf.Lerp(iter_294_3.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 1.966) / var_294_14), (Mathf.Lerp(iter_294_3.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 1.966) / var_294_14)))
							else
								local var_294_15 = Mathf.Lerp(iter_294_3.color.r, 0.5, (arg_291_1.time_ - 1.966) / var_294_14)

								iter_294_3.color = Color.New(var_294_15, var_294_15, var_294_15)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 1.966 + var_294_14 and arg_291_1.time_ < 1.966 + var_294_14 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.actorSpriteComps10153 then
				for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_294_5 then
						iter_294_5.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10153 = nil
			end

			local var_294_16 = arg_291_1.actors_["10153"].transform

			if 1.966 < arg_291_1.time_ and arg_291_1.time_ <= 1.966 + arg_294_0 then
				arg_291_1.var_.moveOldPos10153 = var_294_16.localPosition
				var_294_16.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10153", 7)

				for iter_294_6 = 0, var_294_16.childCount - 1 do
					local var_294_17 = var_294_16:GetChild(iter_294_6)

					if var_294_17.name == "" or not string.find(var_294_17.name, "split") then
						var_294_17.gameObject:SetActive(true)
					else
						var_294_17.gameObject:SetActive(false)
					end
				end
			end

			local var_294_18 = 0.001

			if 1.966 <= arg_291_1.time_ and arg_291_1.time_ < 1.966 + var_294_18 then
				var_294_16.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 1.966) / var_294_18)
			end

			if arg_291_1.time_ >= 1.966 + var_294_18 and arg_291_1.time_ < 1.966 + var_294_18 + arg_294_0 then
				var_294_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				if arg_291_1.var_.effecthainenghudun1 then
					Object.Destroy(arg_291_1.var_.effecthainenghudun1)

					arg_291_1.var_.effecthainenghudun1 = nil
				end
			end

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				local var_294_20 = arg_291_1.var_.effecthailasongbie1

				if not arg_291_1.var_.effecthailasongbie1 then
					var_294_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blueglow"), manager.ui.mainCamera.transform)
					var_294_20.name = "hailasongbie1"
					arg_291_1.var_.effecthailasongbie1 = var_294_20
				else
					var_294_20.transform:SetParent(var_294_9000)
				end

				var_294_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_294_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_294_22 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_294_7, iter_294_8 in ipairs((var_294_20.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_294_8.transform.localScale = Vector3.New(iter_294_8.transform.localScale.x / var_294_22 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_294_8.transform.localScale.y / var_294_22, iter_294_8.transform.localScale.z)
				end
			end

			local var_294_24 = arg_291_1.bgs_.SS2403.transform

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				arg_291_1.var_.moveOldPosSS2403 = var_294_24.localPosition
			end

			local var_294_25 = 2.075

			if 2 <= arg_291_1.time_ and arg_291_1.time_ < 2 + var_294_25 then
				var_294_24.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosSS2403, Vector3.New(0, 1, 10), (arg_291_1.time_ - 2) / var_294_25)
			end

			if arg_291_1.time_ >= 2 + var_294_25 and arg_291_1.time_ < 2 + var_294_25 + arg_294_0 then
				var_294_24.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_26 = 4
			local var_294_27 = 0.175

			if 4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_26 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_28 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_28:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_29 = arg_291_1:GetWordFromCfg(424111067)
				local var_294_30 = arg_291_1:FormatText(var_294_29.content)

				arg_291_1.text_.text = var_294_30

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_32 = 7 <= 0 and var_294_27 or var_294_27 * (utf8.len(var_294_30) / 7)

				if (7 <= 0 and var_294_27 or var_294_27 * (utf8.len(var_294_30) / 7)) > 0 and var_294_27 < var_294_32 then
					arg_291_1.talkMaxDuration = var_294_32
					var_294_26 = var_294_26 + 0.3

					if var_294_32 + var_294_26 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_32 + var_294_26
					end
				end

				arg_291_1.text_.text = var_294_30
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111067", "story_v_out_424111.awb") ~= 0 then
					local var_294_33 = manager.audio:GetVoiceLength("story_v_out_424111", "424111067", "story_v_out_424111.awb") / 1000

					if var_294_33 + var_294_26 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_33 + var_294_26
					end

					if var_294_29.prefab_name ~= "" and arg_291_1.actors_[var_294_29.prefab_name] ~= nil then
						local var_294_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_29.prefab_name].transform, "story_v_out_424111", "424111067", "story_v_out_424111.awb")

						arg_291_1:RecordAudio("424111067", var_294_34)
						arg_291_1:RecordAudio("424111067", var_294_34)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_424111", "424111067", "story_v_out_424111.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_424111", "424111067", "story_v_out_424111.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_35 = var_294_26 + 0.3
			local var_294_36 = math.max(var_294_27, arg_291_1.talkMaxDuration)

			if var_294_26 + 0.3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_35 + var_294_36 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_35) / var_294_36

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_35 + var_294_36 and arg_291_1.time_ < var_294_35 + var_294_36 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.075,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 3),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play424111068 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 424111068
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play424111069(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0.1 < arg_297_1.time_ and arg_297_1.time_ <= 0.1 + arg_300_0 then
				arg_297_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_light", "")
			end

			local var_300_1 = 0
			local var_300_2 = 0.95

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(424111068).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 38 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 38)

				if (38 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 38)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play424111069 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 424111069
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play424111070(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0.233333333333333 < arg_301_1.time_ and arg_301_1.time_ <= 0.233333333333333 + arg_304_0 then
				arg_301_1:AudioAction("play", "effect", "se_story_136", "se_story_136_metalhit", "")
			end

			local var_304_1 = 0
			local var_304_2 = 1.55

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(424111069).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 62 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 62)

				if (62 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 62)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play424111070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 424111070
		arg_305_1.duration_ = 6.7

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play424111071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_9001
			local var_308_9000

			if arg_305_1.bgs_.SS2403a == nil then
				local var_308_0 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2403a")
				var_308_0.name = "SS2403a"
				var_308_0.transform.parent = arg_305_1.stage_.transform
				var_308_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_.SS2403a = var_308_0
			end

			if 1.2 < arg_305_1.time_ and arg_305_1.time_ <= 1.2 + arg_308_0 then
				local var_308_1 = arg_305_1.bgs_.SS2403a

				arg_305_1.bgs_.SS2403a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_308_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_2 = var_308_1:GetComponent("SpriteRenderer")

				if var_308_2 and var_308_2.sprite then
					local var_308_3 = 2 * (var_308_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_308_1.transform.localScale = Vector3.New(var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "SS2403a" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_4 = 1.7

			if 1.7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			if arg_305_1.time_ >= var_308_4 + 0.3 and arg_305_1.time_ < var_308_4 + 0.3 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				local var_308_5 = arg_305_1.var_.effecthailazhuanchang

				if not arg_305_1.var_.effecthailazhuanchang then
					var_308_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_308_5.name = "hailazhuanchang"
					arg_305_1.var_.effecthailazhuanchang = var_308_5
				else
					var_308_5.transform:SetParent(var_308_9001)
				end

				var_308_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_308_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_308_2, iter_308_3 in ipairs((var_308_5.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_308_3.transform.localScale = Vector3.New(iter_308_3.transform.localScale.x / var_308_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_308_3.transform.localScale.y / var_308_7, iter_308_3.transform.localScale.z)
				end
			end

			if 1.2 < arg_305_1.time_ and arg_305_1.time_ <= 1.2 + arg_308_0 then
				if arg_305_1.var_.effecthailazhuanchang then
					Object.Destroy(arg_305_1.var_.effecthailazhuanchang)

					arg_305_1.var_.effecthailazhuanchang = nil
				end
			end

			if 1.2 < arg_305_1.time_ and arg_305_1.time_ <= 1.2 + arg_308_0 then
				local var_308_10 = arg_305_1.var_.effecthailazhuanchang2

				if not arg_305_1.var_.effecthailazhuanchang2 then
					var_308_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_308_10.name = "hailazhuanchang2"
					arg_305_1.var_.effecthailazhuanchang2 = var_308_10
				else
					var_308_10.transform:SetParent(var_308_9000)
				end

				var_308_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_308_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_308_4, iter_308_5 in ipairs((var_308_10.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_308_5.transform.localScale = Vector3.New(iter_308_5.transform.localScale.x / var_308_12 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_308_5.transform.localScale.y / var_308_12, iter_308_5.transform.localScale.z)
				end
			end

			local var_308_14 = arg_305_1.bgs_.SS2403a.transform

			if 1.2 < arg_305_1.time_ and arg_305_1.time_ <= 1.2 + arg_308_0 then
				arg_305_1.var_.moveOldPosSS2403a = var_308_14.localPosition
			end

			local var_308_15 = 1.76666666666667

			if 1.2 <= arg_305_1.time_ and arg_305_1.time_ < 1.2 + var_308_15 then
				var_308_14.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPosSS2403a, Vector3.New(0, 1, 9), (arg_305_1.time_ - 1.2) / var_308_15)
			end

			if arg_305_1.time_ >= 1.2 + var_308_15 and arg_305_1.time_ < 1.2 + var_308_15 + arg_308_0 then
				var_308_14.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_16 = 1.7
			local var_308_17 = 0.075

			if 1.7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_18 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_18:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1409].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_19 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(424111070).content)

				arg_305_1.text_.text = var_308_19

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_21 = 3 <= 0 and var_308_17 or var_308_17 * (utf8.len(var_308_19) / 3)

				if (3 <= 0 and var_308_17 or var_308_17 * (utf8.len(var_308_19) / 3)) > 0 and var_308_17 < var_308_21 then
					arg_305_1.talkMaxDuration = var_308_21
					var_308_16 = var_308_16 + 0.3

					if var_308_21 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_21 + var_308_16
					end
				end

				arg_305_1.text_.text = var_308_19
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = var_308_16 + 0.3
			local var_308_23 = math.max(var_308_17, arg_305_1.talkMaxDuration)

			if var_308_16 + 0.3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_22 + var_308_23 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_22) / var_308_23

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_22 + var_308_23 and arg_305_1.time_ < var_308_22 + var_308_23 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.76666666666667,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play424111071 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 424111071
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play424111072(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.925

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(424111071).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 37 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 37)

				if (37 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 37)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play424111072 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 424111072
		arg_315_1.duration_ = 1.27

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play424111073(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.1

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(424111072)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 4 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 4)

				if (4 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 4)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111072", "story_v_out_424111.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111072", "story_v_out_424111.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_424111", "424111072", "story_v_out_424111.awb")

						arg_315_1:RecordAudio("424111072", var_318_6)
						arg_315_1:RecordAudio("424111072", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_424111", "424111072", "story_v_out_424111.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_424111", "424111072", "story_v_out_424111.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play424111073 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 424111073
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play424111074(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				local var_322_0 = arg_319_1.var_.effectshennengshoushudao

				if not arg_319_1.var_.effectshennengshoushudao then
					var_322_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_322_0.name = "shennengshoushudao"
					arg_319_1.var_.effectshennengshoushudao = var_322_0
				else
					var_322_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_322_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_322_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_322_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_322_0, iter_322_1 in ipairs((var_322_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_322_1.transform.localScale = Vector3.New(iter_322_1.transform.localScale.x / var_322_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_322_1.transform.localScale.y / var_322_2, iter_322_1.transform.localScale.z)
				end
			end

			if 1.83333333333333 < arg_319_1.time_ and arg_319_1.time_ <= 1.83333333333333 + arg_322_0 then
				if arg_319_1.var_.effectshennengshoushudao then
					Object.Destroy(arg_319_1.var_.effectshennengshoushudao)

					arg_319_1.var_.effectshennengshoushudao = nil
				end
			end

			local var_322_5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				local var_322_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_322_6 then
					var_322_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_322_6.radialBlurScale = 0
					var_322_6.radialBlurGradient = 1
					var_322_6.radialBlurIntensity = 1

					if var_322_5 then
						var_322_6.radialBlurTarget = var_322_5.transform
					end
				end
			end

			local var_322_7 = 1

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				local var_322_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_322_8 then
					var_322_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_322_8.radialBlurScale = Mathf.Lerp(0, 0.272, (arg_319_1.time_ - 0) / var_322_7)
					var_322_8.radialBlurGradient = Mathf.Lerp(1, 1, (arg_319_1.time_ - 0) / var_322_7)
					var_322_8.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_319_1.time_ - 0) / var_322_7)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				local var_322_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_322_9 then
					var_322_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_322_9.radialBlurScale = 0.272
					var_322_9.radialBlurGradient = 1
					var_322_9.radialBlurIntensity = 1
				end
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_Portal", "")
			end

			local var_322_11 = 0
			local var_322_12 = 1.5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_11 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_13 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(424111073).content)

				arg_319_1.text_.text = var_322_13

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_15 = 60 <= 0 and var_322_12 or var_322_12 * (utf8.len(var_322_13) / 60)

				if (60 <= 0 and var_322_12 or var_322_12 * (utf8.len(var_322_13) / 60)) > 0 and var_322_12 < var_322_15 then
					arg_319_1.talkMaxDuration = var_322_15

					if var_322_15 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_15 + var_322_11
					end
				end

				arg_319_1.text_.text = var_322_13
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_12, arg_319_1.talkMaxDuration)

			if var_322_11 <= arg_319_1.time_ and arg_319_1.time_ < var_322_11 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_11) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_11 + var_322_16 and arg_319_1.time_ < var_322_11 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play424111074 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 424111074
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play424111075(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:AudioAction("play", "effect", "se_story_146", "se_story_146_roar02", "")
			end

			local var_326_1 = 0
			local var_326_2 = 0.1

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1409].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(424111074).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 4 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 4)

				if (4 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 4)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play424111075 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 424111075
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play424111076(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 1.45

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(424111075).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 58 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 58)

				if (58 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 58)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play424111076 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 424111076
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play424111077(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0.4 < arg_331_1.time_ and arg_331_1.time_ <= 0.4 + arg_334_0 then
				arg_331_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_rock", "")
			end

			local var_334_1 = 0
			local var_334_2 = 1.4

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(424111076).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 56 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 56)

				if (56 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 56)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play424111077 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 424111077
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play424111078(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.125

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(424111077).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 5 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 5)

				if (5 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 5)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play424111078 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 424111078
		arg_339_1.duration_ = 5.61

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play424111079(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0.5 < arg_339_1.time_ and arg_339_1.time_ <= 0.5 + arg_342_0 then
				local var_342_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_342_0 then
					var_342_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_342_0.radialBlurScale = 0
					var_342_0.radialBlurGradient = 1
					var_342_0.radialBlurIntensity = 1

					if nil then
						var_342_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_342_1 = 0.105201698839664

			if 0.5 <= arg_339_1.time_ and arg_339_1.time_ < 0.5 + var_342_1 then
				local var_342_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_342_2 then
					var_342_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_342_2.radialBlurScale = Mathf.Lerp(0, 0, (arg_339_1.time_ - 0.5) / var_342_1)
					var_342_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_339_1.time_ - 0.5) / var_342_1)
					var_342_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_339_1.time_ - 0.5) / var_342_1)
				end
			end

			if arg_339_1.time_ >= 0.5 + var_342_1 and arg_339_1.time_ < 0.5 + var_342_1 + arg_342_0 then
				local var_342_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_342_3 then
					var_342_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_342_3.radialBlurScale = 0
					var_342_3.radialBlurGradient = 1
					var_342_3.radialBlurIntensity = 1
				end
			end

			local var_342_4 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_5 = 0.5

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_5 then
				local var_342_6 = Color.New(1, 1, 1)

				var_342_6.a = Mathf.Lerp(0, 1, (arg_339_1.time_ - var_342_4) / var_342_5)
				arg_339_1.mask_.color = var_342_6
			end

			if arg_339_1.time_ >= var_342_4 + var_342_5 and arg_339_1.time_ < var_342_4 + var_342_5 + arg_342_0 then
				local var_342_7 = Color.New(1, 1, 1)

				var_342_7.a = 1
				arg_339_1.mask_.color = var_342_7
			end

			local var_342_8 = 0.5

			if 0.5 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_9 = 0.7

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_9 then
				local var_342_10 = Color.New(1, 1, 1)

				var_342_10.a = Mathf.Lerp(1, 0, (arg_339_1.time_ - var_342_8) / var_342_9)
				arg_339_1.mask_.color = var_342_10
			end

			if arg_339_1.time_ >= var_342_8 + var_342_9 and arg_339_1.time_ < var_342_8 + var_342_9 + arg_342_0 then
				local var_342_11 = Color.New(1, 1, 1)

				arg_339_1.mask_.enabled = false
				var_342_11.a = 0
				arg_339_1.mask_.color = var_342_11
			end

			local var_342_12 = manager.ui.mainCamera.transform

			if 0.5 < arg_339_1.time_ and arg_339_1.time_ <= 0.5 + arg_342_0 then
				arg_339_1.var_.shakeOldPos = var_342_12.localPosition
			end

			local var_342_13 = 0.6

			if 0.5 <= arg_339_1.time_ and arg_339_1.time_ < 0.5 + var_342_13 then
				local var_342_14, var_342_15 = math.modf((arg_339_1.time_ - 0.5) / 0.066)

				var_342_12.localPosition = Vector3.New(var_342_15 * 0.13, var_342_15 * 0.13, var_342_15 * 0.13) + arg_339_1.var_.shakeOldPos
			end

			if arg_339_1.time_ >= 0.5 + var_342_13 and arg_339_1.time_ < 0.5 + var_342_13 + arg_342_0 then
				var_342_12.localPosition = arg_339_1.var_.shakeOldPos
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:AudioAction("play", "effect", "se_story_140", "se_story_140_laser", "")
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_17 = 0.605201698839664
			local var_342_18 = 1.15

			if 0.605201698839664 < arg_339_1.time_ and arg_339_1.time_ <= var_342_17 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_19 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_19:setOnUpdate(LuaHelper.FloatAction(function(arg_343_0)
					arg_339_1.dialogCg_.alpha = arg_343_0
				end))
				var_342_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_20 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(424111078).content)

				arg_339_1.text_.text = var_342_20

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_22 = 46 <= 0 and var_342_18 or var_342_18 * (utf8.len(var_342_20) / 46)

				if (46 <= 0 and var_342_18 or var_342_18 * (utf8.len(var_342_20) / 46)) > 0 and var_342_18 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22
					var_342_17 = var_342_17 + 0.3

					if var_342_22 + var_342_17 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_17
					end
				end

				arg_339_1.text_.text = var_342_20
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_23 = var_342_17 + 0.3
			local var_342_24 = math.max(var_342_18, arg_339_1.talkMaxDuration)

			if var_342_17 + 0.3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_23 + var_342_24 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_23) / var_342_24

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_23 + var_342_24 and arg_339_1.time_ < var_342_23 + var_342_24 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play424111079 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 424111079
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play424111080(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion04", "")
			end

			local var_348_1 = 0
			local var_348_2 = 1.625

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(424111079).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 65 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 65)

				if (65 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 65)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play424111080 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 424111080
		arg_349_1.duration_ = 4.17

		local var_349_0 = {
			zh = 3.233,
			ja = 4.166
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play424111081(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPosSS2403a = arg_349_1.bgs_.SS2403a.transform.localPosition
			end

			local var_352_0 = 1

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.bgs_.SS2403a.transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPosSS2403a, Vector3.New(0, 1, 8), (arg_349_1.time_ - 0) / var_352_0)
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.bgs_.SS2403a.transform.localPosition = Vector3.New(0, 1, 8)
			end

			local var_352_1 = 0
			local var_352_2 = 0.25

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_3 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_3:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(424111080)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 10 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_5) / 10)

				if (10 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_5) / 10)) > 0 and var_352_2 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7
					var_352_1 = var_352_1 + 0.3

					if var_352_7 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111080", "story_v_out_424111.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111080", "story_v_out_424111.awb") / 1000

					if var_352_8 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_1
					end

					if var_352_4.prefab_name ~= "" and arg_349_1.actors_[var_352_4.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_4.prefab_name].transform, "story_v_out_424111", "424111080", "story_v_out_424111.awb")

						arg_349_1:RecordAudio("424111080", var_352_9)
						arg_349_1:RecordAudio("424111080", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_424111", "424111080", "story_v_out_424111.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_424111", "424111080", "story_v_out_424111.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = var_352_1 + 0.3
			local var_352_11 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 + 0.3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_10) / var_352_11

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play424111081 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 424111081
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play424111082(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.2

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(424111081).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 48 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 48)

				if (48 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 48)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play424111082 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 424111082
		arg_359_1.duration_ = 6.5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play424111083(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if arg_359_1.bgs_.SS2403b == nil then
				local var_362_0 = Object.Instantiate(arg_359_1.paintGo_)

				var_362_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2403b")
				var_362_0.name = "SS2403b"
				var_362_0.transform.parent = arg_359_1.stage_.transform
				var_362_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.bgs_.SS2403b = var_362_0
			end

			if 1 < arg_359_1.time_ and arg_359_1.time_ <= 1 + arg_362_0 then
				local var_362_1 = arg_359_1.bgs_.SS2403b

				arg_359_1.bgs_.SS2403b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_362_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_362_2 = var_362_1:GetComponent("SpriteRenderer")

				if var_362_2 and var_362_2.sprite then
					local var_362_3 = 2 * (var_362_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_362_1.transform.localScale = Vector3.New(var_362_3 / var_362_2.sprite.bounds.size.y < var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x and var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x or var_362_3 / var_362_2.sprite.bounds.size.y, var_362_3 / var_362_2.sprite.bounds.size.y < var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x and var_362_3 * manager.ui.mainCameraCom_.aspect / var_362_2.sprite.bounds.size.x or var_362_3 / var_362_2.sprite.bounds.size.y, 0)
				end

				for iter_362_0, iter_362_1 in pairs(arg_359_1.bgs_) do
					if iter_362_0 ~= "SS2403b" then
						iter_362_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_362_4 = 1.5

			if 1.5 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			if arg_359_1.time_ >= var_362_4 + 0.3 and arg_359_1.time_ < var_362_4 + 0.3 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_5 = 0

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_6 = 1

			if var_362_5 <= arg_359_1.time_ and arg_359_1.time_ < var_362_5 + var_362_6 then
				local var_362_7 = Color.New(1, 1, 1)

				var_362_7.a = Mathf.Lerp(0, 1, (arg_359_1.time_ - var_362_5) / var_362_6)
				arg_359_1.mask_.color = var_362_7
			end

			if arg_359_1.time_ >= var_362_5 + var_362_6 and arg_359_1.time_ < var_362_5 + var_362_6 + arg_362_0 then
				local var_362_8 = Color.New(1, 1, 1)

				var_362_8.a = 1
				arg_359_1.mask_.color = var_362_8
			end

			local var_362_9 = 1

			if 1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_10 = 0.5

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_10 then
				local var_362_11 = Color.New(1, 1, 1)

				var_362_11.a = Mathf.Lerp(1, 0, (arg_359_1.time_ - var_362_9) / var_362_10)
				arg_359_1.mask_.color = var_362_11
			end

			if arg_359_1.time_ >= var_362_9 + var_362_10 and arg_359_1.time_ < var_362_9 + var_362_10 + arg_362_0 then
				local var_362_12 = Color.New(1, 1, 1)

				arg_359_1.mask_.enabled = false
				var_362_12.a = 0
				arg_359_1.mask_.color = var_362_12
			end

			local var_362_13 = arg_359_1.bgs_.SS2403b.transform

			if 1 < arg_359_1.time_ and arg_359_1.time_ <= 1 + arg_362_0 then
				arg_359_1.var_.moveOldPosSS2403b = var_362_13.localPosition
			end

			local var_362_14 = 1.5

			if 1 <= arg_359_1.time_ and arg_359_1.time_ < 1 + var_362_14 then
				var_362_13.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPosSS2403b, Vector3.New(0, 1, 10), (arg_359_1.time_ - 1) / var_362_14)
			end

			if arg_359_1.time_ >= 1 + var_362_14 and arg_359_1.time_ < 1 + var_362_14 + arg_362_0 then
				var_362_13.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_144", "se_story_144_eject", "")
			end

			local var_362_16 = 1

			if 1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			if arg_359_1.time_ >= var_362_16 + 1.5 and arg_359_1.time_ < var_362_16 + 1.5 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_17 = 1.5
			local var_362_18 = 1.4

			if 1.5 < arg_359_1.time_ and arg_359_1.time_ <= var_362_17 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_19 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_19:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_20 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(424111082).content)

				arg_359_1.text_.text = var_362_20

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_22 = 56 <= 0 and var_362_18 or var_362_18 * (utf8.len(var_362_20) / 56)

				if (56 <= 0 and var_362_18 or var_362_18 * (utf8.len(var_362_20) / 56)) > 0 and var_362_18 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22
					var_362_17 = var_362_17 + 0.3

					if var_362_22 + var_362_17 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_17
					end
				end

				arg_359_1.text_.text = var_362_20
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_23 = var_362_17 + 0.3
			local var_362_24 = math.max(var_362_18, arg_359_1.talkMaxDuration)

			if var_362_17 + 0.3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_23 + var_362_24 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_23) / var_362_24

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_23 + var_362_24 and arg_359_1.time_ < var_362_23 + var_362_24 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 1, 5.6),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play424111083 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 424111083
		arg_365_1.duration_ = 1.63

		local var_365_0 = {
			zh = 1.233,
			ja = 1.633
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
				arg_365_0:Play424111084(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.075

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(424111083)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 3 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 3)

				if (3 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 3)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111083", "story_v_out_424111.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111083", "story_v_out_424111.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_424111", "424111083", "story_v_out_424111.awb")

						arg_365_1:RecordAudio("424111083", var_368_6)
						arg_365_1:RecordAudio("424111083", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_424111", "424111083", "story_v_out_424111.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_424111", "424111083", "story_v_out_424111.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play424111084 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 424111084
		arg_369_1.duration_ = 6.93

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play424111085(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				local var_372_0 = arg_369_1.var_.effectshennenghongliu

				if not arg_369_1.var_.effectshennenghongliu then
					var_372_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_glowmask_white"), manager.ui.mainCamera.transform)
					var_372_0.name = "shennenghongliu"
					arg_369_1.var_.effectshennenghongliu = var_372_0
				else
					var_372_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_372_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_372_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_372_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_372_0, iter_372_1 in ipairs((var_372_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_372_1.transform.localScale = Vector3.New(iter_372_1.transform.localScale.x / var_372_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_372_1.transform.localScale.y / var_372_2, iter_372_1.transform.localScale.z)
				end
			end

			local var_372_4 = "STwhite"

			if arg_369_1.bgs_.STwhite == nil then
				local var_372_5 = Object.Instantiate(arg_369_1.paintGo_)

				var_372_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_372_4)
				var_372_5.name = var_372_4
				var_372_5.transform.parent = arg_369_1.stage_.transform
				var_372_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.bgs_[var_372_4] = var_372_5
			end

			if 1.93333333333333 < arg_369_1.time_ and arg_369_1.time_ <= 1.93333333333333 + arg_372_0 then
				local var_372_6 = arg_369_1.bgs_.STwhite

				arg_369_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_372_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_7 = var_372_6:GetComponent("SpriteRenderer")

				if var_372_7 and var_372_7.sprite then
					local var_372_8 = 2 * (var_372_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_372_6.transform.localScale = Vector3.New(var_372_8 / var_372_7.sprite.bounds.size.y < var_372_8 * manager.ui.mainCameraCom_.aspect / var_372_7.sprite.bounds.size.x and var_372_8 * manager.ui.mainCameraCom_.aspect / var_372_7.sprite.bounds.size.x or var_372_8 / var_372_7.sprite.bounds.size.y, var_372_8 / var_372_7.sprite.bounds.size.y < var_372_8 * manager.ui.mainCameraCom_.aspect / var_372_7.sprite.bounds.size.x and var_372_8 * manager.ui.mainCameraCom_.aspect / var_372_7.sprite.bounds.size.x or var_372_8 / var_372_7.sprite.bounds.size.y, 0)
				end

				for iter_372_2, iter_372_3 in pairs(arg_369_1.bgs_) do
					if iter_372_2 ~= "STwhite" then
						iter_372_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.93333333333333 < arg_369_1.time_ and arg_369_1.time_ <= 1.93333333333333 + arg_372_0 then
				if arg_369_1.var_.effecthailasongbie1 then
					Object.Destroy(arg_369_1.var_.effecthailasongbie1)

					arg_369_1.var_.effecthailasongbie1 = nil
				end
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:AudioAction("play", "effect", "se_story_16", "se_story_16_energy02", "")
			end

			local var_372_11 = 1.93333333333333
			local var_372_12 = 1.55

			if 1.93333333333333 < arg_369_1.time_ and arg_369_1.time_ <= var_372_11 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_13 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(424111084).content)

				arg_369_1.text_.text = var_372_13

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_15 = 62 <= 0 and var_372_12 or var_372_12 * (utf8.len(var_372_13) / 62)

				if (62 <= 0 and var_372_12 or var_372_12 * (utf8.len(var_372_13) / 62)) > 0 and var_372_12 < var_372_15 then
					arg_369_1.talkMaxDuration = var_372_15

					if var_372_15 + var_372_11 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_11
					end
				end

				arg_369_1.text_.text = var_372_13
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_12, arg_369_1.talkMaxDuration)

			if var_372_11 <= arg_369_1.time_ and arg_369_1.time_ < var_372_11 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_11) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_11 + var_372_16 and arg_369_1.time_ < var_372_11 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 15,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/UpDown_Shake",
				duration = 1.93333333333333,
				amplitudeGain = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play424111085 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 424111085
		arg_373_1.duration_ = 9

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play424111086(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 2 < arg_373_1.time_ and arg_373_1.time_ <= 2 + arg_376_0 then
				local var_376_0 = arg_373_1.bgs_.ST0117

				arg_373_1.bgs_.ST0117.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_376_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_1 = var_376_0:GetComponent("SpriteRenderer")

				if var_376_1 and var_376_1.sprite then
					local var_376_2 = 2 * (var_376_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_376_0.transform.localScale = Vector3.New(var_376_2 / var_376_1.sprite.bounds.size.y < var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x and var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x or var_376_2 / var_376_1.sprite.bounds.size.y, var_376_2 / var_376_1.sprite.bounds.size.y < var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x and var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x or var_376_2 / var_376_1.sprite.bounds.size.y, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "ST0117" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_376_3 = 4

			if 4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			if arg_373_1.time_ >= var_376_3 + 0.3 and arg_373_1.time_ < var_376_3 + 0.3 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end

			local var_376_4 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_5 = 2

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_5 then
				local var_376_6 = Color.New(0, 0, 0)

				var_376_6.a = Mathf.Lerp(0, 1, (arg_373_1.time_ - var_376_4) / var_376_5)
				arg_373_1.mask_.color = var_376_6
			end

			if arg_373_1.time_ >= var_376_4 + var_376_5 and arg_373_1.time_ < var_376_4 + var_376_5 + arg_376_0 then
				local var_376_7 = Color.New(0, 0, 0)

				var_376_7.a = 1
				arg_373_1.mask_.color = var_376_7
			end

			local var_376_8 = 2

			if 2 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_9 = 2

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_9 then
				local var_376_10 = Color.New(0, 0, 0)

				var_376_10.a = Mathf.Lerp(1, 0, (arg_373_1.time_ - var_376_8) / var_376_9)
				arg_373_1.mask_.color = var_376_10
			end

			if arg_373_1.time_ >= var_376_8 + var_376_9 and arg_373_1.time_ < var_376_8 + var_376_9 + arg_376_0 then
				local var_376_11 = Color.New(0, 0, 0)

				arg_373_1.mask_.enabled = false
				var_376_11.a = 0
				arg_373_1.mask_.color = var_376_11
			end

			if 0.2 < arg_373_1.time_ and arg_373_1.time_ <= 0.2 + arg_376_0 then
				arg_373_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_376_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_373_1.bgmTxt_.text ~= var_376_14 and arg_373_1.bgmTxt_.text ~= "" then
						if arg_373_1.bgmTxt2_.text ~= "" then
							arg_373_1.bgmTxt_.text = arg_373_1.bgmTxt2_.text
						end

						arg_373_1.bgmTxt2_.text = var_376_14

						arg_373_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_373_1.bgmTxt_.text = var_376_14
						arg_373_1.bgmTxt2_.text = var_376_14
					end

					if arg_373_1.bgmTimer then
						arg_373_1.bgmTimer:Stop()

						arg_373_1.bgmTimer = nil
					end

					if arg_373_1.settingData.show_music_name == 1 then
						arg_373_1.musicController:SetSelectedState("show")
						arg_373_1.musicAnimator_:Play("open", 0, 0)

						if arg_373_1.settingData.music_time ~= 0 then
							arg_373_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_373_1.settingData.music_time), function()
								if arg_373_1 == nil or isNil(arg_373_1.bgmTxt_) then
									return
								end

								arg_373_1.musicController:SetSelectedState("hide")
								arg_373_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_15 = 4
			local var_376_16 = 0.2

			if 4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_15 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_17 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_17:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_373_1.dialogCg_.alpha = arg_378_0
				end))
				var_376_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_18 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(424111085).content)

				arg_373_1.text_.text = var_376_18

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_20 = 8 <= 0 and var_376_16 or var_376_16 * (utf8.len(var_376_18) / 8)

				if (8 <= 0 and var_376_16 or var_376_16 * (utf8.len(var_376_18) / 8)) > 0 and var_376_16 < var_376_20 then
					arg_373_1.talkMaxDuration = var_376_20
					var_376_15 = var_376_15 + 0.3

					if var_376_20 + var_376_15 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_20 + var_376_15
					end
				end

				arg_373_1.text_.text = var_376_18
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_21 = var_376_15 + 0.3
			local var_376_22 = math.max(var_376_16, arg_373_1.talkMaxDuration)

			if var_376_15 + 0.3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_21 + var_376_22 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_21) / var_376_22

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_21 + var_376_22 and arg_373_1.time_ < var_376_21 + var_376_22 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play424111086 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 424111086
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play424111087(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0.866666666666667 < arg_380_1.time_ and arg_380_1.time_ <= 0.866666666666667 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun07", "")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:AudioAction("play", "music", "bgm_story_scheme_2", "bgm_story_scheme_2", "bgm_story_scheme_2.awb")

				local var_383_3 = manager.audio:GetAudioName("bgm_story_scheme_2", "bgm_story_scheme_2")

				if "" ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_3 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_3

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_3
						arg_380_1.bgmTxt2_.text = var_383_3
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_383_4 = 0
			local var_383_5 = 1.55

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_6 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(424111086).content)

				arg_380_1.text_.text = var_383_6

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_8 = 62 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_6) / 62)

				if (62 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_6) / 62)) > 0 and var_383_5 < var_383_8 then
					arg_380_1.talkMaxDuration = var_383_8

					if var_383_8 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_4
					end
				end

				arg_380_1.text_.text = var_383_6
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_9 = math.max(var_383_5, arg_380_1.talkMaxDuration)

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_9 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_4) / var_383_9

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_4 + var_383_9 and arg_380_1.time_ < var_383_4 + var_383_9 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play424111087 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 424111087
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play424111088(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 1.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(424111087).content)

				arg_385_1.text_.text = var_388_1

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_3 = 53 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 53)

				if (53 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 53)) > 0 and var_388_0 < var_388_3 then
					arg_385_1.talkMaxDuration = var_388_3

					if var_388_3 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_3 + 0
					end
				end

				arg_385_1.text_.text = var_388_1
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_4 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_4

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play424111088 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 424111088
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play424111089(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 1.55

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(424111088).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 62 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 62)

				if (62 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 62)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play424111089 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 424111089
		arg_393_1.duration_ = 2.37

		local var_393_0 = {
			zh = 1.7,
			ja = 2.366
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
				arg_393_0:Play424111090(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if arg_393_1.actors_["1194"] == nil then
				local var_396_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1194")

				if not isNil(var_396_0) then
					local var_396_1 = Object.Instantiate(var_396_0, arg_393_1.canvasGo_.transform)

					var_396_1.transform:SetSiblingIndex(1)

					var_396_1.name = "1194"
					var_396_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_393_1.actors_["1194"] = var_396_1

					if arg_393_1.isInRecall_ then
						for iter_396_0, iter_396_1 in ipairs((var_396_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_396_1.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_396_2 = arg_393_1.actors_["1194"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1194 == nil then
				arg_393_1.var_.actorSpriteComps1194 = var_396_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_3 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_3 and not isNil(var_396_2) then
				if arg_393_1.var_.actorSpriteComps1194 then
					for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_396_3 then
							if arg_393_1.isInRecall_ then
								iter_396_3.color = Color.New(Mathf.Lerp(iter_396_3.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_3), Mathf.Lerp(iter_396_3.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_3), (Mathf.Lerp(iter_396_3.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_3)))
							else
								local var_396_4 = Mathf.Lerp(iter_396_3.color.r, 1, (arg_393_1.time_ - 0) / var_396_3)

								iter_396_3.color = Color.New(var_396_4, var_396_4, var_396_4)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_3 and arg_393_1.time_ < 0 + var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1194 then
				for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_396_5 then
						iter_396_5.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1194 = nil
			end

			local var_396_5 = arg_393_1.actors_["1194"].transform

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1194 = var_396_5.localPosition
				var_396_5.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1194", 3)

				for iter_396_6 = 0, var_396_5.childCount - 1 do
					local var_396_6 = var_396_5:GetChild(iter_396_6)

					if var_396_6.name == "split_3" or not string.find(var_396_6.name, "split") then
						var_396_6.gameObject:SetActive(true)
					else
						var_396_6.gameObject:SetActive(false)
					end
				end
			end

			local var_396_7 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				var_396_5.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1194, Vector3.New(-60, -360, -240), (arg_393_1.time_ - 0) / var_396_7)
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				var_396_5.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_396_8 = 0
			local var_396_9 = 0.175

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_10 = arg_393_1:GetWordFromCfg(424111089)
				local var_396_11 = arg_393_1:FormatText(var_396_10.content)

				arg_393_1.text_.text = var_396_11

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_13 = 7 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 7)

				if (7 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 7)) > 0 and var_396_9 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_8
					end
				end

				arg_393_1.text_.text = var_396_11
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111089", "story_v_out_424111.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_424111", "424111089", "story_v_out_424111.awb") / 1000

					if var_396_14 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_8
					end

					if var_396_10.prefab_name ~= "" and arg_393_1.actors_[var_396_10.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_10.prefab_name].transform, "story_v_out_424111", "424111089", "story_v_out_424111.awb")

						arg_393_1:RecordAudio("424111089", var_396_15)
						arg_393_1:RecordAudio("424111089", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_424111", "424111089", "story_v_out_424111.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_424111", "424111089", "story_v_out_424111.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_16 = math.max(var_396_9, arg_393_1.talkMaxDuration)

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_16 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_8) / var_396_16

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_8 + var_396_16 and arg_393_1.time_ < var_396_8 + var_396_16 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play424111090 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424111090
		arg_397_1.duration_ = 4.87

		local var_397_0 = {
			zh = 3.166,
			ja = 4.866
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play424111091(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1194"]) and arg_397_1.var_.actorSpriteComps1194 == nil then
				arg_397_1.var_.actorSpriteComps1194 = arg_397_1.actors_["1194"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1194"]) then
				if arg_397_1.var_.actorSpriteComps1194 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1194:ToTable()) do
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

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1194"]) and arg_397_1.var_.actorSpriteComps1194 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1194 = nil
			end

			local var_400_2 = 0
			local var_400_3 = 0.325

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_4 = arg_397_1:GetWordFromCfg(424111090)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 13 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 13)

				if (13 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 13)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111090", "story_v_out_424111.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111090", "story_v_out_424111.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_out_424111", "424111090", "story_v_out_424111.awb")

						arg_397_1:RecordAudio("424111090", var_400_9)
						arg_397_1:RecordAudio("424111090", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_424111", "424111090", "story_v_out_424111.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_424111", "424111090", "story_v_out_424111.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play424111091 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424111091
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424111092(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.65

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(424111091).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 26 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 26)

				if (26 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 26)) > 0 and var_404_0 < var_404_3 then
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
	Play424111092 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424111092
		arg_405_1.duration_ = 1.7

		local var_405_0 = {
			zh = 1.133,
			ja = 1.7
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424111093(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.125

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_1 = arg_405_1:GetWordFromCfg(424111092)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 5 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 5)

				if (5 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 5)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111092", "story_v_out_424111.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111092", "story_v_out_424111.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_424111", "424111092", "story_v_out_424111.awb")

						arg_405_1:RecordAudio("424111092", var_408_6)
						arg_405_1:RecordAudio("424111092", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_424111", "424111092", "story_v_out_424111.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_424111", "424111092", "story_v_out_424111.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play424111093 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 424111093
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play424111094(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.9

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(424111093).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 36 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 36)

				if (36 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 36)) > 0 and var_412_0 < var_412_3 then
					arg_409_1.talkMaxDuration = var_412_3

					if var_412_3 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_3 + 0
					end
				end

				arg_409_1.text_.text = var_412_1
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_4 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_4

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play424111094 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 424111094
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play424111095(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_9000

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1194 = arg_413_1.actors_["1194"].transform.localPosition
				arg_413_1.actors_["1194"].transform.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1194", 7)

				for iter_416_0 = 0, arg_413_1.actors_["1194"].transform.childCount - 1 do
					local var_416_0 = arg_413_1.actors_["1194"].transform:GetChild(iter_416_0)

					if var_416_0.name == "" or not string.find(var_416_0.name, "split") then
						var_416_0.gameObject:SetActive(true)
					else
						var_416_0.gameObject:SetActive(false)
					end
				end
			end

			local var_416_1 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_1 then
				arg_413_1.actors_["1194"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1194, Vector3.New(0, -2000, 0), (arg_413_1.time_ - 0) / var_416_1)
			end

			if arg_413_1.time_ >= 0 + var_416_1 and arg_413_1.time_ < 0 + var_416_1 + arg_416_0 then
				arg_413_1.actors_["1194"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				local var_416_2 = arg_413_1.var_.effectsaomiaoyifengming1

				if not arg_413_1.var_.effectsaomiaoyifengming1 then
					var_416_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_416_2.name = "saomiaoyifengming1"
					arg_413_1.var_.effectsaomiaoyifengming1 = var_416_2
				else
					var_416_2.transform:SetParent(var_416_9000)
				end

				var_416_2.transform.localPosition = Vector3.New(0, 0, -9)
				var_416_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_416_2.transform.localScale = Vector3.New(var_416_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_416_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_416_2.transform.localScale.z)
			end

			if 0.034 < arg_413_1.time_ and arg_413_1.time_ <= 0.034 + arg_416_0 then
				arg_413_1:AudioAction("play", "effect", "se_story_146", "se_story_146_alarm", "")
			end

			local var_416_5 = 0
			local var_416_6 = 1.275

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_7 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_7:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(424111094).content)

				arg_413_1.text_.text = var_416_8

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 51 <= 0 and var_416_6 or var_416_6 * (utf8.len(var_416_8) / 51)

				if (51 <= 0 and var_416_6 or var_416_6 * (utf8.len(var_416_8) / 51)) > 0 and var_416_6 < var_416_10 then
					arg_413_1.talkMaxDuration = var_416_10
					var_416_5 = var_416_5 + 0.3

					if var_416_10 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_5
					end
				end

				arg_413_1.text_.text = var_416_8
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_11 = var_416_5 + 0.3
			local var_416_12 = math.max(var_416_6, arg_413_1.talkMaxDuration)

			if var_416_5 + 0.3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_11 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_11) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_11 + var_416_12 and arg_413_1.time_ < var_416_11 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play424111095 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 424111095
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play424111096(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				local var_422_0 = arg_419_1.var_.effectsaomiaoyifengming2

				if not arg_419_1.var_.effectsaomiaoyifengming2 then
					var_422_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_out"), manager.ui.mainCamera.transform)
					var_422_0.name = "saomiaoyifengming2"
					arg_419_1.var_.effectsaomiaoyifengming2 = var_422_0
				else
					var_422_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_422_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_422_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_422_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_422_0, iter_422_1 in ipairs((var_422_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_422_1.transform.localScale = Vector3.New(iter_422_1.transform.localScale.x / var_422_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_422_1.transform.localScale.y / var_422_2, iter_422_1.transform.localScale.z)
				end
			end

			if 0.2 < arg_419_1.time_ and arg_419_1.time_ <= 0.2 + arg_422_0 then
				if arg_419_1.var_.effectsaomiaoyifengming1 then
					Object.Destroy(arg_419_1.var_.effectsaomiaoyifengming1)

					arg_419_1.var_.effectsaomiaoyifengming1 = nil
				end
			end

			local var_422_5 = 0
			local var_422_6 = 1.025

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_5 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_7 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(424111095).content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 41 <= 0 and var_422_6 or var_422_6 * (utf8.len(var_422_7) / 41)

				if (41 <= 0 and var_422_6 or var_422_6 * (utf8.len(var_422_7) / 41)) > 0 and var_422_6 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_5 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_5
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_6, arg_419_1.talkMaxDuration)

			if var_422_5 <= arg_419_1.time_ and arg_419_1.time_ < var_422_5 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_5) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_5 + var_422_10 and arg_419_1.time_ < var_422_5 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play424111096 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 424111096
		arg_423_1.duration_ = 6.6

		local var_423_0 = {
			zh = 4.1,
			ja = 6.6
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play424111097(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.575

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:GetWordFromCfg(424111096)
				local var_426_2 = arg_423_1:FormatText(var_426_1.content)

				arg_423_1.text_.text = var_426_2

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 23 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 23)

				if (23 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 23)) > 0 and var_426_0 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end

				arg_423_1.text_.text = var_426_2
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111096", "story_v_out_424111.awb") ~= 0 then
					local var_426_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111096", "story_v_out_424111.awb") / 1000

					if var_426_5 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + 0
					end

					if var_426_1.prefab_name ~= "" and arg_423_1.actors_[var_426_1.prefab_name] ~= nil then
						local var_426_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_1.prefab_name].transform, "story_v_out_424111", "424111096", "story_v_out_424111.awb")

						arg_423_1:RecordAudio("424111096", var_426_6)
						arg_423_1:RecordAudio("424111096", var_426_6)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_424111", "424111096", "story_v_out_424111.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_424111", "424111096", "story_v_out_424111.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_7 and arg_423_1.time_ < 0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play424111097 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 424111097
		arg_427_1.duration_ = 2.43

		local var_427_0 = {
			zh = 2.433,
			ja = 2
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play424111098(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.325

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:GetWordFromCfg(424111097)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 13 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 13)

				if (13 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 13)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111097", "story_v_out_424111.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111097", "story_v_out_424111.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_out_424111", "424111097", "story_v_out_424111.awb")

						arg_427_1:RecordAudio("424111097", var_430_6)
						arg_427_1:RecordAudio("424111097", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_424111", "424111097", "story_v_out_424111.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_424111", "424111097", "story_v_out_424111.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play424111098 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 424111098
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play424111099(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.3

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(424111098).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 12 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 12)

				if (12 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 12)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play424111099 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 424111099
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play424111100(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				local var_438_0 = arg_435_1.var_.effectsaomiaoyifengming3

				if not arg_435_1.var_.effectsaomiaoyifengming3 then
					var_438_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_438_0.name = "saomiaoyifengming3"
					arg_435_1.var_.effectsaomiaoyifengming3 = var_438_0
				else
					var_438_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_438_0.transform.localPosition = Vector3.New(0, -0.28, 0)
				var_438_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_438_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_438_0, iter_438_1 in ipairs((var_438_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_438_1.transform.localScale = Vector3.New(iter_438_1.transform.localScale.x / var_438_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_438_1.transform.localScale.y / var_438_2, iter_438_1.transform.localScale.z)
				end
			end

			if 2 < arg_435_1.time_ and arg_435_1.time_ <= 2 + arg_438_0 then
				if arg_435_1.var_.effectsaomiaoyifengming3 then
					Object.Destroy(arg_435_1.var_.effectsaomiaoyifengming3)

					arg_435_1.var_.effectsaomiaoyifengming3 = nil
				end
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun01", "")
			end

			local var_438_6 = 0
			local var_438_7 = 1.275

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0

				arg_435_1.dialog_:SetActive(true)

				arg_435_1.dialogCg_.alpha = 0

				local var_438_8 = LeanTween.value(arg_435_1.dialog_, 0, 1, 0.3)

				var_438_8:setOnUpdate(LuaHelper.FloatAction(function(arg_439_0)
					arg_435_1.dialogCg_.alpha = arg_439_0
				end))
				var_438_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_435_1.dialog_)
					var_438_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_435_1.duration_ = arg_435_1.duration_ + 0.3

				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_9 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(424111099).content)

				arg_435_1.text_.text = var_438_9

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 51 <= 0 and var_438_7 or var_438_7 * (utf8.len(var_438_9) / 51)

				if (51 <= 0 and var_438_7 or var_438_7 * (utf8.len(var_438_9) / 51)) > 0 and var_438_7 < var_438_11 then
					arg_435_1.talkMaxDuration = var_438_11
					var_438_6 = var_438_6 + 0.3

					if var_438_11 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_11 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_9
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = var_438_6 + 0.3
			local var_438_13 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 + 0.3 <= arg_435_1.time_ and arg_435_1.time_ < var_438_12 + var_438_13 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_12) / var_438_13

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_12 + var_438_13 and arg_435_1.time_ < var_438_12 + var_438_13 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 15,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/LeftRight_Shake",
				duration = 0.3,
				amplitudeGain = 0.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play424111100 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 424111100
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play424111101(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.5

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(424111100).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 20 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 20)

				if (20 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 20)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play424111101 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 424111101
		arg_445_1.duration_ = 1.5

		local var_445_0 = {
			zh = 0.999999999999,
			ja = 1.5
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play424111102(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.1

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_1 = arg_445_1:GetWordFromCfg(424111101)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 4 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 4)

				if (4 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 4)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111101", "story_v_out_424111.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111101", "story_v_out_424111.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_out_424111", "424111101", "story_v_out_424111.awb")

						arg_445_1:RecordAudio("424111101", var_448_6)
						arg_445_1:RecordAudio("424111101", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_424111", "424111101", "story_v_out_424111.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_424111", "424111101", "story_v_out_424111.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play424111102 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 424111102
		arg_449_1.duration_ = 6.93

		local var_449_0 = {
			zh = 5.7,
			ja = 6.933
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play424111103(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10153"]) and arg_449_1.var_.actorSpriteComps10153 == nil then
				arg_449_1.var_.actorSpriteComps10153 = arg_449_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10153"]) then
				if arg_449_1.var_.actorSpriteComps10153 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								iter_452_1.color = Color.New(Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor1.r, (arg_449_1.time_ - 0) / var_452_0), Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor1.g, (arg_449_1.time_ - 0) / var_452_0), (Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor1.b, (arg_449_1.time_ - 0) / var_452_0)))
							else
								local var_452_1 = Mathf.Lerp(iter_452_1.color.r, 1, (arg_449_1.time_ - 0) / var_452_0)

								iter_452_1.color = Color.New(var_452_1, var_452_1, var_452_1)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10153"]) and arg_449_1.var_.actorSpriteComps10153 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_452_3 then
						iter_452_3.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_449_1.var_.actorSpriteComps10153 = nil
			end

			local var_452_2 = arg_449_1.actors_["10153"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos10153 = var_452_2.localPosition
				var_452_2.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10153", 3)

				for iter_452_4 = 0, var_452_2.childCount - 1 do
					local var_452_3 = var_452_2:GetChild(iter_452_4)

					if var_452_3.name == "split_3" or not string.find(var_452_3.name, "split") then
						var_452_3.gameObject:SetActive(true)
					else
						var_452_3.gameObject:SetActive(false)
					end
				end
			end

			local var_452_4 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				var_452_2.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_449_1.time_ - 0) / var_452_4)
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				var_452_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_452_5 = 0
			local var_452_6 = 0.65

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_7 = arg_449_1:GetWordFromCfg(424111102)
				local var_452_8 = arg_449_1:FormatText(var_452_7.content)

				arg_449_1.text_.text = var_452_8

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 26 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 26)

				if (26 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 26)) > 0 and var_452_6 < var_452_10 then
					arg_449_1.talkMaxDuration = var_452_10

					if var_452_10 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_5
					end
				end

				arg_449_1.text_.text = var_452_8
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111102", "story_v_out_424111.awb") ~= 0 then
					local var_452_11 = manager.audio:GetVoiceLength("story_v_out_424111", "424111102", "story_v_out_424111.awb") / 1000

					if var_452_11 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_11 + var_452_5
					end

					if var_452_7.prefab_name ~= "" and arg_449_1.actors_[var_452_7.prefab_name] ~= nil then
						local var_452_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_7.prefab_name].transform, "story_v_out_424111", "424111102", "story_v_out_424111.awb")

						arg_449_1:RecordAudio("424111102", var_452_12)
						arg_449_1:RecordAudio("424111102", var_452_12)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_424111", "424111102", "story_v_out_424111.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_424111", "424111102", "story_v_out_424111.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_13 = math.max(var_452_6, arg_449_1.talkMaxDuration)

			if var_452_5 <= arg_449_1.time_ and arg_449_1.time_ < var_452_5 + var_452_13 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_5) / var_452_13

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_5 + var_452_13 and arg_449_1.time_ < var_452_5 + var_452_13 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play424111103 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 424111103
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play424111104(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10153"]) and arg_453_1.var_.actorSpriteComps10153 == nil then
				arg_453_1.var_.actorSpriteComps10153 = arg_453_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10153"]) then
				if arg_453_1.var_.actorSpriteComps10153 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								iter_456_1.color = Color.New(Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor2.r, (arg_453_1.time_ - 0) / var_456_0), Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor2.g, (arg_453_1.time_ - 0) / var_456_0), (Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor2.b, (arg_453_1.time_ - 0) / var_456_0)))
							else
								local var_456_1 = Mathf.Lerp(iter_456_1.color.r, 0.5, (arg_453_1.time_ - 0) / var_456_0)

								iter_456_1.color = Color.New(var_456_1, var_456_1, var_456_1)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10153"]) and arg_453_1.var_.actorSpriteComps10153 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_453_1.var_.actorSpriteComps10153 = nil
			end

			local var_456_2 = 0
			local var_456_3 = 0.875

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_4 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(424111103).content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_6 = 35 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 35)

				if (35 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 35)) > 0 and var_456_3 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_7 and arg_453_1.time_ < var_456_2 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play424111104 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424111104
		arg_457_1.duration_ = 2.37

		local var_457_0 = {
			zh = 2,
			ja = 2.366
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play424111105(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.25

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_1 = arg_457_1:GetWordFromCfg(424111104)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 10 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 10)

				if (10 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 10)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111104", "story_v_out_424111.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_424111", "424111104", "story_v_out_424111.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_424111", "424111104", "story_v_out_424111.awb")

						arg_457_1:RecordAudio("424111104", var_460_6)
						arg_457_1:RecordAudio("424111104", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_424111", "424111104", "story_v_out_424111.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_424111", "424111104", "story_v_out_424111.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play424111105 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 424111105
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play424111106(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1.35

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(424111105).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 54 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 54)

				if (54 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 54)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play424111106 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 424111106
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play424111107(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos10153 = arg_465_1.actors_["10153"].transform.localPosition
				arg_465_1.actors_["10153"].transform.localScale = Vector3.New(1, 1, 1)

				arg_465_1:CheckSpriteTmpPos("10153", 7)

				for iter_468_0 = 0, arg_465_1.actors_["10153"].transform.childCount - 1 do
					local var_468_0 = arg_465_1.actors_["10153"].transform:GetChild(iter_468_0)

					if var_468_0.name == "" or not string.find(var_468_0.name, "split") then
						var_468_0.gameObject:SetActive(true)
					else
						var_468_0.gameObject:SetActive(false)
					end
				end
			end

			local var_468_1 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_1 then
				arg_465_1.actors_["10153"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_465_1.time_ - 0) / var_468_1)
			end

			if arg_465_1.time_ >= 0 + var_468_1 and arg_465_1.time_ < 0 + var_468_1 + arg_468_0 then
				arg_465_1.actors_["10153"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_468_2 = 0
			local var_468_3 = 1.3

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(424111106).content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 52 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 52)

				if (52 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 52)) > 0 and var_468_3 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_7 and arg_465_1.time_ < var_468_2 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play424111107 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 424111107
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play424111108(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 1.3

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(424111107).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 52 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 52)

				if (52 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 52)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play424111108 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 424111108
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play424111109(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 1.4

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(424111108).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 56 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 56)

				if (56 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 56)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play424111109 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 424111109
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play424111110(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0.3 < arg_477_1.time_ and arg_477_1.time_ <= 0.3 + arg_480_0 then
				arg_477_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_slime2", "")
			end

			local var_480_1 = 0
			local var_480_2 = 1.625

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(424111109).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 65 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 65)

				if (65 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 65)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play424111110 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 424111110
		arg_481_1.duration_ = 14.53

		local var_481_0 = {
			zh = 8.866,
			ja = 14.533
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play424111111(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.allBtn_.enabled = false
			end

			if arg_481_1.time_ >= 0 + 2.46666666666667 and arg_481_1.time_ < 0 + 2.46666666666667 + arg_484_0 then
				arg_481_1.allBtn_.enabled = true
			end

			local var_484_0 = 0
			local var_484_1 = 4.46666666666667

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_6")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_2 = arg_481_1:GetWordFromCfg(424111110)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 36 <= 0 and var_484_1 or var_484_1 * (utf8.len(var_484_3) / 36)

				if (36 <= 0 and var_484_1 or var_484_1 * (utf8.len(var_484_3) / 36)) > 0 and var_484_1 < var_484_5 then
					arg_481_1.talkMaxDuration = var_484_5

					if var_484_5 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111110", "story_v_out_424111.awb") ~= 0 then
					local var_484_6 = manager.audio:GetVoiceLength("story_v_out_424111", "424111110", "story_v_out_424111.awb") / 1000

					if var_484_6 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_0
					end

					if var_484_2.prefab_name ~= "" and arg_481_1.actors_[var_484_2.prefab_name] ~= nil then
						local var_484_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_2.prefab_name].transform, "story_v_out_424111", "424111110", "story_v_out_424111.awb")

						arg_481_1:RecordAudio("424111110", var_484_7)
						arg_481_1:RecordAudio("424111110", var_484_7)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_424111", "424111110", "story_v_out_424111.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_424111", "424111110", "story_v_out_424111.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play424111111 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 424111111
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play424111112(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_488_0 = 1

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				local var_488_1, var_488_2 = math.modf((arg_485_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_488_2 * 0.13, var_488_2 * 0.13, var_488_2 * 0.13) + arg_485_1.var_.shakeOldPos
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				manager.ui.mainCamera.transform.localPosition = arg_485_1.var_.shakeOldPos
			end

			local var_488_3 = 0

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_3 + arg_488_0 then
				arg_485_1.allBtn_.enabled = false
			end

			if arg_485_1.time_ >= var_488_3 + 0.5 and arg_485_1.time_ < var_488_3 + 0.5 + arg_488_0 then
				arg_485_1.allBtn_.enabled = true
			end

			if 0.8 < arg_485_1.time_ and arg_485_1.time_ <= 0.8 + arg_488_0 then
				arg_485_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_488_5 = 0
			local var_488_6 = 1.375

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_5 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0

				arg_485_1.dialog_:SetActive(true)

				arg_485_1.dialogCg_.alpha = 0

				local var_488_7 = LeanTween.value(arg_485_1.dialog_, 0, 1, 0.3)

				var_488_7:setOnUpdate(LuaHelper.FloatAction(function(arg_489_0)
					arg_485_1.dialogCg_.alpha = arg_489_0
				end))
				var_488_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_485_1.dialog_)
					var_488_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_485_1.duration_ = arg_485_1.duration_ + 0.3

				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_8 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(424111111).content)

				arg_485_1.text_.text = var_488_8

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_10 = 55 <= 0 and var_488_6 or var_488_6 * (utf8.len(var_488_8) / 55)

				if (55 <= 0 and var_488_6 or var_488_6 * (utf8.len(var_488_8) / 55)) > 0 and var_488_6 < var_488_10 then
					arg_485_1.talkMaxDuration = var_488_10
					var_488_5 = var_488_5 + 0.3

					if var_488_10 + var_488_5 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_10 + var_488_5
					end
				end

				arg_485_1.text_.text = var_488_8
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_11 = var_488_5 + 0.3
			local var_488_12 = math.max(var_488_6, arg_485_1.talkMaxDuration)

			if var_488_5 + 0.3 <= arg_485_1.time_ and arg_485_1.time_ < var_488_11 + var_488_12 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_11) / var_488_12

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_11 + var_488_12 and arg_485_1.time_ < var_488_11 + var_488_12 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play424111112 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 424111112
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play424111113(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0.166666666666667 < arg_491_1.time_ and arg_491_1.time_ <= 0.166666666666667 + arg_494_0 then
				arg_491_1:AudioAction("play", "effect", "se_story_146", "se_story_146_hit", "")
			end

			local var_494_1 = 0
			local var_494_2 = 1.075

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_3 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(424111112).content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 43 <= 0 and var_494_2 or var_494_2 * (utf8.len(var_494_3) / 43)

				if (43 <= 0 and var_494_2 or var_494_2 * (utf8.len(var_494_3) / 43)) > 0 and var_494_2 < var_494_5 then
					arg_491_1.talkMaxDuration = var_494_5

					if var_494_5 + var_494_1 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + var_494_1
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_6 = math.max(var_494_2, arg_491_1.talkMaxDuration)

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_6 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_1) / var_494_6

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_1 + var_494_6 and arg_491_1.time_ < var_494_1 + var_494_6 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play424111113 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 424111113
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play424111114(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.3

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(424111113).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 12 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 12)

				if (12 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 12)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play424111114 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 424111114
		arg_499_1.duration_ = 2.5

		local var_499_0 = {
			zh = 2.5,
			ja = 1.433333333332
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
			arg_499_1.auto_ = false
		end

		function arg_499_1.playNext_(arg_501_0)
			arg_499_1.onStoryFinished_()
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1194"]) and arg_499_1.var_.actorSpriteComps1194 == nil then
				arg_499_1.var_.actorSpriteComps1194 = arg_499_1.actors_["1194"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_0 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1194"]) then
				if arg_499_1.var_.actorSpriteComps1194 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								iter_502_1.color = Color.New(Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, (arg_499_1.time_ - 0) / var_502_0), Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, (arg_499_1.time_ - 0) / var_502_0), (Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, (arg_499_1.time_ - 0) / var_502_0)))
							else
								local var_502_1 = Mathf.Lerp(iter_502_1.color.r, 1, (arg_499_1.time_ - 0) / var_502_0)

								iter_502_1.color = Color.New(var_502_1, var_502_1, var_502_1)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1194"]) and arg_499_1.var_.actorSpriteComps1194 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_502_3 then
						iter_502_3.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps1194 = nil
			end

			local var_502_2 = arg_499_1.actors_["1194"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1194 = var_502_2.localPosition
				var_502_2.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("1194", 3)

				for iter_502_4 = 0, var_502_2.childCount - 1 do
					local var_502_3 = var_502_2:GetChild(iter_502_4)

					if var_502_3.name == "split_4" or not string.find(var_502_3.name, "split") then
						var_502_3.gameObject:SetActive(true)
					else
						var_502_3.gameObject:SetActive(false)
					end
				end
			end

			local var_502_4 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_4 then
				var_502_2.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1194, Vector3.New(-60, -360, -240), (arg_499_1.time_ - 0) / var_502_4)
			end

			if arg_499_1.time_ >= 0 + var_502_4 and arg_499_1.time_ < 0 + var_502_4 + arg_502_0 then
				var_502_2.localPosition = Vector3.New(-60, -360, -240)
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				local var_502_5 = arg_499_1.actors_["1194"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_502_5 then
					arg_499_1.var_.alphaOldValue1194 = var_502_5.alpha
					arg_499_1.var_.characterEffect1194 = var_502_5
				end

				arg_499_1.var_.alphaOldValue1194 = 0
			end

			local var_502_6 = 0.5

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_6 then
				if arg_499_1.var_.characterEffect1194 then
					arg_499_1.var_.characterEffect1194.alpha = Mathf.Lerp(arg_499_1.var_.alphaOldValue1194, 1, (arg_499_1.time_ - 0) / var_502_6)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_6 and arg_499_1.time_ < 0 + var_502_6 + arg_502_0 and arg_499_1.var_.characterEffect1194 then
				arg_499_1.var_.characterEffect1194.alpha = 1
			end

			local var_502_7 = 0
			local var_502_8 = 0.2

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_7 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_9 = arg_499_1:GetWordFromCfg(424111114)
				local var_502_10 = arg_499_1:FormatText(var_502_9.content)

				arg_499_1.text_.text = var_502_10

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_12 = 8 <= 0 and var_502_8 or var_502_8 * (utf8.len(var_502_10) / 8)

				if (8 <= 0 and var_502_8 or var_502_8 * (utf8.len(var_502_10) / 8)) > 0 and var_502_8 < var_502_12 then
					arg_499_1.talkMaxDuration = var_502_12

					if var_502_12 + var_502_7 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_12 + var_502_7
					end
				end

				arg_499_1.text_.text = var_502_10
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111114", "story_v_out_424111.awb") ~= 0 then
					local var_502_13 = manager.audio:GetVoiceLength("story_v_out_424111", "424111114", "story_v_out_424111.awb") / 1000

					if var_502_13 + var_502_7 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_7
					end

					if var_502_9.prefab_name ~= "" and arg_499_1.actors_[var_502_9.prefab_name] ~= nil then
						local var_502_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_9.prefab_name].transform, "story_v_out_424111", "424111114", "story_v_out_424111.awb")

						arg_499_1:RecordAudio("424111114", var_502_14)
						arg_499_1:RecordAudio("424111114", var_502_14)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_424111", "424111114", "story_v_out_424111.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_424111", "424111114", "story_v_out_424111.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_15 = math.max(var_502_8, arg_499_1.talkMaxDuration)

			if var_502_7 <= arg_499_1.time_ and arg_499_1.time_ < var_502_7 + var_502_15 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_7) / var_502_15

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_7 + var_502_15 and arg_499_1.time_ < var_502_7 + var_502_15 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0115a",
		"TextureConfig/Background/ST0116a",
		"TextureConfig/Background/ST0117",
		"TextureConfig/Background/SS2403",
		"TextureConfig/Background/SS2403a",
		"TextureConfig/Background/SS2403b",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_424111.awb"
	}
}
