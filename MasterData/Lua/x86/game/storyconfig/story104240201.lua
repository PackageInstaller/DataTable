return {
	Play424021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
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
				arg_1_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(424021001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 40 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 40)

				if (40 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 40)) > 0 and var_4_17 < var_4_21 then
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
	Play424021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424021002
		arg_9_1.duration_ = 15.5

		local var_9_0 = {
			zh = 10.266,
			ja = 15.5
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
				arg_9_0:Play424021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1037"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "1037"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["1037"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["1037"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1037 == nil then
				arg_9_1.var_.actorSpriteComps1037 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps1037 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1037 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1037 = nil
			end

			local var_12_5 = arg_9_1.actors_["1037"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1037 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1037", 3)

				for iter_12_6 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_6)

					if var_12_6.name == "split_1" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -430, -55)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["1037"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue1037 = var_12_8.alpha
					arg_9_1.var_.characterEffect1037 = var_12_8
				end

				arg_9_1.var_.alphaOldValue1037 = 0
			end

			local var_12_9 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect1037 then
					arg_9_1.var_.characterEffect1037.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue1037, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect1037 then
				arg_9_1.var_.characterEffect1037.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 1.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
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

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:GetWordFromCfg(424021002)
				local var_12_14 = arg_9_1:FormatText(var_12_13.content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 57 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_14) / 57)

				if (57 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_14) / 57)) > 0 and var_12_11 < var_12_16 then
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

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021002", "story_v_out_424021.awb") ~= 0 then
					local var_12_17 = manager.audio:GetVoiceLength("story_v_out_424021", "424021002", "story_v_out_424021.awb") / 1000

					if var_12_17 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_10
					end

					if var_12_13.prefab_name ~= "" and arg_9_1.actors_[var_12_13.prefab_name] ~= nil then
						local var_12_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_13.prefab_name].transform, "story_v_out_424021", "424021002", "story_v_out_424021.awb")

						arg_9_1:RecordAudio("424021002", var_12_18)
						arg_9_1:RecordAudio("424021002", var_12_18)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424021", "424021002", "story_v_out_424021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424021", "424021002", "story_v_out_424021.awb")
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
				actorName = "1037",
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
	Play424021003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 424021003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play424021004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1037"]) and arg_15_1.var_.actorSpriteComps1037 == nil then
				arg_15_1.var_.actorSpriteComps1037 = arg_15_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_0 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1037"]) then
				if arg_15_1.var_.actorSpriteComps1037 then
					for iter_18_0, iter_18_1 in pairs(arg_15_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_18_1 then
							if arg_15_1.isInRecall_ then
								iter_18_1.color = Color.New(Mathf.Lerp(iter_18_1.color.r, arg_15_1.hightColor2.r, (arg_15_1.time_ - 0) / var_18_0), Mathf.Lerp(iter_18_1.color.g, arg_15_1.hightColor2.g, (arg_15_1.time_ - 0) / var_18_0), (Mathf.Lerp(iter_18_1.color.b, arg_15_1.hightColor2.b, (arg_15_1.time_ - 0) / var_18_0)))
							else
								local var_18_1 = Mathf.Lerp(iter_18_1.color.r, 0.5, (arg_15_1.time_ - 0) / var_18_0)

								iter_18_1.color = Color.New(var_18_1, var_18_1, var_18_1)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1037"]) and arg_15_1.var_.actorSpriteComps1037 then
				for iter_18_2, iter_18_3 in pairs(arg_15_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_18_3 then
						iter_18_3.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_15_1.var_.actorSpriteComps1037 = nil
			end

			local var_18_2 = 0
			local var_18_3 = 0.6

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_4 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(424021003).content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_6 = 24 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 24)

				if (24 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 24)) > 0 and var_18_3 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_3, arg_15_1.talkMaxDuration)

			if var_18_2 <= arg_15_1.time_ and arg_15_1.time_ < var_18_2 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_2) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_2 + var_18_7 and arg_15_1.time_ < var_18_2 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play424021004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 424021004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play424021005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1037 = arg_19_1.actors_["1037"].transform.localPosition
				arg_19_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1037", 7)

				for iter_22_0 = 0, arg_19_1.actors_["1037"].transform.childCount - 1 do
					local var_22_0 = arg_19_1.actors_["1037"].transform:GetChild(iter_22_0)

					if var_22_0.name == "" or not string.find(var_22_0.name, "split") then
						var_22_0.gameObject:SetActive(true)
					else
						var_22_0.gameObject:SetActive(false)
					end
				end
			end

			local var_22_1 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 then
				arg_19_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_19_1.time_ - 0) / var_22_1)
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 then
				arg_19_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_22_2 = 0
			local var_22_3 = 1.1

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(424021004).content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 44 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 44)

				if (44 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 44)) > 0 and var_22_3 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_7 and arg_19_1.time_ < var_22_2 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play424021005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 424021005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play424021006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.625

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(424021005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 25 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 25)

				if (25 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 25)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play424021006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 424021006
		arg_27_1.duration_ = 3.23

		local var_27_0 = {
			zh = 2.066,
			ja = 3.233
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play424021007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1037"]) and arg_27_1.var_.actorSpriteComps1037 == nil then
				arg_27_1.var_.actorSpriteComps1037 = arg_27_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1037"]) then
				if arg_27_1.var_.actorSpriteComps1037 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 1, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1037"]) and arg_27_1.var_.actorSpriteComps1037 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps1037 = nil
			end

			local var_30_2 = arg_27_1.actors_["1037"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1037 = var_30_2.localPosition
				var_30_2.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1037", 3)

				for iter_30_4 = 0, var_30_2.childCount - 1 do
					local var_30_3 = var_30_2:GetChild(iter_30_4)

					if var_30_3.name == "split_5" then
						var_30_3:SetAsLastSibling()
						var_30_3.gameObject:SetActive(true)

						arg_27_1.var_.actorSpriteSplit1037 = var_30_3.gameObject:GetComponent(typeof(Image))

						arg_27_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_2.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_27_1.time_ - 0) / var_30_4)

				if arg_27_1.var_.actorSpriteSplit1037 ~= nil then
					arg_27_1.var_.actorSpriteSplit1037:SetAlpha((arg_27_1.time_ - 0) / var_30_4)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_2.localPosition = Vector3.New(0, -430, -55)

				if arg_27_1.var_.actorSpriteSplit1037 ~= nil then
					arg_27_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_30_5 = 0
			local var_30_6 = 0.275

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:GetWordFromCfg(424021006)
				local var_30_8 = arg_27_1:FormatText(var_30_7.content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 11 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 11)

				if (11 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 11)) > 0 and var_30_6 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_8
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021006", "story_v_out_424021.awb") ~= 0 then
					local var_30_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021006", "story_v_out_424021.awb") / 1000

					if var_30_11 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_5
					end

					if var_30_7.prefab_name ~= "" and arg_27_1.actors_[var_30_7.prefab_name] ~= nil then
						local var_30_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_7.prefab_name].transform, "story_v_out_424021", "424021006", "story_v_out_424021.awb")

						arg_27_1:RecordAudio("424021006", var_30_12)
						arg_27_1:RecordAudio("424021006", var_30_12)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_424021", "424021006", "story_v_out_424021.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_424021", "424021006", "story_v_out_424021.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_13 and arg_27_1.time_ < var_30_5 + var_30_13 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play424021007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 424021007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play424021008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1037"]) and arg_31_1.var_.actorSpriteComps1037 == nil then
				arg_31_1.var_.actorSpriteComps1037 = arg_31_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1037"]) then
				if arg_31_1.var_.actorSpriteComps1037 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								iter_34_1.color = Color.New(Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_0), Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_0), (Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_0)))
							else
								local var_34_1 = Mathf.Lerp(iter_34_1.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_0)

								iter_34_1.color = Color.New(var_34_1, var_34_1, var_34_1)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1037"]) and arg_31_1.var_.actorSpriteComps1037 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps1037 = nil
			end

			local var_34_2 = 0
			local var_34_3 = 0.575

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_4 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(424021007).content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_6 = 23 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_4) / 23)

				if (23 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_4) / 23)) > 0 and var_34_3 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_7 and arg_31_1.time_ < var_34_2 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play424021008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 424021008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play424021009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1037 = arg_35_1.actors_["1037"].transform.localPosition
				arg_35_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1037", 7)

				for iter_38_0 = 0, arg_35_1.actors_["1037"].transform.childCount - 1 do
					local var_38_0 = arg_35_1.actors_["1037"].transform:GetChild(iter_38_0)

					if var_38_0.name == "" or not string.find(var_38_0.name, "split") then
						var_38_0.gameObject:SetActive(true)
					else
						var_38_0.gameObject:SetActive(false)
					end
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_35_1.time_ - 0) / var_38_1)
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0.034 < arg_35_1.time_ and arg_35_1.time_ <= 0.034 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_38_3 = 0
			local var_38_4 = 1.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(424021008).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 56 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 56)

				if (56 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 56)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play424021009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 424021009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play424021010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.15

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(424021009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 46 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 46)

				if (46 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 46)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play424021010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 424021010
		arg_43_1.duration_ = 1.33

		local var_43_0 = {
			zh = 1.333,
			ja = 1.133
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play424021011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.05

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_43_1.callingController_:SetSelectedState("calling")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:GetWordFromCfg(424021010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 2 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 2)

				if (2 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 2)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021010", "story_v_out_424021.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021010", "story_v_out_424021.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_424021", "424021010", "story_v_out_424021.awb")

						arg_43_1:RecordAudio("424021010", var_46_6)
						arg_43_1:RecordAudio("424021010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_424021", "424021010", "story_v_out_424021.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_424021", "424021010", "story_v_out_424021.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play424021011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 424021011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play424021012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.925

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(424021011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 37 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 37)

				if (37 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 37)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play424021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 424021012
		arg_51_1.duration_ = 4.33

		local var_51_0 = {
			zh = 4.266,
			ja = 4.333
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
				arg_51_0:Play424021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["1094"] == nil then
				local var_54_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_54_0) then
					local var_54_1 = Object.Instantiate(var_54_0, arg_51_1.canvasGo_.transform)

					var_54_1.transform:SetSiblingIndex(1)

					var_54_1.name = "1094"
					var_54_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_51_1.actors_["1094"] = var_54_1

					if arg_51_1.isInRecall_ then
						for iter_54_0, iter_54_1 in ipairs((var_54_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_54_1.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_54_2 = arg_51_1.actors_["1094"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1094 = var_54_2.localPosition
				var_54_2.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1094", 3)

				for iter_54_2 = 0, var_54_2.childCount - 1 do
					local var_54_3 = var_54_2:GetChild(iter_54_2)

					if var_54_3.name == "" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_2.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_51_1.time_ - 0) / var_54_4)
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_2.localPosition = Vector3.New(0, -335, -230)
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				local var_54_5 = arg_51_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_54_5 then
					arg_51_1.var_.alphaOldValue1094 = var_54_5.alpha
					arg_51_1.var_.characterEffect1094 = var_54_5
				end
			end

			local var_54_6 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 then
				if arg_51_1.var_.characterEffect1094 then
					arg_51_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_51_1.var_.alphaOldValue1094, 0.6, (arg_51_1.time_ - 0) / var_54_6)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and arg_51_1.var_.characterEffect1094 then
				arg_51_1.var_.characterEffect1094.alpha = 0.6
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:SetSpriteNiuquEffect("1094", true)
			end

			local var_54_8 = 0
			local var_54_9 = 0.35

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(424021012)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 14 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 14)

				if (14 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 14)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021012", "story_v_out_424021.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021012", "story_v_out_424021.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_424021", "424021012", "story_v_out_424021.awb")

						arg_51_1:RecordAudio("424021012", var_54_15)
						arg_51_1:RecordAudio("424021012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_424021", "424021012", "story_v_out_424021.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_424021", "424021012", "story_v_out_424021.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play424021013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 424021013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play424021014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1094"]) and arg_55_1.var_.actorSpriteComps1094 == nil then
				arg_55_1.var_.actorSpriteComps1094 = arg_55_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1094"]) then
				if arg_55_1.var_.actorSpriteComps1094 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1094"]) and arg_55_1.var_.actorSpriteComps1094 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps1094 = nil
			end

			local var_58_2 = arg_55_1.actors_["1094"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1094 = var_58_2.localPosition
				var_58_2.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1094", 7)

				for iter_58_4 = 0, var_58_2.childCount - 1 do
					local var_58_3 = var_58_2:GetChild(iter_58_4)

					if var_58_3.name == "" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_2.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 0) / var_58_4)
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				local var_58_5 = arg_55_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_5 then
					arg_55_1.var_.alphaOldValue1094 = var_58_5.alpha
					arg_55_1.var_.characterEffect1094 = var_58_5
				end

				arg_55_1.var_.alphaOldValue1094 = 0
			end

			local var_58_6 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 then
				if arg_55_1.var_.characterEffect1094 then
					arg_55_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_55_1.var_.alphaOldValue1094, 1, (arg_55_1.time_ - 0) / var_58_6)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and arg_55_1.var_.characterEffect1094 then
				arg_55_1.var_.characterEffect1094.alpha = 1
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:SetSpriteNiuquEffect("1094", false)
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera_ui02", "")
			end

			local var_58_9 = 0
			local var_58_10 = 0.825

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_11 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(424021013).content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 33 <= 0 and var_58_10 or var_58_10 * (utf8.len(var_58_11) / 33)

				if (33 <= 0 and var_58_10 or var_58_10 * (utf8.len(var_58_11) / 33)) > 0 and var_58_10 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_9 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_9
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_10, arg_55_1.talkMaxDuration)

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_9) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_9 + var_58_14 and arg_55_1.time_ < var_58_9 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play424021014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 424021014
		arg_59_1.duration_ = 3.8

		local var_59_0 = {
			zh = 2.766,
			ja = 3.8
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play424021015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1037"]) and arg_59_1.var_.actorSpriteComps1037 == nil then
				arg_59_1.var_.actorSpriteComps1037 = arg_59_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1037"]) then
				if arg_59_1.var_.actorSpriteComps1037 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 1, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1037"]) and arg_59_1.var_.actorSpriteComps1037 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps1037 = nil
			end

			local var_62_2 = arg_59_1.actors_["1037"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1037 = var_62_2.localPosition
				var_62_2.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1037", 3)

				for iter_62_4 = 0, var_62_2.childCount - 1 do
					local var_62_3 = var_62_2:GetChild(iter_62_4)

					if var_62_3.name == "split_4" then
						var_62_3:SetAsLastSibling()
						var_62_3.gameObject:SetActive(true)

						arg_59_1.var_.actorSpriteSplit1037 = var_62_3.gameObject:GetComponent(typeof(Image))

						arg_59_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_62_4 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				var_62_2.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_59_1.time_ - 0) / var_62_4)

				if arg_59_1.var_.actorSpriteSplit1037 ~= nil then
					arg_59_1.var_.actorSpriteSplit1037:SetAlpha((arg_59_1.time_ - 0) / var_62_4)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				var_62_2.localPosition = Vector3.New(0, -430, -55)

				if arg_59_1.var_.actorSpriteSplit1037 ~= nil then
					arg_59_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_62_5 = 0
			local var_62_6 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_7 = arg_59_1:GetWordFromCfg(424021014)
				local var_62_8 = arg_59_1:FormatText(var_62_7.content)

				arg_59_1.text_.text = var_62_8

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 11 <= 0 and var_62_6 or var_62_6 * (utf8.len(var_62_8) / 11)

				if (11 <= 0 and var_62_6 or var_62_6 * (utf8.len(var_62_8) / 11)) > 0 and var_62_6 < var_62_10 then
					arg_59_1.talkMaxDuration = var_62_10

					if var_62_10 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_5
					end
				end

				arg_59_1.text_.text = var_62_8
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021014", "story_v_out_424021.awb") ~= 0 then
					local var_62_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021014", "story_v_out_424021.awb") / 1000

					if var_62_11 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_5
					end

					if var_62_7.prefab_name ~= "" and arg_59_1.actors_[var_62_7.prefab_name] ~= nil then
						local var_62_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_7.prefab_name].transform, "story_v_out_424021", "424021014", "story_v_out_424021.awb")

						arg_59_1:RecordAudio("424021014", var_62_12)
						arg_59_1:RecordAudio("424021014", var_62_12)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_424021", "424021014", "story_v_out_424021.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_424021", "424021014", "story_v_out_424021.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_6, arg_59_1.talkMaxDuration)

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_5) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_5 + var_62_13 and arg_59_1.time_ < var_62_5 + var_62_13 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play424021015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 424021015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play424021016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1037"]) and arg_63_1.var_.actorSpriteComps1037 == nil then
				arg_63_1.var_.actorSpriteComps1037 = arg_63_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1037"]) then
				if arg_63_1.var_.actorSpriteComps1037 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1037"]) and arg_63_1.var_.actorSpriteComps1037 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps1037 = nil
			end

			local var_66_2 = 0
			local var_66_3 = 0.375

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_4 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(424021015).content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 15 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_4) / 15)

				if (15 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_4) / 15)) > 0 and var_66_3 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_7 and arg_63_1.time_ < var_66_2 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play424021016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 424021016
		arg_67_1.duration_ = 10.4

		local var_67_0 = {
			zh = 8.166,
			ja = 10.4
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
				arg_67_0:Play424021017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1037"]) and arg_67_1.var_.actorSpriteComps1037 == nil then
				arg_67_1.var_.actorSpriteComps1037 = arg_67_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1037"]) then
				if arg_67_1.var_.actorSpriteComps1037 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								iter_70_1.color = Color.New(Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_0), Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_0), (Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_0)))
							else
								local var_70_1 = Mathf.Lerp(iter_70_1.color.r, 1, (arg_67_1.time_ - 0) / var_70_0)

								iter_70_1.color = Color.New(var_70_1, var_70_1, var_70_1)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1037"]) and arg_67_1.var_.actorSpriteComps1037 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps1037 = nil
			end

			local var_70_2 = arg_67_1.actors_["1037"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1037 = var_70_2.localPosition
				var_70_2.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1037", 3)

				for iter_70_4 = 0, var_70_2.childCount - 1 do
					local var_70_3 = var_70_2:GetChild(iter_70_4)

					if var_70_3.name == "split_1" then
						var_70_3:SetAsLastSibling()
						var_70_3.gameObject:SetActive(true)

						arg_67_1.var_.actorSpriteSplit1037 = var_70_3.gameObject:GetComponent(typeof(Image))

						arg_67_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_70_4 = 0.5

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_2.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_67_1.time_ - 0) / var_70_4)

				if arg_67_1.var_.actorSpriteSplit1037 ~= nil then
					arg_67_1.var_.actorSpriteSplit1037:SetAlpha((arg_67_1.time_ - 0) / var_70_4)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_2.localPosition = Vector3.New(0, -430, -55)

				if arg_67_1.var_.actorSpriteSplit1037 ~= nil then
					arg_67_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_70_5 = 0
			local var_70_6 = 1.075

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:GetWordFromCfg(424021016)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 43 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 43)

				if (43 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 43)) > 0 and var_70_6 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_5
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021016", "story_v_out_424021.awb") ~= 0 then
					local var_70_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021016", "story_v_out_424021.awb") / 1000

					if var_70_11 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_5
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_424021", "424021016", "story_v_out_424021.awb")

						arg_67_1:RecordAudio("424021016", var_70_12)
						arg_67_1:RecordAudio("424021016", var_70_12)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_424021", "424021016", "story_v_out_424021.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_424021", "424021016", "story_v_out_424021.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play424021017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 424021017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play424021018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1037"]) and arg_71_1.var_.actorSpriteComps1037 == nil then
				arg_71_1.var_.actorSpriteComps1037 = arg_71_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1037"]) then
				if arg_71_1.var_.actorSpriteComps1037 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								iter_74_1.color = Color.New(Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_0), Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_0), (Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_0)))
							else
								local var_74_1 = Mathf.Lerp(iter_74_1.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_0)

								iter_74_1.color = Color.New(var_74_1, var_74_1, var_74_1)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1037"]) and arg_71_1.var_.actorSpriteComps1037 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps1037 = nil
			end

			local var_74_2 = 0
			local var_74_3 = 0.225

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_4 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(424021017).content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 9 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_4) / 9)

				if (9 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_4) / 9)) > 0 and var_74_3 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_7 and arg_71_1.time_ < var_74_2 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play424021018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 424021018
		arg_75_1.duration_ = 2.9

		local var_75_0 = {
			zh = 2.466,
			ja = 2.9
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
				arg_75_0:Play424021019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1037"]) and arg_75_1.var_.actorSpriteComps1037 == nil then
				arg_75_1.var_.actorSpriteComps1037 = arg_75_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1037"]) then
				if arg_75_1.var_.actorSpriteComps1037 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1037"]) and arg_75_1.var_.actorSpriteComps1037 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1037 = nil
			end

			local var_78_2 = arg_75_1.actors_["1037"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1037 = var_78_2.localPosition
				var_78_2.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1037", 3)

				for iter_78_4 = 0, var_78_2.childCount - 1 do
					local var_78_3 = var_78_2:GetChild(iter_78_4)

					if var_78_3.name == "split_5" then
						var_78_3:SetAsLastSibling()
						var_78_3.gameObject:SetActive(true)

						arg_75_1.var_.actorSpriteSplit1037 = var_78_3.gameObject:GetComponent(typeof(Image))

						arg_75_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_78_4 = 0.5

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_2.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_75_1.time_ - 0) / var_78_4)

				if arg_75_1.var_.actorSpriteSplit1037 ~= nil then
					arg_75_1.var_.actorSpriteSplit1037:SetAlpha((arg_75_1.time_ - 0) / var_78_4)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_2.localPosition = Vector3.New(0, -430, -55)

				if arg_75_1.var_.actorSpriteSplit1037 ~= nil then
					arg_75_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_78_5 = 0
			local var_78_6 = 0.275

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(424021018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 11 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 11)

				if (11 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 11)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021018", "story_v_out_424021.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021018", "story_v_out_424021.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_424021", "424021018", "story_v_out_424021.awb")

						arg_75_1:RecordAudio("424021018", var_78_12)
						arg_75_1:RecordAudio("424021018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_424021", "424021018", "story_v_out_424021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_424021", "424021018", "story_v_out_424021.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play424021019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 424021019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play424021020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1037"]) and arg_79_1.var_.actorSpriteComps1037 == nil then
				arg_79_1.var_.actorSpriteComps1037 = arg_79_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1037"]) then
				if arg_79_1.var_.actorSpriteComps1037 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1037"]) and arg_79_1.var_.actorSpriteComps1037 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1037 = nil
			end

			local var_82_2 = 0
			local var_82_3 = 0.825

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_4 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(424021019).content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 33 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_4) / 33)

				if (33 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_4) / 33)) > 0 and var_82_3 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_7 and arg_79_1.time_ < var_82_2 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play424021020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 424021020
		arg_83_1.duration_ = 7.67

		local var_83_0 = {
			zh = 4.466,
			ja = 7.666
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
				arg_83_0:Play424021021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1037"]) and arg_83_1.var_.actorSpriteComps1037 == nil then
				arg_83_1.var_.actorSpriteComps1037 = arg_83_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1037"]) then
				if arg_83_1.var_.actorSpriteComps1037 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 1, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1037"]) and arg_83_1.var_.actorSpriteComps1037 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps1037 = nil
			end

			local var_86_2 = arg_83_1.actors_["1037"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1037 = var_86_2.localPosition
				var_86_2.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1037", 3)

				for iter_86_4 = 0, var_86_2.childCount - 1 do
					local var_86_3 = var_86_2:GetChild(iter_86_4)

					if var_86_3.name == "split_1" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_2.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_83_1.time_ - 0) / var_86_4)
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_86_5 = 0
			local var_86_6 = 0.575

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(424021020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 23 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 23)

				if (23 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 23)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021020", "story_v_out_424021.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021020", "story_v_out_424021.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_424021", "424021020", "story_v_out_424021.awb")

						arg_83_1:RecordAudio("424021020", var_86_12)
						arg_83_1:RecordAudio("424021020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_424021", "424021020", "story_v_out_424021.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_424021", "424021020", "story_v_out_424021.awb")
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
				actorName = "1037",
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
	Play424021021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 424021021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play424021022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1037"]) and arg_87_1.var_.actorSpriteComps1037 == nil then
				arg_87_1.var_.actorSpriteComps1037 = arg_87_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1037"]) then
				if arg_87_1.var_.actorSpriteComps1037 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1037"]) and arg_87_1.var_.actorSpriteComps1037 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps1037 = nil
			end

			local var_90_2 = arg_87_1.actors_["1037"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1037 = var_90_2.localPosition
				var_90_2.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1037", 7)

				for iter_90_4 = 0, var_90_2.childCount - 1 do
					local var_90_3 = var_90_2:GetChild(iter_90_4)

					if var_90_3.name == "" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				var_90_2.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_87_1.time_ - 0) / var_90_4)
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				var_90_2.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_90_5 = 0
			local var_90_6 = 0.925

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(424021021).content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 37 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_7) / 37)

				if (37 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_7) / 37)) > 0 and var_90_6 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_10 and arg_87_1.time_ < var_90_5 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play424021022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 424021022
		arg_91_1.duration_ = 7.6

		local var_91_0 = {
			zh = 6,
			ja = 7.6
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
				arg_91_0:Play424021023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1037"]) and arg_91_1.var_.actorSpriteComps1037 == nil then
				arg_91_1.var_.actorSpriteComps1037 = arg_91_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1037"]) then
				if arg_91_1.var_.actorSpriteComps1037 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								iter_94_1.color = Color.New(Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_0), Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_0), (Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_0)))
							else
								local var_94_1 = Mathf.Lerp(iter_94_1.color.r, 1, (arg_91_1.time_ - 0) / var_94_0)

								iter_94_1.color = Color.New(var_94_1, var_94_1, var_94_1)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1037"]) and arg_91_1.var_.actorSpriteComps1037 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps1037 = nil
			end

			local var_94_2 = arg_91_1.actors_["1037"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1037 = var_94_2.localPosition
				var_94_2.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1037", 3)

				for iter_94_4 = 0, var_94_2.childCount - 1 do
					local var_94_3 = var_94_2:GetChild(iter_94_4)

					if var_94_3.name == "split_1" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_91_1.time_ - 0) / var_94_4)
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_94_5 = 0
			local var_94_6 = 0.7

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(424021022)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 28 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 28)

				if (28 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 28)) > 0 and var_94_6 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021022", "story_v_out_424021.awb") ~= 0 then
					local var_94_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021022", "story_v_out_424021.awb") / 1000

					if var_94_11 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_5
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_424021", "424021022", "story_v_out_424021.awb")

						arg_91_1:RecordAudio("424021022", var_94_12)
						arg_91_1:RecordAudio("424021022", var_94_12)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_424021", "424021022", "story_v_out_424021.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_424021", "424021022", "story_v_out_424021.awb")
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
				actorName = "1037",
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
	Play424021023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 424021023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play424021024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1037"]) and arg_95_1.var_.actorSpriteComps1037 == nil then
				arg_95_1.var_.actorSpriteComps1037 = arg_95_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1037"]) then
				if arg_95_1.var_.actorSpriteComps1037 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								iter_98_1.color = Color.New(Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_0), Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_0), (Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_0)))
							else
								local var_98_1 = Mathf.Lerp(iter_98_1.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_0)

								iter_98_1.color = Color.New(var_98_1, var_98_1, var_98_1)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1037"]) and arg_95_1.var_.actorSpriteComps1037 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_98_3 then
						iter_98_3.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps1037 = nil
			end

			local var_98_2 = 0
			local var_98_3 = 0.875

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_4 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(424021023).content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 35 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 35)

				if (35 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 35)) > 0 and var_98_3 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_7 and arg_95_1.time_ < var_98_2 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play424021024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 424021024
		arg_99_1.duration_ = 11.77

		local var_99_0 = {
			zh = 8.466,
			ja = 11.766
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
				arg_99_0:Play424021025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1037"]) and arg_99_1.var_.actorSpriteComps1037 == nil then
				arg_99_1.var_.actorSpriteComps1037 = arg_99_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1037"]) then
				if arg_99_1.var_.actorSpriteComps1037 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 1, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1037"]) and arg_99_1.var_.actorSpriteComps1037 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps1037 = nil
			end

			local var_102_2 = arg_99_1.actors_["1037"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1037 = var_102_2.localPosition
				var_102_2.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1037", 3)

				for iter_102_4 = 0, var_102_2.childCount - 1 do
					local var_102_3 = var_102_2:GetChild(iter_102_4)

					if var_102_3.name == "split_1" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_2.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_99_1.time_ - 0) / var_102_4)
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_102_5 = 0
			local var_102_6 = 1.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_7 = arg_99_1:GetWordFromCfg(424021024)
				local var_102_8 = arg_99_1:FormatText(var_102_7.content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 44 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 44)

				if (44 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 44)) > 0 and var_102_6 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021024", "story_v_out_424021.awb") ~= 0 then
					local var_102_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021024", "story_v_out_424021.awb") / 1000

					if var_102_11 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_5
					end

					if var_102_7.prefab_name ~= "" and arg_99_1.actors_[var_102_7.prefab_name] ~= nil then
						local var_102_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_7.prefab_name].transform, "story_v_out_424021", "424021024", "story_v_out_424021.awb")

						arg_99_1:RecordAudio("424021024", var_102_12)
						arg_99_1:RecordAudio("424021024", var_102_12)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_424021", "424021024", "story_v_out_424021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_424021", "424021024", "story_v_out_424021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_13 = math.max(var_102_6, arg_99_1.talkMaxDuration)

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_13 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_5) / var_102_13

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_5 + var_102_13 and arg_99_1.time_ < var_102_5 + var_102_13 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play424021025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 424021025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play424021026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1037"]) and arg_103_1.var_.actorSpriteComps1037 == nil then
				arg_103_1.var_.actorSpriteComps1037 = arg_103_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1037"]) then
				if arg_103_1.var_.actorSpriteComps1037 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1037"]) and arg_103_1.var_.actorSpriteComps1037 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps1037 = nil
			end

			local var_106_2 = 0
			local var_106_3 = 0.275

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_4 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(424021025).content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_6 = 11 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_4) / 11)

				if (11 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_4) / 11)) > 0 and var_106_3 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_7 and arg_103_1.time_ < var_106_2 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play424021026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424021026
		arg_107_1.duration_ = 13.23

		local var_107_0 = {
			zh = 10.433,
			ja = 13.233
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
				arg_107_0:Play424021027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1037"]) and arg_107_1.var_.actorSpriteComps1037 == nil then
				arg_107_1.var_.actorSpriteComps1037 = arg_107_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1037"]) then
				if arg_107_1.var_.actorSpriteComps1037 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 1, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1037"]) and arg_107_1.var_.actorSpriteComps1037 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps1037 = nil
			end

			local var_110_2 = arg_107_1.actors_["1037"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1037 = var_110_2.localPosition
				var_110_2.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1037", 3)

				for iter_110_4 = 0, var_110_2.childCount - 1 do
					local var_110_3 = var_110_2:GetChild(iter_110_4)

					if var_110_3.name == "split_6" then
						var_110_3:SetAsLastSibling()
						var_110_3.gameObject:SetActive(true)

						arg_107_1.var_.actorSpriteSplit1037 = var_110_3.gameObject:GetComponent(typeof(Image))

						arg_107_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_110_4 = 0.5

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_107_1.time_ - 0) / var_110_4)

				if arg_107_1.var_.actorSpriteSplit1037 ~= nil then
					arg_107_1.var_.actorSpriteSplit1037:SetAlpha((arg_107_1.time_ - 0) / var_110_4)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(0, -430, -55)

				if arg_107_1.var_.actorSpriteSplit1037 ~= nil then
					arg_107_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_110_5 = 0
			local var_110_6 = 1.075

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:GetWordFromCfg(424021026)
				local var_110_8 = arg_107_1:FormatText(var_110_7.content)

				arg_107_1.text_.text = var_110_8

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 43 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 43)

				if (43 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 43)) > 0 and var_110_6 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_8
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021026", "story_v_out_424021.awb") ~= 0 then
					local var_110_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021026", "story_v_out_424021.awb") / 1000

					if var_110_11 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_5
					end

					if var_110_7.prefab_name ~= "" and arg_107_1.actors_[var_110_7.prefab_name] ~= nil then
						local var_110_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_7.prefab_name].transform, "story_v_out_424021", "424021026", "story_v_out_424021.awb")

						arg_107_1:RecordAudio("424021026", var_110_12)
						arg_107_1:RecordAudio("424021026", var_110_12)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_424021", "424021026", "story_v_out_424021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_424021", "424021026", "story_v_out_424021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_13 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_13 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_13

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_13 and arg_107_1.time_ < var_110_5 + var_110_13 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play424021027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424021027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play424021028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1037"]) and arg_111_1.var_.actorSpriteComps1037 == nil then
				arg_111_1.var_.actorSpriteComps1037 = arg_111_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1037"]) then
				if arg_111_1.var_.actorSpriteComps1037 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1037"]) and arg_111_1.var_.actorSpriteComps1037 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps1037 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.65

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_4 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(424021027).content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 26 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 26)

				if (26 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 26)) > 0 and var_114_3 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_7 and arg_111_1.time_ < var_114_2 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play424021028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424021028
		arg_115_1.duration_ = 5.77

		local var_115_0 = {
			zh = 4.666,
			ja = 5.766
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
				arg_115_0:Play424021029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1037 = arg_115_1.actors_["1037"].transform.localPosition
				arg_115_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1037", 7)

				for iter_118_0 = 0, arg_115_1.actors_["1037"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1037"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_118_2 = 0
			local var_118_3 = 0.575

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_4 = arg_115_1:GetWordFromCfg(424021028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 23 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 23)

				if (23 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 23)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021028", "story_v_out_424021.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_424021", "424021028", "story_v_out_424021.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_424021", "424021028", "story_v_out_424021.awb")

						arg_115_1:RecordAudio("424021028", var_118_9)
						arg_115_1:RecordAudio("424021028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_424021", "424021028", "story_v_out_424021.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_424021", "424021028", "story_v_out_424021.awb")
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

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play424021029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424021029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play424021030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(424021029).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 8 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 8)

				if (8 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 8)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play424021030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424021030
		arg_123_1.duration_ = 6.57

		local var_123_0 = {
			zh = 6.1,
			ja = 6.566
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play424021031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["1047"] == nil then
				local var_126_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_126_0) then
					local var_126_1 = Object.Instantiate(var_126_0, arg_123_1.canvasGo_.transform)

					var_126_1.transform:SetSiblingIndex(1)

					var_126_1.name = "1047"
					var_126_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_123_1.actors_["1047"] = var_126_1

					if arg_123_1.isInRecall_ then
						for iter_126_0, iter_126_1 in ipairs((var_126_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_126_1.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_126_2 = arg_123_1.actors_["1047"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1047 == nil then
				arg_123_1.var_.actorSpriteComps1047 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps1047 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								iter_126_3.color = Color.New(Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_3.color.r, 1, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_3.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1047 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_126_5 then
						iter_126_5.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps1047 = nil
			end

			local var_126_5 = arg_123_1.actors_["1047"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1047 = var_126_5.localPosition
				var_126_5.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1047", 3)

				for iter_126_6 = 0, var_126_5.childCount - 1 do
					local var_126_6 = var_126_5:GetChild(iter_126_6)

					if var_126_6.name == "split_4" or not string.find(var_126_6.name, "split") then
						var_126_6.gameObject:SetActive(true)
					else
						var_126_6.gameObject:SetActive(false)
					end
				end
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_123_1.time_ - 0) / var_126_7)
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_8 = arg_123_1.actors_["1047"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_8 then
					arg_123_1.var_.alphaOldValue1047 = var_126_8.alpha
					arg_123_1.var_.characterEffect1047 = var_126_8
				end

				arg_123_1.var_.alphaOldValue1047 = 0
			end

			local var_126_9 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 then
				if arg_123_1.var_.characterEffect1047 then
					arg_123_1.var_.characterEffect1047.alpha = Mathf.Lerp(arg_123_1.var_.alphaOldValue1047, 1, (arg_123_1.time_ - 0) / var_126_9)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and arg_123_1.var_.characterEffect1047 then
				arg_123_1.var_.characterEffect1047.alpha = 1
			end

			local var_126_10 = 0
			local var_126_11 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_12 = arg_123_1:GetWordFromCfg(424021030)
				local var_126_13 = arg_123_1:FormatText(var_126_12.content)

				arg_123_1.text_.text = var_126_13

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 24 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 24)

				if (24 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 24)) > 0 and var_126_11 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_13
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021030", "story_v_out_424021.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_424021", "424021030", "story_v_out_424021.awb") / 1000

					if var_126_16 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_10
					end

					if var_126_12.prefab_name ~= "" and arg_123_1.actors_[var_126_12.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_12.prefab_name].transform, "story_v_out_424021", "424021030", "story_v_out_424021.awb")

						arg_123_1:RecordAudio("424021030", var_126_17)
						arg_123_1:RecordAudio("424021030", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_424021", "424021030", "story_v_out_424021.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_424021", "424021030", "story_v_out_424021.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_10) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_10 + var_126_18 and arg_123_1.time_ < var_126_10 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424021031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424021031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424021032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1047"]) and arg_127_1.var_.actorSpriteComps1047 == nil then
				arg_127_1.var_.actorSpriteComps1047 = arg_127_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1047"]) then
				if arg_127_1.var_.actorSpriteComps1047 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1047"]) and arg_127_1.var_.actorSpriteComps1047 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1047 = nil
			end

			local var_130_2 = 0
			local var_130_3 = 0.525

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
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

				local var_130_4 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(424021031).content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 21 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 21)

				if (21 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 21)) > 0 and var_130_3 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_7 and arg_127_1.time_ < var_130_2 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424021032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424021032
		arg_131_1.duration_ = 5.13

		local var_131_0 = {
			zh = 4.3,
			ja = 5.133
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
				arg_131_0:Play424021033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1047"]) and arg_131_1.var_.actorSpriteComps1047 == nil then
				arg_131_1.var_.actorSpriteComps1047 = arg_131_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1047"]) then
				if arg_131_1.var_.actorSpriteComps1047 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1047"]) and arg_131_1.var_.actorSpriteComps1047 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1047 = nil
			end

			local var_134_2 = arg_131_1.actors_["1047"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1047 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1047", 3)

				for iter_134_4 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_4)

					if var_134_3.name == "split_6" then
						var_134_3:SetAsLastSibling()
						var_134_3.gameObject:SetActive(true)

						arg_131_1.var_.actorSpriteSplit1047 = var_134_3.gameObject:GetComponent(typeof(Image))

						arg_131_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_134_4 = 0.5

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_131_1.time_ - 0) / var_134_4)

				if arg_131_1.var_.actorSpriteSplit1047 ~= nil then
					arg_131_1.var_.actorSpriteSplit1047:SetAlpha((arg_131_1.time_ - 0) / var_134_4)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(-38.9, -360, -319.3)

				if arg_131_1.var_.actorSpriteSplit1047 ~= nil then
					arg_131_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_134_5 = 0
			local var_134_6 = 0.475

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(424021032)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 19 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 19)

				if (19 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 19)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021032", "story_v_out_424021.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021032", "story_v_out_424021.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_424021", "424021032", "story_v_out_424021.awb")

						arg_131_1:RecordAudio("424021032", var_134_12)
						arg_131_1:RecordAudio("424021032", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424021", "424021032", "story_v_out_424021.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424021", "424021032", "story_v_out_424021.awb")
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
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play424021033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424021033
		arg_135_1.duration_ = 8

		local var_135_0 = {
			zh = 6.966,
			ja = 8
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
				arg_135_0:Play424021034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1037"]) and arg_135_1.var_.actorSpriteComps1037 == nil then
				arg_135_1.var_.actorSpriteComps1037 = arg_135_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1037"]) then
				if arg_135_1.var_.actorSpriteComps1037 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 1, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1037"]) and arg_135_1.var_.actorSpriteComps1037 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1037 = nil
			end

			local var_138_2 = arg_135_1.actors_["1047"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1047 == nil then
				arg_135_1.var_.actorSpriteComps1047 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1047 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_138_5 then
							if arg_135_1.isInRecall_ then
								iter_138_5.color = Color.New(Mathf.Lerp(iter_138_5.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_5.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_5.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_5.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_5.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1047 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_138_7 then
						iter_138_7.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1047 = nil
			end

			local var_138_5 = arg_135_1.actors_["1047"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1047 = var_138_5.localPosition
				var_138_5.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1047", 2)

				for iter_138_8 = 0, var_138_5.childCount - 1 do
					local var_138_6 = var_138_5:GetChild(iter_138_8)

					if var_138_6.name == "split_6" or not string.find(var_138_6.name, "split") then
						var_138_6.gameObject:SetActive(true)
					else
						var_138_6.gameObject:SetActive(false)
					end
				end
			end

			local var_138_7 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_135_1.time_ - 0) / var_138_7)
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_138_8 = arg_135_1.actors_["1037"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1037 = var_138_8.localPosition
				var_138_8.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1037", 4)

				for iter_138_9 = 0, var_138_8.childCount - 1 do
					local var_138_9 = var_138_8:GetChild(iter_138_9)

					if var_138_9.name == "split_1" or not string.find(var_138_9.name, "split") then
						var_138_9.gameObject:SetActive(true)
					else
						var_138_9.gameObject:SetActive(false)
					end
				end
			end

			local var_138_10 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_10 then
				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_135_1.time_ - 0) / var_138_10)
			end

			if arg_135_1.time_ >= 0 + var_138_10 and arg_135_1.time_ < 0 + var_138_10 + arg_138_0 then
				var_138_8.localPosition = Vector3.New(390, -430, -55)
			end

			local var_138_11 = 0
			local var_138_12 = 0.85

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(424021033)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 34 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 34)

				if (34 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 34)) > 0 and var_138_12 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021033", "story_v_out_424021.awb") ~= 0 then
					local var_138_17 = manager.audio:GetVoiceLength("story_v_out_424021", "424021033", "story_v_out_424021.awb") / 1000

					if var_138_17 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_11
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_424021", "424021033", "story_v_out_424021.awb")

						arg_135_1:RecordAudio("424021033", var_138_18)
						arg_135_1:RecordAudio("424021033", var_138_18)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424021", "424021033", "story_v_out_424021.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424021", "424021033", "story_v_out_424021.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_19 and arg_135_1.time_ < var_138_11 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
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
	Play424021034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424021034
		arg_139_1.duration_ = 7.73

		local var_139_0 = {
			zh = 5.4,
			ja = 7.733
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
				arg_139_0:Play424021035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1047"]) and arg_139_1.var_.actorSpriteComps1047 == nil then
				arg_139_1.var_.actorSpriteComps1047 = arg_139_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1047"]) then
				if arg_139_1.var_.actorSpriteComps1047 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1047"]) and arg_139_1.var_.actorSpriteComps1047 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1047 = nil
			end

			local var_142_2 = arg_139_1.actors_["1037"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1037 == nil then
				arg_139_1.var_.actorSpriteComps1037 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1037 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								iter_142_5.color = Color.New(Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_5.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_5.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1037 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_142_7 then
						iter_142_7.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1037 = nil
			end

			local var_142_5 = arg_139_1.actors_["1047"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1047 = var_142_5.localPosition
				var_142_5.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1047", 2)

				for iter_142_8 = 0, var_142_5.childCount - 1 do
					local var_142_6 = var_142_5:GetChild(iter_142_8)

					if var_142_6.name == "split_4" then
						var_142_6:SetAsLastSibling()
						var_142_6.gameObject:SetActive(true)

						arg_139_1.var_.actorSpriteSplit1047 = var_142_6.gameObject:GetComponent(typeof(Image))

						arg_139_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_142_7 = 0.5

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_139_1.time_ - 0) / var_142_7)

				if arg_139_1.var_.actorSpriteSplit1047 ~= nil then
					arg_139_1.var_.actorSpriteSplit1047:SetAlpha((arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(-489.8, -360, -319.3)

				if arg_139_1.var_.actorSpriteSplit1047 ~= nil then
					arg_139_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_142_8 = 0
			local var_142_9 = 0.525

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(424021034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 21 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 21)

				if (21 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 21)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021034", "story_v_out_424021.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021034", "story_v_out_424021.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_424021", "424021034", "story_v_out_424021.awb")

						arg_139_1:RecordAudio("424021034", var_142_15)
						arg_139_1:RecordAudio("424021034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_424021", "424021034", "story_v_out_424021.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_424021", "424021034", "story_v_out_424021.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play424021035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424021035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play424021036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1047"]) and arg_143_1.var_.actorSpriteComps1047 == nil then
				arg_143_1.var_.actorSpriteComps1047 = arg_143_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1047"]) then
				if arg_143_1.var_.actorSpriteComps1047 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1047"]) and arg_143_1.var_.actorSpriteComps1047 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps1047 = nil
			end

			local var_146_2 = 0
			local var_146_3 = 0.825

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_4 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(424021035).content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 33 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_4) / 33)

				if (33 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_4) / 33)) > 0 and var_146_3 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_7 and arg_143_1.time_ < var_146_2 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424021036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424021036
		arg_147_1.duration_ = 6.33

		local var_147_0 = {
			zh = 5.133,
			ja = 6.333
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
				arg_147_0:Play424021037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1047"]) and arg_147_1.var_.actorSpriteComps1047 == nil then
				arg_147_1.var_.actorSpriteComps1047 = arg_147_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1047"]) then
				if arg_147_1.var_.actorSpriteComps1047 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1047"]) and arg_147_1.var_.actorSpriteComps1047 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1047 = nil
			end

			local var_150_2 = arg_147_1.actors_["1047"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1047", 2)

				for iter_150_4 = 0, var_150_2.childCount - 1 do
					local var_150_3 = var_150_2:GetChild(iter_150_4)

					if var_150_3.name == "split_1" then
						var_150_3:SetAsLastSibling()
						var_150_3.gameObject:SetActive(true)

						arg_147_1.var_.actorSpriteSplit1047 = var_150_3.gameObject:GetComponent(typeof(Image))

						arg_147_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_150_4 = 0.5

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_147_1.time_ - 0) / var_150_4)

				if arg_147_1.var_.actorSpriteSplit1047 ~= nil then
					arg_147_1.var_.actorSpriteSplit1047:SetAlpha((arg_147_1.time_ - 0) / var_150_4)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(-489.8, -360, -319.3)

				if arg_147_1.var_.actorSpriteSplit1047 ~= nil then
					arg_147_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_150_5 = 0
			local var_150_6 = 0.675

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(424021036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 27 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 27)

				if (27 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 27)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021036", "story_v_out_424021.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021036", "story_v_out_424021.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_424021", "424021036", "story_v_out_424021.awb")

						arg_147_1:RecordAudio("424021036", var_150_12)
						arg_147_1:RecordAudio("424021036", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_424021", "424021036", "story_v_out_424021.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_424021", "424021036", "story_v_out_424021.awb")
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
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play424021037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424021037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play424021038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1047"]) and arg_151_1.var_.actorSpriteComps1047 == nil then
				arg_151_1.var_.actorSpriteComps1047 = arg_151_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1047"]) then
				if arg_151_1.var_.actorSpriteComps1047 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1047"]) and arg_151_1.var_.actorSpriteComps1047 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1047 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.45

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(424021037).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 18 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 18)

				if (18 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 18)) > 0 and var_154_3 < var_154_6 then
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

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play424021038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424021038
		arg_155_1.duration_ = 5.57

		local var_155_0 = {
			zh = 3.933,
			ja = 5.566
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
				arg_155_0:Play424021039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1037"]) and arg_155_1.var_.actorSpriteComps1037 == nil then
				arg_155_1.var_.actorSpriteComps1037 = arg_155_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1037"]) then
				if arg_155_1.var_.actorSpriteComps1037 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 1, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1037"]) and arg_155_1.var_.actorSpriteComps1037 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1037 = nil
			end

			local var_158_2 = arg_155_1.actors_["1037"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1037 = var_158_2.localPosition
				var_158_2.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1037", 4)

				for iter_158_4 = 0, var_158_2.childCount - 1 do
					local var_158_3 = var_158_2:GetChild(iter_158_4)

					if var_158_3.name == "split_1" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				var_158_2.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_155_1.time_ - 0) / var_158_4)
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				var_158_2.localPosition = Vector3.New(390, -430, -55)
			end

			local var_158_5 = 0
			local var_158_6 = 0.45

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(424021038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_10 = 18 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 18)

				if (18 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 18)) > 0 and var_158_6 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021038", "story_v_out_424021.awb") ~= 0 then
					local var_158_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021038", "story_v_out_424021.awb") / 1000

					if var_158_11 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_5
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_424021", "424021038", "story_v_out_424021.awb")

						arg_155_1:RecordAudio("424021038", var_158_12)
						arg_155_1:RecordAudio("424021038", var_158_12)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424021", "424021038", "story_v_out_424021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424021", "424021038", "story_v_out_424021.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play424021039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424021039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play424021040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1037"]) and arg_159_1.var_.actorSpriteComps1037 == nil then
				arg_159_1.var_.actorSpriteComps1037 = arg_159_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1037"]) then
				if arg_159_1.var_.actorSpriteComps1037 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1037"]) and arg_159_1.var_.actorSpriteComps1037 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1037 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 0.4

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(424021039).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 16 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 16)

				if (16 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 16)) > 0 and var_162_3 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_7 and arg_159_1.time_ < var_162_2 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play424021040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424021040
		arg_163_1.duration_ = 8.2

		local var_163_0 = {
			zh = 5.433,
			ja = 8.2
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
				arg_163_0:Play424021041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1047"]) and arg_163_1.var_.actorSpriteComps1047 == nil then
				arg_163_1.var_.actorSpriteComps1047 = arg_163_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1047"]) then
				if arg_163_1.var_.actorSpriteComps1047 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1047"]) and arg_163_1.var_.actorSpriteComps1047 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1047 = nil
			end

			local var_166_2 = arg_163_1.actors_["1047"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1047 = var_166_2.localPosition
				var_166_2.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1047", 2)

				for iter_166_4 = 0, var_166_2.childCount - 1 do
					local var_166_3 = var_166_2:GetChild(iter_166_4)

					if var_166_3.name == "" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_2.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_163_1.time_ - 0) / var_166_4)
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_2.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_166_5 = 0
			local var_166_6 = 0.65

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(424021040)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 26 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 26)

				if (26 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 26)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021040", "story_v_out_424021.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021040", "story_v_out_424021.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_424021", "424021040", "story_v_out_424021.awb")

						arg_163_1:RecordAudio("424021040", var_166_12)
						arg_163_1:RecordAudio("424021040", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_424021", "424021040", "story_v_out_424021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_424021", "424021040", "story_v_out_424021.awb")
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
				actorName = "1047",
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
	Play424021041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424021041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play424021042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1047"]) and arg_167_1.var_.actorSpriteComps1047 == nil then
				arg_167_1.var_.actorSpriteComps1047 = arg_167_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1047"]) then
				if arg_167_1.var_.actorSpriteComps1047 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1047"]) and arg_167_1.var_.actorSpriteComps1047 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1047 = nil
			end

			local var_170_2 = 0
			local var_170_3 = 0.45

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_4 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(424021041).content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 18 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 18)

				if (18 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 18)) > 0 and var_170_3 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_7 and arg_167_1.time_ < var_170_2 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play424021042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424021042
		arg_171_1.duration_ = 9

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play424021043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if arg_171_1.bgs_.ST34 == nil then
				local var_174_0 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST34")
				var_174_0.name = "ST34"
				var_174_0.transform.parent = arg_171_1.stage_.transform
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_.ST34 = var_174_0
			end

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 then
				local var_174_1 = arg_171_1.bgs_.ST34

				arg_171_1.bgs_.ST34.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_2 = var_174_1:GetComponent("SpriteRenderer")

				if var_174_2 and var_174_2.sprite then
					local var_174_3 = 2 * (var_174_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_1.transform.localScale = Vector3.New(var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "ST34" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_4 = 3.999999999999

			if 3.999999999999 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_4 + 0.3 and arg_171_1.time_ < var_174_4 + 0.3 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_5 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_6 = 2

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 then
				local var_174_7 = Color.New(0, 0, 0)

				var_174_7.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_5) / var_174_6)
				arg_171_1.mask_.color = var_174_7
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 then
				local var_174_8 = Color.New(0, 0, 0)

				var_174_8.a = 1
				arg_171_1.mask_.color = var_174_8
			end

			local var_174_9 = 2

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_10 = 2

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 then
				local var_174_11 = Color.New(0, 0, 0)

				var_174_11.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_9) / var_174_10)
				arg_171_1.mask_.color = var_174_11
			end

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 then
				local var_174_12 = Color.New(0, 0, 0)

				arg_171_1.mask_.enabled = false
				var_174_12.a = 0
				arg_171_1.mask_.color = var_174_12
			end

			local var_174_13 = arg_171_1.actors_["1047"].transform

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 then
				arg_171_1.var_.moveOldPos1047 = var_174_13.localPosition
				var_174_13.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1047", 7)

				for iter_174_2 = 0, var_174_13.childCount - 1 do
					local var_174_14 = var_174_13:GetChild(iter_174_2)

					if var_174_14.name == "" or not string.find(var_174_14.name, "split") then
						var_174_14.gameObject:SetActive(true)
					else
						var_174_14.gameObject:SetActive(false)
					end
				end
			end

			local var_174_15 = 0.001

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_15 then
				var_174_13.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_171_1.time_ - 1.966) / var_174_15)
			end

			if arg_171_1.time_ >= 1.966 + var_174_15 and arg_171_1.time_ < 1.966 + var_174_15 + arg_174_0 then
				var_174_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_174_16 = arg_171_1.actors_["1037"].transform

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 then
				arg_171_1.var_.moveOldPos1037 = var_174_16.localPosition
				var_174_16.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1037", 7)

				for iter_174_3 = 0, var_174_16.childCount - 1 do
					local var_174_17 = var_174_16:GetChild(iter_174_3)

					if var_174_17.name == "" or not string.find(var_174_17.name, "split") then
						var_174_17.gameObject:SetActive(true)
					else
						var_174_17.gameObject:SetActive(false)
					end
				end
			end

			local var_174_18 = 0.001

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_18 then
				var_174_16.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1037, Vector3.New(0, -2000, 0), (arg_171_1.time_ - 1.966) / var_174_18)
			end

			if arg_171_1.time_ >= 1.966 + var_174_18 and arg_171_1.time_ < 1.966 + var_174_18 + arg_174_0 then
				var_174_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.233333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 0.233333333333333 + arg_174_0 then
				arg_171_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.6 < arg_171_1.time_ and arg_171_1.time_ <= 1.6 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_21 = 3.999999999999
			local var_174_22 = 0.475

			if 3.999999999999 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_23 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_23:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_24 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(424021042).content)

				arg_171_1.text_.text = var_174_24

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_26 = 19 <= 0 and var_174_22 or var_174_22 * (utf8.len(var_174_24) / 19)

				if (19 <= 0 and var_174_22 or var_174_22 * (utf8.len(var_174_24) / 19)) > 0 and var_174_22 < var_174_26 then
					arg_171_1.talkMaxDuration = var_174_26
					var_174_21 = var_174_21 + 0.3

					if var_174_26 + var_174_21 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_26 + var_174_21
					end
				end

				arg_171_1.text_.text = var_174_24
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_27 = var_174_21 + 0.3
			local var_174_28 = math.max(var_174_22, arg_171_1.talkMaxDuration)

			if var_174_21 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_27 + var_174_28 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_27) / var_174_28

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_27 + var_174_28 and arg_171_1.time_ < var_174_27 + var_174_28 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play424021043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 424021043
		arg_177_1.duration_ = 3.53

		local var_177_0 = {
			zh = 2.8,
			ja = 3.533
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
				arg_177_0:Play424021044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1047"]) and arg_177_1.var_.actorSpriteComps1047 == nil then
				arg_177_1.var_.actorSpriteComps1047 = arg_177_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1047"]) then
				if arg_177_1.var_.actorSpriteComps1047 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1047"]) and arg_177_1.var_.actorSpriteComps1047 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1047 = nil
			end

			local var_180_2 = arg_177_1.actors_["1047"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047 = var_180_2.localPosition
				var_180_2.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1047", 3)

				for iter_180_4 = 0, var_180_2.childCount - 1 do
					local var_180_3 = var_180_2:GetChild(iter_180_4)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_177_1.time_ - 0) / var_180_4)
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_180_5 = 0
			local var_180_6 = 0.3

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(424021043)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 12 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 12)

				if (12 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 12)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021043", "story_v_out_424021.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021043", "story_v_out_424021.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_424021", "424021043", "story_v_out_424021.awb")

						arg_177_1:RecordAudio("424021043", var_180_12)
						arg_177_1:RecordAudio("424021043", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_424021", "424021043", "story_v_out_424021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_424021", "424021043", "story_v_out_424021.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_13 and arg_177_1.time_ < var_180_5 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play424021044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 424021044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play424021045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1047"]) and arg_181_1.var_.actorSpriteComps1047 == nil then
				arg_181_1.var_.actorSpriteComps1047 = arg_181_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1047"]) then
				if arg_181_1.var_.actorSpriteComps1047 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1047"]) and arg_181_1.var_.actorSpriteComps1047 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1047 = nil
			end

			local var_184_2 = arg_181_1.actors_["1047"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1047 = var_184_2.localPosition
				var_184_2.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1047", 7)

				for iter_184_4 = 0, var_184_2.childCount - 1 do
					local var_184_3 = var_184_2:GetChild(iter_184_4)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_2.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_181_1.time_ - 0) / var_184_4)
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_181_1.time_ and arg_181_1.time_ <= 0.3 + arg_184_0 then
				arg_181_1:AudioAction("play", "effect", "se_story_145", "se_story_145_footstep", "")
			end

			local var_184_6 = 0
			local var_184_7 = 0.6

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(424021044).content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 24 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_8) / 24)

				if (24 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_8) / 24)) > 0 and var_184_7 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_11 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_11 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_11

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_11 and arg_181_1.time_ < var_184_6 + var_184_11 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play424021045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 424021045
		arg_185_1.duration_ = 9

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play424021046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if arg_185_1.bgs_.ST0106 == nil then
				local var_188_0 = Object.Instantiate(arg_185_1.paintGo_)

				var_188_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0106")
				var_188_0.name = "ST0106"
				var_188_0.transform.parent = arg_185_1.stage_.transform
				var_188_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_.ST0106 = var_188_0
			end

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				local var_188_1 = arg_185_1.bgs_.ST0106

				arg_185_1.bgs_.ST0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_2 = var_188_1:GetComponent("SpriteRenderer")

				if var_188_2 and var_188_2.sprite then
					local var_188_3 = 2 * (var_188_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_1.transform.localScale = Vector3.New(var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST0106" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_4 = 4

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_4 + 0.3 and arg_185_1.time_ < var_188_4 + 0.3 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_5 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_6 = 2

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_6 then
				local var_188_7 = Color.New(0, 0, 0)

				var_188_7.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_5) / var_188_6)
				arg_185_1.mask_.color = var_188_7
			end

			if arg_185_1.time_ >= var_188_5 + var_188_6 and arg_185_1.time_ < var_188_5 + var_188_6 + arg_188_0 then
				local var_188_8 = Color.New(0, 0, 0)

				var_188_8.a = 1
				arg_185_1.mask_.color = var_188_8
			end

			local var_188_9 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_10 = 2

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 then
				local var_188_11 = Color.New(0, 0, 0)

				var_188_11.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_9) / var_188_10)
				arg_185_1.mask_.color = var_188_11
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 then
				local var_188_12 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_12.a = 0
				arg_185_1.mask_.color = var_188_12
			end

			if 0.133333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 0.133333333333333 + arg_188_0 then
				arg_185_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			if 1.56666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.56666666666667 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= 4 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if 0.133333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 0.133333333333333 + arg_188_0 then
				arg_185_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_188_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_18 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_18

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_18
						arg_185_1.bgmTxt2_.text = var_188_18
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.56666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.56666666666667 + arg_188_0 then
				arg_185_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_188_21 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_21 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_21

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_21
						arg_185_1.bgmTxt2_.text = var_188_21
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_22 = 4
			local var_188_23 = 1

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_22 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_24 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_24:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_185_1.dialogCg_.alpha = arg_191_0
				end))
				var_188_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_25 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(424021045).content)

				arg_185_1.text_.text = var_188_25

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_27 = 40 <= 0 and var_188_23 or var_188_23 * (utf8.len(var_188_25) / 40)

				if (40 <= 0 and var_188_23 or var_188_23 * (utf8.len(var_188_25) / 40)) > 0 and var_188_23 < var_188_27 then
					arg_185_1.talkMaxDuration = var_188_27
					var_188_22 = var_188_22 + 0.3

					if var_188_27 + var_188_22 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_27 + var_188_22
					end
				end

				arg_185_1.text_.text = var_188_25
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_28 = var_188_22 + 0.3
			local var_188_29 = math.max(var_188_23, arg_185_1.talkMaxDuration)

			if var_188_22 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_28 + var_188_29 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_28) / var_188_29

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_28 + var_188_29 and arg_185_1.time_ < var_188_28 + var_188_29 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play424021046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 424021046
		arg_193_1.duration_ = 13.37

		local var_193_0 = {
			zh = 11.666,
			ja = 13.366
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
				arg_193_0:Play424021047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.3

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(424021046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 52 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 52)

				if (52 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 52)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021046", "story_v_out_424021.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021046", "story_v_out_424021.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_424021", "424021046", "story_v_out_424021.awb")

						arg_193_1:RecordAudio("424021046", var_196_6)
						arg_193_1:RecordAudio("424021046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_424021", "424021046", "story_v_out_424021.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_424021", "424021046", "story_v_out_424021.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play424021047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 424021047
		arg_197_1.duration_ = 20.87

		local var_197_0 = {
			zh = 16.633,
			ja = 20.866
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
				arg_197_0:Play424021048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.9

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(424021047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 76 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 76)

				if (76 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 76)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021047", "story_v_out_424021.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021047", "story_v_out_424021.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_424021", "424021047", "story_v_out_424021.awb")

						arg_197_1:RecordAudio("424021047", var_200_6)
						arg_197_1:RecordAudio("424021047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_424021", "424021047", "story_v_out_424021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_424021", "424021047", "story_v_out_424021.awb")
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
	Play424021048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 424021048
		arg_201_1.duration_ = 16.73

		local var_201_0 = {
			zh = 16.733,
			ja = 15.8
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
				arg_201_0:Play424021049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.825

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(424021048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 73 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 73)

				if (73 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 73)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021048", "story_v_out_424021.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021048", "story_v_out_424021.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_424021", "424021048", "story_v_out_424021.awb")

						arg_201_1:RecordAudio("424021048", var_204_6)
						arg_201_1:RecordAudio("424021048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_424021", "424021048", "story_v_out_424021.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_424021", "424021048", "story_v_out_424021.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play424021049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 424021049
		arg_205_1.duration_ = 18.93

		local var_205_0 = {
			zh = 18.666,
			ja = 18.933
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
				arg_205_0:Play424021050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.975

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1059].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(424021049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 80 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 80)

				if (80 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 80)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021049", "story_v_out_424021.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021049", "story_v_out_424021.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_424021", "424021049", "story_v_out_424021.awb")

						arg_205_1:RecordAudio("424021049", var_208_6)
						arg_205_1:RecordAudio("424021049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_424021", "424021049", "story_v_out_424021.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_424021", "424021049", "story_v_out_424021.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play424021050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 424021050
		arg_209_1.duration_ = 4.13

		local var_209_0 = {
			zh = 3,
			ja = 4.133
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
				arg_209_0:Play424021051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1047"]) and arg_209_1.var_.actorSpriteComps1047 == nil then
				arg_209_1.var_.actorSpriteComps1047 = arg_209_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1047"]) then
				if arg_209_1.var_.actorSpriteComps1047 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 1, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1047"]) and arg_209_1.var_.actorSpriteComps1047 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1047 = nil
			end

			local var_212_2 = arg_209_1.actors_["1047"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1047", 3)

				for iter_212_4 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_4)

					if var_212_3.name == "split_1" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_212_5 = 0
			local var_212_6 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(424021050)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 12 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 12)

				if (12 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 12)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021050", "story_v_out_424021.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021050", "story_v_out_424021.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_424021", "424021050", "story_v_out_424021.awb")

						arg_209_1:RecordAudio("424021050", var_212_12)
						arg_209_1:RecordAudio("424021050", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_424021", "424021050", "story_v_out_424021.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_424021", "424021050", "story_v_out_424021.awb")
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
				actorName = "1047",
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
	Play424021051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 424021051
		arg_213_1.duration_ = 3.7

		local var_213_0 = {
			zh = 1.7,
			ja = 3.7
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play424021052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.actors_["10153"] == nil then
				local var_216_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_216_0) then
					local var_216_1 = Object.Instantiate(var_216_0, arg_213_1.canvasGo_.transform)

					var_216_1.transform:SetSiblingIndex(1)

					var_216_1.name = "10153"
					var_216_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_213_1.actors_["10153"] = var_216_1

					if arg_213_1.isInRecall_ then
						for iter_216_0, iter_216_1 in ipairs((var_216_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_216_1.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_216_2 = arg_213_1.actors_["10153"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10153 == nil then
				arg_213_1.var_.actorSpriteComps10153 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10153 then
					for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_216_3 then
							if arg_213_1.isInRecall_ then
								iter_216_3.color = Color.New(Mathf.Lerp(iter_216_3.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_3.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_3.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_3.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_3.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10153 then
				for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_216_5 then
						iter_216_5.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10153 = nil
			end

			local var_216_5 = arg_213_1.actors_["1047"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.actorSpriteComps1047 == nil then
				arg_213_1.var_.actorSpriteComps1047 = var_216_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_6 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_6 and not isNil(var_216_5) then
				if arg_213_1.var_.actorSpriteComps1047 then
					for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_216_7 then
							if arg_213_1.isInRecall_ then
								iter_216_7.color = Color.New(Mathf.Lerp(iter_216_7.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_6), Mathf.Lerp(iter_216_7.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_6), (Mathf.Lerp(iter_216_7.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_6)))
							else
								local var_216_7 = Mathf.Lerp(iter_216_7.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_6)

								iter_216_7.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_6 and arg_213_1.time_ < 0 + var_216_6 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.actorSpriteComps1047 then
				for iter_216_8, iter_216_9 in pairs(arg_213_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_216_9 then
						iter_216_9.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1047 = nil
			end

			local var_216_8 = arg_213_1.actors_["1047"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047 = var_216_8.localPosition
				var_216_8.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1047", 2)

				for iter_216_10 = 0, var_216_8.childCount - 1 do
					local var_216_9 = var_216_8:GetChild(iter_216_10)

					if var_216_9.name == "" or not string.find(var_216_9.name, "split") then
						var_216_9.gameObject:SetActive(true)
					else
						var_216_9.gameObject:SetActive(false)
					end
				end
			end

			local var_216_10 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_10 then
				var_216_8.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_213_1.time_ - 0) / var_216_10)
			end

			if arg_213_1.time_ >= 0 + var_216_10 and arg_213_1.time_ < 0 + var_216_10 + arg_216_0 then
				var_216_8.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_216_11 = arg_213_1.actors_["10153"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10153 = var_216_11.localPosition
				var_216_11.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10153", 4)

				for iter_216_11 = 0, var_216_11.childCount - 1 do
					local var_216_12 = var_216_11:GetChild(iter_216_11)

					if var_216_12.name == "split_1" or not string.find(var_216_12.name, "split") then
						var_216_12.gameObject:SetActive(true)
					else
						var_216_12.gameObject:SetActive(false)
					end
				end
			end

			local var_216_13 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_13 then
				var_216_11.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_213_1.time_ - 0) / var_216_13)
			end

			if arg_213_1.time_ >= 0 + var_216_13 and arg_213_1.time_ < 0 + var_216_13 + arg_216_0 then
				var_216_11.localPosition = Vector3.New(400, -395, -330)
			end

			local var_216_14 = 0
			local var_216_15 = 0.225

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_16 = arg_213_1:GetWordFromCfg(424021051)
				local var_216_17 = arg_213_1:FormatText(var_216_16.content)

				arg_213_1.text_.text = var_216_17

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_19 = 9 <= 0 and var_216_15 or var_216_15 * (utf8.len(var_216_17) / 9)

				if (9 <= 0 and var_216_15 or var_216_15 * (utf8.len(var_216_17) / 9)) > 0 and var_216_15 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19

					if var_216_19 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_14
					end
				end

				arg_213_1.text_.text = var_216_17
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021051", "story_v_out_424021.awb") ~= 0 then
					local var_216_20 = manager.audio:GetVoiceLength("story_v_out_424021", "424021051", "story_v_out_424021.awb") / 1000

					if var_216_20 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_20 + var_216_14
					end

					if var_216_16.prefab_name ~= "" and arg_213_1.actors_[var_216_16.prefab_name] ~= nil then
						local var_216_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_16.prefab_name].transform, "story_v_out_424021", "424021051", "story_v_out_424021.awb")

						arg_213_1:RecordAudio("424021051", var_216_21)
						arg_213_1:RecordAudio("424021051", var_216_21)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_424021", "424021051", "story_v_out_424021.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_424021", "424021051", "story_v_out_424021.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = math.max(var_216_15, arg_213_1.talkMaxDuration)

			if var_216_14 <= arg_213_1.time_ and arg_213_1.time_ < var_216_14 + var_216_22 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_14) / var_216_22

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_14 + var_216_22 and arg_213_1.time_ < var_216_14 + var_216_22 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_213_1:InitPlayNodeList()
	end,
	Play424021052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 424021052
		arg_217_1.duration_ = 6.1

		local var_217_0 = {
			zh = 5.433,
			ja = 6.1
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
				arg_217_0:Play424021053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1047"]) and arg_217_1.var_.actorSpriteComps1047 == nil then
				arg_217_1.var_.actorSpriteComps1047 = arg_217_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1047"]) then
				if arg_217_1.var_.actorSpriteComps1047 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 1, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1047"]) and arg_217_1.var_.actorSpriteComps1047 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps1047 = nil
			end

			local var_220_2 = arg_217_1.actors_["10153"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10153 == nil then
				arg_217_1.var_.actorSpriteComps10153 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps10153 then
					for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_220_5 then
							if arg_217_1.isInRecall_ then
								iter_220_5.color = Color.New(Mathf.Lerp(iter_220_5.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_5.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_5.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_5.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_5.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10153 then
				for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_220_7 then
						iter_220_7.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps10153 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 0.875

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(424021052)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 35 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 35)

				if (35 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 35)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021052", "story_v_out_424021.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021052", "story_v_out_424021.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_424021", "424021052", "story_v_out_424021.awb")

						arg_217_1:RecordAudio("424021052", var_220_12)
						arg_217_1:RecordAudio("424021052", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_424021", "424021052", "story_v_out_424021.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_424021", "424021052", "story_v_out_424021.awb")
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

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play424021053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 424021053
		arg_221_1.duration_ = 4.07

		local var_221_0 = {
			zh = 3.466,
			ja = 4.066
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
				arg_221_0:Play424021054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10153"]) and arg_221_1.var_.actorSpriteComps10153 == nil then
				arg_221_1.var_.actorSpriteComps10153 = arg_221_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10153"]) then
				if arg_221_1.var_.actorSpriteComps10153 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 1, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10153"]) and arg_221_1.var_.actorSpriteComps10153 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10153 = nil
			end

			local var_224_2 = arg_221_1.actors_["1047"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1047 == nil then
				arg_221_1.var_.actorSpriteComps1047 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps1047 then
					for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_224_5 then
							if arg_221_1.isInRecall_ then
								iter_224_5.color = Color.New(Mathf.Lerp(iter_224_5.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_5.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_5.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_5.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_5.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1047 then
				for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_224_7 then
						iter_224_7.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1047 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.35

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(424021053)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 14 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 14)

				if (14 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 14)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021053", "story_v_out_424021.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021053", "story_v_out_424021.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_424021", "424021053", "story_v_out_424021.awb")

						arg_221_1:RecordAudio("424021053", var_224_12)
						arg_221_1:RecordAudio("424021053", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_424021", "424021053", "story_v_out_424021.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_424021", "424021053", "story_v_out_424021.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_13 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_13 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_13

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_13 and arg_221_1.time_ < var_224_5 + var_224_13 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play424021054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 424021054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play424021055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10153"]) and arg_225_1.var_.actorSpriteComps10153 == nil then
				arg_225_1.var_.actorSpriteComps10153 = arg_225_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10153"]) then
				if arg_225_1.var_.actorSpriteComps10153 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								iter_228_1.color = Color.New(Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_0), Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_0), (Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_0)))
							else
								local var_228_1 = Mathf.Lerp(iter_228_1.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_0)

								iter_228_1.color = Color.New(var_228_1, var_228_1, var_228_1)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10153"]) and arg_225_1.var_.actorSpriteComps10153 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10153 = nil
			end

			local var_228_2 = arg_225_1.actors_["10153"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10153 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10153", 7)

				for iter_228_4 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_4)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_228_5 = arg_225_1.actors_["1047"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047 = var_228_5.localPosition
				var_228_5.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1047", 7)

				for iter_228_5 = 0, var_228_5.childCount - 1 do
					local var_228_6 = var_228_5:GetChild(iter_228_5)

					if var_228_6.name == "" or not string.find(var_228_6.name, "split") then
						var_228_6.gameObject:SetActive(true)
					else
						var_228_6.gameObject:SetActive(false)
					end
				end
			end

			local var_228_7 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				var_228_5.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_225_1.time_ - 0) / var_228_7)
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				var_228_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_228_8 = 0
			local var_228_9 = 1.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_10 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(424021054).content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_12 = 57 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_10) / 57)

				if (57 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_10) / 57)) > 0 and var_228_9 < var_228_12 then
					arg_225_1.talkMaxDuration = var_228_12

					if var_228_12 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_13 and arg_225_1.time_ < var_228_8 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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
				actorName = "1047",
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
	Play424021055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 424021055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play424021056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.9

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

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(424021055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 36 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 36)

				if (36 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 36)) > 0 and var_232_0 < var_232_3 then
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
	Play424021056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 424021056
		arg_233_1.duration_ = 7.63

		local var_233_0 = {
			zh = 4.033,
			ja = 7.633
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
				arg_233_0:Play424021057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10153"]) and arg_233_1.var_.actorSpriteComps10153 == nil then
				arg_233_1.var_.actorSpriteComps10153 = arg_233_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10153"]) then
				if arg_233_1.var_.actorSpriteComps10153 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 1, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10153"]) and arg_233_1.var_.actorSpriteComps10153 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps10153 = nil
			end

			local var_236_2 = arg_233_1.actors_["10153"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10153 = var_236_2.localPosition
				var_236_2.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10153", 3)

				for iter_236_4 = 0, var_236_2.childCount - 1 do
					local var_236_3 = var_236_2:GetChild(iter_236_4)

					if var_236_3.name == "" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_2.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_233_1.time_ - 0) / var_236_4)
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_236_5 = 0
			local var_236_6 = 0.475

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_7 = arg_233_1:GetWordFromCfg(424021056)
				local var_236_8 = arg_233_1:FormatText(var_236_7.content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 19 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 19)

				if (19 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 19)) > 0 and var_236_6 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021056", "story_v_out_424021.awb") ~= 0 then
					local var_236_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021056", "story_v_out_424021.awb") / 1000

					if var_236_11 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_5
					end

					if var_236_7.prefab_name ~= "" and arg_233_1.actors_[var_236_7.prefab_name] ~= nil then
						local var_236_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_7.prefab_name].transform, "story_v_out_424021", "424021056", "story_v_out_424021.awb")

						arg_233_1:RecordAudio("424021056", var_236_12)
						arg_233_1:RecordAudio("424021056", var_236_12)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_424021", "424021056", "story_v_out_424021.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_424021", "424021056", "story_v_out_424021.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_6, arg_233_1.talkMaxDuration)

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_5) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_5 + var_236_13 and arg_233_1.time_ < var_236_5 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play424021057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 424021057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play424021058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10153"]) and arg_237_1.var_.actorSpriteComps10153 == nil then
				arg_237_1.var_.actorSpriteComps10153 = arg_237_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10153"]) then
				if arg_237_1.var_.actorSpriteComps10153 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								iter_240_1.color = Color.New(Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_0), Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_0), (Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_0)))
							else
								local var_240_1 = Mathf.Lerp(iter_240_1.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_0)

								iter_240_1.color = Color.New(var_240_1, var_240_1, var_240_1)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10153"]) and arg_237_1.var_.actorSpriteComps10153 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10153 = nil
			end

			local var_240_2 = 0
			local var_240_3 = 0.725

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_4 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(424021057).content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 29 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 29)

				if (29 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 29)) > 0 and var_240_3 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_7 and arg_237_1.time_ < var_240_2 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play424021058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 424021058
		arg_241_1.duration_ = 5.7

		local var_241_0 = {
			zh = 3.966,
			ja = 5.7
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
				arg_241_0:Play424021059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10153"]) and arg_241_1.var_.actorSpriteComps10153 == nil then
				arg_241_1.var_.actorSpriteComps10153 = arg_241_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10153"]) then
				if arg_241_1.var_.actorSpriteComps10153 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								iter_244_1.color = Color.New(Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_0), Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_0), (Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_0)))
							else
								local var_244_1 = Mathf.Lerp(iter_244_1.color.r, 1, (arg_241_1.time_ - 0) / var_244_0)

								iter_244_1.color = Color.New(var_244_1, var_244_1, var_244_1)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10153"]) and arg_241_1.var_.actorSpriteComps10153 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps10153 = nil
			end

			local var_244_2 = arg_241_1.actors_["10153"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10153 = var_244_2.localPosition
				var_244_2.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10153", 3)

				for iter_244_4 = 0, var_244_2.childCount - 1 do
					local var_244_3 = var_244_2:GetChild(iter_244_4)

					if var_244_3.name == "split_4" then
						var_244_3:SetAsLastSibling()
						var_244_3.gameObject:SetActive(true)

						arg_241_1.var_.actorSpriteSplit10153 = var_244_3.gameObject:GetComponent(typeof(Image))

						arg_241_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_244_4 = 0.5

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				var_244_2.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_241_1.time_ - 0) / var_244_4)

				if arg_241_1.var_.actorSpriteSplit10153 ~= nil then
					arg_241_1.var_.actorSpriteSplit10153:SetAlpha((arg_241_1.time_ - 0) / var_244_4)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				var_244_2.localPosition = Vector3.New(-60, -395, -330)

				if arg_241_1.var_.actorSpriteSplit10153 ~= nil then
					arg_241_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_244_5 = 0
			local var_244_6 = 0.325

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(424021058)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 13 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 13)

				if (13 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 13)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021058", "story_v_out_424021.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021058", "story_v_out_424021.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_424021", "424021058", "story_v_out_424021.awb")

						arg_241_1:RecordAudio("424021058", var_244_12)
						arg_241_1:RecordAudio("424021058", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_424021", "424021058", "story_v_out_424021.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_424021", "424021058", "story_v_out_424021.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_6, arg_241_1.talkMaxDuration)

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_5) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_5 + var_244_13 and arg_241_1.time_ < var_244_5 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play424021059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 424021059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play424021060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10153"]) and arg_245_1.var_.actorSpriteComps10153 == nil then
				arg_245_1.var_.actorSpriteComps10153 = arg_245_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10153"]) then
				if arg_245_1.var_.actorSpriteComps10153 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10153"]) and arg_245_1.var_.actorSpriteComps10153 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps10153 = nil
			end

			local var_248_2 = 0
			local var_248_3 = 0.925

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(424021059).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 37 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 37)

				if (37 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 37)) > 0 and var_248_3 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_7 and arg_245_1.time_ < var_248_2 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play424021060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 424021060
		arg_249_1.duration_ = 7.97

		local var_249_0 = {
			zh = 5.466,
			ja = 7.966
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
				arg_249_0:Play424021061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1047"]) and arg_249_1.var_.actorSpriteComps1047 == nil then
				arg_249_1.var_.actorSpriteComps1047 = arg_249_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1047"]) then
				if arg_249_1.var_.actorSpriteComps1047 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								iter_252_1.color = Color.New(Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_0), Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_0), (Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_0)))
							else
								local var_252_1 = Mathf.Lerp(iter_252_1.color.r, 1, (arg_249_1.time_ - 0) / var_252_0)

								iter_252_1.color = Color.New(var_252_1, var_252_1, var_252_1)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1047"]) and arg_249_1.var_.actorSpriteComps1047 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1047 = nil
			end

			local var_252_2 = arg_249_1.actors_["1047"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1047 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1047", 4)

				for iter_252_4 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_4)

					if var_252_3.name == "split_1" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1047, Vector3.New(483.1, -360, -319.3), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(483.1, -360, -319.3)
			end

			local var_252_5 = arg_249_1.actors_["10153"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10153 = var_252_5.localPosition
				var_252_5.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10153", 2)

				for iter_252_5 = 0, var_252_5.childCount - 1 do
					local var_252_6 = var_252_5:GetChild(iter_252_5)

					if var_252_6.name == "split_4" or not string.find(var_252_6.name, "split") then
						var_252_6.gameObject:SetActive(true)
					else
						var_252_6.gameObject:SetActive(false)
					end
				end
			end

			local var_252_7 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				var_252_5.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_249_1.time_ - 0) / var_252_7)
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				var_252_5.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_252_8 = 0
			local var_252_9 = 0.7

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(424021060)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 28 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 28)

				if (28 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 28)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021060", "story_v_out_424021.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021060", "story_v_out_424021.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_424021", "424021060", "story_v_out_424021.awb")

						arg_249_1:RecordAudio("424021060", var_252_15)
						arg_249_1:RecordAudio("424021060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_424021", "424021060", "story_v_out_424021.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_424021", "424021060", "story_v_out_424021.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_249_1:InitPlayNodeList()
	end,
	Play424021061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 424021061
		arg_253_1.duration_ = 1.8

		local var_253_0 = {
			zh = 1.3,
			ja = 1.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play424021062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10153"]) and arg_253_1.var_.actorSpriteComps10153 == nil then
				arg_253_1.var_.actorSpriteComps10153 = arg_253_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10153"]) then
				if arg_253_1.var_.actorSpriteComps10153 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 1, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10153"]) and arg_253_1.var_.actorSpriteComps10153 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10153 = nil
			end

			local var_256_2 = arg_253_1.actors_["1047"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1047 == nil then
				arg_253_1.var_.actorSpriteComps1047 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1047 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_5.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_5.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1047 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1047 = nil
			end

			local var_256_5 = arg_253_1.actors_["10153"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10153 = var_256_5.localPosition
				var_256_5.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10153", 2)

				for iter_256_8 = 0, var_256_5.childCount - 1 do
					local var_256_6 = var_256_5:GetChild(iter_256_8)

					if var_256_6.name == "split_1" then
						var_256_6:SetAsLastSibling()
						var_256_6.gameObject:SetActive(true)

						arg_253_1.var_.actorSpriteSplit10153 = var_256_6.gameObject:GetComponent(typeof(Image))

						arg_253_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_256_7 = 0.5

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				var_256_5.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_253_1.time_ - 0) / var_256_7)

				if arg_253_1.var_.actorSpriteSplit10153 ~= nil then
					arg_253_1.var_.actorSpriteSplit10153:SetAlpha((arg_253_1.time_ - 0) / var_256_7)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				var_256_5.localPosition = Vector3.New(-400, -395, -330)

				if arg_253_1.var_.actorSpriteSplit10153 ~= nil then
					arg_253_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_256_8 = 0
			local var_256_9 = 0.1

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(424021061)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 4 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 4)

				if (4 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 4)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021061", "story_v_out_424021.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021061", "story_v_out_424021.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_424021", "424021061", "story_v_out_424021.awb")

						arg_253_1:RecordAudio("424021061", var_256_15)
						arg_253_1:RecordAudio("424021061", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_424021", "424021061", "story_v_out_424021.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_424021", "424021061", "story_v_out_424021.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play424021062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 424021062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play424021063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10153"]) and arg_257_1.var_.actorSpriteComps10153 == nil then
				arg_257_1.var_.actorSpriteComps10153 = arg_257_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10153"]) then
				if arg_257_1.var_.actorSpriteComps10153 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10153"]) and arg_257_1.var_.actorSpriteComps10153 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10153 = nil
			end

			local var_260_2 = 0
			local var_260_3 = 0.3

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_4 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(424021062).content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 12 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 12)

				if (12 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 12)) > 0 and var_260_3 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_7 and arg_257_1.time_ < var_260_2 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play424021063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 424021063
		arg_261_1.duration_ = 8.13

		local var_261_0 = {
			zh = 6.466,
			ja = 8.133
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
				arg_261_0:Play424021064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["10153"]) and arg_261_1.var_.actorSpriteComps10153 == nil then
				arg_261_1.var_.actorSpriteComps10153 = arg_261_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["10153"]) then
				if arg_261_1.var_.actorSpriteComps10153 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								iter_264_1.color = Color.New(Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_0), Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_0), (Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_0)))
							else
								local var_264_1 = Mathf.Lerp(iter_264_1.color.r, 1, (arg_261_1.time_ - 0) / var_264_0)

								iter_264_1.color = Color.New(var_264_1, var_264_1, var_264_1)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10153"]) and arg_261_1.var_.actorSpriteComps10153 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10153 = nil
			end

			local var_264_2 = arg_261_1.actors_["10153"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10153 = var_264_2.localPosition
				var_264_2.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10153", 2)

				for iter_264_4 = 0, var_264_2.childCount - 1 do
					local var_264_3 = var_264_2:GetChild(iter_264_4)

					if var_264_3.name == "split_1" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_2.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_261_1.time_ - 0) / var_264_4)
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_264_5 = 0
			local var_264_6 = 0.625

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(424021063)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 25 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 25)

				if (25 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 25)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021063", "story_v_out_424021.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021063", "story_v_out_424021.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_424021", "424021063", "story_v_out_424021.awb")

						arg_261_1:RecordAudio("424021063", var_264_12)
						arg_261_1:RecordAudio("424021063", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_424021", "424021063", "story_v_out_424021.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_424021", "424021063", "story_v_out_424021.awb")
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
				actorName = "10153",
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
	Play424021064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 424021064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play424021065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["10153"]) and arg_265_1.var_.actorSpriteComps10153 == nil then
				arg_265_1.var_.actorSpriteComps10153 = arg_265_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["10153"]) then
				if arg_265_1.var_.actorSpriteComps10153 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["10153"]) and arg_265_1.var_.actorSpriteComps10153 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10153 = nil
			end

			local var_268_2 = 0
			local var_268_3 = 0.4

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_4 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(424021064).content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 16 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 16)

				if (16 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 16)) > 0 and var_268_3 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_7 and arg_265_1.time_ < var_268_2 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play424021065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 424021065
		arg_269_1.duration_ = 5.97

		local var_269_0 = {
			zh = 3.666,
			ja = 5.966
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
				arg_269_0:Play424021066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1047"]) and arg_269_1.var_.actorSpriteComps1047 == nil then
				arg_269_1.var_.actorSpriteComps1047 = arg_269_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1047"]) then
				if arg_269_1.var_.actorSpriteComps1047 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								iter_272_1.color = Color.New(Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_0), Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_0), (Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_0)))
							else
								local var_272_1 = Mathf.Lerp(iter_272_1.color.r, 1, (arg_269_1.time_ - 0) / var_272_0)

								iter_272_1.color = Color.New(var_272_1, var_272_1, var_272_1)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1047"]) and arg_269_1.var_.actorSpriteComps1047 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps1047 = nil
			end

			local var_272_2 = arg_269_1.actors_["1047"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1047 = var_272_2.localPosition
				var_272_2.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1047", 4)

				for iter_272_4 = 0, var_272_2.childCount - 1 do
					local var_272_3 = var_272_2:GetChild(iter_272_4)

					if var_272_3.name == "" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_2.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1047, Vector3.New(483.1, -360, -319.3), (arg_269_1.time_ - 0) / var_272_4)
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_2.localPosition = Vector3.New(483.1, -360, -319.3)
			end

			local var_272_5 = 0
			local var_272_6 = 0.4

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:GetWordFromCfg(424021065)
				local var_272_8 = arg_269_1:FormatText(var_272_7.content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 16 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 16)

				if (16 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 16)) > 0 and var_272_6 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021065", "story_v_out_424021.awb") ~= 0 then
					local var_272_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021065", "story_v_out_424021.awb") / 1000

					if var_272_11 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_5
					end

					if var_272_7.prefab_name ~= "" and arg_269_1.actors_[var_272_7.prefab_name] ~= nil then
						local var_272_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_7.prefab_name].transform, "story_v_out_424021", "424021065", "story_v_out_424021.awb")

						arg_269_1:RecordAudio("424021065", var_272_12)
						arg_269_1:RecordAudio("424021065", var_272_12)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_424021", "424021065", "story_v_out_424021.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_424021", "424021065", "story_v_out_424021.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_13 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_13 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_13

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_13 and arg_269_1.time_ < var_272_5 + var_272_13 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424021066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 424021066
		arg_273_1.duration_ = 9.5

		local var_273_0 = {
			zh = 6.733,
			ja = 9.5
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
				arg_273_0:Play424021067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 1.175

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(424021066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 47 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 47)

				if (47 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 47)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021066", "story_v_out_424021.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021066", "story_v_out_424021.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_424021", "424021066", "story_v_out_424021.awb")

						arg_273_1:RecordAudio("424021066", var_276_6)
						arg_273_1:RecordAudio("424021066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_424021", "424021066", "story_v_out_424021.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_424021", "424021066", "story_v_out_424021.awb")
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
	Play424021067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 424021067
		arg_277_1.duration_ = 11.23

		local var_277_0 = {
			zh = 7.133,
			ja = 11.233
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
				arg_277_0:Play424021068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10153"]) and arg_277_1.var_.actorSpriteComps10153 == nil then
				arg_277_1.var_.actorSpriteComps10153 = arg_277_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_0 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10153"]) then
				if arg_277_1.var_.actorSpriteComps10153 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								iter_280_1.color = Color.New(Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_0), Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_0), (Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_0)))
							else
								local var_280_1 = Mathf.Lerp(iter_280_1.color.r, 1, (arg_277_1.time_ - 0) / var_280_0)

								iter_280_1.color = Color.New(var_280_1, var_280_1, var_280_1)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10153"]) and arg_277_1.var_.actorSpriteComps10153 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10153 = nil
			end

			local var_280_2 = arg_277_1.actors_["1047"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1047 == nil then
				arg_277_1.var_.actorSpriteComps1047 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps1047 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_280_5 then
							if arg_277_1.isInRecall_ then
								iter_280_5.color = Color.New(Mathf.Lerp(iter_280_5.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_5.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_5.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_5.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_5.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1047 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_280_7 then
						iter_280_7.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps1047 = nil
			end

			local var_280_5 = arg_277_1.actors_["10153"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10153 = var_280_5.localPosition
				var_280_5.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10153", 2)

				for iter_280_8 = 0, var_280_5.childCount - 1 do
					local var_280_6 = var_280_5:GetChild(iter_280_8)

					if var_280_6.name == "" or not string.find(var_280_6.name, "split") then
						var_280_6.gameObject:SetActive(true)
					else
						var_280_6.gameObject:SetActive(false)
					end
				end
			end

			local var_280_7 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				var_280_5.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_277_1.time_ - 0) / var_280_7)
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				var_280_5.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_280_8 = 0
			local var_280_9 = 0.75

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_10 = arg_277_1:GetWordFromCfg(424021067)
				local var_280_11 = arg_277_1:FormatText(var_280_10.content)

				arg_277_1.text_.text = var_280_11

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 30 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 30)

				if (30 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 30)) > 0 and var_280_9 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_11
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021067", "story_v_out_424021.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021067", "story_v_out_424021.awb") / 1000

					if var_280_14 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_8
					end

					if var_280_10.prefab_name ~= "" and arg_277_1.actors_[var_280_10.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_10.prefab_name].transform, "story_v_out_424021", "424021067", "story_v_out_424021.awb")

						arg_277_1:RecordAudio("424021067", var_280_15)
						arg_277_1:RecordAudio("424021067", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_424021", "424021067", "story_v_out_424021.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_424021", "424021067", "story_v_out_424021.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_16 and arg_277_1.time_ < var_280_8 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play424021068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 424021068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play424021069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10153"]) and arg_281_1.var_.actorSpriteComps10153 == nil then
				arg_281_1.var_.actorSpriteComps10153 = arg_281_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10153"]) then
				if arg_281_1.var_.actorSpriteComps10153 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10153"]) and arg_281_1.var_.actorSpriteComps10153 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10153 = nil
			end

			local var_284_2 = 0
			local var_284_3 = 0.625

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_4 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(424021068).content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_6 = 25 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_4) / 25)

				if (25 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_4) / 25)) > 0 and var_284_3 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_7 and arg_281_1.time_ < var_284_2 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play424021069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 424021069
		arg_285_1.duration_ = 3.6

		local var_285_0 = {
			zh = 3.6,
			ja = 3.4
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
				arg_285_0:Play424021070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10153"]) and arg_285_1.var_.actorSpriteComps10153 == nil then
				arg_285_1.var_.actorSpriteComps10153 = arg_285_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10153"]) then
				if arg_285_1.var_.actorSpriteComps10153 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10153"]) and arg_285_1.var_.actorSpriteComps10153 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10153 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 0.375

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(424021069)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 15 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 15)

				if (15 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 15)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021069", "story_v_out_424021.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_424021", "424021069", "story_v_out_424021.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_424021", "424021069", "story_v_out_424021.awb")

						arg_285_1:RecordAudio("424021069", var_288_9)
						arg_285_1:RecordAudio("424021069", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_424021", "424021069", "story_v_out_424021.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_424021", "424021069", "story_v_out_424021.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play424021070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 424021070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play424021071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10153"]) and arg_289_1.var_.actorSpriteComps10153 == nil then
				arg_289_1.var_.actorSpriteComps10153 = arg_289_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10153"]) then
				if arg_289_1.var_.actorSpriteComps10153 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10153"]) and arg_289_1.var_.actorSpriteComps10153 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps10153 = nil
			end

			local var_292_2 = 0
			local var_292_3 = 0.55

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(424021070).content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_6 = 22 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_4) / 22)

				if (22 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_4) / 22)) > 0 and var_292_3 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_7 and arg_289_1.time_ < var_292_2 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play424021071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 424021071
		arg_293_1.duration_ = 18.03

		local var_293_0 = {
			zh = 11.5,
			ja = 18.033
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
				arg_293_0:Play424021072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1047"]) and arg_293_1.var_.actorSpriteComps1047 == nil then
				arg_293_1.var_.actorSpriteComps1047 = arg_293_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1047"]) then
				if arg_293_1.var_.actorSpriteComps1047 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								iter_296_1.color = Color.New(Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_0), Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_0), (Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_0)))
							else
								local var_296_1 = Mathf.Lerp(iter_296_1.color.r, 1, (arg_293_1.time_ - 0) / var_296_0)

								iter_296_1.color = Color.New(var_296_1, var_296_1, var_296_1)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1047"]) and arg_293_1.var_.actorSpriteComps1047 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1047 = nil
			end

			local var_296_2 = arg_293_1.actors_["1047"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1047 = var_296_2.localPosition
				var_296_2.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1047", 4)

				for iter_296_4 = 0, var_296_2.childCount - 1 do
					local var_296_3 = var_296_2:GetChild(iter_296_4)

					if var_296_3.name == "split_2" then
						var_296_3:SetAsLastSibling()
						var_296_3.gameObject:SetActive(true)

						arg_293_1.var_.actorSpriteSplit1047 = var_296_3.gameObject:GetComponent(typeof(Image))

						arg_293_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_296_4 = 0.5

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				var_296_2.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1047, Vector3.New(483.1, -360, -319.3), (arg_293_1.time_ - 0) / var_296_4)

				if arg_293_1.var_.actorSpriteSplit1047 ~= nil then
					arg_293_1.var_.actorSpriteSplit1047:SetAlpha((arg_293_1.time_ - 0) / var_296_4)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				var_296_2.localPosition = Vector3.New(483.1, -360, -319.3)

				if arg_293_1.var_.actorSpriteSplit1047 ~= nil then
					arg_293_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_296_5 = 0
			local var_296_6 = 1.45

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(424021071)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 58 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 58)

				if (58 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 58)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021071", "story_v_out_424021.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021071", "story_v_out_424021.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_424021", "424021071", "story_v_out_424021.awb")

						arg_293_1:RecordAudio("424021071", var_296_12)
						arg_293_1:RecordAudio("424021071", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_424021", "424021071", "story_v_out_424021.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_424021", "424021071", "story_v_out_424021.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play424021072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 424021072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play424021073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1047"]) and arg_297_1.var_.actorSpriteComps1047 == nil then
				arg_297_1.var_.actorSpriteComps1047 = arg_297_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1047"]) then
				if arg_297_1.var_.actorSpriteComps1047 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1047"]) and arg_297_1.var_.actorSpriteComps1047 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps1047 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.475

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

				local var_300_4 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(424021072).content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_6 = 19 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 19)

				if (19 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 19)) > 0 and var_300_3 < var_300_6 then
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
	Play424021073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 424021073
		arg_301_1.duration_ = 11.2

		local var_301_0 = {
			zh = 9.933,
			ja = 11.2
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
				arg_301_0:Play424021074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["10153"]) and arg_301_1.var_.actorSpriteComps10153 == nil then
				arg_301_1.var_.actorSpriteComps10153 = arg_301_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["10153"]) then
				if arg_301_1.var_.actorSpriteComps10153 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 1, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["10153"]) and arg_301_1.var_.actorSpriteComps10153 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps10153 = nil
			end

			local var_304_2 = arg_301_1.actors_["10153"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10153 = var_304_2.localPosition
				var_304_2.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10153", 2)

				for iter_304_4 = 0, var_304_2.childCount - 1 do
					local var_304_3 = var_304_2:GetChild(iter_304_4)

					if var_304_3.name == "split_4" then
						var_304_3:SetAsLastSibling()
						var_304_3.gameObject:SetActive(true)

						arg_301_1.var_.actorSpriteSplit10153 = var_304_3.gameObject:GetComponent(typeof(Image))

						arg_301_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_304_4 = 0.5

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_301_1.time_ - 0) / var_304_4)

				if arg_301_1.var_.actorSpriteSplit10153 ~= nil then
					arg_301_1.var_.actorSpriteSplit10153:SetAlpha((arg_301_1.time_ - 0) / var_304_4)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_301_1.var_.actorSpriteSplit10153 ~= nil then
					arg_301_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_304_5 = 0
			local var_304_6 = 1.175

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_7 = arg_301_1:GetWordFromCfg(424021073)
				local var_304_8 = arg_301_1:FormatText(var_304_7.content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 47 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 47)

				if (47 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 47)) > 0 and var_304_6 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_5
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021073", "story_v_out_424021.awb") ~= 0 then
					local var_304_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021073", "story_v_out_424021.awb") / 1000

					if var_304_11 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_5
					end

					if var_304_7.prefab_name ~= "" and arg_301_1.actors_[var_304_7.prefab_name] ~= nil then
						local var_304_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_7.prefab_name].transform, "story_v_out_424021", "424021073", "story_v_out_424021.awb")

						arg_301_1:RecordAudio("424021073", var_304_12)
						arg_301_1:RecordAudio("424021073", var_304_12)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_424021", "424021073", "story_v_out_424021.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_424021", "424021073", "story_v_out_424021.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_6, arg_301_1.talkMaxDuration)

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_5) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_5 + var_304_13 and arg_301_1.time_ < var_304_5 + var_304_13 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play424021074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 424021074
		arg_305_1.duration_ = 10.4

		local var_305_0 = {
			zh = 9.166,
			ja = 10.4
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play424021075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(424021074)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 40 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 40)

				if (40 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 40)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021074", "story_v_out_424021.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_424021", "424021074", "story_v_out_424021.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_424021", "424021074", "story_v_out_424021.awb")

						arg_305_1:RecordAudio("424021074", var_308_6)
						arg_305_1:RecordAudio("424021074", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_424021", "424021074", "story_v_out_424021.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_424021", "424021074", "story_v_out_424021.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play424021075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 424021075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play424021076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["10153"]) and arg_309_1.var_.actorSpriteComps10153 == nil then
				arg_309_1.var_.actorSpriteComps10153 = arg_309_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["10153"]) then
				if arg_309_1.var_.actorSpriteComps10153 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["10153"]) and arg_309_1.var_.actorSpriteComps10153 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps10153 = nil
			end

			local var_312_2 = 0
			local var_312_3 = 0.15

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_4 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(424021075).content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 6 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_4) / 6)

				if (6 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_4) / 6)) > 0 and var_312_3 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_7 and arg_309_1.time_ < var_312_2 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play424021076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 424021076
		arg_313_1.duration_ = 16.13

		local var_313_0 = {
			zh = 13.4,
			ja = 16.133
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play424021077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10153"]) and arg_313_1.var_.actorSpriteComps10153 == nil then
				arg_313_1.var_.actorSpriteComps10153 = arg_313_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10153"]) then
				if arg_313_1.var_.actorSpriteComps10153 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 1, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10153"]) and arg_313_1.var_.actorSpriteComps10153 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10153 = nil
			end

			local var_316_2 = arg_313_1.actors_["10153"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10153 = var_316_2.localPosition
				var_316_2.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10153", 2)

				for iter_316_4 = 0, var_316_2.childCount - 1 do
					local var_316_3 = var_316_2:GetChild(iter_316_4)

					if var_316_3.name == "split_1" then
						var_316_3:SetAsLastSibling()
						var_316_3.gameObject:SetActive(true)

						arg_313_1.var_.actorSpriteSplit10153 = var_316_3.gameObject:GetComponent(typeof(Image))

						arg_313_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_316_4 = 0.5

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_2.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_313_1.time_ - 0) / var_316_4)

				if arg_313_1.var_.actorSpriteSplit10153 ~= nil then
					arg_313_1.var_.actorSpriteSplit10153:SetAlpha((arg_313_1.time_ - 0) / var_316_4)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_313_1.var_.actorSpriteSplit10153 ~= nil then
					arg_313_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_316_5 = 0
			local var_316_6 = 1.45

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(424021076)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 58 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 58)

				if (58 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 58)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021076", "story_v_out_424021.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021076", "story_v_out_424021.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_424021", "424021076", "story_v_out_424021.awb")

						arg_313_1:RecordAudio("424021076", var_316_12)
						arg_313_1:RecordAudio("424021076", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_424021", "424021076", "story_v_out_424021.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_424021", "424021076", "story_v_out_424021.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_6, arg_313_1.talkMaxDuration)

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_5) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_5 + var_316_13 and arg_313_1.time_ < var_316_5 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play424021077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 424021077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play424021078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10153"]) and arg_317_1.var_.actorSpriteComps10153 == nil then
				arg_317_1.var_.actorSpriteComps10153 = arg_317_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10153"]) then
				if arg_317_1.var_.actorSpriteComps10153 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								iter_320_1.color = Color.New(Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_0), Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_0), (Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_0)))
							else
								local var_320_1 = Mathf.Lerp(iter_320_1.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_0)

								iter_320_1.color = Color.New(var_320_1, var_320_1, var_320_1)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10153"]) and arg_317_1.var_.actorSpriteComps10153 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps10153 = nil
			end

			local var_320_2 = 0
			local var_320_3 = 0.075

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_4 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(424021077).content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_6 = 3 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_4) / 3)

				if (3 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_4) / 3)) > 0 and var_320_3 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_7 and arg_317_1.time_ < var_320_2 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play424021078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 424021078
		arg_321_1.duration_ = 7

		local var_321_0 = {
			zh = 6.9,
			ja = 7
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play424021079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10153"]) and arg_321_1.var_.actorSpriteComps10153 == nil then
				arg_321_1.var_.actorSpriteComps10153 = arg_321_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10153"]) then
				if arg_321_1.var_.actorSpriteComps10153 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 1, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10153"]) and arg_321_1.var_.actorSpriteComps10153 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps10153 = nil
			end

			local var_324_2 = arg_321_1.actors_["10153"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10153 = var_324_2.localPosition
				var_324_2.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10153", 2)

				for iter_324_4 = 0, var_324_2.childCount - 1 do
					local var_324_3 = var_324_2:GetChild(iter_324_4)

					if var_324_3.name == "split_1" then
						var_324_3:SetAsLastSibling()
						var_324_3.gameObject:SetActive(true)

						arg_321_1.var_.actorSpriteSplit10153 = var_324_3.gameObject:GetComponent(typeof(Image))

						arg_321_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_324_4 = 0.5

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_2.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_321_1.time_ - 0) / var_324_4)

				if arg_321_1.var_.actorSpriteSplit10153 ~= nil then
					arg_321_1.var_.actorSpriteSplit10153:SetAlpha((arg_321_1.time_ - 0) / var_324_4)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_321_1.var_.actorSpriteSplit10153 ~= nil then
					arg_321_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_324_5 = 0
			local var_324_6 = 0.725

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(424021078)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 29 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 29)

				if (29 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 29)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021078", "story_v_out_424021.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021078", "story_v_out_424021.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_424021", "424021078", "story_v_out_424021.awb")

						arg_321_1:RecordAudio("424021078", var_324_12)
						arg_321_1:RecordAudio("424021078", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_424021", "424021078", "story_v_out_424021.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_424021", "424021078", "story_v_out_424021.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_13 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_13

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_13 and arg_321_1.time_ < var_324_5 + var_324_13 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play424021079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 424021079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play424021080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10153"]) and arg_325_1.var_.actorSpriteComps10153 == nil then
				arg_325_1.var_.actorSpriteComps10153 = arg_325_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10153"]) then
				if arg_325_1.var_.actorSpriteComps10153 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10153"]) and arg_325_1.var_.actorSpriteComps10153 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps10153 = nil
			end

			local var_328_2 = 0
			local var_328_3 = 0.825

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_4 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(424021079).content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 33 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 33)

				if (33 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 33)) > 0 and var_328_3 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_7 and arg_325_1.time_ < var_328_2 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play424021080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 424021080
		arg_329_1.duration_ = 13.4

		local var_329_0 = {
			zh = 13.4,
			ja = 12.3
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play424021081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10153"]) and arg_329_1.var_.actorSpriteComps10153 == nil then
				arg_329_1.var_.actorSpriteComps10153 = arg_329_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10153"]) then
				if arg_329_1.var_.actorSpriteComps10153 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								iter_332_1.color = Color.New(Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, (arg_329_1.time_ - 0) / var_332_0), Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, (arg_329_1.time_ - 0) / var_332_0), (Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, (arg_329_1.time_ - 0) / var_332_0)))
							else
								local var_332_1 = Mathf.Lerp(iter_332_1.color.r, 1, (arg_329_1.time_ - 0) / var_332_0)

								iter_332_1.color = Color.New(var_332_1, var_332_1, var_332_1)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10153"]) and arg_329_1.var_.actorSpriteComps10153 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps10153 = nil
			end

			local var_332_2 = arg_329_1.actors_["10153"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10153 = var_332_2.localPosition
				var_332_2.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("10153", 2)

				for iter_332_4 = 0, var_332_2.childCount - 1 do
					local var_332_3 = var_332_2:GetChild(iter_332_4)

					if var_332_3.name == "split_1" then
						var_332_3:SetAsLastSibling()
						var_332_3.gameObject:SetActive(true)

						arg_329_1.var_.actorSpriteSplit10153 = var_332_3.gameObject:GetComponent(typeof(Image))

						arg_329_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_332_4 = 0.5

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_2.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_329_1.time_ - 0) / var_332_4)

				if arg_329_1.var_.actorSpriteSplit10153 ~= nil then
					arg_329_1.var_.actorSpriteSplit10153:SetAlpha((arg_329_1.time_ - 0) / var_332_4)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_329_1.var_.actorSpriteSplit10153 ~= nil then
					arg_329_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_332_5 = 0
			local var_332_6 = 1.275

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_7 = arg_329_1:GetWordFromCfg(424021080)
				local var_332_8 = arg_329_1:FormatText(var_332_7.content)

				arg_329_1.text_.text = var_332_8

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 51 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 51)

				if (51 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 51)) > 0 and var_332_6 < var_332_10 then
					arg_329_1.talkMaxDuration = var_332_10

					if var_332_10 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_5
					end
				end

				arg_329_1.text_.text = var_332_8
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021080", "story_v_out_424021.awb") ~= 0 then
					local var_332_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021080", "story_v_out_424021.awb") / 1000

					if var_332_11 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_11 + var_332_5
					end

					if var_332_7.prefab_name ~= "" and arg_329_1.actors_[var_332_7.prefab_name] ~= nil then
						local var_332_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_7.prefab_name].transform, "story_v_out_424021", "424021080", "story_v_out_424021.awb")

						arg_329_1:RecordAudio("424021080", var_332_12)
						arg_329_1:RecordAudio("424021080", var_332_12)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_424021", "424021080", "story_v_out_424021.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_424021", "424021080", "story_v_out_424021.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_6, arg_329_1.talkMaxDuration)

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_5) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_5 + var_332_13 and arg_329_1.time_ < var_332_5 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play424021081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 424021081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play424021082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10153"]) and arg_333_1.var_.actorSpriteComps10153 == nil then
				arg_333_1.var_.actorSpriteComps10153 = arg_333_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10153"]) then
				if arg_333_1.var_.actorSpriteComps10153 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10153"]) and arg_333_1.var_.actorSpriteComps10153 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps10153 = nil
			end

			local var_336_2 = 0
			local var_336_3 = 0.35

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_4 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(424021081).content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_6 = 14 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_4) / 14)

				if (14 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_4) / 14)) > 0 and var_336_3 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_7 and arg_333_1.time_ < var_336_2 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play424021082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 424021082
		arg_337_1.duration_ = 4.77

		local var_337_0 = {
			zh = 4.466,
			ja = 4.766
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
				arg_337_0:Play424021083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["10153"]) and arg_337_1.var_.actorSpriteComps10153 == nil then
				arg_337_1.var_.actorSpriteComps10153 = arg_337_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["10153"]) then
				if arg_337_1.var_.actorSpriteComps10153 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								iter_340_1.color = Color.New(Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_0), Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_0), (Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_0)))
							else
								local var_340_1 = Mathf.Lerp(iter_340_1.color.r, 1, (arg_337_1.time_ - 0) / var_340_0)

								iter_340_1.color = Color.New(var_340_1, var_340_1, var_340_1)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["10153"]) and arg_337_1.var_.actorSpriteComps10153 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps10153 = nil
			end

			local var_340_2 = arg_337_1.actors_["10153"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10153 = var_340_2.localPosition
				var_340_2.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10153", 2)

				for iter_340_4 = 0, var_340_2.childCount - 1 do
					local var_340_3 = var_340_2:GetChild(iter_340_4)

					if var_340_3.name == "split_5" then
						var_340_3:SetAsLastSibling()
						var_340_3.gameObject:SetActive(true)

						arg_337_1.var_.actorSpriteSplit10153 = var_340_3.gameObject:GetComponent(typeof(Image))

						arg_337_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_340_4 = 0.5

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				var_340_2.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_337_1.time_ - 0) / var_340_4)

				if arg_337_1.var_.actorSpriteSplit10153 ~= nil then
					arg_337_1.var_.actorSpriteSplit10153:SetAlpha((arg_337_1.time_ - 0) / var_340_4)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				var_340_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_337_1.var_.actorSpriteSplit10153 ~= nil then
					arg_337_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_340_5 = 0
			local var_340_6 = 0.45

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:GetWordFromCfg(424021082)
				local var_340_8 = arg_337_1:FormatText(var_340_7.content)

				arg_337_1.text_.text = var_340_8

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 18 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_8) / 18)

				if (18 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_8) / 18)) > 0 and var_340_6 < var_340_10 then
					arg_337_1.talkMaxDuration = var_340_10

					if var_340_10 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_8
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021082", "story_v_out_424021.awb") ~= 0 then
					local var_340_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021082", "story_v_out_424021.awb") / 1000

					if var_340_11 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_11 + var_340_5
					end

					if var_340_7.prefab_name ~= "" and arg_337_1.actors_[var_340_7.prefab_name] ~= nil then
						local var_340_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_7.prefab_name].transform, "story_v_out_424021", "424021082", "story_v_out_424021.awb")

						arg_337_1:RecordAudio("424021082", var_340_12)
						arg_337_1:RecordAudio("424021082", var_340_12)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_424021", "424021082", "story_v_out_424021.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_424021", "424021082", "story_v_out_424021.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_13 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_13 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_13

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_13 and arg_337_1.time_ < var_340_5 + var_340_13 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play424021083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 424021083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play424021084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["10153"]) and arg_341_1.var_.actorSpriteComps10153 == nil then
				arg_341_1.var_.actorSpriteComps10153 = arg_341_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_0 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["10153"]) then
				if arg_341_1.var_.actorSpriteComps10153 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								iter_344_1.color = Color.New(Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_0), Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_0), (Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_0)))
							else
								local var_344_1 = Mathf.Lerp(iter_344_1.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_0)

								iter_344_1.color = Color.New(var_344_1, var_344_1, var_344_1)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["10153"]) and arg_341_1.var_.actorSpriteComps10153 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_344_3 then
						iter_344_3.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps10153 = nil
			end

			local var_344_2 = 0
			local var_344_3 = 0.3

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_4 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(424021083).content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_6 = 12 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_4) / 12)

				if (12 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_4) / 12)) > 0 and var_344_3 < var_344_6 then
					arg_341_1.talkMaxDuration = var_344_6

					if var_344_6 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_6 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_7 and arg_341_1.time_ < var_344_2 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play424021084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 424021084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play424021085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.775

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(424021084).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 31)

				if (31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 31)) > 0 and var_348_0 < var_348_3 then
					arg_345_1.talkMaxDuration = var_348_3

					if var_348_3 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_3 + 0
					end
				end

				arg_345_1.text_.text = var_348_1
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_4 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_4

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play424021085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 424021085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play424021086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.15

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(424021085).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 6 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 6)

				if (6 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 6)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play424021086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 424021086
		arg_353_1.duration_ = 9.73

		local var_353_0 = {
			zh = 6.233,
			ja = 9.733
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play424021087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10153"]) and arg_353_1.var_.actorSpriteComps10153 == nil then
				arg_353_1.var_.actorSpriteComps10153 = arg_353_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10153"]) then
				if arg_353_1.var_.actorSpriteComps10153 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								iter_356_1.color = Color.New(Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_0), Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_0), (Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_0)))
							else
								local var_356_1 = Mathf.Lerp(iter_356_1.color.r, 1, (arg_353_1.time_ - 0) / var_356_0)

								iter_356_1.color = Color.New(var_356_1, var_356_1, var_356_1)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10153"]) and arg_353_1.var_.actorSpriteComps10153 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10153 = nil
			end

			local var_356_2 = arg_353_1.actors_["10153"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10153 = var_356_2.localPosition
				var_356_2.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10153", 2)

				for iter_356_4 = 0, var_356_2.childCount - 1 do
					local var_356_3 = var_356_2:GetChild(iter_356_4)

					if var_356_3.name == "split_1" then
						var_356_3:SetAsLastSibling()
						var_356_3.gameObject:SetActive(true)

						arg_353_1.var_.actorSpriteSplit10153 = var_356_3.gameObject:GetComponent(typeof(Image))

						arg_353_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_356_4 = 0.5

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				var_356_2.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_353_1.time_ - 0) / var_356_4)

				if arg_353_1.var_.actorSpriteSplit10153 ~= nil then
					arg_353_1.var_.actorSpriteSplit10153:SetAlpha((arg_353_1.time_ - 0) / var_356_4)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				var_356_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_353_1.var_.actorSpriteSplit10153 ~= nil then
					arg_353_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_356_5 = 0
			local var_356_6 = 0.475

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(424021086)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 19 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 19)

				if (19 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 19)) > 0 and var_356_6 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_5
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021086", "story_v_out_424021.awb") ~= 0 then
					local var_356_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021086", "story_v_out_424021.awb") / 1000

					if var_356_11 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_5
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_424021", "424021086", "story_v_out_424021.awb")

						arg_353_1:RecordAudio("424021086", var_356_12)
						arg_353_1:RecordAudio("424021086", var_356_12)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_424021", "424021086", "story_v_out_424021.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_424021", "424021086", "story_v_out_424021.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_6, arg_353_1.talkMaxDuration)

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_5) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_5 + var_356_13 and arg_353_1.time_ < var_356_5 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play424021087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 424021087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play424021088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10153"]) and arg_357_1.var_.actorSpriteComps10153 == nil then
				arg_357_1.var_.actorSpriteComps10153 = arg_357_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10153"]) then
				if arg_357_1.var_.actorSpriteComps10153 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10153"]) and arg_357_1.var_.actorSpriteComps10153 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10153 = nil
			end

			local var_360_2 = 0
			local var_360_3 = 0.7

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_4 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(424021087).content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_6 = 28 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 28)

				if (28 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 28)) > 0 and var_360_3 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_7 and arg_357_1.time_ < var_360_2 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play424021088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 424021088
		arg_361_1.duration_ = 10.4

		local var_361_0 = {
			zh = 7.933,
			ja = 10.4
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play424021089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1047"]) and arg_361_1.var_.actorSpriteComps1047 == nil then
				arg_361_1.var_.actorSpriteComps1047 = arg_361_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1047"]) then
				if arg_361_1.var_.actorSpriteComps1047 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								iter_364_1.color = Color.New(Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_0), Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_0), (Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_0)))
							else
								local var_364_1 = Mathf.Lerp(iter_364_1.color.r, 1, (arg_361_1.time_ - 0) / var_364_0)

								iter_364_1.color = Color.New(var_364_1, var_364_1, var_364_1)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1047"]) and arg_361_1.var_.actorSpriteComps1047 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps1047 = nil
			end

			local var_364_2 = arg_361_1.actors_["1047"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1047 = var_364_2.localPosition
				var_364_2.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1047", 4)

				for iter_364_4 = 0, var_364_2.childCount - 1 do
					local var_364_3 = var_364_2:GetChild(iter_364_4)

					if var_364_3.name == "split_3" then
						var_364_3:SetAsLastSibling()
						var_364_3.gameObject:SetActive(true)

						arg_361_1.var_.actorSpriteSplit1047 = var_364_3.gameObject:GetComponent(typeof(Image))

						arg_361_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_364_4 = 0.5

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				var_364_2.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1047, Vector3.New(483.1, -360, -319.3), (arg_361_1.time_ - 0) / var_364_4)

				if arg_361_1.var_.actorSpriteSplit1047 ~= nil then
					arg_361_1.var_.actorSpriteSplit1047:SetAlpha((arg_361_1.time_ - 0) / var_364_4)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				var_364_2.localPosition = Vector3.New(483.1, -360, -319.3)

				if arg_361_1.var_.actorSpriteSplit1047 ~= nil then
					arg_361_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_364_5 = 0
			local var_364_6 = 0.875

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:GetWordFromCfg(424021088)
				local var_364_8 = arg_361_1:FormatText(var_364_7.content)

				arg_361_1.text_.text = var_364_8

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 35 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 35)

				if (35 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 35)) > 0 and var_364_6 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_8
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021088", "story_v_out_424021.awb") ~= 0 then
					local var_364_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021088", "story_v_out_424021.awb") / 1000

					if var_364_11 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_11 + var_364_5
					end

					if var_364_7.prefab_name ~= "" and arg_361_1.actors_[var_364_7.prefab_name] ~= nil then
						local var_364_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_7.prefab_name].transform, "story_v_out_424021", "424021088", "story_v_out_424021.awb")

						arg_361_1:RecordAudio("424021088", var_364_12)
						arg_361_1:RecordAudio("424021088", var_364_12)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_424021", "424021088", "story_v_out_424021.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_424021", "424021088", "story_v_out_424021.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_13 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_13 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_13

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_13 and arg_361_1.time_ < var_364_5 + var_364_13 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play424021089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 424021089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play424021090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1047"]) and arg_365_1.var_.actorSpriteComps1047 == nil then
				arg_365_1.var_.actorSpriteComps1047 = arg_365_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_0 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1047"]) then
				if arg_365_1.var_.actorSpriteComps1047 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								iter_368_1.color = Color.New(Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_0), Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_0), (Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_0)))
							else
								local var_368_1 = Mathf.Lerp(iter_368_1.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_0)

								iter_368_1.color = Color.New(var_368_1, var_368_1, var_368_1)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1047"]) and arg_365_1.var_.actorSpriteComps1047 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_368_3 then
						iter_368_3.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps1047 = nil
			end

			local var_368_2 = 0
			local var_368_3 = 1.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_4 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(424021089).content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_6 = 50 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_4) / 50)

				if (50 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_4) / 50)) > 0 and var_368_3 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_7 and arg_365_1.time_ < var_368_2 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play424021090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 424021090
		arg_369_1.duration_ = 1.17

		local var_369_0 = {
			zh = 1,
			ja = 1.166
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
				arg_369_0:Play424021091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10153"]) and arg_369_1.var_.actorSpriteComps10153 == nil then
				arg_369_1.var_.actorSpriteComps10153 = arg_369_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_0 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10153"]) then
				if arg_369_1.var_.actorSpriteComps10153 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								iter_372_1.color = Color.New(Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_0), Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_0), (Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_0)))
							else
								local var_372_1 = Mathf.Lerp(iter_372_1.color.r, 1, (arg_369_1.time_ - 0) / var_372_0)

								iter_372_1.color = Color.New(var_372_1, var_372_1, var_372_1)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10153"]) and arg_369_1.var_.actorSpriteComps10153 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_372_3 then
						iter_372_3.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10153 = nil
			end

			local var_372_2 = arg_369_1.actors_["10153"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10153 = var_372_2.localPosition
				var_372_2.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10153", 2)

				for iter_372_4 = 0, var_372_2.childCount - 1 do
					local var_372_3 = var_372_2:GetChild(iter_372_4)

					if var_372_3.name == "split_2" then
						var_372_3:SetAsLastSibling()
						var_372_3.gameObject:SetActive(true)

						arg_369_1.var_.actorSpriteSplit10153 = var_372_3.gameObject:GetComponent(typeof(Image))

						arg_369_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_372_4 = 0.5

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				var_372_2.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_369_1.time_ - 0) / var_372_4)

				if arg_369_1.var_.actorSpriteSplit10153 ~= nil then
					arg_369_1.var_.actorSpriteSplit10153:SetAlpha((arg_369_1.time_ - 0) / var_372_4)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				var_372_2.localPosition = Vector3.New(-400, -395, -330)

				if arg_369_1.var_.actorSpriteSplit10153 ~= nil then
					arg_369_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_372_5 = 0
			local var_372_6 = 0.05

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:GetWordFromCfg(424021090)
				local var_372_8 = arg_369_1:FormatText(var_372_7.content)

				arg_369_1.text_.text = var_372_8

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_10 = 2 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 2)

				if (2 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 2)) > 0 and var_372_6 < var_372_10 then
					arg_369_1.talkMaxDuration = var_372_10

					if var_372_10 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_8
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021090", "story_v_out_424021.awb") ~= 0 then
					local var_372_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021090", "story_v_out_424021.awb") / 1000

					if var_372_11 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_5
					end

					if var_372_7.prefab_name ~= "" and arg_369_1.actors_[var_372_7.prefab_name] ~= nil then
						local var_372_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_7.prefab_name].transform, "story_v_out_424021", "424021090", "story_v_out_424021.awb")

						arg_369_1:RecordAudio("424021090", var_372_12)
						arg_369_1:RecordAudio("424021090", var_372_12)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_424021", "424021090", "story_v_out_424021.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_424021", "424021090", "story_v_out_424021.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_13 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_13 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_13

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_13 and arg_369_1.time_ < var_372_5 + var_372_13 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play424021091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 424021091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play424021092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10153"]) and arg_373_1.var_.actorSpriteComps10153 == nil then
				arg_373_1.var_.actorSpriteComps10153 = arg_373_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10153"]) then
				if arg_373_1.var_.actorSpriteComps10153 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10153"]) and arg_373_1.var_.actorSpriteComps10153 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps10153 = nil
			end

			local var_376_2 = 0
			local var_376_3 = 0.625

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(424021091).content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_6 = 25 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_4) / 25)

				if (25 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_4) / 25)) > 0 and var_376_3 < var_376_6 then
					arg_373_1.talkMaxDuration = var_376_6

					if var_376_6 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_6 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_7 and arg_373_1.time_ < var_376_2 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play424021092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 424021092
		arg_377_1.duration_ = 14.3

		local var_377_0 = {
			zh = 10.766,
			ja = 14.3
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
				arg_377_0:Play424021093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1047"]) and arg_377_1.var_.actorSpriteComps1047 == nil then
				arg_377_1.var_.actorSpriteComps1047 = arg_377_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1047"]) then
				if arg_377_1.var_.actorSpriteComps1047 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1047"]) and arg_377_1.var_.actorSpriteComps1047 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps1047 = nil
			end

			local var_380_2 = arg_377_1.actors_["1047"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1047 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1047", 4)

				for iter_380_4 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_4)

					if var_380_3.name == "" then
						var_380_3:SetAsLastSibling()
						var_380_3.gameObject:SetActive(true)

						arg_377_1.var_.actorSpriteSplit1047 = var_380_3.gameObject:GetComponent(typeof(Image))

						arg_377_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_380_4 = 0.5

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1047, Vector3.New(483.1, -360, -319.3), (arg_377_1.time_ - 0) / var_380_4)

				if arg_377_1.var_.actorSpriteSplit1047 ~= nil then
					arg_377_1.var_.actorSpriteSplit1047:SetAlpha((arg_377_1.time_ - 0) / var_380_4)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(483.1, -360, -319.3)

				if arg_377_1.var_.actorSpriteSplit1047 ~= nil then
					arg_377_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_380_5 = 0
			local var_380_6 = 1.25

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:GetWordFromCfg(424021092)
				local var_380_8 = arg_377_1:FormatText(var_380_7.content)

				arg_377_1.text_.text = var_380_8

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 50 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 50)

				if (50 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 50)) > 0 and var_380_6 < var_380_10 then
					arg_377_1.talkMaxDuration = var_380_10

					if var_380_10 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_8
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021092", "story_v_out_424021.awb") ~= 0 then
					local var_380_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021092", "story_v_out_424021.awb") / 1000

					if var_380_11 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_11 + var_380_5
					end

					if var_380_7.prefab_name ~= "" and arg_377_1.actors_[var_380_7.prefab_name] ~= nil then
						local var_380_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_7.prefab_name].transform, "story_v_out_424021", "424021092", "story_v_out_424021.awb")

						arg_377_1:RecordAudio("424021092", var_380_12)
						arg_377_1:RecordAudio("424021092", var_380_12)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_424021", "424021092", "story_v_out_424021.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_424021", "424021092", "story_v_out_424021.awb")
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
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play424021093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 424021093
		arg_381_1.duration_ = 10.67

		local var_381_0 = {
			zh = 8.533,
			ja = 10.666
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play424021094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["10153"]) and arg_381_1.var_.actorSpriteComps10153 == nil then
				arg_381_1.var_.actorSpriteComps10153 = arg_381_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_0 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["10153"]) then
				if arg_381_1.var_.actorSpriteComps10153 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								iter_384_1.color = Color.New(Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_0), Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_0), (Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_0)))
							else
								local var_384_1 = Mathf.Lerp(iter_384_1.color.r, 1, (arg_381_1.time_ - 0) / var_384_0)

								iter_384_1.color = Color.New(var_384_1, var_384_1, var_384_1)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["10153"]) and arg_381_1.var_.actorSpriteComps10153 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_384_3 then
						iter_384_3.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps10153 = nil
			end

			local var_384_2 = arg_381_1.actors_["1047"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1047 == nil then
				arg_381_1.var_.actorSpriteComps1047 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps1047 then
					for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_384_5 then
							if arg_381_1.isInRecall_ then
								iter_384_5.color = Color.New(Mathf.Lerp(iter_384_5.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_5.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_5.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_5.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_5.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1047 then
				for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_384_7 then
						iter_384_7.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1047 = nil
			end

			local var_384_5 = arg_381_1.actors_["10153"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10153 = var_384_5.localPosition
				var_384_5.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10153", 2)

				for iter_384_8 = 0, var_384_5.childCount - 1 do
					local var_384_6 = var_384_5:GetChild(iter_384_8)

					if var_384_6.name == "" then
						var_384_6:SetAsLastSibling()
						var_384_6.gameObject:SetActive(true)

						arg_381_1.var_.actorSpriteSplit10153 = var_384_6.gameObject:GetComponent(typeof(Image))

						arg_381_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_384_7 = 0.5

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				var_384_5.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_381_1.time_ - 0) / var_384_7)

				if arg_381_1.var_.actorSpriteSplit10153 ~= nil then
					arg_381_1.var_.actorSpriteSplit10153:SetAlpha((arg_381_1.time_ - 0) / var_384_7)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				var_384_5.localPosition = Vector3.New(-400, -395, -330)

				if arg_381_1.var_.actorSpriteSplit10153 ~= nil then
					arg_381_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_384_8 = 0
			local var_384_9 = 0.925

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_10 = arg_381_1:GetWordFromCfg(424021093)
				local var_384_11 = arg_381_1:FormatText(var_384_10.content)

				arg_381_1.text_.text = var_384_11

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_13 = 37 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_11) / 37)

				if (37 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_11) / 37)) > 0 and var_384_9 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_8
					end
				end

				arg_381_1.text_.text = var_384_11
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021093", "story_v_out_424021.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021093", "story_v_out_424021.awb") / 1000

					if var_384_14 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_8
					end

					if var_384_10.prefab_name ~= "" and arg_381_1.actors_[var_384_10.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_10.prefab_name].transform, "story_v_out_424021", "424021093", "story_v_out_424021.awb")

						arg_381_1:RecordAudio("424021093", var_384_15)
						arg_381_1:RecordAudio("424021093", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_424021", "424021093", "story_v_out_424021.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_424021", "424021093", "story_v_out_424021.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_9, arg_381_1.talkMaxDuration)

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_8) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_8 + var_384_16 and arg_381_1.time_ < var_384_8 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play424021094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 424021094
		arg_385_1.duration_ = 1.37

		local var_385_0 = {
			zh = 1.366,
			ja = 1.066
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
				arg_385_0:Play424021095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1047"]) and arg_385_1.var_.actorSpriteComps1047 == nil then
				arg_385_1.var_.actorSpriteComps1047 = arg_385_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1047"]) then
				if arg_385_1.var_.actorSpriteComps1047 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								iter_388_1.color = Color.New(Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_0), Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_0), (Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_0)))
							else
								local var_388_1 = Mathf.Lerp(iter_388_1.color.r, 1, (arg_385_1.time_ - 0) / var_388_0)

								iter_388_1.color = Color.New(var_388_1, var_388_1, var_388_1)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1047"]) and arg_385_1.var_.actorSpriteComps1047 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps1047 = nil
			end

			local var_388_2 = arg_385_1.actors_["10153"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps10153 == nil then
				arg_385_1.var_.actorSpriteComps10153 = var_388_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_3 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.actorSpriteComps10153 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_388_5 then
							if arg_385_1.isInRecall_ then
								iter_388_5.color = Color.New(Mathf.Lerp(iter_388_5.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 0) / var_388_3), Mathf.Lerp(iter_388_5.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 0) / var_388_3), (Mathf.Lerp(iter_388_5.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 0) / var_388_3)))
							else
								local var_388_4 = Mathf.Lerp(iter_388_5.color.r, 0.5, (arg_385_1.time_ - 0) / var_388_3)

								iter_388_5.color = Color.New(var_388_4, var_388_4, var_388_4)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps10153 then
				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_388_7 then
						iter_388_7.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps10153 = nil
			end

			local var_388_5 = arg_385_1.actors_["1047"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1047 = var_388_5.localPosition
				var_388_5.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1047", 4)

				for iter_388_8 = 0, var_388_5.childCount - 1 do
					local var_388_6 = var_388_5:GetChild(iter_388_8)

					if var_388_6.name == "split_7" then
						var_388_6:SetAsLastSibling()
						var_388_6.gameObject:SetActive(true)

						arg_385_1.var_.actorSpriteSplit1047 = var_388_6.gameObject:GetComponent(typeof(Image))

						arg_385_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_388_7 = 0.5

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				var_388_5.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1047, Vector3.New(483.1, -360, -319.3), (arg_385_1.time_ - 0) / var_388_7)

				if arg_385_1.var_.actorSpriteSplit1047 ~= nil then
					arg_385_1.var_.actorSpriteSplit1047:SetAlpha((arg_385_1.time_ - 0) / var_388_7)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				var_388_5.localPosition = Vector3.New(483.1, -360, -319.3)

				if arg_385_1.var_.actorSpriteSplit1047 ~= nil then
					arg_385_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_388_8 = 0
			local var_388_9 = 0.125

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_10 = arg_385_1:GetWordFromCfg(424021094)
				local var_388_11 = arg_385_1:FormatText(var_388_10.content)

				arg_385_1.text_.text = var_388_11

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_13 = 5 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_11) / 5)

				if (5 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_11) / 5)) > 0 and var_388_9 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_8
					end
				end

				arg_385_1.text_.text = var_388_11
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021094", "story_v_out_424021.awb") ~= 0 then
					local var_388_14 = manager.audio:GetVoiceLength("story_v_out_424021", "424021094", "story_v_out_424021.awb") / 1000

					if var_388_14 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_14 + var_388_8
					end

					if var_388_10.prefab_name ~= "" and arg_385_1.actors_[var_388_10.prefab_name] ~= nil then
						local var_388_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_10.prefab_name].transform, "story_v_out_424021", "424021094", "story_v_out_424021.awb")

						arg_385_1:RecordAudio("424021094", var_388_15)
						arg_385_1:RecordAudio("424021094", var_388_15)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_424021", "424021094", "story_v_out_424021.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_424021", "424021094", "story_v_out_424021.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_16 = math.max(var_388_9, arg_385_1.talkMaxDuration)

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_16 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_8) / var_388_16

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_8 + var_388_16 and arg_385_1.time_ < var_388_8 + var_388_16 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play424021095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 424021095
		arg_389_1.duration_ = 6.83

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play424021096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 1 < arg_389_1.time_ and arg_389_1.time_ <= 1 + arg_392_0 and not isNil(arg_389_1.actors_["1047"]) and arg_389_1.var_.actorSpriteComps1047 == nil then
				arg_389_1.var_.actorSpriteComps1047 = arg_389_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 1 <= arg_389_1.time_ and arg_389_1.time_ < 1 + var_392_0 and not isNil(arg_389_1.actors_["1047"]) then
				if arg_389_1.var_.actorSpriteComps1047 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 1) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 1) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 1) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 0.5, (arg_389_1.time_ - 1) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 1 + var_392_0 and arg_389_1.time_ < 1 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1047"]) and arg_389_1.var_.actorSpriteComps1047 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps1047 = nil
			end

			local var_392_2 = arg_389_1.actors_["1047"].transform

			if 1 < arg_389_1.time_ and arg_389_1.time_ <= 1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1047 = var_392_2.localPosition
				var_392_2.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1047", 7)

				for iter_392_4 = 0, var_392_2.childCount - 1 do
					local var_392_3 = var_392_2:GetChild(iter_392_4)

					if var_392_3.name == "" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if 1 <= arg_389_1.time_ and arg_389_1.time_ < 1 + var_392_4 then
				var_392_2.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_389_1.time_ - 1) / var_392_4)
			end

			if arg_389_1.time_ >= 1 + var_392_4 and arg_389_1.time_ < 1 + var_392_4 + arg_392_0 then
				var_392_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_392_5 = arg_389_1.actors_["10153"].transform

			if 1 < arg_389_1.time_ and arg_389_1.time_ <= 1 + arg_392_0 then
				arg_389_1.var_.moveOldPos10153 = var_392_5.localPosition
				var_392_5.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10153", 7)

				for iter_392_5 = 0, var_392_5.childCount - 1 do
					local var_392_6 = var_392_5:GetChild(iter_392_5)

					if var_392_6.name == "" or not string.find(var_392_6.name, "split") then
						var_392_6.gameObject:SetActive(true)
					else
						var_392_6.gameObject:SetActive(false)
					end
				end
			end

			local var_392_7 = 0.001

			if 1 <= arg_389_1.time_ and arg_389_1.time_ < 1 + var_392_7 then
				var_392_5.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_389_1.time_ - 1) / var_392_7)
			end

			if arg_389_1.time_ >= 1 + var_392_7 and arg_389_1.time_ < 1 + var_392_7 + arg_392_0 then
				var_392_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_389_1.time_ and arg_389_1.time_ <= 1 + arg_392_0 then
				arg_389_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_392_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_389_1.bgmTxt_.text ~= var_392_10 and arg_389_1.bgmTxt_.text ~= "" then
						if arg_389_1.bgmTxt2_.text ~= "" then
							arg_389_1.bgmTxt_.text = arg_389_1.bgmTxt2_.text
						end

						arg_389_1.bgmTxt2_.text = var_392_10

						arg_389_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_389_1.bgmTxt_.text = var_392_10
						arg_389_1.bgmTxt2_.text = var_392_10
					end

					if arg_389_1.bgmTimer then
						arg_389_1.bgmTimer:Stop()

						arg_389_1.bgmTimer = nil
					end

					if arg_389_1.settingData.show_music_name == 1 then
						arg_389_1.musicController:SetSelectedState("show")
						arg_389_1.musicAnimator_:Play("open", 0, 0)

						if arg_389_1.settingData.music_time ~= 0 then
							arg_389_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_389_1.settingData.music_time), function()
								if arg_389_1 == nil or isNil(arg_389_1.bgmTxt_) then
									return
								end

								arg_389_1.musicController:SetSelectedState("hide")
								arg_389_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.3 < arg_389_1.time_ and arg_389_1.time_ <= 1.3 + arg_392_0 then
				arg_389_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_392_13 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_389_1.bgmTxt_.text ~= var_392_13 and arg_389_1.bgmTxt_.text ~= "" then
						if arg_389_1.bgmTxt2_.text ~= "" then
							arg_389_1.bgmTxt_.text = arg_389_1.bgmTxt2_.text
						end

						arg_389_1.bgmTxt2_.text = var_392_13

						arg_389_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_389_1.bgmTxt_.text = var_392_13
						arg_389_1.bgmTxt2_.text = var_392_13
					end

					if arg_389_1.bgmTimer then
						arg_389_1.bgmTimer:Stop()

						arg_389_1.bgmTimer = nil
					end

					if arg_389_1.settingData.show_music_name == 1 then
						arg_389_1.musicController:SetSelectedState("show")
						arg_389_1.musicAnimator_:Play("open", 0, 0)

						if arg_389_1.settingData.music_time ~= 0 then
							arg_389_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_389_1.settingData.music_time), function()
								if arg_389_1 == nil or isNil(arg_389_1.bgmTxt_) then
									return
								end

								arg_389_1.musicController:SetSelectedState("hide")
								arg_389_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_392_14 = 0

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1.mask_.enabled = true
				arg_389_1.mask_.raycastTarget = true

				arg_389_1:SetGaussion(false)
			end

			local var_392_15 = 1

			if var_392_14 <= arg_389_1.time_ and arg_389_1.time_ < var_392_14 + var_392_15 then
				local var_392_16 = Color.New(0, 0, 0)

				var_392_16.a = Mathf.Lerp(0, 1, (arg_389_1.time_ - var_392_14) / var_392_15)
				arg_389_1.mask_.color = var_392_16
			end

			if arg_389_1.time_ >= var_392_14 + var_392_15 and arg_389_1.time_ < var_392_14 + var_392_15 + arg_392_0 then
				local var_392_17 = Color.New(0, 0, 0)

				var_392_17.a = 1
				arg_389_1.mask_.color = var_392_17
			end

			local var_392_18 = 1

			if 1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_18 + arg_392_0 then
				arg_389_1.mask_.enabled = true
				arg_389_1.mask_.raycastTarget = true

				arg_389_1:SetGaussion(false)
			end

			local var_392_19 = 1

			if var_392_18 <= arg_389_1.time_ and arg_389_1.time_ < var_392_18 + var_392_19 then
				local var_392_20 = Color.New(0, 0, 0)

				var_392_20.a = Mathf.Lerp(1, 0, (arg_389_1.time_ - var_392_18) / var_392_19)
				arg_389_1.mask_.color = var_392_20
			end

			if arg_389_1.time_ >= var_392_18 + var_392_19 and arg_389_1.time_ < var_392_18 + var_392_19 + arg_392_0 then
				local var_392_21 = Color.New(0, 0, 0)

				arg_389_1.mask_.enabled = false
				var_392_21.a = 0
				arg_389_1.mask_.color = var_392_21
			end

			local var_392_22 = 1.83333333333333

			if 1.83333333333333 < arg_389_1.time_ and arg_389_1.time_ <= var_392_22 + arg_392_0 then
				arg_389_1.allBtn_.enabled = false
			end

			if arg_389_1.time_ >= var_392_22 + 0.6 and arg_389_1.time_ < var_392_22 + 0.6 + arg_392_0 then
				arg_389_1.allBtn_.enabled = true
			end

			if arg_389_1.frameCnt_ <= 1 then
				arg_389_1.dialog_:SetActive(false)
			end

			local var_392_23 = 1.83333333333333
			local var_392_24 = 0.75

			if 1.83333333333333 < arg_389_1.time_ and arg_389_1.time_ <= var_392_23 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0

				arg_389_1.dialog_:SetActive(true)

				arg_389_1.dialogCg_.alpha = 0

				local var_392_25 = LeanTween.value(arg_389_1.dialog_, 0, 1, 0.3)

				var_392_25:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_389_1.dialogCg_.alpha = arg_395_0
				end))
				var_392_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_389_1.dialog_)
					var_392_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_389_1.duration_ = arg_389_1.duration_ + 0.3

				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_26 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(424021095).content)

				arg_389_1.text_.text = var_392_26

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_28 = 30 <= 0 and var_392_24 or var_392_24 * (utf8.len(var_392_26) / 30)

				if (30 <= 0 and var_392_24 or var_392_24 * (utf8.len(var_392_26) / 30)) > 0 and var_392_24 < var_392_28 then
					arg_389_1.talkMaxDuration = var_392_28
					var_392_23 = var_392_23 + 0.3

					if var_392_28 + var_392_23 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_28 + var_392_23
					end
				end

				arg_389_1.text_.text = var_392_26
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_29 = var_392_23 + 0.3
			local var_392_30 = math.max(var_392_24, arg_389_1.talkMaxDuration)

			if var_392_23 + 0.3 <= arg_389_1.time_ and arg_389_1.time_ < var_392_29 + var_392_30 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_29) / var_392_30

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_29 + var_392_30 and arg_389_1.time_ < var_392_29 + var_392_30 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play424021096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424021096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play424021097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.55

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(424021096).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 22 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 22)

				if (22 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 22)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play424021097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424021097
		arg_401_1.duration_ = 3.2

		local var_401_0 = {
			zh = 2.366,
			ja = 3.2
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424021098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1037 = arg_401_1.actors_["1037"].transform.localPosition
				arg_401_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("1037", 3)

				for iter_404_0 = 0, arg_401_1.actors_["1037"].transform.childCount - 1 do
					local var_404_0 = arg_401_1.actors_["1037"].transform:GetChild(iter_404_0)

					if var_404_0.name == "split_5" then
						var_404_0:SetAsLastSibling()
						var_404_0.gameObject:SetActive(true)

						arg_401_1.var_.actorSpriteSplit1037 = var_404_0.gameObject:GetComponent(typeof(Image))

						arg_401_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_404_1 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_1 then
				arg_401_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_401_1.time_ - 0) / var_404_1)

				if arg_401_1.var_.actorSpriteSplit1037 ~= nil then
					arg_401_1.var_.actorSpriteSplit1037:SetAlpha((arg_401_1.time_ - 0) / var_404_1)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_1 and arg_401_1.time_ < 0 + var_404_1 + arg_404_0 then
				arg_401_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)

				if arg_401_1.var_.actorSpriteSplit1037 ~= nil then
					arg_401_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				local var_404_2 = arg_401_1.actors_["1037"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_2 then
					arg_401_1.var_.alphaOldValue1037 = var_404_2.alpha
					arg_401_1.var_.characterEffect1037 = var_404_2
				end
			end

			local var_404_3 = 0.1

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 then
				if arg_401_1.var_.characterEffect1037 then
					arg_401_1.var_.characterEffect1037.alpha = Mathf.Lerp(arg_401_1.var_.alphaOldValue1037, 0.6, (arg_401_1.time_ - 0) / var_404_3)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and arg_401_1.var_.characterEffect1037 then
				arg_401_1.var_.characterEffect1037.alpha = 0.6
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:SetSpriteNiuquEffect("1037", true)
			end

			local var_404_5 = 0
			local var_404_6 = 0.2

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:GetWordFromCfg(424021097)
				local var_404_8 = arg_401_1:FormatText(var_404_7.content)

				arg_401_1.text_.text = var_404_8

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_10 = 8 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_8) / 8)

				if (8 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_8) / 8)) > 0 and var_404_6 < var_404_10 then
					arg_401_1.talkMaxDuration = var_404_10

					if var_404_10 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_5
					end
				end

				arg_401_1.text_.text = var_404_8
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021097", "story_v_out_424021.awb") ~= 0 then
					local var_404_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021097", "story_v_out_424021.awb") / 1000

					if var_404_11 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_5
					end

					if var_404_7.prefab_name ~= "" and arg_401_1.actors_[var_404_7.prefab_name] ~= nil then
						local var_404_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_7.prefab_name].transform, "story_v_out_424021", "424021097", "story_v_out_424021.awb")

						arg_401_1:RecordAudio("424021097", var_404_12)
						arg_401_1:RecordAudio("424021097", var_404_12)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_424021", "424021097", "story_v_out_424021.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_424021", "424021097", "story_v_out_424021.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_13 = math.max(var_404_6, arg_401_1.talkMaxDuration)

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_13 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_5) / var_404_13

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_5 + var_404_13 and arg_401_1.time_ < var_404_5 + var_404_13 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play424021098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424021098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424021099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.525

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(424021098).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 21 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 21)

				if (21 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 21)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play424021099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 424021099
		arg_409_1.duration_ = 6.63

		local var_409_0 = {
			zh = 5.5,
			ja = 6.633
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play424021100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1037 = arg_409_1.actors_["1037"].transform.localPosition
				arg_409_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("1037", 3)

				for iter_412_0 = 0, arg_409_1.actors_["1037"].transform.childCount - 1 do
					local var_412_0 = arg_409_1.actors_["1037"].transform:GetChild(iter_412_0)

					if var_412_0.name == "split_1" then
						var_412_0:SetAsLastSibling()
						var_412_0.gameObject:SetActive(true)

						arg_409_1.var_.actorSpriteSplit1037 = var_412_0.gameObject:GetComponent(typeof(Image))

						arg_409_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_412_1 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_1 then
				arg_409_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_409_1.time_ - 0) / var_412_1)

				if arg_409_1.var_.actorSpriteSplit1037 ~= nil then
					arg_409_1.var_.actorSpriteSplit1037:SetAlpha((arg_409_1.time_ - 0) / var_412_1)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_1 and arg_409_1.time_ < 0 + var_412_1 + arg_412_0 then
				arg_409_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)

				if arg_409_1.var_.actorSpriteSplit1037 ~= nil then
					arg_409_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_412_2 = 0
			local var_412_3 = 0.7

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:GetWordFromCfg(424021099)
				local var_412_5 = arg_409_1:FormatText(var_412_4.content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 28 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 28)

				if (28 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 28)) > 0 and var_412_3 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021099", "story_v_out_424021.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_424021", "424021099", "story_v_out_424021.awb") / 1000

					if var_412_8 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_2
					end

					if var_412_4.prefab_name ~= "" and arg_409_1.actors_[var_412_4.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_4.prefab_name].transform, "story_v_out_424021", "424021099", "story_v_out_424021.awb")

						arg_409_1:RecordAudio("424021099", var_412_9)
						arg_409_1:RecordAudio("424021099", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_424021", "424021099", "story_v_out_424021.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_424021", "424021099", "story_v_out_424021.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_10 and arg_409_1.time_ < var_412_2 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play424021100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 424021100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play424021101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.075

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(424021100).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 3 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 3)

				if (3 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 3)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play424021101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 424021101
		arg_417_1.duration_ = 3.67

		local var_417_0 = {
			zh = 2.933,
			ja = 3.666
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play424021102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1047"]) and arg_417_1.var_.actorSpriteComps1047 == nil then
				arg_417_1.var_.actorSpriteComps1047 = arg_417_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1047"]) then
				if arg_417_1.var_.actorSpriteComps1047 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								iter_420_1.color = Color.New(Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor1.r, (arg_417_1.time_ - 0) / var_420_0), Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor1.g, (arg_417_1.time_ - 0) / var_420_0), (Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor1.b, (arg_417_1.time_ - 0) / var_420_0)))
							else
								local var_420_1 = Mathf.Lerp(iter_420_1.color.r, 1, (arg_417_1.time_ - 0) / var_420_0)

								iter_420_1.color = Color.New(var_420_1, var_420_1, var_420_1)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1047"]) and arg_417_1.var_.actorSpriteComps1047 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps1047 = nil
			end

			local var_420_2 = arg_417_1.actors_["1037"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1037 = var_420_2.localPosition
				var_420_2.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("1037", 7)

				for iter_420_4 = 0, var_420_2.childCount - 1 do
					local var_420_3 = var_420_2:GetChild(iter_420_4)

					if var_420_3.name == "" or not string.find(var_420_3.name, "split") then
						var_420_3.gameObject:SetActive(true)
					else
						var_420_3.gameObject:SetActive(false)
					end
				end
			end

			local var_420_4 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				var_420_2.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_417_1.time_ - 0) / var_420_4)
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				var_420_2.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_420_5 = arg_417_1.actors_["1047"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1047 = var_420_5.localPosition
				var_420_5.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("1047", 3)

				for iter_420_5 = 0, var_420_5.childCount - 1 do
					local var_420_6 = var_420_5:GetChild(iter_420_5)

					if var_420_6.name == "split_1" or not string.find(var_420_6.name, "split") then
						var_420_6.gameObject:SetActive(true)
					else
						var_420_6.gameObject:SetActive(false)
					end
				end
			end

			local var_420_7 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_7 then
				var_420_5.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_417_1.time_ - 0) / var_420_7)
			end

			if arg_417_1.time_ >= 0 + var_420_7 and arg_417_1.time_ < 0 + var_420_7 + arg_420_0 then
				var_420_5.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:SetSpriteNiuquEffect("1037", false)
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				local var_420_9 = arg_417_1.actors_["1037"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_420_9 then
					arg_417_1.var_.alphaOldValue1037 = var_420_9.alpha
					arg_417_1.var_.characterEffect1037 = var_420_9
				end

				arg_417_1.var_.alphaOldValue1037 = 0
			end

			local var_420_10 = 0.0333333333333333

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_10 then
				if arg_417_1.var_.characterEffect1037 then
					arg_417_1.var_.characterEffect1037.alpha = Mathf.Lerp(arg_417_1.var_.alphaOldValue1037, 1, (arg_417_1.time_ - 0) / var_420_10)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_10 and arg_417_1.time_ < 0 + var_420_10 + arg_420_0 and arg_417_1.var_.characterEffect1037 then
				arg_417_1.var_.characterEffect1037.alpha = 1
			end

			local var_420_11 = 0
			local var_420_12 = 0.275

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_11 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_13 = arg_417_1:GetWordFromCfg(424021101)
				local var_420_14 = arg_417_1:FormatText(var_420_13.content)

				arg_417_1.text_.text = var_420_14

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_16 = 11 <= 0 and var_420_12 or var_420_12 * (utf8.len(var_420_14) / 11)

				if (11 <= 0 and var_420_12 or var_420_12 * (utf8.len(var_420_14) / 11)) > 0 and var_420_12 < var_420_16 then
					arg_417_1.talkMaxDuration = var_420_16

					if var_420_16 + var_420_11 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_16 + var_420_11
					end
				end

				arg_417_1.text_.text = var_420_14
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021101", "story_v_out_424021.awb") ~= 0 then
					local var_420_17 = manager.audio:GetVoiceLength("story_v_out_424021", "424021101", "story_v_out_424021.awb") / 1000

					if var_420_17 + var_420_11 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_17 + var_420_11
					end

					if var_420_13.prefab_name ~= "" and arg_417_1.actors_[var_420_13.prefab_name] ~= nil then
						local var_420_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_13.prefab_name].transform, "story_v_out_424021", "424021101", "story_v_out_424021.awb")

						arg_417_1:RecordAudio("424021101", var_420_18)
						arg_417_1:RecordAudio("424021101", var_420_18)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_424021", "424021101", "story_v_out_424021.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_424021", "424021101", "story_v_out_424021.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_19 = math.max(var_420_12, arg_417_1.talkMaxDuration)

			if var_420_11 <= arg_417_1.time_ and arg_417_1.time_ < var_420_11 + var_420_19 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_11) / var_420_19

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_11 + var_420_19 and arg_417_1.time_ < var_420_11 + var_420_19 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play424021102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 424021102
		arg_421_1.duration_ = 1

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"

			SetActive(arg_421_1.choicesGo_, true)

			for iter_422_0, iter_422_1 in ipairs(arg_421_1.choices_) do
				SetActive(iter_422_1.go, iter_422_0 <= 2)
			end

			arg_421_1.choices_[1].txt.text = arg_421_1:FormatText(StoryChoiceCfg[1478].name)
			arg_421_1.choices_[2].txt.text = arg_421_1:FormatText(StoryChoiceCfg[1479].name)
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play424021103(arg_421_1)
			end

			if arg_423_0 == 2 then
				arg_421_0:Play424021105(arg_421_1)
			end

			arg_421_1:RecordChoiceLog(424021102, 1478, 1479)
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1047"]) and arg_421_1.var_.actorSpriteComps1047 == nil then
				arg_421_1.var_.actorSpriteComps1047 = arg_421_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1047"]) then
				if arg_421_1.var_.actorSpriteComps1047 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								iter_424_1.color = Color.New(Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor2.r, (arg_421_1.time_ - 0) / var_424_0), Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor2.g, (arg_421_1.time_ - 0) / var_424_0), (Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor2.b, (arg_421_1.time_ - 0) / var_424_0)))
							else
								local var_424_1 = Mathf.Lerp(iter_424_1.color.r, 0.5, (arg_421_1.time_ - 0) / var_424_0)

								iter_424_1.color = Color.New(var_424_1, var_424_1, var_424_1)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1047"]) and arg_421_1.var_.actorSpriteComps1047 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_424_3 then
						iter_424_3.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps1047 = nil
			end

			local var_424_2 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			if arg_421_1.time_ >= var_424_2 + 0.5 and arg_421_1.time_ < var_424_2 + 0.5 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play424021103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 424021103
		arg_425_1.duration_ = 3.27

		local var_425_0 = {
			zh = 2.4,
			ja = 3.266
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play424021104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1047"]) and arg_425_1.var_.actorSpriteComps1047 == nil then
				arg_425_1.var_.actorSpriteComps1047 = arg_425_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1047"]) then
				if arg_425_1.var_.actorSpriteComps1047 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								iter_428_1.color = Color.New(Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor1.r, (arg_425_1.time_ - 0) / var_428_0), Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor1.g, (arg_425_1.time_ - 0) / var_428_0), (Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor1.b, (arg_425_1.time_ - 0) / var_428_0)))
							else
								local var_428_1 = Mathf.Lerp(iter_428_1.color.r, 1, (arg_425_1.time_ - 0) / var_428_0)

								iter_428_1.color = Color.New(var_428_1, var_428_1, var_428_1)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1047"]) and arg_425_1.var_.actorSpriteComps1047 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_428_3 then
						iter_428_3.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_425_1.var_.actorSpriteComps1047 = nil
			end

			local var_428_2 = arg_425_1.actors_["1047"].transform

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1047 = var_428_2.localPosition
				var_428_2.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("1047", 3)

				for iter_428_4 = 0, var_428_2.childCount - 1 do
					local var_428_3 = var_428_2:GetChild(iter_428_4)

					if var_428_3.name == "split_2" then
						var_428_3:SetAsLastSibling()
						var_428_3.gameObject:SetActive(true)

						arg_425_1.var_.actorSpriteSplit1047 = var_428_3.gameObject:GetComponent(typeof(Image))

						arg_425_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_428_4 = 0.5

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				var_428_2.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_425_1.time_ - 0) / var_428_4)

				if arg_425_1.var_.actorSpriteSplit1047 ~= nil then
					arg_425_1.var_.actorSpriteSplit1047:SetAlpha((arg_425_1.time_ - 0) / var_428_4)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				var_428_2.localPosition = Vector3.New(-38.9, -360, -319.3)

				if arg_425_1.var_.actorSpriteSplit1047 ~= nil then
					arg_425_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_428_5 = 0
			local var_428_6 = 0.25

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_7 = arg_425_1:GetWordFromCfg(424021103)
				local var_428_8 = arg_425_1:FormatText(var_428_7.content)

				arg_425_1.text_.text = var_428_8

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_10 = 10 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_8) / 10)

				if (10 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_8) / 10)) > 0 and var_428_6 < var_428_10 then
					arg_425_1.talkMaxDuration = var_428_10

					if var_428_10 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_5
					end
				end

				arg_425_1.text_.text = var_428_8
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021103", "story_v_out_424021.awb") ~= 0 then
					local var_428_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021103", "story_v_out_424021.awb") / 1000

					if var_428_11 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_11 + var_428_5
					end

					if var_428_7.prefab_name ~= "" and arg_425_1.actors_[var_428_7.prefab_name] ~= nil then
						local var_428_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_7.prefab_name].transform, "story_v_out_424021", "424021103", "story_v_out_424021.awb")

						arg_425_1:RecordAudio("424021103", var_428_12)
						arg_425_1:RecordAudio("424021103", var_428_12)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_424021", "424021103", "story_v_out_424021.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_424021", "424021103", "story_v_out_424021.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_13 = math.max(var_428_6, arg_425_1.talkMaxDuration)

			if var_428_5 <= arg_425_1.time_ and arg_425_1.time_ < var_428_5 + var_428_13 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_5) / var_428_13

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_5 + var_428_13 and arg_425_1.time_ < var_428_5 + var_428_13 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play424021104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 424021104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play424021107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1047"]) and arg_429_1.var_.actorSpriteComps1047 == nil then
				arg_429_1.var_.actorSpriteComps1047 = arg_429_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1047"]) then
				if arg_429_1.var_.actorSpriteComps1047 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								iter_432_1.color = Color.New(Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor2.r, (arg_429_1.time_ - 0) / var_432_0), Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor2.g, (arg_429_1.time_ - 0) / var_432_0), (Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor2.b, (arg_429_1.time_ - 0) / var_432_0)))
							else
								local var_432_1 = Mathf.Lerp(iter_432_1.color.r, 0.5, (arg_429_1.time_ - 0) / var_432_0)

								iter_432_1.color = Color.New(var_432_1, var_432_1, var_432_1)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1047"]) and arg_429_1.var_.actorSpriteComps1047 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps1047 = nil
			end

			local var_432_2 = 0
			local var_432_3 = 0.075

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_4 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(424021104).content)

				arg_429_1.text_.text = var_432_4

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_6 = 3 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_4) / 3)

				if (3 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_4) / 3)) > 0 and var_432_3 < var_432_6 then
					arg_429_1.talkMaxDuration = var_432_6

					if var_432_6 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_6 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_4
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_7 and arg_429_1.time_ < var_432_2 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play424021107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 424021107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play424021108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 1.3

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(424021107).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 52 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 52)

				if (52 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 52)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play424021108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 424021108
		arg_437_1.duration_ = 3.87

		local var_437_0 = {
			zh = 2.966,
			ja = 3.866
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play424021109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1047"]) and arg_437_1.var_.actorSpriteComps1047 == nil then
				arg_437_1.var_.actorSpriteComps1047 = arg_437_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_0 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1047"]) then
				if arg_437_1.var_.actorSpriteComps1047 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								iter_440_1.color = Color.New(Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor1.r, (arg_437_1.time_ - 0) / var_440_0), Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor1.g, (arg_437_1.time_ - 0) / var_440_0), (Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor1.b, (arg_437_1.time_ - 0) / var_440_0)))
							else
								local var_440_1 = Mathf.Lerp(iter_440_1.color.r, 1, (arg_437_1.time_ - 0) / var_440_0)

								iter_440_1.color = Color.New(var_440_1, var_440_1, var_440_1)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1047"]) and arg_437_1.var_.actorSpriteComps1047 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_440_3 then
						iter_440_3.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_437_1.var_.actorSpriteComps1047 = nil
			end

			local var_440_2 = arg_437_1.actors_["1047"].transform

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1047 = var_440_2.localPosition
				var_440_2.localScale = Vector3.New(1, 1, 1)

				arg_437_1:CheckSpriteTmpPos("1047", 3)

				for iter_440_4 = 0, var_440_2.childCount - 1 do
					local var_440_3 = var_440_2:GetChild(iter_440_4)

					if var_440_3.name == "split_7" then
						var_440_3:SetAsLastSibling()
						var_440_3.gameObject:SetActive(true)

						arg_437_1.var_.actorSpriteSplit1047 = var_440_3.gameObject:GetComponent(typeof(Image))

						arg_437_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_440_4 = 0.5

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				var_440_2.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_437_1.time_ - 0) / var_440_4)

				if arg_437_1.var_.actorSpriteSplit1047 ~= nil then
					arg_437_1.var_.actorSpriteSplit1047:SetAlpha((arg_437_1.time_ - 0) / var_440_4)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				var_440_2.localPosition = Vector3.New(-38.9, -360, -319.3)

				if arg_437_1.var_.actorSpriteSplit1047 ~= nil then
					arg_437_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_440_5 = 0
			local var_440_6 = 0.375

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_5 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_7 = arg_437_1:GetWordFromCfg(424021108)
				local var_440_8 = arg_437_1:FormatText(var_440_7.content)

				arg_437_1.text_.text = var_440_8

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_10 = 15 <= 0 and var_440_6 or var_440_6 * (utf8.len(var_440_8) / 15)

				if (15 <= 0 and var_440_6 or var_440_6 * (utf8.len(var_440_8) / 15)) > 0 and var_440_6 < var_440_10 then
					arg_437_1.talkMaxDuration = var_440_10

					if var_440_10 + var_440_5 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_5
					end
				end

				arg_437_1.text_.text = var_440_8
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021108", "story_v_out_424021.awb") ~= 0 then
					local var_440_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021108", "story_v_out_424021.awb") / 1000

					if var_440_11 + var_440_5 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_11 + var_440_5
					end

					if var_440_7.prefab_name ~= "" and arg_437_1.actors_[var_440_7.prefab_name] ~= nil then
						local var_440_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_7.prefab_name].transform, "story_v_out_424021", "424021108", "story_v_out_424021.awb")

						arg_437_1:RecordAudio("424021108", var_440_12)
						arg_437_1:RecordAudio("424021108", var_440_12)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_424021", "424021108", "story_v_out_424021.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_424021", "424021108", "story_v_out_424021.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_13 = math.max(var_440_6, arg_437_1.talkMaxDuration)

			if var_440_5 <= arg_437_1.time_ and arg_437_1.time_ < var_440_5 + var_440_13 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_5) / var_440_13

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_5 + var_440_13 and arg_437_1.time_ < var_440_5 + var_440_13 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play424021109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 424021109
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play424021110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1047"]) and arg_441_1.var_.actorSpriteComps1047 == nil then
				arg_441_1.var_.actorSpriteComps1047 = arg_441_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_0 = 0.2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1047"]) then
				if arg_441_1.var_.actorSpriteComps1047 then
					for iter_444_0, iter_444_1 in pairs(arg_441_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_444_1 then
							if arg_441_1.isInRecall_ then
								iter_444_1.color = Color.New(Mathf.Lerp(iter_444_1.color.r, arg_441_1.hightColor2.r, (arg_441_1.time_ - 0) / var_444_0), Mathf.Lerp(iter_444_1.color.g, arg_441_1.hightColor2.g, (arg_441_1.time_ - 0) / var_444_0), (Mathf.Lerp(iter_444_1.color.b, arg_441_1.hightColor2.b, (arg_441_1.time_ - 0) / var_444_0)))
							else
								local var_444_1 = Mathf.Lerp(iter_444_1.color.r, 0.5, (arg_441_1.time_ - 0) / var_444_0)

								iter_444_1.color = Color.New(var_444_1, var_444_1, var_444_1)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1047"]) and arg_441_1.var_.actorSpriteComps1047 then
				for iter_444_2, iter_444_3 in pairs(arg_441_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_444_3 then
						iter_444_3.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_441_1.var_.actorSpriteComps1047 = nil
			end

			local var_444_2 = 0
			local var_444_3 = 0.35

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
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

				local var_444_4 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(424021109).content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_6 = 14 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_4) / 14)

				if (14 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_4) / 14)) > 0 and var_444_3 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_7 and arg_441_1.time_ < var_444_2 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play424021110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 424021110
		arg_445_1.duration_ = 6.83

		local var_445_0 = {
			zh = 3.866,
			ja = 6.833
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
				arg_445_0:Play424021111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1047"]) and arg_445_1.var_.actorSpriteComps1047 == nil then
				arg_445_1.var_.actorSpriteComps1047 = arg_445_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1047"]) then
				if arg_445_1.var_.actorSpriteComps1047 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_448_1 then
							if arg_445_1.isInRecall_ then
								iter_448_1.color = Color.New(Mathf.Lerp(iter_448_1.color.r, arg_445_1.hightColor1.r, (arg_445_1.time_ - 0) / var_448_0), Mathf.Lerp(iter_448_1.color.g, arg_445_1.hightColor1.g, (arg_445_1.time_ - 0) / var_448_0), (Mathf.Lerp(iter_448_1.color.b, arg_445_1.hightColor1.b, (arg_445_1.time_ - 0) / var_448_0)))
							else
								local var_448_1 = Mathf.Lerp(iter_448_1.color.r, 1, (arg_445_1.time_ - 0) / var_448_0)

								iter_448_1.color = Color.New(var_448_1, var_448_1, var_448_1)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1047"]) and arg_445_1.var_.actorSpriteComps1047 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_448_3 then
						iter_448_3.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_445_1.var_.actorSpriteComps1047 = nil
			end

			local var_448_2 = arg_445_1.actors_["1047"].transform

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1047 = var_448_2.localPosition
				var_448_2.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("1047", 3)

				for iter_448_4 = 0, var_448_2.childCount - 1 do
					local var_448_3 = var_448_2:GetChild(iter_448_4)

					if var_448_3.name == "split_1" then
						var_448_3:SetAsLastSibling()
						var_448_3.gameObject:SetActive(true)

						arg_445_1.var_.actorSpriteSplit1047 = var_448_3.gameObject:GetComponent(typeof(Image))

						arg_445_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_448_4 = 0.5

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				var_448_2.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_445_1.time_ - 0) / var_448_4)

				if arg_445_1.var_.actorSpriteSplit1047 ~= nil then
					arg_445_1.var_.actorSpriteSplit1047:SetAlpha((arg_445_1.time_ - 0) / var_448_4)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				var_448_2.localPosition = Vector3.New(-38.9, -360, -319.3)

				if arg_445_1.var_.actorSpriteSplit1047 ~= nil then
					arg_445_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_448_5 = 0
			local var_448_6 = 0.45

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_7 = arg_445_1:GetWordFromCfg(424021110)
				local var_448_8 = arg_445_1:FormatText(var_448_7.content)

				arg_445_1.text_.text = var_448_8

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_10 = 18 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_8) / 18)

				if (18 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_8) / 18)) > 0 and var_448_6 < var_448_10 then
					arg_445_1.talkMaxDuration = var_448_10

					if var_448_10 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_5
					end
				end

				arg_445_1.text_.text = var_448_8
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021110", "story_v_out_424021.awb") ~= 0 then
					local var_448_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021110", "story_v_out_424021.awb") / 1000

					if var_448_11 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_11 + var_448_5
					end

					if var_448_7.prefab_name ~= "" and arg_445_1.actors_[var_448_7.prefab_name] ~= nil then
						local var_448_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_7.prefab_name].transform, "story_v_out_424021", "424021110", "story_v_out_424021.awb")

						arg_445_1:RecordAudio("424021110", var_448_12)
						arg_445_1:RecordAudio("424021110", var_448_12)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_424021", "424021110", "story_v_out_424021.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_424021", "424021110", "story_v_out_424021.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_13 = math.max(var_448_6, arg_445_1.talkMaxDuration)

			if var_448_5 <= arg_445_1.time_ and arg_445_1.time_ < var_448_5 + var_448_13 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_5) / var_448_13

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_5 + var_448_13 and arg_445_1.time_ < var_448_5 + var_448_13 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play424021111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 424021111
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
			arg_449_1.auto_ = false
		end

		function arg_449_1.playNext_(arg_451_0)
			arg_449_1.onStoryFinished_()
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1047"]) and arg_449_1.var_.actorSpriteComps1047 == nil then
				arg_449_1.var_.actorSpriteComps1047 = arg_449_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1047"]) then
				if arg_449_1.var_.actorSpriteComps1047 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								iter_452_1.color = Color.New(Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor2.r, (arg_449_1.time_ - 0) / var_452_0), Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor2.g, (arg_449_1.time_ - 0) / var_452_0), (Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor2.b, (arg_449_1.time_ - 0) / var_452_0)))
							else
								local var_452_1 = Mathf.Lerp(iter_452_1.color.r, 0.5, (arg_449_1.time_ - 0) / var_452_0)

								iter_452_1.color = Color.New(var_452_1, var_452_1, var_452_1)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1047"]) and arg_449_1.var_.actorSpriteComps1047 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_452_3 then
						iter_452_3.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_449_1.var_.actorSpriteComps1047 = nil
			end

			local var_452_2 = 0
			local var_452_3 = 0.85

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_4 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(424021111).content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_6 = 34 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 34)

				if (34 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 34)) > 0 and var_452_3 < var_452_6 then
					arg_449_1.talkMaxDuration = var_452_6

					if var_452_6 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_6 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 <= arg_449_1.time_ and arg_449_1.time_ < var_452_2 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_2) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_2 + var_452_7 and arg_449_1.time_ < var_452_2 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play424021105 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 424021105
		arg_453_1.duration_ = 2.2

		local var_453_0 = {
			zh = 2.2,
			ja = 1.8
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play424021106(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1047"]) and arg_453_1.var_.actorSpriteComps1047 == nil then
				arg_453_1.var_.actorSpriteComps1047 = arg_453_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1047"]) then
				if arg_453_1.var_.actorSpriteComps1047 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								iter_456_1.color = Color.New(Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor1.r, (arg_453_1.time_ - 0) / var_456_0), Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor1.g, (arg_453_1.time_ - 0) / var_456_0), (Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor1.b, (arg_453_1.time_ - 0) / var_456_0)))
							else
								local var_456_1 = Mathf.Lerp(iter_456_1.color.r, 1, (arg_453_1.time_ - 0) / var_456_0)

								iter_456_1.color = Color.New(var_456_1, var_456_1, var_456_1)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1047"]) and arg_453_1.var_.actorSpriteComps1047 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_453_1.var_.actorSpriteComps1047 = nil
			end

			local var_456_2 = arg_453_1.actors_["1047"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1047 = var_456_2.localPosition
				var_456_2.localScale = Vector3.New(1, 1, 1)

				arg_453_1:CheckSpriteTmpPos("1047", 3)

				for iter_456_4 = 0, var_456_2.childCount - 1 do
					local var_456_3 = var_456_2:GetChild(iter_456_4)

					if var_456_3.name == "" or not string.find(var_456_3.name, "split") then
						var_456_3.gameObject:SetActive(true)
					else
						var_456_3.gameObject:SetActive(false)
					end
				end
			end

			local var_456_4 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				var_456_2.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_453_1.time_ - 0) / var_456_4)
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				var_456_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_456_5 = 0
			local var_456_6 = 0.125

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_5 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_7 = arg_453_1:GetWordFromCfg(424021105)
				local var_456_8 = arg_453_1:FormatText(var_456_7.content)

				arg_453_1.text_.text = var_456_8

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_10 = 5 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_8) / 5)

				if (5 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_8) / 5)) > 0 and var_456_6 < var_456_10 then
					arg_453_1.talkMaxDuration = var_456_10

					if var_456_10 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_5
					end
				end

				arg_453_1.text_.text = var_456_8
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424021", "424021105", "story_v_out_424021.awb") ~= 0 then
					local var_456_11 = manager.audio:GetVoiceLength("story_v_out_424021", "424021105", "story_v_out_424021.awb") / 1000

					if var_456_11 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_11 + var_456_5
					end

					if var_456_7.prefab_name ~= "" and arg_453_1.actors_[var_456_7.prefab_name] ~= nil then
						local var_456_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_7.prefab_name].transform, "story_v_out_424021", "424021105", "story_v_out_424021.awb")

						arg_453_1:RecordAudio("424021105", var_456_12)
						arg_453_1:RecordAudio("424021105", var_456_12)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_424021", "424021105", "story_v_out_424021.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_424021", "424021105", "story_v_out_424021.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_13 = math.max(var_456_6, arg_453_1.talkMaxDuration)

			if var_456_5 <= arg_453_1.time_ and arg_453_1.time_ < var_456_5 + var_456_13 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_5) / var_456_13

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_5 + var_456_13 and arg_453_1.time_ < var_456_5 + var_456_13 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play424021106 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424021106
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play424021107(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1047"]) and arg_457_1.var_.actorSpriteComps1047 == nil then
				arg_457_1.var_.actorSpriteComps1047 = arg_457_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_0 = 0.2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1047"]) then
				if arg_457_1.var_.actorSpriteComps1047 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_460_1 then
							if arg_457_1.isInRecall_ then
								iter_460_1.color = Color.New(Mathf.Lerp(iter_460_1.color.r, arg_457_1.hightColor2.r, (arg_457_1.time_ - 0) / var_460_0), Mathf.Lerp(iter_460_1.color.g, arg_457_1.hightColor2.g, (arg_457_1.time_ - 0) / var_460_0), (Mathf.Lerp(iter_460_1.color.b, arg_457_1.hightColor2.b, (arg_457_1.time_ - 0) / var_460_0)))
							else
								local var_460_1 = Mathf.Lerp(iter_460_1.color.r, 0.5, (arg_457_1.time_ - 0) / var_460_0)

								iter_460_1.color = Color.New(var_460_1, var_460_1, var_460_1)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1047"]) and arg_457_1.var_.actorSpriteComps1047 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_460_3 then
						iter_460_3.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_457_1.var_.actorSpriteComps1047 = nil
			end

			local var_460_2 = 0
			local var_460_3 = 0.425

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_2 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_4 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(424021106).content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_6 = 17 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_4) / 17)

				if (17 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_4) / 17)) > 0 and var_460_3 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_2
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_3, arg_457_1.talkMaxDuration)

			if var_460_2 <= arg_457_1.time_ and arg_457_1.time_ < var_460_2 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_2) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_2 + var_460_7 and arg_457_1.time_ < var_460_2 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST34",
		"TextureConfig/Background/ST0106"
	},
	voices = {
		"story_v_out_424021.awb"
	}
}
