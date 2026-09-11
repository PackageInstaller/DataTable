return {
	Play418031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418031001
		arg_1_1.duration_ = 16.17

		local var_1_0 = {
			ja = 16.166,
			CriLanguages = 10.733,
			zh = 10.733
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
				arg_1_0:Play418031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST1001b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST1001b")
				var_4_0.name = "ST1001b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST1001b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST1001b

				arg_1_1.bgs_.ST1001b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST1001b" then
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

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_harbor", "")
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.875

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(418031001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 35 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 35)

				if (35 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 35)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb")

						arg_1_1:RecordAudio("418031001", var_4_21)
						arg_1_1:RecordAudio("418031001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
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
	Play418031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418031002
		arg_8_1.duration_ = 3.1

		local var_8_0 = {
			ja = 2.633,
			CriLanguages = 3.1,
			zh = 3.1
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play418031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["10135"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "10135"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["10135"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["10135"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10135 == nil then
				arg_8_1.var_.actorSpriteComps10135 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps10135 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								iter_11_3.color = Color.New(Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, (arg_8_1.time_ - 0) / var_11_3), Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, (arg_8_1.time_ - 0) / var_11_3), (Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, (arg_8_1.time_ - 0) / var_11_3)))
							else
								local var_11_4 = Mathf.Lerp(iter_11_3.color.r, 1, (arg_8_1.time_ - 0) / var_11_3)

								iter_11_3.color = Color.New(var_11_4, var_11_4, var_11_4)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10135 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps10135 = nil
			end

			local var_11_5 = arg_8_1.actors_["10135"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10135 = var_11_5.localPosition
				var_11_5.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10135", 3)

				for iter_11_6 = 0, var_11_5.childCount - 1 do
					local var_11_6 = var_11_5:GetChild(iter_11_6)

					if var_11_6.name == "split_6" or not string.find(var_11_6.name, "split") then
						var_11_6.gameObject:SetActive(true)
					else
						var_11_6.gameObject:SetActive(false)
					end
				end
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_8_1.time_ - 0) / var_11_7)
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_11_8 = 0
			local var_11_9 = 0.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(418031002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 16 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 16)

				if (16 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 16)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb")

						arg_8_1:RecordAudio("418031002", var_11_15)
						arg_8_1:RecordAudio("418031002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play418031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418031003
		arg_12_1.duration_ = 8.3

		local var_12_0 = {
			ja = 8.3,
			CriLanguages = 8.2,
			zh = 8.2
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play418031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["10135"]) and arg_12_1.var_.actorSpriteComps10135 == nil then
				arg_12_1.var_.actorSpriteComps10135 = arg_12_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["10135"]) then
				if arg_12_1.var_.actorSpriteComps10135 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								iter_15_1.color = Color.New(Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor2.r, (arg_12_1.time_ - 0) / var_15_0), Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor2.g, (arg_12_1.time_ - 0) / var_15_0), (Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor2.b, (arg_12_1.time_ - 0) / var_15_0)))
							else
								local var_15_1 = Mathf.Lerp(iter_15_1.color.r, 0.5, (arg_12_1.time_ - 0) / var_15_0)

								iter_15_1.color = Color.New(var_15_1, var_15_1, var_15_1)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["10135"]) and arg_12_1.var_.actorSpriteComps10135 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_12_1.var_.actorSpriteComps10135 = nil
			end

			local var_15_2 = 0
			local var_15_3 = 0.825

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_4 = arg_12_1:GetWordFromCfg(418031003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 33 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 33)

				if (33 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 33)) > 0 and var_15_3 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb") / 1000

					if var_15_8 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_2
					end

					if var_15_4.prefab_name ~= "" and arg_12_1.actors_[var_15_4.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_4.prefab_name].transform, "story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb")

						arg_12_1:RecordAudio("418031003", var_15_9)
						arg_12_1:RecordAudio("418031003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_10 and arg_12_1.time_ < var_15_2 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play418031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418031004
		arg_16_1.duration_ = 4.83

		local var_16_0 = {
			ja = 4.833,
			CriLanguages = 4.333,
			zh = 4.333
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["10135"]) and arg_16_1.var_.actorSpriteComps10135 == nil then
				arg_16_1.var_.actorSpriteComps10135 = arg_16_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["10135"]) then
				if arg_16_1.var_.actorSpriteComps10135 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								iter_19_1.color = Color.New(Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor1.r, (arg_16_1.time_ - 0) / var_19_0), Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor1.g, (arg_16_1.time_ - 0) / var_19_0), (Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor1.b, (arg_16_1.time_ - 0) / var_19_0)))
							else
								local var_19_1 = Mathf.Lerp(iter_19_1.color.r, 1, (arg_16_1.time_ - 0) / var_19_0)

								iter_19_1.color = Color.New(var_19_1, var_19_1, var_19_1)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["10135"]) and arg_16_1.var_.actorSpriteComps10135 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_16_1.var_.actorSpriteComps10135 = nil
			end

			local var_19_2 = arg_16_1.actors_["10135"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10135 = var_19_2.localPosition
				var_19_2.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10135", 3)

				for iter_19_4 = 0, var_19_2.childCount - 1 do
					local var_19_3 = var_19_2:GetChild(iter_19_4)

					if var_19_3.name == "split_4" or not string.find(var_19_3.name, "split") then
						var_19_3.gameObject:SetActive(true)
					else
						var_19_3.gameObject:SetActive(false)
					end
				end
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_2.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_16_1.time_ - 0) / var_19_4)
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_2.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_19_5 = 0
			local var_19_6 = 0.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_7 = arg_16_1:GetWordFromCfg(418031004)
				local var_19_8 = arg_16_1:FormatText(var_19_7.content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 24 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_8) / 24)

				if (24 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_8) / 24)) > 0 and var_19_6 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10

					if var_19_10 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_5
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb") ~= 0 then
					local var_19_11 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb") / 1000

					if var_19_11 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_5
					end

					if var_19_7.prefab_name ~= "" and arg_16_1.actors_[var_19_7.prefab_name] ~= nil then
						local var_19_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_7.prefab_name].transform, "story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb")

						arg_16_1:RecordAudio("418031004", var_19_12)
						arg_16_1:RecordAudio("418031004", var_19_12)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_6, arg_16_1.talkMaxDuration)

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_5) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_5 + var_19_13 and arg_16_1.time_ < var_19_5 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play418031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418031005
		arg_20_1.duration_ = 9.03

		local var_20_0 = {
			ja = 9.033,
			CriLanguages = 7.1,
			zh = 7.1
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play418031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1073"] == nil then
				local var_23_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

				if not isNil(var_23_0) then
					local var_23_1 = Object.Instantiate(var_23_0, arg_20_1.canvasGo_.transform)

					var_23_1.transform:SetSiblingIndex(1)

					var_23_1.name = "1073"
					var_23_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_["1073"] = var_23_1

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs((var_23_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_2 = arg_20_1.actors_["1073"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps1073 == nil then
				arg_20_1.var_.actorSpriteComps1073 = var_23_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_3 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.actorSpriteComps1073 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_23_3 then
							if arg_20_1.isInRecall_ then
								iter_23_3.color = Color.New(Mathf.Lerp(iter_23_3.color.r, arg_20_1.hightColor1.r, (arg_20_1.time_ - 0) / var_23_3), Mathf.Lerp(iter_23_3.color.g, arg_20_1.hightColor1.g, (arg_20_1.time_ - 0) / var_23_3), (Mathf.Lerp(iter_23_3.color.b, arg_20_1.hightColor1.b, (arg_20_1.time_ - 0) / var_23_3)))
							else
								local var_23_4 = Mathf.Lerp(iter_23_3.color.r, 1, (arg_20_1.time_ - 0) / var_23_3)

								iter_23_3.color = Color.New(var_23_4, var_23_4, var_23_4)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps1073 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_23_5 then
						iter_23_5.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps1073 = nil
			end

			local var_23_5 = arg_20_1.actors_["10135"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_23_7 then
							if arg_20_1.isInRecall_ then
								iter_23_7.color = Color.New(Mathf.Lerp(iter_23_7.color.r, arg_20_1.hightColor2.r, (arg_20_1.time_ - 0) / var_23_6), Mathf.Lerp(iter_23_7.color.g, arg_20_1.hightColor2.g, (arg_20_1.time_ - 0) / var_23_6), (Mathf.Lerp(iter_23_7.color.b, arg_20_1.hightColor2.b, (arg_20_1.time_ - 0) / var_23_6)))
							else
								local var_23_7 = Mathf.Lerp(iter_23_7.color.r, 0.5, (arg_20_1.time_ - 0) / var_23_6)

								iter_23_7.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_8, iter_23_9 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_9 then
						iter_23_9.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_8 = arg_20_1.actors_["10135"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10135 = var_23_8.localPosition
				var_23_8.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10135", 7)

				for iter_23_10 = 0, var_23_8.childCount - 1 do
					local var_23_9 = var_23_8:GetChild(iter_23_10)

					if var_23_9.name == "" or not string.find(var_23_9.name, "split") then
						var_23_9.gameObject:SetActive(true)
					else
						var_23_9.gameObject:SetActive(false)
					end
				end
			end

			local var_23_10 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_10 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_20_1.time_ - 0) / var_23_10)
			end

			if arg_20_1.time_ >= 0 + var_23_10 and arg_20_1.time_ < 0 + var_23_10 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_23_11 = arg_20_1.actors_["1073"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1073 = var_23_11.localPosition
				var_23_11.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1073", 3)

				for iter_23_11 = 0, var_23_11.childCount - 1 do
					local var_23_12 = var_23_11:GetChild(iter_23_11)

					if var_23_12.name == "" or not string.find(var_23_12.name, "split") then
						var_23_12.gameObject:SetActive(true)
					else
						var_23_12.gameObject:SetActive(false)
					end
				end
			end

			local var_23_13 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_13 then
				var_23_11.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_20_1.time_ - 0) / var_23_13)
			end

			if arg_20_1.time_ >= 0 + var_23_13 and arg_20_1.time_ < 0 + var_23_13 + arg_23_0 then
				var_23_11.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_23_14 = 0
			local var_23_15 = 0.8

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_16 = arg_20_1:GetWordFromCfg(418031005)
				local var_23_17 = arg_20_1:FormatText(var_23_16.content)

				arg_20_1.text_.text = var_23_17

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_19 = 32 <= 0 and var_23_15 or var_23_15 * (utf8.len(var_23_17) / 32)

				if (32 <= 0 and var_23_15 or var_23_15 * (utf8.len(var_23_17) / 32)) > 0 and var_23_15 < var_23_19 then
					arg_20_1.talkMaxDuration = var_23_19

					if var_23_19 + var_23_14 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_14
					end
				end

				arg_20_1.text_.text = var_23_17
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb") ~= 0 then
					local var_23_20 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb") / 1000

					if var_23_20 + var_23_14 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_20 + var_23_14
					end

					if var_23_16.prefab_name ~= "" and arg_20_1.actors_[var_23_16.prefab_name] ~= nil then
						local var_23_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_16.prefab_name].transform, "story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb")

						arg_20_1:RecordAudio("418031005", var_23_21)
						arg_20_1:RecordAudio("418031005", var_23_21)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = math.max(var_23_15, arg_20_1.talkMaxDuration)

			if var_23_14 <= arg_20_1.time_ and arg_20_1.time_ < var_23_14 + var_23_22 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_14) / var_23_22

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_14 + var_23_22 and arg_20_1.time_ < var_23_14 + var_23_22 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play418031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418031006
		arg_24_1.duration_ = 14.4

		local var_24_0 = {
			ja = 14.4,
			CriLanguages = 11.866,
			zh = 11.866
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play418031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10135"]) and arg_24_1.var_.actorSpriteComps10135 == nil then
				arg_24_1.var_.actorSpriteComps10135 = arg_24_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10135"]) then
				if arg_24_1.var_.actorSpriteComps10135 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								iter_27_1.color = Color.New(Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor1.r, (arg_24_1.time_ - 0) / var_27_0), Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor1.g, (arg_24_1.time_ - 0) / var_27_0), (Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor1.b, (arg_24_1.time_ - 0) / var_27_0)))
							else
								local var_27_1 = Mathf.Lerp(iter_27_1.color.r, 1, (arg_24_1.time_ - 0) / var_27_0)

								iter_27_1.color = Color.New(var_27_1, var_27_1, var_27_1)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10135"]) and arg_24_1.var_.actorSpriteComps10135 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps10135 = nil
			end

			local var_27_2 = arg_24_1.actors_["1073"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1073 == nil then
				arg_24_1.var_.actorSpriteComps1073 = var_27_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_3 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.actorSpriteComps1073 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_27_5 then
							if arg_24_1.isInRecall_ then
								iter_27_5.color = Color.New(Mathf.Lerp(iter_27_5.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_3), Mathf.Lerp(iter_27_5.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_3), (Mathf.Lerp(iter_27_5.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_3)))
							else
								local var_27_4 = Mathf.Lerp(iter_27_5.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_3)

								iter_27_5.color = Color.New(var_27_4, var_27_4, var_27_4)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1073 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_27_7 then
						iter_27_7.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps1073 = nil
			end

			local var_27_5 = arg_24_1.actors_["10135"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10135 = var_27_5.localPosition
				var_27_5.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10135", 3)

				for iter_27_8 = 0, var_27_5.childCount - 1 do
					local var_27_6 = var_27_5:GetChild(iter_27_8)

					if var_27_6.name == "split_5" or not string.find(var_27_6.name, "split") then
						var_27_6.gameObject:SetActive(true)
					else
						var_27_6.gameObject:SetActive(false)
					end
				end
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_24_1.time_ - 0) / var_27_7)
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_27_8 = arg_24_1.actors_["1073"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1073 = var_27_8.localPosition
				var_27_8.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1073", 7)

				for iter_27_9 = 0, var_27_8.childCount - 1 do
					local var_27_9 = var_27_8:GetChild(iter_27_9)

					if var_27_9.name == "" or not string.find(var_27_9.name, "split") then
						var_27_9.gameObject:SetActive(true)
					else
						var_27_9.gameObject:SetActive(false)
					end
				end
			end

			local var_27_10 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_10 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_24_1.time_ - 0) / var_27_10)
			end

			if arg_24_1.time_ >= 0 + var_27_10 and arg_24_1.time_ < 0 + var_27_10 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_27_11 = 0
			local var_27_12 = 1.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_13 = arg_24_1:GetWordFromCfg(418031006)
				local var_27_14 = arg_24_1:FormatText(var_27_13.content)

				arg_24_1.text_.text = var_27_14

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_16 = 52 <= 0 and var_27_12 or var_27_12 * (utf8.len(var_27_14) / 52)

				if (52 <= 0 and var_27_12 or var_27_12 * (utf8.len(var_27_14) / 52)) > 0 and var_27_12 < var_27_16 then
					arg_24_1.talkMaxDuration = var_27_16

					if var_27_16 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_11
					end
				end

				arg_24_1.text_.text = var_27_14
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb") ~= 0 then
					local var_27_17 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb") / 1000

					if var_27_17 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_11
					end

					if var_27_13.prefab_name ~= "" and arg_24_1.actors_[var_27_13.prefab_name] ~= nil then
						local var_27_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_13.prefab_name].transform, "story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb")

						arg_24_1:RecordAudio("418031006", var_27_18)
						arg_24_1:RecordAudio("418031006", var_27_18)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_19 = math.max(var_27_12, arg_24_1.talkMaxDuration)

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_19 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_11) / var_27_19

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_11 + var_27_19 and arg_24_1.time_ < var_27_11 + var_27_19 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play418031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418031007
		arg_28_1.duration_ = 12.7

		local var_28_0 = {
			ja = 12.7,
			CriLanguages = 11.2,
			zh = 11.2
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play418031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10135"]) and arg_28_1.var_.actorSpriteComps10135 == nil then
				arg_28_1.var_.actorSpriteComps10135 = arg_28_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10135"]) then
				if arg_28_1.var_.actorSpriteComps10135 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								iter_31_1.color = Color.New(Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor2.r, (arg_28_1.time_ - 0) / var_31_0), Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor2.g, (arg_28_1.time_ - 0) / var_31_0), (Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor2.b, (arg_28_1.time_ - 0) / var_31_0)))
							else
								local var_31_1 = Mathf.Lerp(iter_31_1.color.r, 0.5, (arg_28_1.time_ - 0) / var_31_0)

								iter_31_1.color = Color.New(var_31_1, var_31_1, var_31_1)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10135"]) and arg_28_1.var_.actorSpriteComps10135 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps10135 = nil
			end

			local var_31_2 = 0
			local var_31_3 = 1.15

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_4 = arg_28_1:GetWordFromCfg(418031007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 46 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 46)

				if (46 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 46)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb")

						arg_28_1:RecordAudio("418031007", var_31_9)
						arg_28_1:RecordAudio("418031007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play418031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418031008
		arg_32_1.duration_ = 22.27

		local var_32_0 = {
			ja = 22.266,
			CriLanguages = 12.3,
			zh = 12.3
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play418031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.425

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(418031008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 57 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 57)

				if (57 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 57)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb")

						arg_32_1:RecordAudio("418031008", var_35_6)
						arg_32_1:RecordAudio("418031008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play418031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418031009
		arg_36_1.duration_ = 7.7

		local var_36_0 = {
			ja = 7.7,
			CriLanguages = 6.133,
			zh = 6.133
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play418031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1073"]) and arg_36_1.var_.actorSpriteComps1073 == nil then
				arg_36_1.var_.actorSpriteComps1073 = arg_36_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1073"]) then
				if arg_36_1.var_.actorSpriteComps1073 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								iter_39_1.color = Color.New(Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, (arg_36_1.time_ - 0) / var_39_0), Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, (arg_36_1.time_ - 0) / var_39_0), (Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, (arg_36_1.time_ - 0) / var_39_0)))
							else
								local var_39_1 = Mathf.Lerp(iter_39_1.color.r, 1, (arg_36_1.time_ - 0) / var_39_0)

								iter_39_1.color = Color.New(var_39_1, var_39_1, var_39_1)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1073"]) and arg_36_1.var_.actorSpriteComps1073 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps1073 = nil
			end

			local var_39_2 = arg_36_1.actors_["10135"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10135 = var_39_2.localPosition
				var_39_2.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10135", 7)

				for iter_39_4 = 0, var_39_2.childCount - 1 do
					local var_39_3 = var_39_2:GetChild(iter_39_4)

					if var_39_3.name == "" or not string.find(var_39_3.name, "split") then
						var_39_3.gameObject:SetActive(true)
					else
						var_39_3.gameObject:SetActive(false)
					end
				end
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_2.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_36_1.time_ - 0) / var_39_4)
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_5 = arg_36_1.actors_["1073"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1073 = var_39_5.localPosition
				var_39_5.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1073", 3)

				for iter_39_5 = 0, var_39_5.childCount - 1 do
					local var_39_6 = var_39_5:GetChild(iter_39_5)

					if var_39_6.name == "" or not string.find(var_39_6.name, "split") then
						var_39_6.gameObject:SetActive(true)
					else
						var_39_6.gameObject:SetActive(false)
					end
				end
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_36_1.time_ - 0) / var_39_7)
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_39_8 = 0
			local var_39_9 = 0.75

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(418031009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 30 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 30)

				if (30 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 30)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb")

						arg_36_1:RecordAudio("418031009", var_39_15)
						arg_36_1:RecordAudio("418031009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play418031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418031010
		arg_40_1.duration_ = 15.6

		local var_40_0 = {
			ja = 15.6,
			CriLanguages = 13.4,
			zh = 13.4
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play418031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1073"]) and arg_40_1.var_.actorSpriteComps1073 == nil then
				arg_40_1.var_.actorSpriteComps1073 = arg_40_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1073"]) then
				if arg_40_1.var_.actorSpriteComps1073 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor2.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor2.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor2.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 0.5, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1073"]) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_2 = 0
			local var_43_3 = 1.375

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_4 = arg_40_1:GetWordFromCfg(418031010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 55 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 55)

				if (55 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 55)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb")

						arg_40_1:RecordAudio("418031010", var_43_9)
						arg_40_1:RecordAudio("418031010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play418031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418031011
		arg_44_1.duration_ = 14.7

		local var_44_0 = {
			ja = 14.7,
			CriLanguages = 11.766,
			zh = 11.766
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play418031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(418031011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 47 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 47)

				if (47 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 47)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb")

						arg_44_1:RecordAudio("418031011", var_47_6)
						arg_44_1:RecordAudio("418031011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play418031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418031012
		arg_48_1.duration_ = 8.93

		local var_48_0 = {
			ja = 8.933,
			CriLanguages = 5.133,
			zh = 5.133
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play418031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1073"]) and arg_48_1.var_.actorSpriteComps1073 == nil then
				arg_48_1.var_.actorSpriteComps1073 = arg_48_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1073"]) then
				if arg_48_1.var_.actorSpriteComps1073 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 1, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1073"]) and arg_48_1.var_.actorSpriteComps1073 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps1073 = nil
			end

			local var_51_2 = 0
			local var_51_3 = 0.65

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(418031012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 26 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 26)

				if (26 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 26)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb")

						arg_48_1:RecordAudio("418031012", var_51_9)
						arg_48_1:RecordAudio("418031012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_10 and arg_48_1.time_ < var_51_2 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play418031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418031013
		arg_52_1.duration_ = 24.8

		local var_52_0 = {
			ja = 24.8,
			CriLanguages = 15.966,
			zh = 15.966
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play418031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1073"]) and arg_52_1.var_.actorSpriteComps1073 == nil then
				arg_52_1.var_.actorSpriteComps1073 = arg_52_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1073"]) then
				if arg_52_1.var_.actorSpriteComps1073 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								iter_55_1.color = Color.New(Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor2.r, (arg_52_1.time_ - 0) / var_55_0), Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor2.g, (arg_52_1.time_ - 0) / var_55_0), (Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor2.b, (arg_52_1.time_ - 0) / var_55_0)))
							else
								local var_55_1 = Mathf.Lerp(iter_55_1.color.r, 0.5, (arg_52_1.time_ - 0) / var_55_0)

								iter_55_1.color = Color.New(var_55_1, var_55_1, var_55_1)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1073"]) and arg_52_1.var_.actorSpriteComps1073 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps1073 = nil
			end

			local var_55_2 = 0
			local var_55_3 = 1.55

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_4 = arg_52_1:GetWordFromCfg(418031013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 62 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 62)

				if (62 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 62)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb")

						arg_52_1:RecordAudio("418031013", var_55_9)
						arg_52_1:RecordAudio("418031013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play418031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418031014
		arg_56_1.duration_ = 8.4

		local var_56_0 = {
			ja = 8.4,
			CriLanguages = 7.266,
			zh = 7.266
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play418031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1073"]) and arg_56_1.var_.actorSpriteComps1073 == nil then
				arg_56_1.var_.actorSpriteComps1073 = arg_56_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1073"]) then
				if arg_56_1.var_.actorSpriteComps1073 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 1, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1073"]) and arg_56_1.var_.actorSpriteComps1073 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1073 = nil
			end

			local var_59_2 = arg_56_1.actors_["1073"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1073 = var_59_2.localPosition
				var_59_2.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1073", 3)

				for iter_59_4 = 0, var_59_2.childCount - 1 do
					local var_59_3 = var_59_2:GetChild(iter_59_4)

					if var_59_3.name == "split_3" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_56_1.time_ - 0) / var_59_4)
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_59_5 = 0
			local var_59_6 = 0.8

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:GetWordFromCfg(418031014)
				local var_59_8 = arg_56_1:FormatText(var_59_7.content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 32 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 32)

				if (32 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 32)) > 0 and var_59_6 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb") ~= 0 then
					local var_59_11 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb") / 1000

					if var_59_11 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_5
					end

					if var_59_7.prefab_name ~= "" and arg_56_1.actors_[var_59_7.prefab_name] ~= nil then
						local var_59_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_7.prefab_name].transform, "story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb")

						arg_56_1:RecordAudio("418031014", var_59_12)
						arg_56_1:RecordAudio("418031014", var_59_12)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_13 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_13

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_13 and arg_56_1.time_ < var_59_5 + var_59_13 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play418031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418031015
		arg_60_1.duration_ = 8.5

		local var_60_0 = {
			ja = 8.5,
			CriLanguages = 6.9,
			zh = 6.9
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play418031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1073"]) and arg_60_1.var_.actorSpriteComps1073 == nil then
				arg_60_1.var_.actorSpriteComps1073 = arg_60_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1073"]) then
				if arg_60_1.var_.actorSpriteComps1073 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1073"]) and arg_60_1.var_.actorSpriteComps1073 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps1073 = nil
			end

			local var_63_2 = 0
			local var_63_3 = 0.6

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_4 = arg_60_1:GetWordFromCfg(418031015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 24 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 24)

				if (24 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 24)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb")

						arg_60_1:RecordAudio("418031015", var_63_9)
						arg_60_1:RecordAudio("418031015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play418031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418031016
		arg_64_1.duration_ = 1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"

			SetActive(arg_64_1.choicesGo_, true)

			for iter_65_0, iter_65_1 in ipairs(arg_64_1.choices_) do
				SetActive(iter_65_1.go, iter_65_0 <= 2)
			end

			arg_64_1.choices_[1].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1276].name)
			arg_64_1.choices_[2].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1277].name)
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418031017(arg_64_1)
			end

			if arg_66_0 == 2 then
				arg_64_0:Play418031017(arg_64_1)
			end

			arg_64_1:RecordChoiceLog(418031016, 1276, 1277)
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			return
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play418031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418031017
		arg_68_1.duration_ = 5.57

		local var_68_0 = {
			ja = 4.733,
			CriLanguages = 5.566,
			zh = 5.566
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play418031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10135"]) and arg_68_1.var_.actorSpriteComps10135 == nil then
				arg_68_1.var_.actorSpriteComps10135 = arg_68_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10135"]) then
				if arg_68_1.var_.actorSpriteComps10135 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 1, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10135"]) and arg_68_1.var_.actorSpriteComps10135 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_68_1.var_.actorSpriteComps10135 = nil
			end

			local var_71_2 = arg_68_1.actors_["10135"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10135 = var_71_2.localPosition
				var_71_2.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10135", 3)

				for iter_71_4 = 0, var_71_2.childCount - 1 do
					local var_71_3 = var_71_2:GetChild(iter_71_4)

					if var_71_3.name == "split_6" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_68_1.time_ - 0) / var_71_4)
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_71_5 = arg_68_1.actors_["1073"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1073 = var_71_5.localPosition
				var_71_5.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("1073", 7)

				for iter_71_5 = 0, var_71_5.childCount - 1 do
					local var_71_6 = var_71_5:GetChild(iter_71_5)

					if var_71_6.name == "" or not string.find(var_71_6.name, "split") then
						var_71_6.gameObject:SetActive(true)
					else
						var_71_6.gameObject:SetActive(false)
					end
				end
			end

			local var_71_7 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				var_71_5.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_68_1.time_ - 0) / var_71_7)
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				var_71_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_71_8 = 0
			local var_71_9 = 0.525

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(418031017)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 21 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 21)

				if (21 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 21)) > 0 and var_71_9 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb") / 1000

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb")

						arg_68_1:RecordAudio("418031017", var_71_15)
						arg_68_1:RecordAudio("418031017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_16 and arg_68_1.time_ < var_71_8 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play418031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418031018
		arg_72_1.duration_ = 8.83

		local var_72_0 = {
			ja = 8.833,
			CriLanguages = 8.3,
			zh = 8.3
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play418031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1073"]) and arg_72_1.var_.actorSpriteComps1073 == nil then
				arg_72_1.var_.actorSpriteComps1073 = arg_72_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1073"]) then
				if arg_72_1.var_.actorSpriteComps1073 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1073"]) and arg_72_1.var_.actorSpriteComps1073 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps1073 = nil
			end

			local var_75_2 = arg_72_1.actors_["10135"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10135 == nil then
				arg_72_1.var_.actorSpriteComps10135 = var_75_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_3 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.actorSpriteComps10135 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								iter_75_5.color = Color.New(Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_3), Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_3), (Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_3)))
							else
								local var_75_4 = Mathf.Lerp(iter_75_5.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_3)

								iter_75_5.color = Color.New(var_75_4, var_75_4, var_75_4)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10135 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_75_7 then
						iter_75_7.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps10135 = nil
			end

			local var_75_5 = arg_72_1.actors_["10135"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10135 = var_75_5.localPosition
				var_75_5.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10135", 4)

				for iter_75_8 = 0, var_75_5.childCount - 1 do
					local var_75_6 = var_75_5:GetChild(iter_75_8)

					if var_75_6.name == "split_6" or not string.find(var_75_6.name, "split") then
						var_75_6.gameObject:SetActive(true)
					else
						var_75_6.gameObject:SetActive(false)
					end
				end
			end

			local var_75_7 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_72_1.time_ - 0) / var_75_7)
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_75_8 = arg_72_1.actors_["1073"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1073 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1073", 2)

				for iter_75_9 = 0, var_75_8.childCount - 1 do
					local var_75_9 = var_75_8:GetChild(iter_75_9)

					if var_75_9.name == "" or not string.find(var_75_9.name, "split") then
						var_75_9.gameObject:SetActive(true)
					else
						var_75_9.gameObject:SetActive(false)
					end
				end
			end

			local var_75_10 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_10 then
				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_72_1.time_ - 0) / var_75_10)
			end

			if arg_72_1.time_ >= 0 + var_75_10 and arg_72_1.time_ < 0 + var_75_10 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_75_11 = 0
			local var_75_12 = 1

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_13 = arg_72_1:GetWordFromCfg(418031018)
				local var_75_14 = arg_72_1:FormatText(var_75_13.content)

				arg_72_1.text_.text = var_75_14

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_16 = 40 <= 0 and var_75_12 or var_75_12 * (utf8.len(var_75_14) / 40)

				if (40 <= 0 and var_75_12 or var_75_12 * (utf8.len(var_75_14) / 40)) > 0 and var_75_12 < var_75_16 then
					arg_72_1.talkMaxDuration = var_75_16

					if var_75_16 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_11
					end
				end

				arg_72_1.text_.text = var_75_14
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb") ~= 0 then
					local var_75_17 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb") / 1000

					if var_75_17 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_17 + var_75_11
					end

					if var_75_13.prefab_name ~= "" and arg_72_1.actors_[var_75_13.prefab_name] ~= nil then
						local var_75_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_13.prefab_name].transform, "story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb")

						arg_72_1:RecordAudio("418031018", var_75_18)
						arg_72_1:RecordAudio("418031018", var_75_18)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_19 = math.max(var_75_12, arg_72_1.talkMaxDuration)

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_19 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_11) / var_75_19

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_11 + var_75_19 and arg_72_1.time_ < var_75_11 + var_75_19 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play418031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418031019
		arg_76_1.duration_ = 4.1

		local var_76_0 = {
			ja = 4.1,
			CriLanguages = 3.7,
			zh = 3.7
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play418031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10135"]) and arg_76_1.var_.actorSpriteComps10135 == nil then
				arg_76_1.var_.actorSpriteComps10135 = arg_76_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10135"]) then
				if arg_76_1.var_.actorSpriteComps10135 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 1, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10135"]) and arg_76_1.var_.actorSpriteComps10135 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps10135 = nil
			end

			local var_79_2 = arg_76_1.actors_["1073"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1073 == nil then
				arg_76_1.var_.actorSpriteComps1073 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps1073 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								iter_79_5.color = Color.New(Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_5.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_5.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1073 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_79_7 then
						iter_79_7.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps1073 = nil
			end

			local var_79_5 = arg_76_1.actors_["10135"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10135 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10135", 4)

				for iter_79_8 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_8)

					if var_79_6.name == "" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_79_8 = 0
			local var_79_9 = 0.25

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:GetWordFromCfg(418031019)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 10 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 10)

				if (10 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 10)) > 0 and var_79_9 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb") / 1000

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb")

						arg_76_1:RecordAudio("418031019", var_79_15)
						arg_76_1:RecordAudio("418031019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_16 and arg_76_1.time_ < var_79_8 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play418031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418031020
		arg_80_1.duration_ = 5.93

		local var_80_0 = {
			ja = 5.233,
			CriLanguages = 5.933,
			zh = 5.933
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play418031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1073"]) and arg_80_1.var_.actorSpriteComps1073 == nil then
				arg_80_1.var_.actorSpriteComps1073 = arg_80_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1073"]) then
				if arg_80_1.var_.actorSpriteComps1073 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1073"]) and arg_80_1.var_.actorSpriteComps1073 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps1073 = nil
			end

			local var_83_2 = arg_80_1.actors_["10135"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps10135 == nil then
				arg_80_1.var_.actorSpriteComps10135 = var_83_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_3 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.actorSpriteComps10135 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								iter_83_5.color = Color.New(Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, (arg_80_1.time_ - 0) / var_83_3), Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, (arg_80_1.time_ - 0) / var_83_3), (Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, (arg_80_1.time_ - 0) / var_83_3)))
							else
								local var_83_4 = Mathf.Lerp(iter_83_5.color.r, 0.5, (arg_80_1.time_ - 0) / var_83_3)

								iter_83_5.color = Color.New(var_83_4, var_83_4, var_83_4)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps10135 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_83_7 then
						iter_83_7.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_80_1.var_.actorSpriteComps10135 = nil
			end

			local var_83_5 = arg_80_1.actors_["1073"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1073 = var_83_5.localPosition
				var_83_5.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1073", 2)

				for iter_83_8 = 0, var_83_5.childCount - 1 do
					local var_83_6 = var_83_5:GetChild(iter_83_8)

					if var_83_6.name == "split_2" or not string.find(var_83_6.name, "split") then
						var_83_6.gameObject:SetActive(true)
					else
						var_83_6.gameObject:SetActive(false)
					end
				end
			end

			local var_83_7 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_80_1.time_ - 0) / var_83_7)
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_83_8 = 0
			local var_83_9 = 0.7

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_10 = arg_80_1:GetWordFromCfg(418031020)
				local var_83_11 = arg_80_1:FormatText(var_83_10.content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 28 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 28)

				if (28 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 28)) > 0 and var_83_9 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb") / 1000

					if var_83_14 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_8
					end

					if var_83_10.prefab_name ~= "" and arg_80_1.actors_[var_83_10.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_10.prefab_name].transform, "story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb")

						arg_80_1:RecordAudio("418031020", var_83_15)
						arg_80_1:RecordAudio("418031020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_16 and arg_80_1.time_ < var_83_8 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play418031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418031021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play418031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1073"]) and arg_84_1.var_.actorSpriteComps1073 == nil then
				arg_84_1.var_.actorSpriteComps1073 = arg_84_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1073"]) then
				if arg_84_1.var_.actorSpriteComps1073 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1073"]) and arg_84_1.var_.actorSpriteComps1073 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps1073 = nil
			end

			local var_87_2 = arg_84_1.actors_["1073"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1073 = var_87_2.localPosition
				var_87_2.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1073", 7)

				for iter_87_4 = 0, var_87_2.childCount - 1 do
					local var_87_3 = var_87_2:GetChild(iter_87_4)

					if var_87_3.name == "" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_2.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_84_1.time_ - 0) / var_87_4)
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_5 = arg_84_1.actors_["10135"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10135 = var_87_5.localPosition
				var_87_5.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10135", 7)

				for iter_87_5 = 0, var_87_5.childCount - 1 do
					local var_87_6 = var_87_5:GetChild(iter_87_5)

					if var_87_6.name == "" or not string.find(var_87_6.name, "split") then
						var_87_6.gameObject:SetActive(true)
					else
						var_87_6.gameObject:SetActive(false)
					end
				end
			end

			local var_87_7 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_84_1.time_ - 0) / var_87_7)
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_8 = 0
			local var_87_9 = 0.5

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(418031021).content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_12 = 20 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_10) / 20)

				if (20 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_10) / 20)) > 0 and var_87_9 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_13 and arg_84_1.time_ < var_87_8 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play418031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418031022
		arg_88_1.duration_ = 6.4

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play418031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_0 = 1.4

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				local var_91_1 = Color.New(0, 0, 0)

				var_91_1.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.mask_.color = var_91_1
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				local var_91_2 = Color.New(0, 0, 0)

				var_91_2.a = 1
				arg_88_1.mask_.color = var_91_2
			end

			local var_91_3 = 1.4

			if 1.4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_4 = 1.4

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_4 then
				local var_91_5 = Color.New(0, 0, 0)

				var_91_5.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_3) / var_91_4)
				arg_88_1.mask_.color = var_91_5
			end

			if arg_88_1.time_ >= var_91_3 + var_91_4 and arg_88_1.time_ < var_91_3 + var_91_4 + arg_91_0 then
				local var_91_6 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_6.a = 0
				arg_88_1.mask_.color = var_91_6
			end

			if 1.4 < arg_88_1.time_ and arg_88_1.time_ <= 1.4 + arg_91_0 then
				arg_88_1.fswbg_:SetActive(true)
				arg_88_1.dialog_:SetActive(false)

				arg_88_1.fswtw_.percent = 0
				arg_88_1.fswt_.text = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(418031022).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.fswt_)

				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_88_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_88_1.fswtw_:SetDirty()

				arg_88_1.typewritterCharCountI18N = 0

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_7 = 2.2

			if 2.2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.var_.oldValueTypewriter = arg_88_1.fswtw_.percent

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_8 = 5
			local var_91_9 = 0.333333333333333
			local var_91_10, var_91_11 = arg_88_1:GetPercentByPara(arg_88_1:FormatText(arg_88_1:GetWordFromCfg(418031022).content), 1)

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				local var_91_12 = var_91_8 <= 0 and var_91_9 or var_91_9 * ((var_91_11 - arg_88_1.typewritterCharCountI18N) / var_91_8)

				if (var_91_8 <= 0 and var_91_9 or var_91_9 * ((var_91_11 - arg_88_1.typewritterCharCountI18N) / var_91_8)) > 0 and var_91_9 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12

					if var_91_12 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_7
					end
				end
			end

			local var_91_13 = math.max(0.333333333333333, arg_88_1.talkMaxDuration)

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_13 then
				arg_88_1.fswtw_.percent = Mathf.Lerp(arg_88_1.var_.oldValueTypewriter, var_91_10, (arg_88_1.time_ - var_91_7) / var_91_13)
				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_88_1.fswtw_:SetDirty()
			end

			if arg_88_1.time_ >= var_91_7 + var_91_13 and arg_88_1.time_ < var_91_7 + var_91_13 + arg_91_0 then
				arg_88_1.fswtw_.percent = var_91_10

				arg_88_1.fswtw_:SetDirty()
				arg_88_1:ShowNextGo(true)

				arg_88_1.typewritterCharCountI18N = var_91_11
			end

			if 1.4 < arg_88_1.time_ and arg_88_1.time_ <= 1.4 + arg_91_0 then
				local var_91_14 = arg_88_1.fswbg_.transform:Find("textbox/adapt/content") or arg_88_1.fswbg_.transform:Find("textbox/content")
				local var_91_15 = arg_88_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_91_16 = var_91_14:GetComponent("RectTransform")

				var_91_14:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_91_16.offsetMin = Vector2.New(0, 0)
				var_91_16.offsetMax = Vector2.New(0, 0)
			end

			local var_91_17 = "STblack"

			if arg_88_1.bgs_.STblack == nil then
				local var_91_18 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_17)
				var_91_18.name = var_91_17
				var_91_18.transform.parent = arg_88_1.stage_.transform
				var_91_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_17] = var_91_18
			end

			if 1.4 < arg_88_1.time_ and arg_88_1.time_ <= 1.4 + arg_91_0 then
				local var_91_19 = arg_88_1.bgs_.STblack

				arg_88_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_20 = var_91_19:GetComponent("SpriteRenderer")

				if var_91_20 and var_91_20.sprite then
					local var_91_21 = 2 * (var_91_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_19.transform.localScale = Vector3.New(var_91_21 / var_91_20.sprite.bounds.size.y < var_91_21 * manager.ui.mainCameraCom_.aspect / var_91_20.sprite.bounds.size.x and var_91_21 * manager.ui.mainCameraCom_.aspect / var_91_20.sprite.bounds.size.x or var_91_21 / var_91_20.sprite.bounds.size.y, var_91_21 / var_91_20.sprite.bounds.size.y < var_91_21 * manager.ui.mainCameraCom_.aspect / var_91_20.sprite.bounds.size.x and var_91_21 * manager.ui.mainCameraCom_.aspect / var_91_20.sprite.bounds.size.x or var_91_21 / var_91_20.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "STblack" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play418031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418031023
		arg_92_1.duration_ = 8.8

		local var_92_0 = {
			ja = 8.8,
			CriLanguages = 7.533,
			zh = 7.533
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play418031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 2.93333333333333 < arg_92_1.time_ and arg_92_1.time_ <= 2.93333333333333 + arg_95_0 and not isNil(arg_92_1.actors_["1073"]) and arg_92_1.var_.actorSpriteComps1073 == nil then
				arg_92_1.var_.actorSpriteComps1073 = arg_92_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 2.93333333333333 <= arg_92_1.time_ and arg_92_1.time_ < 2.93333333333333 + var_95_0 and not isNil(arg_92_1.actors_["1073"]) then
				if arg_92_1.var_.actorSpriteComps1073 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 2.93333333333333) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 2.93333333333333) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 2.93333333333333) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 1, (arg_92_1.time_ - 2.93333333333333) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 2.93333333333333 + var_95_0 and arg_92_1.time_ < 2.93333333333333 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1073"]) and arg_92_1.var_.actorSpriteComps1073 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps1073 = nil
			end

			local var_95_2 = arg_92_1.actors_["1073"].transform

			if 2.93333333333333 < arg_92_1.time_ and arg_92_1.time_ <= 2.93333333333333 + arg_95_0 then
				arg_92_1.var_.moveOldPos1073 = var_95_2.localPosition
				var_95_2.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1073", 3)

				for iter_95_4 = 0, var_95_2.childCount - 1 do
					local var_95_3 = var_95_2:GetChild(iter_95_4)

					if var_95_3.name == "" or not string.find(var_95_3.name, "split") then
						var_95_3.gameObject:SetActive(true)
					else
						var_95_3.gameObject:SetActive(false)
					end
				end
			end

			local var_95_4 = 0.001

			if 2.93333333333333 <= arg_92_1.time_ and arg_92_1.time_ < 2.93333333333333 + var_95_4 then
				var_95_2.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_92_1.time_ - 2.93333333333333) / var_95_4)
			end

			if arg_92_1.time_ >= 2.93333333333333 + var_95_4 and arg_92_1.time_ < 2.93333333333333 + var_95_4 + arg_95_0 then
				var_95_2.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_95_5 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_6 = 1.4

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 then
				local var_95_7 = Color.New(0, 0, 0)

				var_95_7.a = Mathf.Lerp(0, 1, (arg_92_1.time_ - var_95_5) / var_95_6)
				arg_92_1.mask_.color = var_95_7
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 then
				local var_95_8 = Color.New(0, 0, 0)

				var_95_8.a = 1
				arg_92_1.mask_.color = var_95_8
			end

			local var_95_9 = 1.4

			if 1.4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_10 = 1.9

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_10 then
				local var_95_11 = Color.New(0, 0, 0)

				var_95_11.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - var_95_9) / var_95_10)
				arg_92_1.mask_.color = var_95_11
			end

			if arg_92_1.time_ >= var_95_9 + var_95_10 and arg_92_1.time_ < var_95_9 + var_95_10 + arg_95_0 then
				local var_95_12 = Color.New(0, 0, 0)

				arg_92_1.mask_.enabled = false
				var_95_12.a = 0
				arg_92_1.mask_.color = var_95_12
			end

			if 1.4 < arg_92_1.time_ and arg_92_1.time_ <= 1.4 + arg_95_0 then
				arg_92_1.fswbg_:SetActive(false)
				arg_92_1.dialog_:SetActive(false)
				SetActive(arg_92_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_92_1:ShowNextGo(false)
			end

			if 1.41666666666667 < arg_92_1.time_ and arg_92_1.time_ <= 1.41666666666667 + arg_95_0 then
				arg_92_1.fswbg_:SetActive(false)
				arg_92_1.dialog_:SetActive(false)
				SetActive(arg_92_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_92_1:ShowNextGo(false)
			end

			if 1.4 < arg_92_1.time_ and arg_92_1.time_ <= 1.4 + arg_95_0 then
				local var_95_13 = arg_92_1.bgs_.ST1001b

				arg_92_1.bgs_.ST1001b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_95_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_14 = var_95_13:GetComponent("SpriteRenderer")

				if var_95_14 and var_95_14.sprite then
					local var_95_15 = 2 * (var_95_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_95_13.transform.localScale = Vector3.New(var_95_15 / var_95_14.sprite.bounds.size.y < var_95_15 * manager.ui.mainCameraCom_.aspect / var_95_14.sprite.bounds.size.x and var_95_15 * manager.ui.mainCameraCom_.aspect / var_95_14.sprite.bounds.size.x or var_95_15 / var_95_14.sprite.bounds.size.y, var_95_15 / var_95_14.sprite.bounds.size.y < var_95_15 * manager.ui.mainCameraCom_.aspect / var_95_14.sprite.bounds.size.x and var_95_15 * manager.ui.mainCameraCom_.aspect / var_95_14.sprite.bounds.size.x or var_95_15 / var_95_14.sprite.bounds.size.y, 0)
				end

				for iter_95_5, iter_95_6 in pairs(arg_92_1.bgs_) do
					if iter_95_5 ~= "ST1001b" then
						iter_95_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_16 = 3.3
			local var_95_17 = 0.35

			if 3.3 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_18 = arg_92_1:GetWordFromCfg(418031023)
				local var_95_19 = arg_92_1:FormatText(var_95_18.content)

				arg_92_1.text_.text = var_95_19

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_21 = 14 <= 0 and var_95_17 or var_95_17 * (utf8.len(var_95_19) / 14)

				if (14 <= 0 and var_95_17 or var_95_17 * (utf8.len(var_95_19) / 14)) > 0 and var_95_17 < var_95_21 then
					arg_92_1.talkMaxDuration = var_95_21

					if var_95_21 + var_95_16 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_21 + var_95_16
					end
				end

				arg_92_1.text_.text = var_95_19
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb") ~= 0 then
					local var_95_22 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb") / 1000

					if var_95_22 + var_95_16 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_22 + var_95_16
					end

					if var_95_18.prefab_name ~= "" and arg_92_1.actors_[var_95_18.prefab_name] ~= nil then
						local var_95_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_18.prefab_name].transform, "story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb")

						arg_92_1:RecordAudio("418031023", var_95_23)
						arg_92_1:RecordAudio("418031023", var_95_23)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_24 = math.max(var_95_17, arg_92_1.talkMaxDuration)

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_24 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_16) / var_95_24

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_16 + var_95_24 and arg_92_1.time_ < var_95_16 + var_95_24 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play418031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418031024
		arg_96_1.duration_ = 3.7

		local var_96_0 = {
			ja = 3.7,
			CriLanguages = 2.666,
			zh = 2.666
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play418031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1073"]) and arg_96_1.var_.actorSpriteComps1073 == nil then
				arg_96_1.var_.actorSpriteComps1073 = arg_96_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1073"]) then
				if arg_96_1.var_.actorSpriteComps1073 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1073"]) and arg_96_1.var_.actorSpriteComps1073 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps1073 = nil
			end

			local var_99_2 = 0
			local var_99_3 = 0.2

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_4 = arg_96_1:GetWordFromCfg(418031024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 8 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 8)

				if (8 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 8)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb")

						arg_96_1:RecordAudio("418031024", var_99_9)
						arg_96_1:RecordAudio("418031024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play418031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418031025
		arg_100_1.duration_ = 8.97

		local var_100_0 = {
			ja = 8.966,
			CriLanguages = 7.966,
			zh = 7.966
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play418031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1073"]) and arg_100_1.var_.actorSpriteComps1073 == nil then
				arg_100_1.var_.actorSpriteComps1073 = arg_100_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1073"]) then
				if arg_100_1.var_.actorSpriteComps1073 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 1, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1073"]) and arg_100_1.var_.actorSpriteComps1073 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps1073 = nil
			end

			local var_103_2 = 0
			local var_103_3 = 1.075

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(418031025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 43 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 43)

				if (43 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 43)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb")

						arg_100_1:RecordAudio("418031025", var_103_9)
						arg_100_1:RecordAudio("418031025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play418031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418031026
		arg_104_1.duration_ = 6.63

		local var_104_0 = {
			ja = 6.2,
			CriLanguages = 6.633,
			zh = 6.633
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play418031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1073 = arg_104_1.actors_["1073"].transform.localPosition
				arg_104_1.actors_["1073"].transform.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1073", 3)

				for iter_107_0 = 0, arg_104_1.actors_["1073"].transform.childCount - 1 do
					local var_107_0 = arg_104_1.actors_["1073"].transform:GetChild(iter_107_0)

					if var_107_0.name == "" or not string.find(var_107_0.name, "split") then
						var_107_0.gameObject:SetActive(true)
					else
						var_107_0.gameObject:SetActive(false)
					end
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1073"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_104_1.time_ - 0) / var_107_1)
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1073"].transform.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_107_2 = 0
			local var_107_3 = 0.8

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(418031026)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 32 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 32)

				if (32 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 32)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb")

						arg_104_1:RecordAudio("418031026", var_107_9)
						arg_104_1:RecordAudio("418031026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play418031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418031027
		arg_108_1.duration_ = 9.53

		local var_108_0 = {
			ja = 8.7,
			CriLanguages = 9.533,
			zh = 9.533
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play418031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1073"]) and arg_108_1.var_.actorSpriteComps1073 == nil then
				arg_108_1.var_.actorSpriteComps1073 = arg_108_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1073"]) then
				if arg_108_1.var_.actorSpriteComps1073 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1073"]) and arg_108_1.var_.actorSpriteComps1073 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps1073 = nil
			end

			local var_111_2 = 0
			local var_111_3 = 0.825

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1188].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_4 = arg_108_1:GetWordFromCfg(418031027)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 33 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 33)

				if (33 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 33)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb")

						arg_108_1:RecordAudio("418031027", var_111_9)
						arg_108_1:RecordAudio("418031027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_10 and arg_108_1.time_ < var_111_2 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play418031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 418031028
		arg_112_1.duration_ = 3.7

		local var_112_0 = {
			ja = 3.666,
			CriLanguages = 3.7,
			zh = 3.7
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
			arg_112_1.auto_ = false
		end

		function arg_112_1.playNext_(arg_114_0)
			arg_112_1.onStoryFinished_()
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10135"]) and arg_112_1.var_.actorSpriteComps10135 == nil then
				arg_112_1.var_.actorSpriteComps10135 = arg_112_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10135"]) then
				if arg_112_1.var_.actorSpriteComps10135 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 1, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10135"]) and arg_112_1.var_.actorSpriteComps10135 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps10135 = nil
			end

			local var_115_2 = arg_112_1.actors_["10135"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10135 = var_115_2.localPosition
				var_115_2.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10135", 3)

				for iter_115_4 = 0, var_115_2.childCount - 1 do
					local var_115_3 = var_115_2:GetChild(iter_115_4)

					if var_115_3.name == "split_2" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_112_1.time_ - 0) / var_115_4)
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_115_5 = arg_112_1.actors_["1073"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1073 = var_115_5.localPosition
				var_115_5.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1073", 7)

				for iter_115_5 = 0, var_115_5.childCount - 1 do
					local var_115_6 = var_115_5:GetChild(iter_115_5)

					if var_115_6.name == "" or not string.find(var_115_6.name, "split") then
						var_115_6.gameObject:SetActive(true)
					else
						var_115_6.gameObject:SetActive(false)
					end
				end
			end

			local var_115_7 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_112_1.time_ - 0) / var_115_7)
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_115_8 = 0
			local var_115_9 = 0.325

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(418031028)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 13 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 13)

				if (13 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 13)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb")

						arg_112_1:RecordAudio("418031028", var_115_15)
						arg_112_1:RecordAudio("418031028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST1001b",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_old_418031.awb"
	}
}
