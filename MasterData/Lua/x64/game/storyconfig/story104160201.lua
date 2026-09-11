return {
	Play416021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0106 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0106")
				var_4_0.name = "ST0106"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0106 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0106

				arg_1_1.bgs_.ST0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0106" then
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

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

			if 0.766666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.766666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 1.5

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(416021001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 60 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 60)

				if (60 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 60)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416021002
		arg_9_1.duration_ = 8.17

		local var_9_0 = {
			zh = 2.866,
			ja = 8.166
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
				arg_9_0:Play416021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10108"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10108"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10108"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10108"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10108 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10108", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_12_5 = arg_9_1.actors_["10108"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10108 == nil then
				arg_9_1.var_.actorSpriteComps10108 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.125

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10108 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10108 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10108 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(416021002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 11 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 11)

				if (11 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 11)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021002", "story_v_out_416021.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021002", "story_v_out_416021.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_416021", "416021002", "story_v_out_416021.awb")

						arg_9_1:RecordAudio("416021002", var_12_15)
						arg_9_1:RecordAudio("416021002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416021", "416021002", "story_v_out_416021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416021", "416021002", "story_v_out_416021.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play416021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416021003
		arg_13_1.duration_ = 8.23

		local var_13_0 = {
			zh = 6,
			ja = 8.233
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
				arg_13_0:Play416021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.625

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(416021003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 25 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 25)

				if (25 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 25)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021003", "story_v_out_416021.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021003", "story_v_out_416021.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_416021", "416021003", "story_v_out_416021.awb")

						arg_13_1:RecordAudio("416021003", var_16_6)
						arg_13_1:RecordAudio("416021003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416021", "416021003", "story_v_out_416021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416021", "416021003", "story_v_out_416021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play416021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416021004
		arg_17_1.duration_ = 9.83

		local var_17_0 = {
			zh = 6.133,
			ja = 9.833
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
				arg_17_0:Play416021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(416021004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 23 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 23)

				if (23 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 23)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021004", "story_v_out_416021.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021004", "story_v_out_416021.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_416021", "416021004", "story_v_out_416021.awb")

						arg_17_1:RecordAudio("416021004", var_20_6)
						arg_17_1:RecordAudio("416021004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416021", "416021004", "story_v_out_416021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416021", "416021004", "story_v_out_416021.awb")
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
	Play416021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416021005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10108 = arg_21_1.actors_["10108"].transform.localPosition
				arg_21_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10108", 7)

				for iter_24_0 = 0, arg_21_1.actors_["10108"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10108"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_2 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_2 + 1 and arg_21_1.time_ < var_24_2 + 1 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_3 = 0
			local var_24_4 = 1.75

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(416021005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 70 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 70)

				if (70 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 70)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play416021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416021006
		arg_25_1.duration_ = 7.73

		local var_25_0 = {
			zh = 4.833,
			ja = 7.733
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
				arg_25_0:Play416021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1028"] == nil then
				local var_28_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_28_0) then
					local var_28_1 = Object.Instantiate(var_28_0, arg_25_1.canvasGo_.transform)

					var_28_1.transform:SetSiblingIndex(1)

					var_28_1.name = "1028"
					var_28_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_["1028"] = var_28_1

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs((var_28_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_2 = arg_25_1.actors_["1028"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1028 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1028", 3)

				for iter_28_2 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_2)

					if var_28_3.name == "split_6" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_28_5 = arg_25_1.actors_["1028"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps1028 == nil then
				arg_25_1.var_.actorSpriteComps1028 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps1028 then
					for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_28_4 then
							if arg_25_1.isInRecall_ then
								iter_28_4.color = Color.New(Mathf.Lerp(iter_28_4.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_6), Mathf.Lerp(iter_28_4.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_6), (Mathf.Lerp(iter_28_4.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_6)))
							else
								local var_28_7 = Mathf.Lerp(iter_28_4.color.r, 1, (arg_25_1.time_ - 0) / var_28_6)

								iter_28_4.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps1028 then
				for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_28_6 then
						iter_28_6.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1028 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.525

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(416021006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 21 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 21)

				if (21 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 21)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021006", "story_v_out_416021.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021006", "story_v_out_416021.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_416021", "416021006", "story_v_out_416021.awb")

						arg_25_1:RecordAudio("416021006", var_28_15)
						arg_25_1:RecordAudio("416021006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416021", "416021006", "story_v_out_416021.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416021", "416021006", "story_v_out_416021.awb")
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
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play416021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416021007
		arg_29_1.duration_ = 12.13

		local var_29_0 = {
			zh = 6.966,
			ja = 12.133
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
				arg_29_0:Play416021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10108 = arg_29_1.actors_["10108"].transform.localPosition
				arg_29_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10108", 4)

				for iter_32_0 = 0, arg_29_1.actors_["10108"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10108"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_1" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10108"].transform.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_32_2 = arg_29_1.actors_["10108"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10108 == nil then
				arg_29_1.var_.actorSpriteComps10108 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10108 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10108 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10108 = nil
			end

			local var_32_5 = arg_29_1.actors_["1028"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1028 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1028", 2)

				for iter_32_5 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_5)

					if var_32_6.name == "split_6" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_32_8 = arg_29_1.actors_["1028"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1028 == nil then
				arg_29_1.var_.actorSpriteComps1028 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 and not isNil(var_32_8) then
				if arg_29_1.var_.actorSpriteComps1028 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1028 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_32_9 then
						iter_32_9.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1028 = nil
			end

			local var_32_11 = 0
			local var_32_12 = 0.6

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
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

				local var_32_13 = arg_29_1:GetWordFromCfg(416021007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 24 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_14) / 24)

				if (24 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_14) / 24)) > 0 and var_32_12 < var_32_16 then
					arg_29_1.talkMaxDuration = var_32_16

					if var_32_16 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021007", "story_v_out_416021.awb") ~= 0 then
					local var_32_17 = manager.audio:GetVoiceLength("story_v_out_416021", "416021007", "story_v_out_416021.awb") / 1000

					if var_32_17 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_11
					end

					if var_32_13.prefab_name ~= "" and arg_29_1.actors_[var_32_13.prefab_name] ~= nil then
						local var_32_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_13.prefab_name].transform, "story_v_out_416021", "416021007", "story_v_out_416021.awb")

						arg_29_1:RecordAudio("416021007", var_32_18)
						arg_29_1:RecordAudio("416021007", var_32_18)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416021", "416021007", "story_v_out_416021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416021", "416021007", "story_v_out_416021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_19 and arg_29_1.time_ < var_32_11 + var_32_19 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416021008
		arg_33_1.duration_ = 9.17

		local var_33_0 = {
			zh = 4.133,
			ja = 9.166
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
				arg_33_0:Play416021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1028"]) and arg_33_1.var_.actorSpriteComps1028 == nil then
				arg_33_1.var_.actorSpriteComps1028 = arg_33_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1028"]) then
				if arg_33_1.var_.actorSpriteComps1028 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1028"]) and arg_33_1.var_.actorSpriteComps1028 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1028 = nil
			end

			local var_36_2 = arg_33_1.actors_["10108"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10108 == nil then
				arg_33_1.var_.actorSpriteComps10108 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10108 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_5.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_5.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10108 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10108 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(416021008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 20 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 20)

				if (20 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 20)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021008", "story_v_out_416021.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021008", "story_v_out_416021.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_416021", "416021008", "story_v_out_416021.awb")

						arg_33_1:RecordAudio("416021008", var_36_12)
						arg_33_1:RecordAudio("416021008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416021", "416021008", "story_v_out_416021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416021", "416021008", "story_v_out_416021.awb")
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

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416021009
		arg_37_1.duration_ = 13.9

		local var_37_0 = {
			zh = 5.533,
			ja = 13.9
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
				arg_37_0:Play416021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1028"]) and arg_37_1.var_.actorSpriteComps1028 == nil then
				arg_37_1.var_.actorSpriteComps1028 = arg_37_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1028"]) then
				if arg_37_1.var_.actorSpriteComps1028 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1028"]) and arg_37_1.var_.actorSpriteComps1028 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1028 = nil
			end

			local var_40_2 = arg_37_1.actors_["10108"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10108 == nil then
				arg_37_1.var_.actorSpriteComps10108 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10108 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10108 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10108 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.625

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(416021009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 25 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 25)

				if (25 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 25)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021009", "story_v_out_416021.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021009", "story_v_out_416021.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_416021", "416021009", "story_v_out_416021.awb")

						arg_37_1:RecordAudio("416021009", var_40_12)
						arg_37_1:RecordAudio("416021009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416021", "416021009", "story_v_out_416021.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416021", "416021009", "story_v_out_416021.awb")
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play416021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416021010
		arg_41_1.duration_ = 6.07

		local var_41_0 = {
			zh = 3.8,
			ja = 6.066
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
				arg_41_0:Play416021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1028"]) and arg_41_1.var_.actorSpriteComps1028 == nil then
				arg_41_1.var_.actorSpriteComps1028 = arg_41_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1028"]) then
				if arg_41_1.var_.actorSpriteComps1028 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1028"]) and arg_41_1.var_.actorSpriteComps1028 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1028 = nil
			end

			local var_44_2 = arg_41_1.actors_["10108"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10108 == nil then
				arg_41_1.var_.actorSpriteComps10108 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10108 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10108 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10108 = nil
			end

			local var_44_5 = arg_41_1.actors_["1028"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1028 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1028", 2)

				for iter_44_8 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_8)

					if var_44_6.name == "split_4" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_44_8 = 0
			local var_44_9 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(416021010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 17 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 17)

				if (17 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 17)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021010", "story_v_out_416021.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021010", "story_v_out_416021.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_416021", "416021010", "story_v_out_416021.awb")

						arg_41_1:RecordAudio("416021010", var_44_15)
						arg_41_1:RecordAudio("416021010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416021", "416021010", "story_v_out_416021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416021", "416021010", "story_v_out_416021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play416021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416021011
		arg_45_1.duration_ = 11.73

		local var_45_0 = {
			zh = 8.166,
			ja = 11.733
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
				arg_45_0:Play416021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1028"]) and arg_45_1.var_.actorSpriteComps1028 == nil then
				arg_45_1.var_.actorSpriteComps1028 = arg_45_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1028"]) then
				if arg_45_1.var_.actorSpriteComps1028 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1028"]) and arg_45_1.var_.actorSpriteComps1028 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1028 = nil
			end

			local var_48_2 = arg_45_1.actors_["10108"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10108 == nil then
				arg_45_1.var_.actorSpriteComps10108 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10108 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								iter_48_5.color = Color.New(Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_5.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_5.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10108 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_48_7 then
						iter_48_7.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10108 = nil
			end

			local var_48_5 = 0
			local var_48_6 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(416021011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 28 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 28)

				if (28 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 28)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021011", "story_v_out_416021.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021011", "story_v_out_416021.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_416021", "416021011", "story_v_out_416021.awb")

						arg_45_1:RecordAudio("416021011", var_48_12)
						arg_45_1:RecordAudio("416021011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416021", "416021011", "story_v_out_416021.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416021", "416021011", "story_v_out_416021.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416021012
		arg_49_1.duration_ = 10

		local var_49_0 = {
			zh = 7.733,
			ja = 10
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
				arg_49_0:Play416021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1028"]) and arg_49_1.var_.actorSpriteComps1028 == nil then
				arg_49_1.var_.actorSpriteComps1028 = arg_49_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.125

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1028"]) then
				if arg_49_1.var_.actorSpriteComps1028 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1028"]) and arg_49_1.var_.actorSpriteComps1028 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1028 = nil
			end

			local var_52_2 = arg_49_1.actors_["10108"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10108 == nil then
				arg_49_1.var_.actorSpriteComps10108 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.125

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10108 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								iter_52_5.color = Color.New(Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_5.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_5.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10108 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_52_7 then
						iter_52_7.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10108 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.8

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(416021012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 32 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 32)

				if (32 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 32)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021012", "story_v_out_416021.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021012", "story_v_out_416021.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_416021", "416021012", "story_v_out_416021.awb")

						arg_49_1:RecordAudio("416021012", var_52_12)
						arg_49_1:RecordAudio("416021012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416021", "416021012", "story_v_out_416021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416021", "416021012", "story_v_out_416021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_13 and arg_49_1.time_ < var_52_5 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play416021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416021013
		arg_53_1.duration_ = 7.63

		local var_53_0 = {
			zh = 5.8,
			ja = 7.633
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
				arg_53_0:Play416021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.575

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(416021013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 23 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 23)

				if (23 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 23)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021013", "story_v_out_416021.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021013", "story_v_out_416021.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_416021", "416021013", "story_v_out_416021.awb")

						arg_53_1:RecordAudio("416021013", var_56_6)
						arg_53_1:RecordAudio("416021013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416021", "416021013", "story_v_out_416021.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416021", "416021013", "story_v_out_416021.awb")
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
	Play416021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416021014
		arg_57_1.duration_ = 13.73

		local var_57_0 = {
			zh = 8.4,
			ja = 13.733
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
				arg_57_0:Play416021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1028"]) and arg_57_1.var_.actorSpriteComps1028 == nil then
				arg_57_1.var_.actorSpriteComps1028 = arg_57_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1028"]) then
				if arg_57_1.var_.actorSpriteComps1028 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1028"]) and arg_57_1.var_.actorSpriteComps1028 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1028 = nil
			end

			local var_60_2 = arg_57_1.actors_["10108"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10108 == nil then
				arg_57_1.var_.actorSpriteComps10108 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10108 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								iter_60_5.color = Color.New(Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_5.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_5.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10108 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10108 = nil
			end

			local var_60_5 = arg_57_1.actors_["10108"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10108 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10108", 4)

				for iter_60_8 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_8)

					if var_60_6.name == "split_4" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_60_8 = 0
			local var_60_9 = 0.625

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(416021014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 25 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 25)

				if (25 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 25)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021014", "story_v_out_416021.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021014", "story_v_out_416021.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_416021", "416021014", "story_v_out_416021.awb")

						arg_57_1:RecordAudio("416021014", var_60_15)
						arg_57_1:RecordAudio("416021014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416021", "416021014", "story_v_out_416021.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416021", "416021014", "story_v_out_416021.awb")
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
				actorName = "10108",
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
	Play416021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416021015
		arg_61_1.duration_ = 7.8

		local var_61_0 = {
			zh = 7.8,
			ja = 4.533
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
				arg_61_0:Play416021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.725

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(416021015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 29 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 29)

				if (29 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 29)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021015", "story_v_out_416021.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021015", "story_v_out_416021.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_416021", "416021015", "story_v_out_416021.awb")

						arg_61_1:RecordAudio("416021015", var_64_6)
						arg_61_1:RecordAudio("416021015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416021", "416021015", "story_v_out_416021.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416021", "416021015", "story_v_out_416021.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416021016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416021016
		arg_65_1.duration_ = 3.3

		local var_65_0 = {
			zh = 3.3,
			ja = 2.9
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
				arg_65_0:Play416021017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1028"]) and arg_65_1.var_.actorSpriteComps1028 == nil then
				arg_65_1.var_.actorSpriteComps1028 = arg_65_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.125

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1028"]) then
				if arg_65_1.var_.actorSpriteComps1028 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1028"]) and arg_65_1.var_.actorSpriteComps1028 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1028 = nil
			end

			local var_68_2 = arg_65_1.actors_["10108"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10108 == nil then
				arg_65_1.var_.actorSpriteComps10108 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.125

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10108 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10108 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10108 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.2

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(416021016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 8 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 8)

				if (8 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 8)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021016", "story_v_out_416021.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021016", "story_v_out_416021.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_416021", "416021016", "story_v_out_416021.awb")

						arg_65_1:RecordAudio("416021016", var_68_12)
						arg_65_1:RecordAudio("416021016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416021", "416021016", "story_v_out_416021.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416021", "416021016", "story_v_out_416021.awb")
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play416021017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416021017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play416021018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1028"]) and arg_69_1.var_.actorSpriteComps1028 == nil then
				arg_69_1.var_.actorSpriteComps1028 = arg_69_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.125

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1028"]) then
				if arg_69_1.var_.actorSpriteComps1028 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1028"]) and arg_69_1.var_.actorSpriteComps1028 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1028 = nil
			end

			local var_72_2 = arg_69_1.actors_["10108"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10108 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10108", 7)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_5 = arg_69_1.actors_["1028"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1028 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1028", 7)

				for iter_72_5 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_5)

					if var_72_6.name == "split_5" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_8 = 0
			local var_72_9 = 1.675

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(416021017).content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 67 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_10) / 67)

				if (67 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_10) / 67)) > 0 and var_72_9 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_13 and arg_69_1.time_ < var_72_8 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416021018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416021018
		arg_73_1.duration_ = 5.37

		local var_73_0 = {
			zh = 3.666,
			ja = 5.366
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
				arg_73_0:Play416021019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1028"]) and arg_73_1.var_.actorSpriteComps1028 == nil then
				arg_73_1.var_.actorSpriteComps1028 = arg_73_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.125

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1028"]) then
				if arg_73_1.var_.actorSpriteComps1028 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1028"]) and arg_73_1.var_.actorSpriteComps1028 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1028 = nil
			end

			local var_76_2 = arg_73_1.actors_["1028"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1028 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1028", 2)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_76_5 = 0
			local var_76_6 = 0.35

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(416021018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 14 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 14)

				if (14 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 14)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021018", "story_v_out_416021.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021018", "story_v_out_416021.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_416021", "416021018", "story_v_out_416021.awb")

						arg_73_1:RecordAudio("416021018", var_76_12)
						arg_73_1:RecordAudio("416021018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416021", "416021018", "story_v_out_416021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416021", "416021018", "story_v_out_416021.awb")
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
				actorName = "1028",
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
	Play416021019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416021019
		arg_77_1.duration_ = 9.43

		local var_77_0 = {
			zh = 4.266,
			ja = 9.433
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
				arg_77_0:Play416021020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1028"]) and arg_77_1.var_.actorSpriteComps1028 == nil then
				arg_77_1.var_.actorSpriteComps1028 = arg_77_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.125

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1028"]) then
				if arg_77_1.var_.actorSpriteComps1028 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1028"]) and arg_77_1.var_.actorSpriteComps1028 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1028 = nil
			end

			local var_80_2 = arg_77_1.actors_["10108"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10108 == nil then
				arg_77_1.var_.actorSpriteComps10108 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.125

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10108 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_5.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_5.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10108 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10108 = nil
			end

			local var_80_5 = arg_77_1.actors_["10108"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10108 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10108", 4)

				for iter_80_8 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_8)

					if var_80_6.name == "" or not string.find(var_80_6.name, "split") then
						var_80_6.gameObject:SetActive(true)
					else
						var_80_6.gameObject:SetActive(false)
					end
				end
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_77_1.time_ - 0) / var_80_7)
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_80_8 = 0
			local var_80_9 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(416021019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 17 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 17)

				if (17 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 17)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021019", "story_v_out_416021.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021019", "story_v_out_416021.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_416021", "416021019", "story_v_out_416021.awb")

						arg_77_1:RecordAudio("416021019", var_80_15)
						arg_77_1:RecordAudio("416021019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416021", "416021019", "story_v_out_416021.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416021", "416021019", "story_v_out_416021.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play416021020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416021020
		arg_81_1.duration_ = 4.23

		local var_81_0 = {
			zh = 4.233,
			ja = 3.8
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
				arg_81_0:Play416021021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1028"]) and arg_81_1.var_.actorSpriteComps1028 == nil then
				arg_81_1.var_.actorSpriteComps1028 = arg_81_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.125

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1028"]) then
				if arg_81_1.var_.actorSpriteComps1028 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 1, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1028"]) and arg_81_1.var_.actorSpriteComps1028 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1028 = nil
			end

			local var_84_2 = arg_81_1.actors_["10108"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10108 == nil then
				arg_81_1.var_.actorSpriteComps10108 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.125

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10108 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10108 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10108 = nil
			end

			local var_84_5 = 0
			local var_84_6 = 0.55

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(416021020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 22 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 22)

				if (22 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 22)) > 0 and var_84_6 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021020", "story_v_out_416021.awb") ~= 0 then
					local var_84_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021020", "story_v_out_416021.awb") / 1000

					if var_84_11 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_5
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_416021", "416021020", "story_v_out_416021.awb")

						arg_81_1:RecordAudio("416021020", var_84_12)
						arg_81_1:RecordAudio("416021020", var_84_12)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416021", "416021020", "story_v_out_416021.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416021", "416021020", "story_v_out_416021.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_13 and arg_81_1.time_ < var_84_5 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play416021021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416021021
		arg_85_1.duration_ = 9.87

		local var_85_0 = {
			zh = 3.5,
			ja = 9.866
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
				arg_85_0:Play416021022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1028"]) and arg_85_1.var_.actorSpriteComps1028 == nil then
				arg_85_1.var_.actorSpriteComps1028 = arg_85_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1028"]) then
				if arg_85_1.var_.actorSpriteComps1028 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1028"]) and arg_85_1.var_.actorSpriteComps1028 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1028 = nil
			end

			local var_88_2 = arg_85_1.actors_["10108"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10108 == nil then
				arg_85_1.var_.actorSpriteComps10108 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.125

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10108 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10108 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10108 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(416021021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 14 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 14)

				if (14 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 14)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021021", "story_v_out_416021.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021021", "story_v_out_416021.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_416021", "416021021", "story_v_out_416021.awb")

						arg_85_1:RecordAudio("416021021", var_88_12)
						arg_85_1:RecordAudio("416021021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416021", "416021021", "story_v_out_416021.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416021", "416021021", "story_v_out_416021.awb")
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
	Play416021022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416021022
		arg_89_1.duration_ = 3.73

		local var_89_0 = {
			zh = 3.733,
			ja = 2.766
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
				arg_89_0:Play416021023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1028"]) and arg_89_1.var_.actorSpriteComps1028 == nil then
				arg_89_1.var_.actorSpriteComps1028 = arg_89_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1028"]) then
				if arg_89_1.var_.actorSpriteComps1028 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 1, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1028"]) and arg_89_1.var_.actorSpriteComps1028 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1028 = nil
			end

			local var_92_2 = arg_89_1.actors_["10108"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10108 == nil then
				arg_89_1.var_.actorSpriteComps10108 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.125

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10108 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								iter_92_5.color = Color.New(Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_5.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_5.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10108 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_92_7 then
						iter_92_7.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10108 = nil
			end

			local var_92_5 = 0
			local var_92_6 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(416021022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 16 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 16)

				if (16 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 16)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021022", "story_v_out_416021.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021022", "story_v_out_416021.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_416021", "416021022", "story_v_out_416021.awb")

						arg_89_1:RecordAudio("416021022", var_92_12)
						arg_89_1:RecordAudio("416021022", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416021", "416021022", "story_v_out_416021.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416021", "416021022", "story_v_out_416021.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416021023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416021023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play416021024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1028"]) and arg_93_1.var_.actorSpriteComps1028 == nil then
				arg_93_1.var_.actorSpriteComps1028 = arg_93_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.125

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1028"]) then
				if arg_93_1.var_.actorSpriteComps1028 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1028"]) and arg_93_1.var_.actorSpriteComps1028 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1028 = nil
			end

			local var_96_2 = arg_93_1.actors_["10108"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10108 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10108", 4)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "split_2" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_96_5 = 0
			local var_96_6 = 0.85

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(416021023).content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 34 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_7) / 34)

				if (34 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_7) / 34)) > 0 and var_96_6 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_10 and arg_93_1.time_ < var_96_5 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play416021024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416021024
		arg_97_1.duration_ = 7.9

		local var_97_0 = {
			zh = 7.9,
			ja = 7.866
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
				arg_97_0:Play416021025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1028"]) and arg_97_1.var_.actorSpriteComps1028 == nil then
				arg_97_1.var_.actorSpriteComps1028 = arg_97_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.125

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1028"]) then
				if arg_97_1.var_.actorSpriteComps1028 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1028"]) and arg_97_1.var_.actorSpriteComps1028 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1028 = nil
			end

			local var_100_2 = arg_97_1.actors_["10108"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10108 == nil then
				arg_97_1.var_.actorSpriteComps10108 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.125

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10108 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10108 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10108 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 0.675

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(416021024)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 27 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 27)

				if (27 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 27)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021024", "story_v_out_416021.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021024", "story_v_out_416021.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_416021", "416021024", "story_v_out_416021.awb")

						arg_97_1:RecordAudio("416021024", var_100_12)
						arg_97_1:RecordAudio("416021024", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416021", "416021024", "story_v_out_416021.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416021", "416021024", "story_v_out_416021.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play416021025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416021025
		arg_101_1.duration_ = 9.57

		local var_101_0 = {
			zh = 6.433,
			ja = 9.566
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
				arg_101_0:Play416021026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1028"]) and arg_101_1.var_.actorSpriteComps1028 == nil then
				arg_101_1.var_.actorSpriteComps1028 = arg_101_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.125

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1028"]) then
				if arg_101_1.var_.actorSpriteComps1028 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 1, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1028"]) and arg_101_1.var_.actorSpriteComps1028 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1028 = nil
			end

			local var_104_2 = arg_101_1.actors_["10108"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10108 == nil then
				arg_101_1.var_.actorSpriteComps10108 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.125

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10108 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								iter_104_5.color = Color.New(Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_5.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_5.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10108 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_104_7 then
						iter_104_7.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10108 = nil
			end

			local var_104_5 = arg_101_1.actors_["1028"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1028 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1028", 2)

				for iter_104_8 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_8)

					if var_104_6.name == "split_4" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_104_8 = 0
			local var_104_9 = 0.5

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(416021025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 20 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 20)

				if (20 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 20)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021025", "story_v_out_416021.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021025", "story_v_out_416021.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_416021", "416021025", "story_v_out_416021.awb")

						arg_101_1:RecordAudio("416021025", var_104_15)
						arg_101_1:RecordAudio("416021025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416021", "416021025", "story_v_out_416021.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416021", "416021025", "story_v_out_416021.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play416021026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416021026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play416021027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10108 = arg_105_1.actors_["10108"].transform.localPosition
				arg_105_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10108", 7)

				for iter_108_0 = 0, arg_105_1.actors_["10108"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10108"].transform:GetChild(iter_108_0)

					if var_108_0.name == "" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_2 = arg_105_1.actors_["1028"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1028 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1028", 7)

				for iter_108_1 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_1)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_5 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= var_108_5 + 0.833333333333333 and arg_105_1.time_ < var_108_5 + 0.833333333333333 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			if 0.7 < arg_105_1.time_ and arg_105_1.time_ <= 0.7 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_108_7 = 0
			local var_108_8 = 1.325

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_9 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(416021026).content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 53 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_9) / 53)

				if (53 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_9) / 53)) > 0 and var_108_8 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_7) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_7 + var_108_12 and arg_105_1.time_ < var_108_7 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416021027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416021027
		arg_109_1.duration_ = 4.13

		local var_109_0 = {
			zh = 4.133,
			ja = 3.533
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
				arg_109_0:Play416021028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.5

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(416021027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 20 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 20)

				if (20 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 20)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021027", "story_v_out_416021.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021027", "story_v_out_416021.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_416021", "416021027", "story_v_out_416021.awb")

						arg_109_1:RecordAudio("416021027", var_112_6)
						arg_109_1:RecordAudio("416021027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416021", "416021027", "story_v_out_416021.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416021", "416021027", "story_v_out_416021.awb")
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
	Play416021028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416021028
		arg_113_1.duration_ = 3.83

		local var_113_0 = {
			zh = 2.266,
			ja = 3.833
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
				arg_113_0:Play416021029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1028"]) and arg_113_1.var_.actorSpriteComps1028 == nil then
				arg_113_1.var_.actorSpriteComps1028 = arg_113_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.125

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1028"]) then
				if arg_113_1.var_.actorSpriteComps1028 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1028"]) and arg_113_1.var_.actorSpriteComps1028 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps1028 = nil
			end

			local var_116_2 = arg_113_1.actors_["1028"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1028 = var_116_2.localPosition
				var_116_2.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1028", 3)

				for iter_116_4 = 0, var_116_2.childCount - 1 do
					local var_116_3 = var_116_2:GetChild(iter_116_4)

					if var_116_3.name == "" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_113_1.time_ - 0) / var_116_4)
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_116_5 = 0
			local var_116_6 = 0.225

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(416021028)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 9 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 9)

				if (9 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 9)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021028", "story_v_out_416021.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021028", "story_v_out_416021.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_416021", "416021028", "story_v_out_416021.awb")

						arg_113_1:RecordAudio("416021028", var_116_12)
						arg_113_1:RecordAudio("416021028", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416021", "416021028", "story_v_out_416021.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416021", "416021028", "story_v_out_416021.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play416021029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416021029
		arg_117_1.duration_ = 10.2

		local var_117_0 = {
			zh = 6.866,
			ja = 10.2
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
				arg_117_0:Play416021030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1028"]) and arg_117_1.var_.actorSpriteComps1028 == nil then
				arg_117_1.var_.actorSpriteComps1028 = arg_117_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.125

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1028"]) then
				if arg_117_1.var_.actorSpriteComps1028 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1028"]) and arg_117_1.var_.actorSpriteComps1028 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps1028 = nil
			end

			local var_120_2 = 0
			local var_120_3 = 0.75

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_4 = arg_117_1:GetWordFromCfg(416021029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 30 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 30)

				if (30 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 30)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021029", "story_v_out_416021.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021029", "story_v_out_416021.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_416021", "416021029", "story_v_out_416021.awb")

						arg_117_1:RecordAudio("416021029", var_120_9)
						arg_117_1:RecordAudio("416021029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_416021", "416021029", "story_v_out_416021.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_416021", "416021029", "story_v_out_416021.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play416021030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 416021030
		arg_121_1.duration_ = 7.43

		local var_121_0 = {
			zh = 4.3,
			ja = 7.433
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
				arg_121_0:Play416021031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1028"]) and arg_121_1.var_.actorSpriteComps1028 == nil then
				arg_121_1.var_.actorSpriteComps1028 = arg_121_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.125

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1028"]) then
				if arg_121_1.var_.actorSpriteComps1028 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1028"]) and arg_121_1.var_.actorSpriteComps1028 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1028 = nil
			end

			local var_124_2 = arg_121_1.actors_["10108"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10108 == nil then
				arg_121_1.var_.actorSpriteComps10108 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.125

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10108 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								iter_124_5.color = Color.New(Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_5.color.r, 1, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_5.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10108 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_124_7 then
						iter_124_7.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10108 = nil
			end

			local var_124_5 = arg_121_1.actors_["10108"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10108 = var_124_5.localPosition
				var_124_5.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10108", 4)

				for iter_124_8 = 0, var_124_5.childCount - 1 do
					local var_124_6 = var_124_5:GetChild(iter_124_8)

					if var_124_6.name == "split_1" or not string.find(var_124_6.name, "split") then
						var_124_6.gameObject:SetActive(true)
					else
						var_124_6.gameObject:SetActive(false)
					end
				end
			end

			local var_124_7 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_121_1.time_ - 0) / var_124_7)
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_124_8 = arg_121_1.actors_["1028"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1028 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1028", 2)

				for iter_124_9 = 0, var_124_8.childCount - 1 do
					local var_124_9 = var_124_8:GetChild(iter_124_9)

					if var_124_9.name == "" or not string.find(var_124_9.name, "split") then
						var_124_9.gameObject:SetActive(true)
					else
						var_124_9.gameObject:SetActive(false)
					end
				end
			end

			local var_124_10 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_10 then
				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_121_1.time_ - 0) / var_124_10)
			end

			if arg_121_1.time_ >= 0 + var_124_10 and arg_121_1.time_ < 0 + var_124_10 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_124_11 = 0
			local var_124_12 = 0.425

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(416021030)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 17 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 17)

				if (17 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 17)) > 0 and var_124_12 < var_124_16 then
					arg_121_1.talkMaxDuration = var_124_16

					if var_124_16 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021030", "story_v_out_416021.awb") ~= 0 then
					local var_124_17 = manager.audio:GetVoiceLength("story_v_out_416021", "416021030", "story_v_out_416021.awb") / 1000

					if var_124_17 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_11
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_416021", "416021030", "story_v_out_416021.awb")

						arg_121_1:RecordAudio("416021030", var_124_18)
						arg_121_1:RecordAudio("416021030", var_124_18)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_416021", "416021030", "story_v_out_416021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_416021", "416021030", "story_v_out_416021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_19 = math.max(var_124_12, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_19 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_19

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_19 and arg_121_1.time_ < var_124_11 + var_124_19 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416021031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416021031
		arg_125_1.duration_ = 3.2

		local var_125_0 = {
			zh = 3.2,
			ja = 2.233
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
				arg_125_0:Play416021032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1028"]) and arg_125_1.var_.actorSpriteComps1028 == nil then
				arg_125_1.var_.actorSpriteComps1028 = arg_125_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1028"]) then
				if arg_125_1.var_.actorSpriteComps1028 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 1, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1028"]) and arg_125_1.var_.actorSpriteComps1028 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps1028 = nil
			end

			local var_128_2 = arg_125_1.actors_["10108"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10108 == nil then
				arg_125_1.var_.actorSpriteComps10108 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.125

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps10108 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								iter_128_5.color = Color.New(Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_3), Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_3), (Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_3)))
							else
								local var_128_4 = Mathf.Lerp(iter_128_5.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_3)

								iter_128_5.color = Color.New(var_128_4, var_128_4, var_128_4)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10108 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_128_7 then
						iter_128_7.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10108 = nil
			end

			local var_128_5 = 0
			local var_128_6 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(416021031)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 18 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 18)

				if (18 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 18)) > 0 and var_128_6 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021031", "story_v_out_416021.awb") ~= 0 then
					local var_128_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021031", "story_v_out_416021.awb") / 1000

					if var_128_11 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_5
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_416021", "416021031", "story_v_out_416021.awb")

						arg_125_1:RecordAudio("416021031", var_128_12)
						arg_125_1:RecordAudio("416021031", var_128_12)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_416021", "416021031", "story_v_out_416021.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_416021", "416021031", "story_v_out_416021.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_6, arg_125_1.talkMaxDuration)

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_5) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_5 + var_128_13 and arg_125_1.time_ < var_128_5 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play416021032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416021032
		arg_129_1.duration_ = 2.7

		local var_129_0 = {
			zh = 2.2,
			ja = 2.7
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
				arg_129_0:Play416021033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.175

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
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(416021032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 7 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 7)

				if (7 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 7)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021032", "story_v_out_416021.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021032", "story_v_out_416021.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_416021", "416021032", "story_v_out_416021.awb")

						arg_129_1:RecordAudio("416021032", var_132_6)
						arg_129_1:RecordAudio("416021032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416021", "416021032", "story_v_out_416021.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416021", "416021032", "story_v_out_416021.awb")
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
	Play416021033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416021033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play416021034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10108 = arg_133_1.actors_["10108"].transform.localPosition
				arg_133_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10108", 7)

				for iter_136_0 = 0, arg_133_1.actors_["10108"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10108"].transform:GetChild(iter_136_0)

					if var_136_0.name == "" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_136_2 = arg_133_1.actors_["1028"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1028 = var_136_2.localPosition
				var_136_2.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1028", 7)

				for iter_136_1 = 0, var_136_2.childCount - 1 do
					local var_136_3 = var_136_2:GetChild(iter_136_1)

					if var_136_3.name == "" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				var_136_2.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_133_1.time_ - 0) / var_136_4)
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				var_136_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_136_5 = 0
			local var_136_6 = 1.025

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(416021033).content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 41 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_7) / 41)

				if (41 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_7) / 41)) > 0 and var_136_6 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_10 and arg_133_1.time_ < var_136_5 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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
				actorName = "1028",
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
	Play416021034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416021034
		arg_137_1.duration_ = 13.67

		local var_137_0 = {
			zh = 10.8666666666657,
			ja = 13.6666666666657
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
				arg_137_0:Play416021035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.bgs_.I14f == nil then
				local var_140_0 = Object.Instantiate(arg_137_1.paintGo_)

				var_140_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I14f")
				var_140_0.name = "I14f"
				var_140_0.transform.parent = arg_137_1.stage_.transform
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.bgs_.I14f = var_140_0
			end

			if 1.06666666666667 < arg_137_1.time_ and arg_137_1.time_ <= 1.06666666666667 + arg_140_0 then
				local var_140_1 = arg_137_1.bgs_.I14f

				arg_137_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_2 = var_140_1:GetComponent("SpriteRenderer")

				if var_140_2 and var_140_2.sprite then
					local var_140_3 = 2 * (var_140_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_1.transform.localScale = Vector3.New(var_140_3 / var_140_2.sprite.bounds.size.y < var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x and var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x or var_140_3 / var_140_2.sprite.bounds.size.y, var_140_3 / var_140_2.sprite.bounds.size.y < var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x and var_140_3 * manager.ui.mainCameraCom_.aspect / var_140_2.sprite.bounds.size.x or var_140_3 / var_140_2.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "I14f" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_4 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_5 = 1.06666666666667

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_5 then
				local var_140_6 = Color.New(0, 0, 0)

				var_140_6.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_4) / var_140_5)
				arg_137_1.mask_.color = var_140_6
			end

			if arg_137_1.time_ >= var_140_4 + var_140_5 and arg_137_1.time_ < var_140_4 + var_140_5 + arg_140_0 then
				local var_140_7 = Color.New(0, 0, 0)

				var_140_7.a = 1
				arg_137_1.mask_.color = var_140_7
			end

			local var_140_8 = 1.06666666666667

			if 1.06666666666667 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_9 = 2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 then
				local var_140_10 = Color.New(0, 0, 0)

				var_140_10.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_8) / var_140_9)
				arg_137_1.mask_.color = var_140_10
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 then
				local var_140_11 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_11.a = 0
				arg_137_1.mask_.color = var_140_11
			end

			if 0.633333333333333 < arg_137_1.time_ and arg_137_1.time_ <= 0.633333333333333 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_13 = 3.06666666666567
			local var_140_14 = 0.775

			if 3.06666666666567 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_15 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_15:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_16 = arg_137_1:GetWordFromCfg(416021034)
				local var_140_17 = arg_137_1:FormatText(var_140_16.content)

				arg_137_1.text_.text = var_140_17

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 31 <= 0 and var_140_14 or var_140_14 * (utf8.len(var_140_17) / 31)

				if (31 <= 0 and var_140_14 or var_140_14 * (utf8.len(var_140_17) / 31)) > 0 and var_140_14 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19
					var_140_13 = var_140_13 + 0.3

					if var_140_19 + var_140_13 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_13
					end
				end

				arg_137_1.text_.text = var_140_17
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021034", "story_v_out_416021.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_416021", "416021034", "story_v_out_416021.awb") / 1000

					if var_140_20 + var_140_13 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_13
					end

					if var_140_16.prefab_name ~= "" and arg_137_1.actors_[var_140_16.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_16.prefab_name].transform, "story_v_out_416021", "416021034", "story_v_out_416021.awb")

						arg_137_1:RecordAudio("416021034", var_140_21)
						arg_137_1:RecordAudio("416021034", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_416021", "416021034", "story_v_out_416021.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_416021", "416021034", "story_v_out_416021.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = var_140_13 + 0.3
			local var_140_23 = math.max(var_140_14, arg_137_1.talkMaxDuration)

			if var_140_13 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_22 + var_140_23 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_22) / var_140_23

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_22 + var_140_23 and arg_137_1.time_ < var_140_22 + var_140_23 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play416021035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416021035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play416021036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.85

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

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(416021035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 74 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 74)

				if (74 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 74)) > 0 and var_146_0 < var_146_3 then
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
	Play416021036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 416021036
		arg_147_1.duration_ = 4.03

		local var_147_0 = {
			zh = 2.533,
			ja = 4.033
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
				arg_147_0:Play416021037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1028"]) and arg_147_1.var_.actorSpriteComps1028 == nil then
				arg_147_1.var_.actorSpriteComps1028 = arg_147_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.125

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1028"]) then
				if arg_147_1.var_.actorSpriteComps1028 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 1, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1028"]) and arg_147_1.var_.actorSpriteComps1028 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1028 = nil
			end

			local var_150_2 = arg_147_1.actors_["1028"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1028 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1028", 3)

				for iter_150_4 = 0, var_150_2.childCount - 1 do
					local var_150_3 = var_150_2:GetChild(iter_150_4)

					if var_150_3.name == "" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_147_1.time_ - 0) / var_150_4)
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_150_5 = 0
			local var_150_6 = 0.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(416021036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 11 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 11)

				if (11 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 11)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021036", "story_v_out_416021.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021036", "story_v_out_416021.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_416021", "416021036", "story_v_out_416021.awb")

						arg_147_1:RecordAudio("416021036", var_150_12)
						arg_147_1:RecordAudio("416021036", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_416021", "416021036", "story_v_out_416021.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_416021", "416021036", "story_v_out_416021.awb")
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
				actorName = "1028",
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
	Play416021037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416021037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play416021038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1028 = arg_151_1.actors_["1028"].transform.localPosition
				arg_151_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1028", 7)

				for iter_154_0 = 0, arg_151_1.actors_["1028"].transform.childCount - 1 do
					local var_154_0 = arg_151_1.actors_["1028"].transform:GetChild(iter_154_0)

					if var_154_0.name == "" or not string.find(var_154_0.name, "split") then
						var_154_0.gameObject:SetActive(true)
					else
						var_154_0.gameObject:SetActive(false)
					end
				end
			end

			local var_154_1 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				arg_151_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_151_1.time_ - 0) / var_154_1)
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				arg_151_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_154_2 = 0
			local var_154_3 = 1.475

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(416021037).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 59 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 59)

				if (59 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 59)) > 0 and var_154_3 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_7 and arg_151_1.time_ < var_154_2 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play416021038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416021038
		arg_155_1.duration_ = 11.7

		local var_155_0 = {
			zh = 5.733,
			ja = 11.7
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
				arg_155_0:Play416021039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.675

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(416021038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 27 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 27)

				if (27 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 27)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021038", "story_v_out_416021.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021038", "story_v_out_416021.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_416021", "416021038", "story_v_out_416021.awb")

						arg_155_1:RecordAudio("416021038", var_158_6)
						arg_155_1:RecordAudio("416021038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416021", "416021038", "story_v_out_416021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416021", "416021038", "story_v_out_416021.awb")
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
	Play416021039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416021039
		arg_159_1.duration_ = 4.27

		local var_159_0 = {
			zh = 2.866,
			ja = 4.266
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
				arg_159_0:Play416021040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1028 = arg_159_1.actors_["1028"].transform.localPosition
				arg_159_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("1028", 3)

				for iter_162_0 = 0, arg_159_1.actors_["1028"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["1028"].transform:GetChild(iter_162_0)

					if var_162_0.name == "" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["1028"].transform.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_162_2 = arg_159_1.actors_["1028"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1028 == nil then
				arg_159_1.var_.actorSpriteComps1028 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 0.125

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps1028 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1028 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps1028 = nil
			end

			local var_162_5 = 0
			local var_162_6 = 0.325

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(416021039)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 13 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 13)

				if (13 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 13)) > 0 and var_162_6 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021039", "story_v_out_416021.awb") ~= 0 then
					local var_162_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021039", "story_v_out_416021.awb") / 1000

					if var_162_11 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_5
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_416021", "416021039", "story_v_out_416021.awb")

						arg_159_1:RecordAudio("416021039", var_162_12)
						arg_159_1:RecordAudio("416021039", var_162_12)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_416021", "416021039", "story_v_out_416021.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_416021", "416021039", "story_v_out_416021.awb")
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
				actorName = "1028",
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
	Play416021040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416021040
		arg_163_1.duration_ = 6

		local var_163_0 = {
			zh = 3.1,
			ja = 6
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
				arg_163_0:Play416021041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.425

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(416021040)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 17 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 17)

				if (17 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 17)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021040", "story_v_out_416021.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021040", "story_v_out_416021.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_416021", "416021040", "story_v_out_416021.awb")

						arg_163_1:RecordAudio("416021040", var_166_6)
						arg_163_1:RecordAudio("416021040", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416021", "416021040", "story_v_out_416021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416021", "416021040", "story_v_out_416021.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play416021041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416021041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play416021042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1028"]) and arg_167_1.var_.actorSpriteComps1028 == nil then
				arg_167_1.var_.actorSpriteComps1028 = arg_167_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.125

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1028"]) then
				if arg_167_1.var_.actorSpriteComps1028 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1028"]) and arg_167_1.var_.actorSpriteComps1028 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps1028 = nil
			end

			local var_170_2 = arg_167_1.actors_["1028"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1028 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1028", 7)

				for iter_170_4 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_4)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_5 = 0
			local var_170_6 = 2.05

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(416021041).content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 82 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 82)

				if (82 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 82)) > 0 and var_170_6 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_10 and arg_167_1.time_ < var_170_5 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play416021042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416021042
		arg_171_1.duration_ = 7.23

		local var_171_0 = {
			zh = 5.4,
			ja = 7.233
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
				arg_171_0:Play416021043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.65

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(416021042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 26 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 26)

				if (26 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 26)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021042", "story_v_out_416021.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021042", "story_v_out_416021.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_416021", "416021042", "story_v_out_416021.awb")

						arg_171_1:RecordAudio("416021042", var_174_6)
						arg_171_1:RecordAudio("416021042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416021", "416021042", "story_v_out_416021.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416021", "416021042", "story_v_out_416021.awb")
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
	Play416021043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416021043
		arg_175_1.duration_ = 4.6

		local var_175_0 = {
			zh = 3.933,
			ja = 4.6
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
				arg_175_0:Play416021044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1028"]) and arg_175_1.var_.actorSpriteComps1028 == nil then
				arg_175_1.var_.actorSpriteComps1028 = arg_175_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.125

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1028"]) then
				if arg_175_1.var_.actorSpriteComps1028 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 1, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1028"]) and arg_175_1.var_.actorSpriteComps1028 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1028 = nil
			end

			local var_178_2 = arg_175_1.actors_["1028"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1028 = var_178_2.localPosition
				var_178_2.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1028", 3)

				for iter_178_4 = 0, var_178_2.childCount - 1 do
					local var_178_3 = var_178_2:GetChild(iter_178_4)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_2.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_175_1.time_ - 0) / var_178_4)
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_178_5 = 0
			local var_178_6 = 0.375

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(416021043)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 15 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 15)

				if (15 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 15)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021043", "story_v_out_416021.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021043", "story_v_out_416021.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_416021", "416021043", "story_v_out_416021.awb")

						arg_175_1:RecordAudio("416021043", var_178_12)
						arg_175_1:RecordAudio("416021043", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416021", "416021043", "story_v_out_416021.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416021", "416021043", "story_v_out_416021.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_13 and arg_175_1.time_ < var_178_5 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play416021044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416021044
		arg_179_1.duration_ = 9.07

		local var_179_0 = {
			zh = 8.533,
			ja = 9.066
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
				arg_179_0:Play416021045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1028"]) and arg_179_1.var_.actorSpriteComps1028 == nil then
				arg_179_1.var_.actorSpriteComps1028 = arg_179_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.125

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1028"]) then
				if arg_179_1.var_.actorSpriteComps1028 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1028"]) and arg_179_1.var_.actorSpriteComps1028 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps1028 = nil
			end

			local var_182_2 = 0
			local var_182_3 = 0.675

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_4 = arg_179_1:GetWordFromCfg(416021044)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 27 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 27)

				if (27 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 27)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021044", "story_v_out_416021.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021044", "story_v_out_416021.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_out_416021", "416021044", "story_v_out_416021.awb")

						arg_179_1:RecordAudio("416021044", var_182_9)
						arg_179_1:RecordAudio("416021044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416021", "416021044", "story_v_out_416021.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416021", "416021044", "story_v_out_416021.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play416021045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416021045
		arg_183_1.duration_ = 6.27

		local var_183_0 = {
			zh = 6.266,
			ja = 6.2
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
				arg_183_0:Play416021046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.6

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(416021045)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 24 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 24)

				if (24 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 24)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021045", "story_v_out_416021.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021045", "story_v_out_416021.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_416021", "416021045", "story_v_out_416021.awb")

						arg_183_1:RecordAudio("416021045", var_186_6)
						arg_183_1:RecordAudio("416021045", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416021", "416021045", "story_v_out_416021.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416021", "416021045", "story_v_out_416021.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play416021046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416021046
		arg_187_1.duration_ = 5.77

		local var_187_0 = {
			zh = 2.2,
			ja = 5.766
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
				arg_187_0:Play416021047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1028"]) and arg_187_1.var_.actorSpriteComps1028 == nil then
				arg_187_1.var_.actorSpriteComps1028 = arg_187_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_0 = 0.125

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1028"]) then
				if arg_187_1.var_.actorSpriteComps1028 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								iter_190_1.color = Color.New(Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_0), Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_0), (Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_0)))
							else
								local var_190_1 = Mathf.Lerp(iter_190_1.color.r, 1, (arg_187_1.time_ - 0) / var_190_0)

								iter_190_1.color = Color.New(var_190_1, var_190_1, var_190_1)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1028"]) and arg_187_1.var_.actorSpriteComps1028 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_190_3 then
						iter_190_3.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps1028 = nil
			end

			local var_190_2 = 0
			local var_190_3 = 0.3

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(416021046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 12 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 12)

				if (12 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 12)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021046", "story_v_out_416021.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021046", "story_v_out_416021.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_416021", "416021046", "story_v_out_416021.awb")

						arg_187_1:RecordAudio("416021046", var_190_9)
						arg_187_1:RecordAudio("416021046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416021", "416021046", "story_v_out_416021.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416021", "416021046", "story_v_out_416021.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play416021047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416021047
		arg_191_1.duration_ = 8.8

		local var_191_0 = {
			zh = 4.933,
			ja = 8.8
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
				arg_191_0:Play416021048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1028"]) and arg_191_1.var_.actorSpriteComps1028 == nil then
				arg_191_1.var_.actorSpriteComps1028 = arg_191_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.125

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1028"]) then
				if arg_191_1.var_.actorSpriteComps1028 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1028"]) and arg_191_1.var_.actorSpriteComps1028 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps1028 = nil
			end

			local var_194_2 = 0
			local var_194_3 = 0.55

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_4 = arg_191_1:GetWordFromCfg(416021047)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 22 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 22)

				if (22 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 22)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021047", "story_v_out_416021.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021047", "story_v_out_416021.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_416021", "416021047", "story_v_out_416021.awb")

						arg_191_1:RecordAudio("416021047", var_194_9)
						arg_191_1:RecordAudio("416021047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416021", "416021047", "story_v_out_416021.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416021", "416021047", "story_v_out_416021.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play416021048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416021048
		arg_195_1.duration_ = 6.33

		local var_195_0 = {
			zh = 3.7,
			ja = 6.333
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
				arg_195_0:Play416021049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1028"]) and arg_195_1.var_.actorSpriteComps1028 == nil then
				arg_195_1.var_.actorSpriteComps1028 = arg_195_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.125

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1028"]) then
				if arg_195_1.var_.actorSpriteComps1028 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 1, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1028"]) and arg_195_1.var_.actorSpriteComps1028 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1028 = nil
			end

			local var_198_2 = arg_195_1.actors_["1028"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1028 = var_198_2.localPosition
				var_198_2.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1028", 3)

				for iter_198_4 = 0, var_198_2.childCount - 1 do
					local var_198_3 = var_198_2:GetChild(iter_198_4)

					if var_198_3.name == "split_2" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_198_5 = 0
			local var_198_6 = 0.5

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_7 = arg_195_1:GetWordFromCfg(416021048)
				local var_198_8 = arg_195_1:FormatText(var_198_7.content)

				arg_195_1.text_.text = var_198_8

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_10 = 20 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_8) / 20)

				if (20 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_8) / 20)) > 0 and var_198_6 < var_198_10 then
					arg_195_1.talkMaxDuration = var_198_10

					if var_198_10 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_5
					end
				end

				arg_195_1.text_.text = var_198_8
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021048", "story_v_out_416021.awb") ~= 0 then
					local var_198_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021048", "story_v_out_416021.awb") / 1000

					if var_198_11 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_5
					end

					if var_198_7.prefab_name ~= "" and arg_195_1.actors_[var_198_7.prefab_name] ~= nil then
						local var_198_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_7.prefab_name].transform, "story_v_out_416021", "416021048", "story_v_out_416021.awb")

						arg_195_1:RecordAudio("416021048", var_198_12)
						arg_195_1:RecordAudio("416021048", var_198_12)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_416021", "416021048", "story_v_out_416021.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_416021", "416021048", "story_v_out_416021.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_6, arg_195_1.talkMaxDuration)

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_5) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_5 + var_198_13 and arg_195_1.time_ < var_198_5 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play416021049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416021049
		arg_199_1.duration_ = 2.2

		local var_199_0 = {
			zh = 0.999999999999,
			ja = 2.2
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
				arg_199_0:Play416021050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1028"]) and arg_199_1.var_.actorSpriteComps1028 == nil then
				arg_199_1.var_.actorSpriteComps1028 = arg_199_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.125

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1028"]) then
				if arg_199_1.var_.actorSpriteComps1028 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1028"]) and arg_199_1.var_.actorSpriteComps1028 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1028 = nil
			end

			local var_202_2 = 0
			local var_202_3 = 0.1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_4 = arg_199_1:GetWordFromCfg(416021049)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 4 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 4)

				if (4 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 4)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021049", "story_v_out_416021.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021049", "story_v_out_416021.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_out_416021", "416021049", "story_v_out_416021.awb")

						arg_199_1:RecordAudio("416021049", var_202_9)
						arg_199_1:RecordAudio("416021049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416021", "416021049", "story_v_out_416021.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416021", "416021049", "story_v_out_416021.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play416021050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416021050
		arg_203_1.duration_ = 3.83

		local var_203_0 = {
			zh = 2.9,
			ja = 3.833
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
				arg_203_0:Play416021051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1028"]) and arg_203_1.var_.actorSpriteComps1028 == nil then
				arg_203_1.var_.actorSpriteComps1028 = arg_203_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.125

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1028"]) then
				if arg_203_1.var_.actorSpriteComps1028 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 1, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1028"]) and arg_203_1.var_.actorSpriteComps1028 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1028 = nil
			end

			local var_206_2 = arg_203_1.actors_["1028"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1028 = var_206_2.localPosition
				var_206_2.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1028", 3)

				for iter_206_4 = 0, var_206_2.childCount - 1 do
					local var_206_3 = var_206_2:GetChild(iter_206_4)

					if var_206_3.name == "split_6" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_2.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_203_1.time_ - 0) / var_206_4)
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_206_5 = 0
			local var_206_6 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(416021050)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 12 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 12)

				if (12 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 12)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021050", "story_v_out_416021.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021050", "story_v_out_416021.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_416021", "416021050", "story_v_out_416021.awb")

						arg_203_1:RecordAudio("416021050", var_206_12)
						arg_203_1:RecordAudio("416021050", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416021", "416021050", "story_v_out_416021.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416021", "416021050", "story_v_out_416021.awb")
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
				actorName = "1028",
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
	Play416021051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416021051
		arg_207_1.duration_ = 8.3

		local var_207_0 = {
			zh = 8.3,
			ja = 7.533
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
				arg_207_0:Play416021052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.bgs_.I13f == nil then
				local var_210_0 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13f")
				var_210_0.name = "I13f"
				var_210_0.transform.parent = arg_207_1.stage_.transform
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_.I13f = var_210_0
			end

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= 2 + arg_210_0 then
				local var_210_1 = arg_207_1.bgs_.I13f

				arg_207_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_2 = var_210_1:GetComponent("SpriteRenderer")

				if var_210_2 and var_210_2.sprite then
					local var_210_3 = 2 * (var_210_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_1.transform.localScale = Vector3.New(var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "I13f" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_4 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_5 = 2

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_5 then
				local var_210_6 = Color.New(0, 0, 0)

				var_210_6.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_4) / var_210_5)
				arg_207_1.mask_.color = var_210_6
			end

			if arg_207_1.time_ >= var_210_4 + var_210_5 and arg_207_1.time_ < var_210_4 + var_210_5 + arg_210_0 then
				local var_210_7 = Color.New(0, 0, 0)

				var_210_7.a = 1
				arg_207_1.mask_.color = var_210_7
			end

			local var_210_8 = 2

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_9 = 2

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 then
				local var_210_10 = Color.New(0, 0, 0)

				var_210_10.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_8) / var_210_9)
				arg_207_1.mask_.color = var_210_10
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 then
				local var_210_11 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_11.a = 0
				arg_207_1.mask_.color = var_210_11
			end

			local var_210_12 = arg_207_1.actors_["1028"].transform

			if 1.966 < arg_207_1.time_ and arg_207_1.time_ <= 1.966 + arg_210_0 then
				arg_207_1.var_.moveOldPos1028 = var_210_12.localPosition
				var_210_12.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1028", 7)

				for iter_210_2 = 0, var_210_12.childCount - 1 do
					local var_210_13 = var_210_12:GetChild(iter_210_2)

					if var_210_13.name == "" or not string.find(var_210_13.name, "split") then
						var_210_13.gameObject:SetActive(true)
					else
						var_210_13.gameObject:SetActive(false)
					end
				end
			end

			local var_210_14 = 0.001

			if 1.966 <= arg_207_1.time_ and arg_207_1.time_ < 1.966 + var_210_14 then
				var_210_12.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_207_1.time_ - 1.966) / var_210_14)
			end

			if arg_207_1.time_ >= 1.966 + var_210_14 and arg_207_1.time_ < 1.966 + var_210_14 + arg_210_0 then
				var_210_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.36666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 1.36666666666667 + arg_210_0 then
				arg_207_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_210_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_18 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_18

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_18
						arg_207_1.bgmTxt2_.text = var_210_18
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.966 < arg_207_1.time_ and arg_207_1.time_ <= 0.966 + arg_210_0 then
				arg_207_1:AudioAction("play", "music", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_210_21 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

				if "" ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_21 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_21

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_21
						arg_207_1.bgmTxt2_.text = var_210_21
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_22 = 4
			local var_210_23 = 0.3

			if 4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_22 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_24 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_24:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_207_1.dialogCg_.alpha = arg_213_0
				end))
				var_210_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_25 = arg_207_1:GetWordFromCfg(416021051)
				local var_210_26 = arg_207_1:FormatText(var_210_25.content)

				arg_207_1.text_.text = var_210_26

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_28 = 12 <= 0 and var_210_23 or var_210_23 * (utf8.len(var_210_26) / 12)

				if (12 <= 0 and var_210_23 or var_210_23 * (utf8.len(var_210_26) / 12)) > 0 and var_210_23 < var_210_28 then
					arg_207_1.talkMaxDuration = var_210_28
					var_210_22 = var_210_22 + 0.3

					if var_210_28 + var_210_22 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_28 + var_210_22
					end
				end

				arg_207_1.text_.text = var_210_26
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021051", "story_v_out_416021.awb") ~= 0 then
					local var_210_29 = manager.audio:GetVoiceLength("story_v_out_416021", "416021051", "story_v_out_416021.awb") / 1000

					if var_210_29 + var_210_22 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_29 + var_210_22
					end

					if var_210_25.prefab_name ~= "" and arg_207_1.actors_[var_210_25.prefab_name] ~= nil then
						local var_210_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_25.prefab_name].transform, "story_v_out_416021", "416021051", "story_v_out_416021.awb")

						arg_207_1:RecordAudio("416021051", var_210_30)
						arg_207_1:RecordAudio("416021051", var_210_30)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416021", "416021051", "story_v_out_416021.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416021", "416021051", "story_v_out_416021.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_31 = var_210_22 + 0.3
			local var_210_32 = math.max(var_210_23, arg_207_1.talkMaxDuration)

			if var_210_22 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_31 + var_210_32 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_31) / var_210_32

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_31 + var_210_32 and arg_207_1.time_ < var_210_31 + var_210_32 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play416021052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416021052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416021053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.95

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(416021052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 78 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 78)

				if (78 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 78)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play416021053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416021053
		arg_219_1.duration_ = 2.23

		local var_219_0 = {
			zh = 2.033,
			ja = 2.233
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
				arg_219_0:Play416021054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.actors_["1148"] == nil then
				local var_222_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_222_0) then
					local var_222_1 = Object.Instantiate(var_222_0, arg_219_1.canvasGo_.transform)

					var_222_1.transform:SetSiblingIndex(1)

					var_222_1.name = "1148"
					var_222_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_219_1.actors_["1148"] = var_222_1

					if arg_219_1.isInRecall_ then
						for iter_222_0, iter_222_1 in ipairs((var_222_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_222_1.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_222_2 = arg_219_1.actors_["1148"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1148 == nil then
				arg_219_1.var_.actorSpriteComps1148 = var_222_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_3 = 0.125

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.actorSpriteComps1148 then
					for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_222_3 then
							if arg_219_1.isInRecall_ then
								iter_222_3.color = Color.New(Mathf.Lerp(iter_222_3.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_3), Mathf.Lerp(iter_222_3.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_3), (Mathf.Lerp(iter_222_3.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_3)))
							else
								local var_222_4 = Mathf.Lerp(iter_222_3.color.r, 1, (arg_219_1.time_ - 0) / var_222_3)

								iter_222_3.color = Color.New(var_222_4, var_222_4, var_222_4)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1148 then
				for iter_222_4, iter_222_5 in pairs(arg_219_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_222_5 then
						iter_222_5.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps1148 = nil
			end

			local var_222_5 = arg_219_1.actors_["1148"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1148 = var_222_5.localPosition
				var_222_5.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1148", 3)

				for iter_222_6 = 0, var_222_5.childCount - 1 do
					local var_222_6 = var_222_5:GetChild(iter_222_6)

					if var_222_6.name == "" or not string.find(var_222_6.name, "split") then
						var_222_6.gameObject:SetActive(true)
					else
						var_222_6.gameObject:SetActive(false)
					end
				end
			end

			local var_222_7 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_219_1.time_ - 0) / var_222_7)
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(0, -429, -180)
			end

			local var_222_8 = 0
			local var_222_9 = 0.225

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:GetWordFromCfg(416021053)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 9 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 9)

				if (9 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 9)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021053", "story_v_out_416021.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_416021", "416021053", "story_v_out_416021.awb") / 1000

					if var_222_14 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_8
					end

					if var_222_10.prefab_name ~= "" and arg_219_1.actors_[var_222_10.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_10.prefab_name].transform, "story_v_out_416021", "416021053", "story_v_out_416021.awb")

						arg_219_1:RecordAudio("416021053", var_222_15)
						arg_219_1:RecordAudio("416021053", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416021", "416021053", "story_v_out_416021.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416021", "416021053", "story_v_out_416021.awb")
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
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play416021054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416021054
		arg_223_1.duration_ = 6.93

		local var_223_0 = {
			zh = 6.1,
			ja = 6.933
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
				arg_223_0:Play416021055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1148"]) and arg_223_1.var_.actorSpriteComps1148 == nil then
				arg_223_1.var_.actorSpriteComps1148 = arg_223_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.125

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1148"]) then
				if arg_223_1.var_.actorSpriteComps1148 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1148"]) and arg_223_1.var_.actorSpriteComps1148 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps1148 = nil
			end

			local var_226_2 = 0
			local var_226_3 = 0.5

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_4 = arg_223_1:GetWordFromCfg(416021054)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 20 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 20)

				if (20 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 20)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021054", "story_v_out_416021.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021054", "story_v_out_416021.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_out_416021", "416021054", "story_v_out_416021.awb")

						arg_223_1:RecordAudio("416021054", var_226_9)
						arg_223_1:RecordAudio("416021054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416021", "416021054", "story_v_out_416021.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416021", "416021054", "story_v_out_416021.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play416021055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416021055
		arg_227_1.duration_ = 4.4

		local var_227_0 = {
			zh = 2.6,
			ja = 4.4
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play416021056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1148"]) and arg_227_1.var_.actorSpriteComps1148 == nil then
				arg_227_1.var_.actorSpriteComps1148 = arg_227_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.125

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1148"]) then
				if arg_227_1.var_.actorSpriteComps1148 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 1, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1148"]) and arg_227_1.var_.actorSpriteComps1148 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1148 = nil
			end

			local var_230_2 = 0
			local var_230_3 = 0.275

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(416021055)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 11 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 11)

				if (11 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 11)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021055", "story_v_out_416021.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021055", "story_v_out_416021.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_416021", "416021055", "story_v_out_416021.awb")

						arg_227_1:RecordAudio("416021055", var_230_9)
						arg_227_1:RecordAudio("416021055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416021", "416021055", "story_v_out_416021.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416021", "416021055", "story_v_out_416021.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416021056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416021056
		arg_231_1.duration_ = 3.43

		local var_231_0 = {
			zh = 3.266,
			ja = 3.433
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
				arg_231_0:Play416021057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.375

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:GetWordFromCfg(416021056)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 15 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 15)

				if (15 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 15)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021056", "story_v_out_416021.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021056", "story_v_out_416021.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_416021", "416021056", "story_v_out_416021.awb")

						arg_231_1:RecordAudio("416021056", var_234_6)
						arg_231_1:RecordAudio("416021056", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416021", "416021056", "story_v_out_416021.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416021", "416021056", "story_v_out_416021.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416021057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416021057
		arg_235_1.duration_ = 5.07

		local var_235_0 = {
			zh = 4.3,
			ja = 5.066
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
				arg_235_0:Play416021058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1148"]) and arg_235_1.var_.actorSpriteComps1148 == nil then
				arg_235_1.var_.actorSpriteComps1148 = arg_235_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.125

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1148"]) then
				if arg_235_1.var_.actorSpriteComps1148 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1148"]) and arg_235_1.var_.actorSpriteComps1148 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps1148 = nil
			end

			local var_238_2 = 0
			local var_238_3 = 0.425

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_4 = arg_235_1:GetWordFromCfg(416021057)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 17 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 17)

				if (17 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 17)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021057", "story_v_out_416021.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021057", "story_v_out_416021.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_416021", "416021057", "story_v_out_416021.awb")

						arg_235_1:RecordAudio("416021057", var_238_9)
						arg_235_1:RecordAudio("416021057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416021", "416021057", "story_v_out_416021.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416021", "416021057", "story_v_out_416021.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416021058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416021058
		arg_239_1.duration_ = 4.2

		local var_239_0 = {
			zh = 4.2,
			ja = 4.066
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
				arg_239_0:Play416021059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1148"]) and arg_239_1.var_.actorSpriteComps1148 == nil then
				arg_239_1.var_.actorSpriteComps1148 = arg_239_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.125

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1148"]) then
				if arg_239_1.var_.actorSpriteComps1148 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 1, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1148"]) and arg_239_1.var_.actorSpriteComps1148 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1148 = nil
			end

			local var_242_2 = 0
			local var_242_3 = 0.525

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
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

				local var_242_4 = arg_239_1:GetWordFromCfg(416021058)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 21 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 21)

				if (21 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 21)) > 0 and var_242_3 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021058", "story_v_out_416021.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021058", "story_v_out_416021.awb") / 1000

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_out_416021", "416021058", "story_v_out_416021.awb")

						arg_239_1:RecordAudio("416021058", var_242_9)
						arg_239_1:RecordAudio("416021058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416021", "416021058", "story_v_out_416021.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416021", "416021058", "story_v_out_416021.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416021059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416021059
		arg_243_1.duration_ = 10.1

		local var_243_0 = {
			zh = 4.4,
			ja = 10.1
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
				arg_243_0:Play416021060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.45

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(416021059)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 18 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 18)

				if (18 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 18)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021059", "story_v_out_416021.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021059", "story_v_out_416021.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_416021", "416021059", "story_v_out_416021.awb")

						arg_243_1:RecordAudio("416021059", var_246_6)
						arg_243_1:RecordAudio("416021059", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416021", "416021059", "story_v_out_416021.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416021", "416021059", "story_v_out_416021.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play416021060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416021060
		arg_247_1.duration_ = 5.2

		local var_247_0 = {
			zh = 4.6,
			ja = 5.2
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
				arg_247_0:Play416021061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1148"]) and arg_247_1.var_.actorSpriteComps1148 == nil then
				arg_247_1.var_.actorSpriteComps1148 = arg_247_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.125

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1148"]) then
				if arg_247_1.var_.actorSpriteComps1148 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 0.5, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1148"]) and arg_247_1.var_.actorSpriteComps1148 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps1148 = nil
			end

			local var_250_2 = 0
			local var_250_3 = 0.325

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_4 = arg_247_1:GetWordFromCfg(416021060)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 13 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 13)

				if (13 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 13)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021060", "story_v_out_416021.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021060", "story_v_out_416021.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_416021", "416021060", "story_v_out_416021.awb")

						arg_247_1:RecordAudio("416021060", var_250_9)
						arg_247_1:RecordAudio("416021060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416021", "416021060", "story_v_out_416021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416021", "416021060", "story_v_out_416021.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play416021061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416021061
		arg_251_1.duration_ = 6.1

		local var_251_0 = {
			zh = 5.1,
			ja = 6.1
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
				arg_251_0:Play416021062(arg_251_1)
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

			local var_254_2 = 0
			local var_254_3 = 0.65

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:GetWordFromCfg(416021061)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 26 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 26)

				if (26 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 26)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021061", "story_v_out_416021.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_416021", "416021061", "story_v_out_416021.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_out_416021", "416021061", "story_v_out_416021.awb")

						arg_251_1:RecordAudio("416021061", var_254_9)
						arg_251_1:RecordAudio("416021061", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416021", "416021061", "story_v_out_416021.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416021", "416021061", "story_v_out_416021.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416021062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416021062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play416021063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1148 = arg_255_1.actors_["1148"].transform.localPosition
				arg_255_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1148", 7)

				for iter_258_0 = 0, arg_255_1.actors_["1148"].transform.childCount - 1 do
					local var_258_0 = arg_255_1.actors_["1148"].transform:GetChild(iter_258_0)

					if var_258_0.name == "" or not string.find(var_258_0.name, "split") then
						var_258_0.gameObject:SetActive(true)
					else
						var_258_0.gameObject:SetActive(false)
					end
				end
			end

			local var_258_1 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 then
				arg_255_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_255_1.time_ - 0) / var_258_1)
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 then
				arg_255_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_258_2 = 0
			local var_258_3 = 1.375

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(416021062).content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_6 = 55 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 55)

				if (55 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 55)) > 0 and var_258_3 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6

					if var_258_6 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_7 and arg_255_1.time_ < var_258_2 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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
	Play416021063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416021063
		arg_259_1.duration_ = 5.23

		local var_259_0 = {
			zh = 3.2,
			ja = 5.233
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
				arg_259_0:Play416021064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1148 = arg_259_1.actors_["1148"].transform.localPosition
				arg_259_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1148", 3)

				for iter_262_0 = 0, arg_259_1.actors_["1148"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["1148"].transform:GetChild(iter_262_0)

					if var_262_0.name == "" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_262_2 = arg_259_1.actors_["1148"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps1148 == nil then
				arg_259_1.var_.actorSpriteComps1148 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 0.125

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps1148 then
					for iter_262_1, iter_262_2 in pairs(arg_259_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_262_2 then
							if arg_259_1.isInRecall_ then
								iter_262_2.color = Color.New(Mathf.Lerp(iter_262_2.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_2.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_2.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_2.color.r, 1, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_2.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps1148 then
				for iter_262_3, iter_262_4 in pairs(arg_259_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_262_4 then
						iter_262_4.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps1148 = nil
			end

			local var_262_5 = 0
			local var_262_6 = 0.375

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
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

				local var_262_7 = arg_259_1:GetWordFromCfg(416021063)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 15 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 15)

				if (15 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 15)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021063", "story_v_out_416021.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021063", "story_v_out_416021.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_416021", "416021063", "story_v_out_416021.awb")

						arg_259_1:RecordAudio("416021063", var_262_12)
						arg_259_1:RecordAudio("416021063", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416021", "416021063", "story_v_out_416021.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416021", "416021063", "story_v_out_416021.awb")
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
				actorName = "1148",
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
	Play416021064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416021064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play416021065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1148 = arg_263_1.actors_["1148"].transform.localPosition
				arg_263_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1148", 7)

				for iter_266_0 = 0, arg_263_1.actors_["1148"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["1148"].transform:GetChild(iter_266_0)

					if var_266_0.name == "" or not string.find(var_266_0.name, "split") then
						var_266_0.gameObject:SetActive(true)
					else
						var_266_0.gameObject:SetActive(false)
					end
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_263_1.time_ - 0) / var_266_1)
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_266_2 = 0
			local var_266_3 = 0.9

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

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(416021064).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 36 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 36)

				if (36 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 36)) > 0 and var_266_3 < var_266_6 then
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

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play416021065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416021065
		arg_267_1.duration_ = 7.83

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416021066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if arg_267_1.bgs_.H01 == nil then
				local var_270_0 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H01")
				var_270_0.name = "H01"
				var_270_0.transform.parent = arg_267_1.stage_.transform
				var_270_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_.H01 = var_270_0
			end

			if 1.16666666666667 < arg_267_1.time_ and arg_267_1.time_ <= 1.16666666666667 + arg_270_0 then
				local var_270_1 = arg_267_1.bgs_.H01

				arg_267_1.bgs_.H01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_2 = var_270_1:GetComponent("SpriteRenderer")

				if var_270_2 and var_270_2.sprite then
					local var_270_3 = 2 * (var_270_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_1.transform.localScale = Vector3.New(var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "H01" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_4 = 3.16666666666667

			if 3.16666666666667 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_4 + 0.3 and arg_267_1.time_ < var_270_4 + 0.3 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_5 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_6 = 1.16666666666667

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = Color.New(0, 0, 0)

				var_270_7.a = Mathf.Lerp(0, 1, (arg_267_1.time_ - var_270_5) / var_270_6)
				arg_267_1.mask_.color = var_270_7
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				local var_270_8 = Color.New(0, 0, 0)

				var_270_8.a = 1
				arg_267_1.mask_.color = var_270_8
			end

			local var_270_9 = 1.16666666666667

			if 1.16666666666667 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_10 = 2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 then
				local var_270_11 = Color.New(0, 0, 0)

				var_270_11.a = Mathf.Lerp(1, 0, (arg_267_1.time_ - var_270_9) / var_270_10)
				arg_267_1.mask_.color = var_270_11
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 then
				local var_270_12 = Color.New(0, 0, 0)

				arg_267_1.mask_.enabled = false
				var_270_12.a = 0
				arg_267_1.mask_.color = var_270_12
			end

			if 1.16666666666667 < arg_267_1.time_ and arg_267_1.time_ <= 1.16666666666667 + arg_270_0 then
				if arg_267_1.var_.effect1055 then
					Object.Destroy(arg_267_1.var_.effect1055)

					arg_267_1.var_.effect1055 = nil
				end
			end

			if 1 < arg_267_1.time_ and arg_267_1.time_ <= 1 + arg_270_0 then
				arg_267_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_15 = 2.83333333333333
			local var_270_16 = 1.95

			if 2.83333333333333 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_17 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_17:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_18 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(416021065).content)

				arg_267_1.text_.text = var_270_18

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 78 <= 0 and var_270_16 or var_270_16 * (utf8.len(var_270_18) / 78)

				if (78 <= 0 and var_270_16 or var_270_16 * (utf8.len(var_270_18) / 78)) > 0 and var_270_16 < var_270_20 then
					arg_267_1.talkMaxDuration = var_270_20
					var_270_15 = var_270_15 + 0.3

					if var_270_20 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_18
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_21 = var_270_15 + 0.3
			local var_270_22 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_22 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_21) / var_270_22

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_21 + var_270_22 and arg_267_1.time_ < var_270_21 + var_270_22 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416021066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 416021066
		arg_273_1.duration_ = 4.33

		local var_273_0 = {
			zh = 4.333,
			ja = 2.433
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
				arg_273_0:Play416021067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.475

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:GetWordFromCfg(416021066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 19 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 19)

				if (19 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 19)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021066", "story_v_out_416021.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021066", "story_v_out_416021.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_416021", "416021066", "story_v_out_416021.awb")

						arg_273_1:RecordAudio("416021066", var_276_6)
						arg_273_1:RecordAudio("416021066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_416021", "416021066", "story_v_out_416021.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_416021", "416021066", "story_v_out_416021.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play416021067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 416021067
		arg_277_1.duration_ = 3.57

		local var_277_0 = {
			zh = 2.533,
			ja = 3.566
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
				arg_277_0:Play416021068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.175

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(416021067)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 7 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 7)

				if (7 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 7)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021067", "story_v_out_416021.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021067", "story_v_out_416021.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_416021", "416021067", "story_v_out_416021.awb")

						arg_277_1:RecordAudio("416021067", var_280_6)
						arg_277_1:RecordAudio("416021067", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_416021", "416021067", "story_v_out_416021.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_416021", "416021067", "story_v_out_416021.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play416021068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 416021068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play416021069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 1.36666666666667 < arg_281_1.time_ and arg_281_1.time_ <= 1.36666666666667 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_16", "se_story_16_electric", "")
			end

			local var_284_1 = 0
			local var_284_2 = 2.15

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(416021068).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 86 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 86)

				if (86 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 86)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play416021069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 416021069
		arg_285_1.duration_ = 4.5

		local var_285_0 = {
			zh = 4.5,
			ja = 3.933
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
				arg_285_0:Play416021070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1028"]) and arg_285_1.var_.actorSpriteComps1028 == nil then
				arg_285_1.var_.actorSpriteComps1028 = arg_285_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.125

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1028"]) then
				if arg_285_1.var_.actorSpriteComps1028 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 1, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1028"]) and arg_285_1.var_.actorSpriteComps1028 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1028 = nil
			end

			local var_288_2 = arg_285_1.actors_["1028"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1028 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1028", 3)

				for iter_288_4 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_4)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_288_5 = 0
			local var_288_6 = 0.45

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(416021069)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 18 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 18)

				if (18 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 18)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021069", "story_v_out_416021.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021069", "story_v_out_416021.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_416021", "416021069", "story_v_out_416021.awb")

						arg_285_1:RecordAudio("416021069", var_288_12)
						arg_285_1:RecordAudio("416021069", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_416021", "416021069", "story_v_out_416021.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_416021", "416021069", "story_v_out_416021.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play416021070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 416021070
		arg_289_1.duration_ = 3

		local var_289_0 = {
			zh = 1.7,
			ja = 3
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play416021071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.175

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(416021070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 7 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 7)

				if (7 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 7)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021070", "story_v_out_416021.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021070", "story_v_out_416021.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_416021", "416021070", "story_v_out_416021.awb")

						arg_289_1:RecordAudio("416021070", var_292_6)
						arg_289_1:RecordAudio("416021070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_416021", "416021070", "story_v_out_416021.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_416021", "416021070", "story_v_out_416021.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play416021071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 416021071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play416021072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1028 = arg_293_1.actors_["1028"].transform.localPosition
				arg_293_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1028", 7)

				for iter_296_0 = 0, arg_293_1.actors_["1028"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["1028"].transform:GetChild(iter_296_0)

					if var_296_0.name == "" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.9 < arg_293_1.time_ and arg_293_1.time_ <= 0.9 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_stick", "")
			end

			if 1.4 < arg_293_1.time_ and arg_293_1.time_ <= 1.4 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_stick", "")
			end

			local var_296_4 = 0
			local var_296_5 = 1.575

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(416021071).content)

				arg_293_1.text_.text = var_296_6

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_8 = 63 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_6) / 63)

				if (63 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_6) / 63)) > 0 and var_296_5 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_6
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_9 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_9 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_9

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_9 and arg_293_1.time_ < var_296_4 + var_296_9 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play416021072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 416021072
		arg_297_1.duration_ = 5.87

		local var_297_0 = {
			zh = 5.87433333333233,
			ja = 5.47433333333233
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play416021073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if arg_297_1.bgs_.H01b == nil then
				local var_300_0 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H01b")
				var_300_0.name = "H01b"
				var_300_0.transform.parent = arg_297_1.stage_.transform
				var_300_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_.H01b = var_300_0
			end

			if 1.33333333333333 < arg_297_1.time_ and arg_297_1.time_ <= 1.33333333333333 + arg_300_0 then
				local var_300_1 = arg_297_1.bgs_.H01b

				arg_297_1.bgs_.H01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_2 = var_300_1:GetComponent("SpriteRenderer")

				if var_300_2 and var_300_2.sprite then
					local var_300_3 = 2 * (var_300_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_1.transform.localScale = Vector3.New(var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "H01b" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_4 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_5 = 1.33333333333333

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_5 then
				local var_300_6 = Color.New(0, 0, 0)

				var_300_6.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_4) / var_300_5)
				arg_297_1.mask_.color = var_300_6
			end

			if arg_297_1.time_ >= var_300_4 + var_300_5 and arg_297_1.time_ < var_300_4 + var_300_5 + arg_300_0 then
				local var_300_7 = Color.New(0, 0, 0)

				var_300_7.a = 1
				arg_297_1.mask_.color = var_300_7
			end

			local var_300_8 = 1.33333333333333

			if 1.33333333333333 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_9 = 1.174999999999

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 then
				local var_300_10 = Color.New(0, 0, 0)

				var_300_10.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_8) / var_300_9)
				arg_297_1.mask_.color = var_300_10
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 then
				local var_300_11 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_11.a = 0
				arg_297_1.mask_.color = var_300_11
			end

			if 0.966666666666667 < arg_297_1.time_ and arg_297_1.time_ <= 0.966666666666667 + arg_300_0 then
				arg_297_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_13 = 2.50833333333233
			local var_300_14 = 0.175

			if 2.50833333333233 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_15 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_15:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_16 = arg_297_1:GetWordFromCfg(416021072)
				local var_300_17 = arg_297_1:FormatText(var_300_16.content)

				arg_297_1.text_.text = var_300_17

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_19 = 7 <= 0 and var_300_14 or var_300_14 * (utf8.len(var_300_17) / 7)

				if (7 <= 0 and var_300_14 or var_300_14 * (utf8.len(var_300_17) / 7)) > 0 and var_300_14 < var_300_19 then
					arg_297_1.talkMaxDuration = var_300_19
					var_300_13 = var_300_13 + 0.3

					if var_300_19 + var_300_13 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_13
					end
				end

				arg_297_1.text_.text = var_300_17
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021072", "story_v_out_416021.awb") ~= 0 then
					local var_300_20 = manager.audio:GetVoiceLength("story_v_out_416021", "416021072", "story_v_out_416021.awb") / 1000

					if var_300_20 + var_300_13 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_20 + var_300_13
					end

					if var_300_16.prefab_name ~= "" and arg_297_1.actors_[var_300_16.prefab_name] ~= nil then
						local var_300_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_16.prefab_name].transform, "story_v_out_416021", "416021072", "story_v_out_416021.awb")

						arg_297_1:RecordAudio("416021072", var_300_21)
						arg_297_1:RecordAudio("416021072", var_300_21)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_416021", "416021072", "story_v_out_416021.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_416021", "416021072", "story_v_out_416021.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_22 = var_300_13 + 0.3
			local var_300_23 = math.max(var_300_14, arg_297_1.talkMaxDuration)

			if var_300_13 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_22 + var_300_23 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_22) / var_300_23

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_22 + var_300_23 and arg_297_1.time_ < var_300_22 + var_300_23 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play416021073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416021073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play416021074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1028 = arg_303_1.actors_["1028"].transform.localPosition
				arg_303_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1028", 7)

				for iter_306_0 = 0, arg_303_1.actors_["1028"].transform.childCount - 1 do
					local var_306_0 = arg_303_1.actors_["1028"].transform:GetChild(iter_306_0)

					if var_306_0.name == "" or not string.find(var_306_0.name, "split") then
						var_306_0.gameObject:SetActive(true)
					else
						var_306_0.gameObject:SetActive(false)
					end
				end
			end

			local var_306_1 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 then
				arg_303_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_303_1.time_ - 0) / var_306_1)
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 then
				arg_303_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_2 = 0
			local var_306_3 = 2.025

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_4 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(416021073).content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 81 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_4) / 81)

				if (81 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_4) / 81)) > 0 and var_306_3 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_7 and arg_303_1.time_ < var_306_2 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play416021074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416021074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play416021075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 1.33333333333333 < arg_307_1.time_ and arg_307_1.time_ <= 1.33333333333333 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_Metal", "")
			end

			local var_310_1 = 0
			local var_310_2 = 1.925

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(416021074).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 77 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 77)

				if (77 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 77)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play416021075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416021075
		arg_311_1.duration_ = 5.83

		local var_311_0 = {
			zh = 5.833,
			ja = 5.633
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play416021076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1028 = arg_311_1.actors_["1028"].transform.localPosition
				arg_311_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1028", 3)

				for iter_314_0 = 0, arg_311_1.actors_["1028"].transform.childCount - 1 do
					local var_314_0 = arg_311_1.actors_["1028"].transform:GetChild(iter_314_0)

					if var_314_0.name == "" or not string.find(var_314_0.name, "split") then
						var_314_0.gameObject:SetActive(true)
					else
						var_314_0.gameObject:SetActive(false)
					end
				end
			end

			local var_314_1 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_1 then
				arg_311_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_311_1.time_ - 0) / var_314_1)
			end

			if arg_311_1.time_ >= 0 + var_314_1 and arg_311_1.time_ < 0 + var_314_1 + arg_314_0 then
				arg_311_1.actors_["1028"].transform.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_314_2 = arg_311_1.actors_["1028"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps1028 == nil then
				arg_311_1.var_.actorSpriteComps1028 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 0.125

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps1028 then
					for iter_314_1, iter_314_2 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_314_2 then
							if arg_311_1.isInRecall_ then
								iter_314_2.color = Color.New(Mathf.Lerp(iter_314_2.color.r, arg_311_1.hightColor1.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_2.color.g, arg_311_1.hightColor1.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_2.color.b, arg_311_1.hightColor1.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_2.color.r, 1, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_2.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps1028 then
				for iter_314_3, iter_314_4 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_314_4 then
						iter_314_4.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps1028 = nil
			end

			local var_314_5 = 0
			local var_314_6 = 0.375

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(416021075)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 15 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 15)

				if (15 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 15)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021075", "story_v_out_416021.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021075", "story_v_out_416021.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_416021", "416021075", "story_v_out_416021.awb")

						arg_311_1:RecordAudio("416021075", var_314_12)
						arg_311_1:RecordAudio("416021075", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416021", "416021075", "story_v_out_416021.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416021", "416021075", "story_v_out_416021.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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

		arg_311_1:InitPlayNodeList()
	end,
	Play416021076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416021076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play416021077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1028"]) and arg_315_1.var_.actorSpriteComps1028 == nil then
				arg_315_1.var_.actorSpriteComps1028 = arg_315_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.125

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1028"]) then
				if arg_315_1.var_.actorSpriteComps1028 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor2.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor2.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor2.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 0.5, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1028"]) and arg_315_1.var_.actorSpriteComps1028 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps1028 = nil
			end

			local var_318_2 = 0
			local var_318_3 = 1.8

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(416021076).content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_6 = 72 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_4) / 72)

				if (72 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_4) / 72)) > 0 and var_318_3 < var_318_6 then
					arg_315_1.talkMaxDuration = var_318_6

					if var_318_6 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_6 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_7 and arg_315_1.time_ < var_318_2 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play416021077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 416021077
		arg_319_1.duration_ = 3.73

		local var_319_0 = {
			zh = 1.866,
			ja = 3.733
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
				arg_319_0:Play416021078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1028"]) and arg_319_1.var_.actorSpriteComps1028 == nil then
				arg_319_1.var_.actorSpriteComps1028 = arg_319_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.125

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1028"]) then
				if arg_319_1.var_.actorSpriteComps1028 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 1, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1028"]) and arg_319_1.var_.actorSpriteComps1028 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps1028 = nil
			end

			local var_322_2 = arg_319_1.actors_["1028"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1028 = var_322_2.localPosition
				var_322_2.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1028", 3)

				for iter_322_4 = 0, var_322_2.childCount - 1 do
					local var_322_3 = var_322_2:GetChild(iter_322_4)

					if var_322_3.name == "split_2" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				var_322_2.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_319_1.time_ - 0) / var_322_4)
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				var_322_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:AudioAction("play", "effect", "se_story_138", "se_story_138_weird01", "")
			end

			local var_322_6 = 0
			local var_322_7 = 0.125

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_8 = arg_319_1:GetWordFromCfg(416021077)
				local var_322_9 = arg_319_1:FormatText(var_322_8.content)

				arg_319_1.text_.text = var_322_9

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 5 <= 0 and var_322_7 or var_322_7 * (utf8.len(var_322_9) / 5)

				if (5 <= 0 and var_322_7 or var_322_7 * (utf8.len(var_322_9) / 5)) > 0 and var_322_7 < var_322_11 then
					arg_319_1.talkMaxDuration = var_322_11

					if var_322_11 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_11 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_9
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021077", "story_v_out_416021.awb") ~= 0 then
					local var_322_12 = manager.audio:GetVoiceLength("story_v_out_416021", "416021077", "story_v_out_416021.awb") / 1000

					if var_322_12 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_12 + var_322_6
					end

					if var_322_8.prefab_name ~= "" and arg_319_1.actors_[var_322_8.prefab_name] ~= nil then
						local var_322_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_8.prefab_name].transform, "story_v_out_416021", "416021077", "story_v_out_416021.awb")

						arg_319_1:RecordAudio("416021077", var_322_13)
						arg_319_1:RecordAudio("416021077", var_322_13)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_416021", "416021077", "story_v_out_416021.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_416021", "416021077", "story_v_out_416021.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_14 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_14 and arg_319_1.time_ < var_322_6 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play416021078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 416021078
		arg_323_1.duration_ = 6.33

		local var_323_0 = {
			zh = 5.266,
			ja = 6.333
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
				arg_323_0:Play416021079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.475

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:GetWordFromCfg(416021078)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 19 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 19)

				if (19 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 19)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021078", "story_v_out_416021.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021078", "story_v_out_416021.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_out_416021", "416021078", "story_v_out_416021.awb")

						arg_323_1:RecordAudio("416021078", var_326_6)
						arg_323_1:RecordAudio("416021078", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_416021", "416021078", "story_v_out_416021.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_416021", "416021078", "story_v_out_416021.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play416021079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 416021079
		arg_327_1.duration_ = 5.67

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play416021080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1028 = arg_327_1.actors_["1028"].transform.localPosition
				arg_327_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1028", 7)

				for iter_330_0 = 0, arg_327_1.actors_["1028"].transform.childCount - 1 do
					local var_330_0 = arg_327_1.actors_["1028"].transform:GetChild(iter_330_0)

					if var_330_0.name == "" or not string.find(var_330_0.name, "split") then
						var_330_0.gameObject:SetActive(true)
					else
						var_330_0.gameObject:SetActive(false)
					end
				end
			end

			local var_330_1 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 then
				arg_327_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_327_1.time_ - 0) / var_330_1)
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 then
				arg_327_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_330_2 = 0.034

			if 0.034 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = false

				arg_327_1:SetGaussion(false)
			end

			local var_330_3 = 0.632666666666667

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_3 then
				local var_330_4 = Color.New(1, 1, 1)

				var_330_4.a = Mathf.Lerp(1, 0, (arg_327_1.time_ - var_330_2) / var_330_3)
				arg_327_1.mask_.color = var_330_4
			end

			if arg_327_1.time_ >= var_330_2 + var_330_3 and arg_327_1.time_ < var_330_2 + var_330_3 + arg_330_0 then
				local var_330_5 = Color.New(1, 1, 1)

				arg_327_1.mask_.enabled = false
				var_330_5.a = 0
				arg_327_1.mask_.color = var_330_5
			end

			if 0.266666666666667 < arg_327_1.time_ and arg_327_1.time_ <= 0.266666666666667 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_138", "se_story_138_thunderhitwood", "")
			end

			if 0.526666666666667 < arg_327_1.time_ and arg_327_1.time_ <= 0.526666666666667 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_8 = 0.666666666666667
			local var_330_9 = 1.425

			if 0.666666666666667 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_10 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_10:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_11 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(416021079).content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 57 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 57)

				if (57 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 57)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13
					var_330_8 = var_330_8 + 0.3

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = var_330_8 + 0.3
			local var_330_15 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 + 0.3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_14 + var_330_15 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_14) / var_330_15

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_14 + var_330_15 and arg_327_1.time_ < var_330_14 + var_330_15 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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

		arg_327_1:InitPlayNodeList()
	end,
	Play416021080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 416021080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play416021081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:AudioAction("play", "effect", "se_story_138", "se_story_138_weird02", "")
			end

			local var_336_1 = 0
			local var_336_2 = 1.7

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(416021080).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 68 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 68)

				if (68 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 68)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play416021081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416021081
		arg_337_1.duration_ = 3.67

		local var_337_0 = {
			zh = 2.533,
			ja = 3.666
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play416021082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.125

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(416021081)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 5 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 5)

				if (5 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 5)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021081", "story_v_out_416021.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021081", "story_v_out_416021.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_416021", "416021081", "story_v_out_416021.awb")

						arg_337_1:RecordAudio("416021081", var_340_6)
						arg_337_1:RecordAudio("416021081", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_416021", "416021081", "story_v_out_416021.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_416021", "416021081", "story_v_out_416021.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play416021082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416021082
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play416021083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0.266666666666667 < arg_341_1.time_ and arg_341_1.time_ <= 0.266666666666667 + arg_344_0 then
				arg_341_1:AudioAction("play", "effect", "se_story_16", "se_story_16_droplet_loop02", "")
			end

			local var_344_1 = 0
			local var_344_2 = 1.95

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(416021082).content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 78 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 78)

				if (78 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 78)) > 0 and var_344_2 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_1 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_1
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_6 = math.max(var_344_2, arg_341_1.talkMaxDuration)

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_6 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_1) / var_344_6

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_1 + var_344_6 and arg_341_1.time_ < var_344_1 + var_344_6 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play416021083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416021083
		arg_345_1.duration_ = 6.9

		local var_345_0 = {
			zh = 6.7,
			ja = 6.9
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play416021084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 then
				local var_348_0 = arg_345_1.bgs_.H01

				arg_345_1.bgs_.H01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_1 = var_348_0:GetComponent("SpriteRenderer")

				if var_348_1 and var_348_1.sprite then
					local var_348_2 = 2 * (var_348_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_0.transform.localScale = Vector3.New(var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "H01" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_3 = 4.00066666666667

			if 4.00066666666667 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_3 + 0.133333333333333 and arg_345_1.time_ < var_348_3 + 0.133333333333333 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_4 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_5 = 2

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_5 then
				local var_348_6 = Color.New(0, 0, 0)

				var_348_6.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_4) / var_348_5)
				arg_345_1.mask_.color = var_348_6
			end

			if arg_345_1.time_ >= var_348_4 + var_348_5 and arg_345_1.time_ < var_348_4 + var_348_5 + arg_348_0 then
				local var_348_7 = Color.New(0, 0, 0)

				var_348_7.a = 1
				arg_345_1.mask_.color = var_348_7
			end

			local var_348_8 = 2

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 2

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(0, 0, 0)

				var_348_10.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(0, 0, 0)

				arg_345_1.mask_.enabled = false
				var_348_11.a = 0
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = arg_345_1.actors_["1028"].transform

			if 3.73333333333333 < arg_345_1.time_ and arg_345_1.time_ <= 3.73333333333333 + arg_348_0 then
				arg_345_1.var_.moveOldPos1028 = var_348_12.localPosition
				var_348_12.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1028", 3)

				for iter_348_2 = 0, var_348_12.childCount - 1 do
					local var_348_13 = var_348_12:GetChild(iter_348_2)

					if var_348_13.name == "" or not string.find(var_348_13.name, "split") then
						var_348_13.gameObject:SetActive(true)
					else
						var_348_13.gameObject:SetActive(false)
					end
				end
			end

			local var_348_14 = 0.001

			if 3.73333333333333 <= arg_345_1.time_ and arg_345_1.time_ < 3.73333333333333 + var_348_14 then
				var_348_12.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_345_1.time_ - 3.73333333333333) / var_348_14)
			end

			if arg_345_1.time_ >= 3.73333333333333 + var_348_14 and arg_345_1.time_ < 3.73333333333333 + var_348_14 + arg_348_0 then
				var_348_12.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_348_15 = arg_345_1.actors_["1028"]

			if 3.73333333333333 < arg_345_1.time_ and arg_345_1.time_ <= 3.73333333333333 + arg_348_0 and not isNil(var_348_15) and arg_345_1.var_.actorSpriteComps1028 == nil then
				arg_345_1.var_.actorSpriteComps1028 = var_348_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_16 = 0.125

			if 3.73333333333333 <= arg_345_1.time_ and arg_345_1.time_ < 3.73333333333333 + var_348_16 and not isNil(var_348_15) then
				if arg_345_1.var_.actorSpriteComps1028 then
					for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_348_4 then
							if arg_345_1.isInRecall_ then
								iter_348_4.color = Color.New(Mathf.Lerp(iter_348_4.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 3.73333333333333) / var_348_16), Mathf.Lerp(iter_348_4.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 3.73333333333333) / var_348_16), (Mathf.Lerp(iter_348_4.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 3.73333333333333) / var_348_16)))
							else
								local var_348_17 = Mathf.Lerp(iter_348_4.color.r, 1, (arg_345_1.time_ - 3.73333333333333) / var_348_16)

								iter_348_4.color = Color.New(var_348_17, var_348_17, var_348_17)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 3.73333333333333 + var_348_16 and arg_345_1.time_ < 3.73333333333333 + var_348_16 + arg_348_0 and not isNil(var_348_15) and arg_345_1.var_.actorSpriteComps1028 then
				for iter_348_5, iter_348_6 in pairs(arg_345_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_348_6 then
						iter_348_6.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps1028 = nil
			end

			if 3.73333333333333 < arg_345_1.time_ and arg_345_1.time_ <= 3.73333333333333 + arg_348_0 then
				local var_348_18 = arg_345_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_18 then
					arg_345_1.var_.alphaOldValue1028 = var_348_18.alpha
					arg_345_1.var_.characterEffect1028 = var_348_18
				end

				arg_345_1.var_.alphaOldValue1028 = 0
			end

			local var_348_19 = 0.857666666666667

			if 3.73333333333333 <= arg_345_1.time_ and arg_345_1.time_ < 3.73333333333333 + var_348_19 then
				if arg_345_1.var_.characterEffect1028 then
					arg_345_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_345_1.var_.alphaOldValue1028, 1, (arg_345_1.time_ - 3.73333333333333) / var_348_19)
				end
			end

			if arg_345_1.time_ >= 3.73333333333333 + var_348_19 and arg_345_1.time_ < 3.73333333333333 + var_348_19 + arg_348_0 and arg_345_1.var_.characterEffect1028 then
				arg_345_1.var_.characterEffect1028.alpha = 1
			end

			if 1.76666666666667 < arg_345_1.time_ and arg_345_1.time_ <= 1.76666666666667 + arg_348_0 then
				arg_345_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_droplet_loop02", "")
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_21 = 4
			local var_348_22 = 0.25

			if 4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_23 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_23:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_24 = arg_345_1:GetWordFromCfg(416021083)
				local var_348_25 = arg_345_1:FormatText(var_348_24.content)

				arg_345_1.text_.text = var_348_25

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_27 = 10 <= 0 and var_348_22 or var_348_22 * (utf8.len(var_348_25) / 10)

				if (10 <= 0 and var_348_22 or var_348_22 * (utf8.len(var_348_25) / 10)) > 0 and var_348_22 < var_348_27 then
					arg_345_1.talkMaxDuration = var_348_27
					var_348_21 = var_348_21 + 0.3

					if var_348_27 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_27 + var_348_21
					end
				end

				arg_345_1.text_.text = var_348_25
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021083", "story_v_out_416021.awb") ~= 0 then
					local var_348_28 = manager.audio:GetVoiceLength("story_v_out_416021", "416021083", "story_v_out_416021.awb") / 1000

					if var_348_28 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_28 + var_348_21
					end

					if var_348_24.prefab_name ~= "" and arg_345_1.actors_[var_348_24.prefab_name] ~= nil then
						local var_348_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_24.prefab_name].transform, "story_v_out_416021", "416021083", "story_v_out_416021.awb")

						arg_345_1:RecordAudio("416021083", var_348_29)
						arg_345_1:RecordAudio("416021083", var_348_29)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_416021", "416021083", "story_v_out_416021.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_416021", "416021083", "story_v_out_416021.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_30 = var_348_21 + 0.3
			local var_348_31 = math.max(var_348_22, arg_345_1.talkMaxDuration)

			if var_348_21 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_30 + var_348_31 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_30) / var_348_31

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_30 + var_348_31 and arg_345_1.time_ < var_348_30 + var_348_31 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play416021084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 416021084
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play416021085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1028 = arg_351_1.actors_["1028"].transform.localPosition
				arg_351_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1028", 7)

				for iter_354_0 = 0, arg_351_1.actors_["1028"].transform.childCount - 1 do
					local var_354_0 = arg_351_1.actors_["1028"].transform:GetChild(iter_354_0)

					if var_354_0.name == "" or not string.find(var_354_0.name, "split") then
						var_354_0.gameObject:SetActive(true)
					else
						var_354_0.gameObject:SetActive(false)
					end
				end
			end

			local var_354_1 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 then
				arg_351_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_351_1.time_ - 0) / var_354_1)
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 then
				arg_351_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_354_2 = 0
			local var_354_3 = 1.525

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

				local var_354_4 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(416021084).content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 61 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_4) / 61)

				if (61 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_4) / 61)) > 0 and var_354_3 < var_354_6 then
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

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play416021085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 416021085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play416021086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0.3 < arg_355_1.time_ and arg_355_1.time_ <= 0.3 + arg_358_0 then
				arg_355_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			local var_358_1 = 0
			local var_358_2 = 1.675

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(416021085).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 67 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 67)

				if (67 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 67)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play416021086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 416021086
		arg_359_1.duration_ = 5.67

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play416021087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = false

				arg_359_1:SetGaussion(false)
			end

			local var_362_0 = 0.666666666666667

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				local var_362_1 = Color.New(1, 1, 1)

				var_362_1.a = Mathf.Lerp(1, 0, (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.mask_.color = var_362_1
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				local var_362_2 = Color.New(1, 1, 1)

				arg_359_1.mask_.enabled = false
				var_362_2.a = 0
				arg_359_1.mask_.color = var_362_2
			end

			local var_362_3 = manager.ui.mainCamera.transform

			if 1.68333333333333 < arg_359_1.time_ and arg_359_1.time_ <= 1.68333333333333 + arg_362_0 then
				arg_359_1.var_.shakeOldPos = var_362_3.localPosition
			end

			local var_362_4 = 0.433333333333333

			if 1.68333333333333 <= arg_359_1.time_ and arg_359_1.time_ < 1.68333333333333 + var_362_4 then
				local var_362_5, var_362_6 = math.modf((arg_359_1.time_ - 1.68333333333333) / 0.099)

				var_362_3.localPosition = Vector3.New(var_362_6 * 0.13, var_362_6 * 0.13, var_362_6 * 0.13) + arg_359_1.var_.shakeOldPos
			end

			if arg_359_1.time_ >= 1.68333333333333 + var_362_4 and arg_359_1.time_ < 1.68333333333333 + var_362_4 + arg_362_0 then
				var_362_3.localPosition = arg_359_1.var_.shakeOldPos
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_138", "se_story_138_elecskill01", "")
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_8 = 0.666666666666667
			local var_362_9 = 1.45

			if 0.666666666666667 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_10 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_10:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_11 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(416021086).content)

				arg_359_1.text_.text = var_362_11

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 58 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 58)

				if (58 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 58)) > 0 and var_362_9 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13
					var_362_8 = var_362_8 + 0.3

					if var_362_13 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_8
					end
				end

				arg_359_1.text_.text = var_362_11
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_14 = var_362_8 + 0.3
			local var_362_15 = math.max(var_362_9, arg_359_1.talkMaxDuration)

			if var_362_8 + 0.3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_14 + var_362_15 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_14) / var_362_15

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_14 + var_362_15 and arg_359_1.time_ < var_362_14 + var_362_15 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play416021087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 416021087
		arg_365_1.duration_ = 4.9

		local var_365_0 = {
			zh = 4.9,
			ja = 4.133
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
				arg_365_0:Play416021088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1028 = arg_365_1.actors_["1028"].transform.localPosition
				arg_365_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1028", 3)

				for iter_368_0 = 0, arg_365_1.actors_["1028"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["1028"].transform:GetChild(iter_368_0)

					if var_368_0.name == "split_2" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["1028"].transform.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_368_2 = arg_365_1.actors_["1028"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1028 == nil then
				arg_365_1.var_.actorSpriteComps1028 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 0.125

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps1028 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1028 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_368_4 then
						iter_368_4.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps1028 = nil
			end

			local var_368_5 = 0
			local var_368_6 = 0.6

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_7 = arg_365_1:GetWordFromCfg(416021087)
				local var_368_8 = arg_365_1:FormatText(var_368_7.content)

				arg_365_1.text_.text = var_368_8

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_10 = 24 <= 0 and var_368_6 or var_368_6 * (utf8.len(var_368_8) / 24)

				if (24 <= 0 and var_368_6 or var_368_6 * (utf8.len(var_368_8) / 24)) > 0 and var_368_6 < var_368_10 then
					arg_365_1.talkMaxDuration = var_368_10

					if var_368_10 + var_368_5 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_5
					end
				end

				arg_365_1.text_.text = var_368_8
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021087", "story_v_out_416021.awb") ~= 0 then
					local var_368_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021087", "story_v_out_416021.awb") / 1000

					if var_368_11 + var_368_5 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_11 + var_368_5
					end

					if var_368_7.prefab_name ~= "" and arg_365_1.actors_[var_368_7.prefab_name] ~= nil then
						local var_368_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_7.prefab_name].transform, "story_v_out_416021", "416021087", "story_v_out_416021.awb")

						arg_365_1:RecordAudio("416021087", var_368_12)
						arg_365_1:RecordAudio("416021087", var_368_12)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_416021", "416021087", "story_v_out_416021.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_416021", "416021087", "story_v_out_416021.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_13 = math.max(var_368_6, arg_365_1.talkMaxDuration)

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_13 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_5) / var_368_13

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_5 + var_368_13 and arg_365_1.time_ < var_368_5 + var_368_13 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play416021088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 416021088
		arg_369_1.duration_ = 4.93

		local var_369_0 = {
			zh = 3.266,
			ja = 4.933
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
				arg_369_0:Play416021089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.4

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:GetWordFromCfg(416021088)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 16 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 16)

				if (16 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 16)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021088", "story_v_out_416021.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_416021", "416021088", "story_v_out_416021.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_416021", "416021088", "story_v_out_416021.awb")

						arg_369_1:RecordAudio("416021088", var_372_6)
						arg_369_1:RecordAudio("416021088", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_416021", "416021088", "story_v_out_416021.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_416021", "416021088", "story_v_out_416021.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play416021089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 416021089
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play416021090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1028 = arg_373_1.actors_["1028"].transform.localPosition
				arg_373_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1028", 7)

				for iter_376_0 = 0, arg_373_1.actors_["1028"].transform.childCount - 1 do
					local var_376_0 = arg_373_1.actors_["1028"].transform:GetChild(iter_376_0)

					if var_376_0.name == "" or not string.find(var_376_0.name, "split") then
						var_376_0.gameObject:SetActive(true)
					else
						var_376_0.gameObject:SetActive(false)
					end
				end
			end

			local var_376_1 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_1 then
				arg_373_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_373_1.time_ - 0) / var_376_1)
			end

			if arg_373_1.time_ >= 0 + var_376_1 and arg_373_1.time_ < 0 + var_376_1 + arg_376_0 then
				arg_373_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_373_1.time_ and arg_373_1.time_ <= 0.2 + arg_376_0 then
				arg_373_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			local var_376_3 = 0
			local var_376_4 = 1.25

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_5 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(416021089).content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 50 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 50)

				if (50 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 50)) > 0 and var_376_4 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_3 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_3
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_4, arg_373_1.talkMaxDuration)

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_3) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_3 + var_376_8 and arg_373_1.time_ < var_376_3 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play416021090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 416021090
		arg_377_1.duration_ = 5.47

		local var_377_0 = {
			zh = 4,
			ja = 5.466
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
			arg_377_1.auto_ = false
		end

		function arg_377_1.playNext_(arg_379_0)
			arg_377_1.onStoryFinished_()
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1028"]) and arg_377_1.var_.actorSpriteComps1028 == nil then
				arg_377_1.var_.actorSpriteComps1028 = arg_377_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.125

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1028"]) then
				if arg_377_1.var_.actorSpriteComps1028 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								iter_380_1.color = Color.New(Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_0), Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_0), (Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_0)))
							else
								local var_380_1 = Mathf.Lerp(iter_380_1.color.r, 1, (arg_377_1.time_ - 0) / var_380_0)

								iter_380_1.color = Color.New(var_380_1, var_380_1, var_380_1)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1028"]) and arg_377_1.var_.actorSpriteComps1028 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps1028 = nil
			end

			local var_380_2 = arg_377_1.actors_["1028"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1028 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1028", 3)

				for iter_380_4 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_4)

					if var_380_3.name == "split_6" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_380_5 = 0
			local var_380_6 = 0.35

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:GetWordFromCfg(416021090)
				local var_380_8 = arg_377_1:FormatText(var_380_7.content)

				arg_377_1.text_.text = var_380_8

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 14 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 14)

				if (14 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 14)) > 0 and var_380_6 < var_380_10 then
					arg_377_1.talkMaxDuration = var_380_10

					if var_380_10 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_8
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416021", "416021090", "story_v_out_416021.awb") ~= 0 then
					local var_380_11 = manager.audio:GetVoiceLength("story_v_out_416021", "416021090", "story_v_out_416021.awb") / 1000

					if var_380_11 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_11 + var_380_5
					end

					if var_380_7.prefab_name ~= "" and arg_377_1.actors_[var_380_7.prefab_name] ~= nil then
						local var_380_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_7.prefab_name].transform, "story_v_out_416021", "416021090", "story_v_out_416021.awb")

						arg_377_1:RecordAudio("416021090", var_380_12)
						arg_377_1:RecordAudio("416021090", var_380_12)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_416021", "416021090", "story_v_out_416021.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_416021", "416021090", "story_v_out_416021.awb")
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
				actorName = "1028",
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
	assets = {
		"TextureConfig/Background/ST0106",
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/H01",
		"TextureConfig/Background/H01b"
	},
	voices = {
		"story_v_out_416021.awb"
	}
}
