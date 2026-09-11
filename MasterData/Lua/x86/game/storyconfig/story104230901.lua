return {
	Play423091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423091001
		arg_1_1.duration_ = 3.53

		local var_1_0 = {
			zh = 3.266,
			ja = 3.533
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
				arg_1_0:Play423091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I25g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25g")
				var_4_0.name = "I25g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I25g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I25g

				arg_1_1.bgs_.I25g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I25g" then
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

			local var_4_9 = "1083"

			if arg_1_1.actors_["1083"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

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

			local var_4_12 = arg_1_1.actors_["1083"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1083 == nil then
				arg_1_1.var_.actorSpriteComps1083 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1083 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1083 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1083 = nil
			end

			local var_4_15 = arg_1_1.actors_["1083"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1083 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1083", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_8" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_1_1.time_ - 1.8) / var_4_17)
			end

			if arg_1_1.time_ >= 1.8 + var_4_17 and arg_1_1.time_ < 1.8 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-50, -345, -345)
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1083 = var_4_18.alpha
					arg_1_1.var_.characterEffect1083 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1083 = 0
			end

			local var_4_19 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_19 then
				if arg_1_1.var_.characterEffect1083 then
					arg_1_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1083, 1, (arg_1_1.time_ - 1.8) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_19 and arg_1_1.time_ < 1.8 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1083 then
				arg_1_1.var_.characterEffect1083.alpha = 1
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_town_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			local var_4_27 = 2
			local var_4_28 = 0.05

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1341].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_30 = arg_1_1:GetWordFromCfg(423091001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 2 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 2)

				if (2 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 2)) > 0 and var_4_28 < var_4_33 then
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

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091001", "story_v_out_423091.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_423091", "423091001", "story_v_out_423091.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_423091", "423091001", "story_v_out_423091.awb")

						arg_1_1:RecordAudio("423091001", var_4_35)
						arg_1_1:RecordAudio("423091001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423091", "423091001", "story_v_out_423091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423091", "423091001", "story_v_out_423091.awb")
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
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1083"]) and arg_9_1.var_.actorSpriteComps1083 == nil then
				arg_9_1.var_.actorSpriteComps1083 = arg_9_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1083"]) then
				if arg_9_1.var_.actorSpriteComps1083 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1083"]) and arg_9_1.var_.actorSpriteComps1083 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1083 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_4 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_4:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423091002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 28 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 28)

				if (28 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 28)) > 0 and var_12_3 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7
					var_12_2 = var_12_2 + 0.3

					if var_12_7 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = var_12_2 + 0.3
			local var_12_9 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423091003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 423091003
		arg_15_1.duration_ = 14.83

		local var_15_0 = {
			zh = 9.1,
			ja = 14.833
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
				arg_15_0:Play423091004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 1.075 < arg_15_1.time_ and arg_15_1.time_ <= 1.075 + arg_18_0 then
				arg_15_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_clap", "")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_1 = arg_15_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_18_1 then
					arg_15_1.var_.alphaOldValue1083 = var_18_1.alpha
					arg_15_1.var_.characterEffect1083 = var_18_1
				end

				arg_15_1.var_.alphaOldValue1083 = 1
			end

			local var_18_2 = 0.5

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 then
				if arg_15_1.var_.characterEffect1083 then
					arg_15_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_15_1.var_.alphaOldValue1083, 0, (arg_15_1.time_ - 0) / var_18_2)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and arg_15_1.var_.characterEffect1083 then
				arg_15_1.var_.characterEffect1083.alpha = 0
			end

			local var_18_3 = 0
			local var_18_4 = 1.075

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_3 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_5 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_5:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_6 = arg_15_1:GetWordFromCfg(423091003)
				local var_18_7 = arg_15_1:FormatText(var_18_6.content)

				arg_15_1.text_.text = var_18_7

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_9 = 43 <= 0 and var_18_4 or var_18_4 * (utf8.len(var_18_7) / 43)

				if (43 <= 0 and var_18_4 or var_18_4 * (utf8.len(var_18_7) / 43)) > 0 and var_18_4 < var_18_9 then
					arg_15_1.talkMaxDuration = var_18_9
					var_18_3 = var_18_3 + 0.3

					if var_18_9 + var_18_3 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_9 + var_18_3
					end
				end

				arg_15_1.text_.text = var_18_7
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091003", "story_v_out_423091.awb") ~= 0 then
					local var_18_10 = manager.audio:GetVoiceLength("story_v_out_423091", "423091003", "story_v_out_423091.awb") / 1000

					if var_18_10 + var_18_3 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_10 + var_18_3
					end

					if var_18_6.prefab_name ~= "" and arg_15_1.actors_[var_18_6.prefab_name] ~= nil then
						local var_18_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_6.prefab_name].transform, "story_v_out_423091", "423091003", "story_v_out_423091.awb")

						arg_15_1:RecordAudio("423091003", var_18_11)
						arg_15_1:RecordAudio("423091003", var_18_11)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_423091", "423091003", "story_v_out_423091.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_423091", "423091003", "story_v_out_423091.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_12 = var_18_3 + 0.3
			local var_18_13 = math.max(var_18_4, arg_15_1.talkMaxDuration)

			if var_18_3 + 0.3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_13 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_12) / var_18_13

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_12 + var_18_13 and arg_15_1.time_ < var_18_12 + var_18_13 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play423091004 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423091004
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play423091005(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.95

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(423091004).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 38 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 38)

				if (38 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 38)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play423091005 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423091005
		arg_25_1.duration_ = 8.53

		local var_25_0 = {
			zh = 5.833,
			ja = 8.533
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
				arg_25_0:Play423091006(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(423091005)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091005", "story_v_out_423091.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091005", "story_v_out_423091.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_423091", "423091005", "story_v_out_423091.awb")

						arg_25_1:RecordAudio("423091005", var_28_6)
						arg_25_1:RecordAudio("423091005", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423091", "423091005", "story_v_out_423091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423091", "423091005", "story_v_out_423091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play423091006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423091006
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423091007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(423091006).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 47 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 47)

				if (47 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 47)) > 0 and var_32_0 < var_32_3 then
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
	Play423091007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423091007
		arg_33_1.duration_ = 10.57

		local var_33_0 = {
			zh = 10.566,
			ja = 8.966
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
				arg_33_0:Play423091008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(423091007)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 55 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 55)

				if (55 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 55)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091007", "story_v_out_423091.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091007", "story_v_out_423091.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_423091", "423091007", "story_v_out_423091.awb")

						arg_33_1:RecordAudio("423091007", var_36_6)
						arg_33_1:RecordAudio("423091007", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423091", "423091007", "story_v_out_423091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423091", "423091007", "story_v_out_423091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play423091008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423091008
		arg_37_1.duration_ = 5.53

		local var_37_0 = {
			zh = 4.4,
			ja = 5.533
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
				arg_37_0:Play423091009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(423091008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 19 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 19)

				if (19 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 19)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091008", "story_v_out_423091.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091008", "story_v_out_423091.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_423091", "423091008", "story_v_out_423091.awb")

						arg_37_1:RecordAudio("423091008", var_40_6)
						arg_37_1:RecordAudio("423091008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423091", "423091008", "story_v_out_423091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423091", "423091008", "story_v_out_423091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423091009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423091009
		arg_41_1.duration_ = 12.43

		local var_41_0 = {
			zh = 7.533,
			ja = 12.433
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
				arg_41_0:Play423091010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1083"]) and arg_41_1.var_.actorSpriteComps1083 == nil then
				arg_41_1.var_.actorSpriteComps1083 = arg_41_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1083"]) then
				if arg_41_1.var_.actorSpriteComps1083 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1083"]) and arg_41_1.var_.actorSpriteComps1083 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1083 = nil
			end

			local var_44_2 = arg_41_1.actors_["1083"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 3)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "split_1" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_5 = arg_41_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_44_5 then
					arg_41_1.var_.alphaOldValue1083 = var_44_5.alpha
					arg_41_1.var_.characterEffect1083 = var_44_5
				end

				arg_41_1.var_.alphaOldValue1083 = 0
			end

			local var_44_6 = 0.5

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 then
				if arg_41_1.var_.characterEffect1083 then
					arg_41_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_41_1.var_.alphaOldValue1083, 1, (arg_41_1.time_ - 0) / var_44_6)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and arg_41_1.var_.characterEffect1083 then
				arg_41_1.var_.characterEffect1083.alpha = 1
			end

			local var_44_7 = 0
			local var_44_8 = 0.875

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(423091009)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 35 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_10) / 35)

				if (35 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_10) / 35)) > 0 and var_44_8 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091009", "story_v_out_423091.awb") ~= 0 then
					local var_44_13 = manager.audio:GetVoiceLength("story_v_out_423091", "423091009", "story_v_out_423091.awb") / 1000

					if var_44_13 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_7
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_423091", "423091009", "story_v_out_423091.awb")

						arg_41_1:RecordAudio("423091009", var_44_14)
						arg_41_1:RecordAudio("423091009", var_44_14)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423091", "423091009", "story_v_out_423091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423091", "423091009", "story_v_out_423091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_15 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_15 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_7) / var_44_15

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_7 + var_44_15 and arg_41_1.time_ < var_44_7 + var_44_15 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423091010
		arg_45_1.duration_ = 7.57

		local var_45_0 = {
			zh = 4.4,
			ja = 7.566
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
				arg_45_0:Play423091011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = arg_45_1.actors_["1083"].transform.localPosition
				arg_45_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 3)

				for iter_48_0 = 0, arg_45_1.actors_["1083"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1083"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_1" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_48_2 = 0
			local var_48_3 = 0.625

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(423091010)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 25 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 25)

				if (25 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 25)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091010", "story_v_out_423091.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091010", "story_v_out_423091.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_423091", "423091010", "story_v_out_423091.awb")

						arg_45_1:RecordAudio("423091010", var_48_9)
						arg_45_1:RecordAudio("423091010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423091", "423091010", "story_v_out_423091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423091", "423091010", "story_v_out_423091.awb")
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

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423091011
		arg_49_1.duration_ = 11.7

		local var_49_0 = {
			zh = 5.7,
			ja = 11.7
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
				arg_49_0:Play423091012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1083"]) and arg_49_1.var_.actorSpriteComps1083 == nil then
				arg_49_1.var_.actorSpriteComps1083 = arg_49_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1083"]) then
				if arg_49_1.var_.actorSpriteComps1083 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1083"]) and arg_49_1.var_.actorSpriteComps1083 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1083 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.65

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_4 = arg_49_1:GetWordFromCfg(423091011)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 26 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 26)

				if (26 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 26)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091011", "story_v_out_423091.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091011", "story_v_out_423091.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_423091", "423091011", "story_v_out_423091.awb")

						arg_49_1:RecordAudio("423091011", var_52_9)
						arg_49_1:RecordAudio("423091011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423091", "423091011", "story_v_out_423091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423091", "423091011", "story_v_out_423091.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play423091012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423091012
		arg_53_1.duration_ = 18.6

		local var_53_0 = {
			zh = 10.766,
			ja = 18.6
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
				arg_53_0:Play423091013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1083 = arg_53_1.actors_["1083"].transform.localPosition
				arg_53_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1083", 3)

				for iter_56_0 = 0, arg_53_1.actors_["1083"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1083"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_1" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_56_2 = 0
			local var_56_3 = 1.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(423091012)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 47 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 47)

				if (47 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 47)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091012", "story_v_out_423091.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091012", "story_v_out_423091.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_423091", "423091012", "story_v_out_423091.awb")

						arg_53_1:RecordAudio("423091012", var_56_9)
						arg_53_1:RecordAudio("423091012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423091", "423091012", "story_v_out_423091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423091", "423091012", "story_v_out_423091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423091013
		arg_57_1.duration_ = 7.93

		local var_57_0 = {
			zh = 7.933,
			ja = 7.733
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
				arg_57_0:Play423091014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(423091013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 34 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 34)

				if (34 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 34)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091013", "story_v_out_423091.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091013", "story_v_out_423091.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_423091", "423091013", "story_v_out_423091.awb")

						arg_57_1:RecordAudio("423091013", var_60_6)
						arg_57_1:RecordAudio("423091013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423091", "423091013", "story_v_out_423091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423091", "423091013", "story_v_out_423091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play423091014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423091014
		arg_61_1.duration_ = 9.2

		local var_61_0 = {
			zh = 9.2,
			ja = 8.5
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
				arg_61_0:Play423091015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0.5 < arg_61_1.time_ and arg_61_1.time_ <= 0.5 + arg_64_0 then
				arg_61_1.var_.moveOldPos1083 = arg_61_1.actors_["1083"].transform.localPosition
				arg_61_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1083", 3)

				for iter_64_0 = 0, arg_61_1.actors_["1083"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1083"].transform:GetChild(iter_64_0)

					if var_64_0.name == "split_8" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0.5 <= arg_61_1.time_ and arg_61_1.time_ < 0.5 + var_64_1 then
				arg_61_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_61_1.time_ - 0.5) / var_64_1)
			end

			if arg_61_1.time_ >= 0.5 + var_64_1 and arg_61_1.time_ < 0.5 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_64_2 = 0
			local var_64_3 = 0.875

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:GetWordFromCfg(423091014)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 35 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 35)

				if (35 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 35)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091014", "story_v_out_423091.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091014", "story_v_out_423091.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_423091", "423091014", "story_v_out_423091.awb")

						arg_61_1:RecordAudio("423091014", var_64_9)
						arg_61_1:RecordAudio("423091014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_423091", "423091014", "story_v_out_423091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_423091", "423091014", "story_v_out_423091.awb")
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play423091015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423091015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play423091016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.15

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(423091015).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 46 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 46)

				if (46 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 46)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play423091016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423091016
		arg_69_1.duration_ = 7.37

		local var_69_0 = {
			zh = 6.166,
			ja = 7.366
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
				arg_69_0:Play423091017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1083"]) and arg_69_1.var_.actorSpriteComps1083 == nil then
				arg_69_1.var_.actorSpriteComps1083 = arg_69_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1083"]) then
				if arg_69_1.var_.actorSpriteComps1083 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 1, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1083"]) and arg_69_1.var_.actorSpriteComps1083 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1083 = nil
			end

			local var_72_2 = arg_69_1.actors_["1083"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1083 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1083", 3)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "split_2" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_72_5 = 0
			local var_72_6 = 0.7

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(423091016)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 28 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 28)

				if (28 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 28)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091016", "story_v_out_423091.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091016", "story_v_out_423091.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_423091", "423091016", "story_v_out_423091.awb")

						arg_69_1:RecordAudio("423091016", var_72_12)
						arg_69_1:RecordAudio("423091016", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423091", "423091016", "story_v_out_423091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423091", "423091016", "story_v_out_423091.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423091017
		arg_73_1.duration_ = 9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play423091018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.bgs_.I25h == nil then
				local var_76_0 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25h")
				var_76_0.name = "I25h"
				var_76_0.transform.parent = arg_73_1.stage_.transform
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_.I25h = var_76_0
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_1 = arg_73_1.bgs_.I25h

				arg_73_1.bgs_.I25h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_2 = var_76_1:GetComponent("SpriteRenderer")

				if var_76_2 and var_76_2.sprite then
					local var_76_3 = 2 * (var_76_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_1.transform.localScale = Vector3.New(var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "I25h" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_4 = 4

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_4 + 0.3 and arg_73_1.time_ < var_76_4 + 0.3 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			local var_76_5 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_6 = 2

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_6 then
				local var_76_7 = Color.New(0, 0, 0)

				var_76_7.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_5) / var_76_6)
				arg_73_1.mask_.color = var_76_7
			end

			if arg_73_1.time_ >= var_76_5 + var_76_6 and arg_73_1.time_ < var_76_5 + var_76_6 + arg_76_0 then
				local var_76_8 = Color.New(0, 0, 0)

				var_76_8.a = 1
				arg_73_1.mask_.color = var_76_8
			end

			local var_76_9 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_10 = 2

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 then
				local var_76_11 = Color.New(0, 0, 0)

				var_76_11.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_9) / var_76_10)
				arg_73_1.mask_.color = var_76_11
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 then
				local var_76_12 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_12.a = 0
				arg_73_1.mask_.color = var_76_12
			end

			local var_76_13 = arg_73_1.actors_["1083"]

			if 1.8 < arg_73_1.time_ and arg_73_1.time_ <= 1.8 + arg_76_0 and not isNil(var_76_13) and arg_73_1.var_.actorSpriteComps1083 == nil then
				arg_73_1.var_.actorSpriteComps1083 = var_76_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_14 = 0.2

			if 1.8 <= arg_73_1.time_ and arg_73_1.time_ < 1.8 + var_76_14 and not isNil(var_76_13) then
				if arg_73_1.var_.actorSpriteComps1083 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								iter_76_3.color = Color.New(Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 1.8) / var_76_14), Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 1.8) / var_76_14), (Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 1.8) / var_76_14)))
							else
								local var_76_15 = Mathf.Lerp(iter_76_3.color.r, 0.5, (arg_73_1.time_ - 1.8) / var_76_14)

								iter_76_3.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 1.8 + var_76_14 and arg_73_1.time_ < 1.8 + var_76_14 + arg_76_0 and not isNil(var_76_13) and arg_73_1.var_.actorSpriteComps1083 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_76_5 then
						iter_76_5.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1083 = nil
			end

			local var_76_16 = arg_73_1.actors_["1083"].transform

			if 1.966 < arg_73_1.time_ and arg_73_1.time_ <= 1.966 + arg_76_0 then
				arg_73_1.var_.moveOldPos1083 = var_76_16.localPosition
				var_76_16.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1083", 7)

				for iter_76_6 = 0, var_76_16.childCount - 1 do
					local var_76_17 = var_76_16:GetChild(iter_76_6)

					if var_76_17.name == "" or not string.find(var_76_17.name, "split") then
						var_76_17.gameObject:SetActive(true)
					else
						var_76_17.gameObject:SetActive(false)
					end
				end
			end

			local var_76_18 = 0.001

			if 1.966 <= arg_73_1.time_ and arg_73_1.time_ < 1.966 + var_76_18 then
				var_76_16.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 1.966) / var_76_18)
			end

			if arg_73_1.time_ >= 1.966 + var_76_18 and arg_73_1.time_ < 1.966 + var_76_18 + arg_76_0 then
				var_76_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_73_1.time_ and arg_73_1.time_ <= 0.1 + arg_76_0 then
				arg_73_1:AudioAction("stop", "effect", "se_story_144", "se_story_144_amb_town_loop", "")
			end

			if 1.6 < arg_73_1.time_ and arg_73_1.time_ <= 1.6 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_21 = 4
			local var_76_22 = 1.625

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_23 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_23:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(423091017).content)

				arg_73_1.text_.text = var_76_24

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 65 <= 0 and var_76_22 or var_76_22 * (utf8.len(var_76_24) / 65)

				if (65 <= 0 and var_76_22 or var_76_22 * (utf8.len(var_76_24) / 65)) > 0 and var_76_22 < var_76_26 then
					arg_73_1.talkMaxDuration = var_76_26
					var_76_21 = var_76_21 + 0.3

					if var_76_26 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_26 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_24
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_27 = var_76_21 + 0.3
			local var_76_28 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_27 + var_76_28 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_27) / var_76_28

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_27 + var_76_28 and arg_73_1.time_ < var_76_27 + var_76_28 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play423091018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423091018
		arg_79_1.duration_ = 10.7

		local var_79_0 = {
			zh = 6.833,
			ja = 10.7
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
				arg_79_0:Play423091019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.actors_["10148"] == nil then
				local var_82_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_82_0) then
					local var_82_1 = Object.Instantiate(var_82_0, arg_79_1.canvasGo_.transform)

					var_82_1.transform:SetSiblingIndex(1)

					var_82_1.name = "10148"
					var_82_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_79_1.actors_["10148"] = var_82_1

					if arg_79_1.isInRecall_ then
						for iter_82_0, iter_82_1 in ipairs((var_82_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_82_1.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_82_2 = arg_79_1.actors_["10148"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10148 == nil then
				arg_79_1.var_.actorSpriteComps10148 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps10148 then
					for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_82_3 then
							if arg_79_1.isInRecall_ then
								iter_82_3.color = Color.New(Mathf.Lerp(iter_82_3.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_3.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_3.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_3.color.r, 1, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_3.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10148 then
				for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_82_5 then
						iter_82_5.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10148 = nil
			end

			local var_82_5 = arg_79_1.actors_["10148"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10148 = var_82_5.localPosition
				var_82_5.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10148", 3)

				for iter_82_6 = 0, var_82_5.childCount - 1 do
					local var_82_6 = var_82_5:GetChild(iter_82_6)

					if var_82_6.name == "split_1" or not string.find(var_82_6.name, "split") then
						var_82_6.gameObject:SetActive(true)
					else
						var_82_6.gameObject:SetActive(false)
					end
				end
			end

			local var_82_7 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				var_82_5.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_79_1.time_ - 0) / var_82_7)
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				var_82_5.localPosition = Vector3.New(0, -350, -270)
			end

			local var_82_8 = 0
			local var_82_9 = 0.975

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(423091018)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 39 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 39)

				if (39 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 39)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091018", "story_v_out_423091.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_423091", "423091018", "story_v_out_423091.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_423091", "423091018", "story_v_out_423091.awb")

						arg_79_1:RecordAudio("423091018", var_82_15)
						arg_79_1:RecordAudio("423091018", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_423091", "423091018", "story_v_out_423091.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_423091", "423091018", "story_v_out_423091.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423091019
		arg_83_1.duration_ = 8.5

		local var_83_0 = {
			zh = 6.933,
			ja = 8.5
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
				arg_83_0:Play423091020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.8

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(423091019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 32 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 32)

				if (32 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 32)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091019", "story_v_out_423091.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091019", "story_v_out_423091.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_423091", "423091019", "story_v_out_423091.awb")

						arg_83_1:RecordAudio("423091019", var_86_6)
						arg_83_1:RecordAudio("423091019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_423091", "423091019", "story_v_out_423091.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_423091", "423091019", "story_v_out_423091.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play423091020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423091020
		arg_87_1.duration_ = 11.6

		local var_87_0 = {
			zh = 7.566,
			ja = 11.6
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
				arg_87_0:Play423091021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10148 = arg_87_1.actors_["10148"].transform.localPosition
				arg_87_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10148", 3)

				for iter_90_0 = 0, arg_87_1.actors_["10148"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["10148"].transform:GetChild(iter_90_0)

					if var_90_0.name == "split_2" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_90_2 = 0
			local var_90_3 = 0.975

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(423091020)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 39 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 39)

				if (39 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 39)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091020", "story_v_out_423091.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091020", "story_v_out_423091.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_423091", "423091020", "story_v_out_423091.awb")

						arg_87_1:RecordAudio("423091020", var_90_9)
						arg_87_1:RecordAudio("423091020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_423091", "423091020", "story_v_out_423091.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_423091", "423091020", "story_v_out_423091.awb")
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

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423091021
		arg_91_1.duration_ = 12.3

		local var_91_0 = {
			zh = 10.833,
			ja = 12.3
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
				arg_91_0:Play423091022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10148 = arg_91_1.actors_["10148"].transform.localPosition
				arg_91_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10148", 3)

				for iter_94_0 = 0, arg_91_1.actors_["10148"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["10148"].transform:GetChild(iter_94_0)

					if var_94_0.name == "" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_94_2 = 0
			local var_94_3 = 1.25

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(423091021)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 50 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 50)

				if (50 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 50)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091021", "story_v_out_423091.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091021", "story_v_out_423091.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_423091", "423091021", "story_v_out_423091.awb")

						arg_91_1:RecordAudio("423091021", var_94_9)
						arg_91_1:RecordAudio("423091021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423091", "423091021", "story_v_out_423091.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423091", "423091021", "story_v_out_423091.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423091022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play423091023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10148"]) and arg_95_1.var_.actorSpriteComps10148 == nil then
				arg_95_1.var_.actorSpriteComps10148 = arg_95_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10148"]) then
				if arg_95_1.var_.actorSpriteComps10148 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10148"]) and arg_95_1.var_.actorSpriteComps10148 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_98_3 then
						iter_98_3.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10148 = nil
			end

			local var_98_2 = arg_95_1.actors_["10148"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10148 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10148", 7)

				for iter_98_4 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_4)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_5 = 0
			local var_98_6 = 2.025

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(423091022).content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 81 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 81)

				if (81 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 81)) > 0 and var_98_6 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_10 and arg_95_1.time_ < var_98_5 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423091023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play423091024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.35

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(423091023).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 14 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 14)

				if (14 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 14)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play423091024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423091024
		arg_103_1.duration_ = 10.1

		local var_103_0 = {
			zh = 8.366,
			ja = 10.1
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
				arg_103_0:Play423091025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1083"]) and arg_103_1.var_.actorSpriteComps1083 == nil then
				arg_103_1.var_.actorSpriteComps1083 = arg_103_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1083"]) then
				if arg_103_1.var_.actorSpriteComps1083 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1083"]) and arg_103_1.var_.actorSpriteComps1083 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1083 = nil
			end

			local var_106_2 = arg_103_1.actors_["1083"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1083 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1083", 3)

				for iter_106_4 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_4)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_106_5 = 0
			local var_106_6 = 0.875

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(423091024)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 35 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 35)

				if (35 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 35)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091024", "story_v_out_423091.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091024", "story_v_out_423091.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_423091", "423091024", "story_v_out_423091.awb")

						arg_103_1:RecordAudio("423091024", var_106_12)
						arg_103_1:RecordAudio("423091024", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_423091", "423091024", "story_v_out_423091.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_423091", "423091024", "story_v_out_423091.awb")
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
				actorName = "1083",
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
	Play423091025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423091025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play423091026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1083"]) and arg_107_1.var_.actorSpriteComps1083 == nil then
				arg_107_1.var_.actorSpriteComps1083 = arg_107_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1083"]) then
				if arg_107_1.var_.actorSpriteComps1083 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1083"]) and arg_107_1.var_.actorSpriteComps1083 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1083 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.75

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(423091025).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 30 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 30)

				if (30 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 30)) > 0 and var_110_3 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_7 and arg_107_1.time_ < var_110_2 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play423091026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423091026
		arg_111_1.duration_ = 10.47

		local var_111_0 = {
			zh = 9.9,
			ja = 10.466
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
				arg_111_0:Play423091027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1083"]) and arg_111_1.var_.actorSpriteComps1083 == nil then
				arg_111_1.var_.actorSpriteComps1083 = arg_111_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1083"]) then
				if arg_111_1.var_.actorSpriteComps1083 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 1, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1083"]) and arg_111_1.var_.actorSpriteComps1083 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1083 = nil
			end

			local var_114_2 = arg_111_1.actors_["1083"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1083 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1083", 3)

				for iter_114_4 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_4)

					if var_114_3.name == "split_2" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_111_1.time_ - 0) / var_114_4)
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_114_5 = 0
			local var_114_6 = 0.95

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(423091026)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 38 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 38)

				if (38 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 38)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091026", "story_v_out_423091.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091026", "story_v_out_423091.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_423091", "423091026", "story_v_out_423091.awb")

						arg_111_1:RecordAudio("423091026", var_114_12)
						arg_111_1:RecordAudio("423091026", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423091", "423091026", "story_v_out_423091.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423091", "423091026", "story_v_out_423091.awb")
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
				actorName = "1083",
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
	Play423091027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423091027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play423091028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1083"]) and arg_115_1.var_.actorSpriteComps1083 == nil then
				arg_115_1.var_.actorSpriteComps1083 = arg_115_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1083"]) then
				if arg_115_1.var_.actorSpriteComps1083 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1083"]) and arg_115_1.var_.actorSpriteComps1083 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1083 = nil
			end

			local var_118_2 = 0
			local var_118_3 = 0.825

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

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_4 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(423091027).content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_6 = 33 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_4) / 33)

				if (33 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_4) / 33)) > 0 and var_118_3 < var_118_6 then
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
	Play423091028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423091028
		arg_119_1.duration_ = 8.07

		local var_119_0 = {
			zh = 5.3,
			ja = 8.066
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
				arg_119_0:Play423091029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1083"]) and arg_119_1.var_.actorSpriteComps1083 == nil then
				arg_119_1.var_.actorSpriteComps1083 = arg_119_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1083"]) then
				if arg_119_1.var_.actorSpriteComps1083 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1083"]) and arg_119_1.var_.actorSpriteComps1083 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1083 = nil
			end

			local var_122_2 = arg_119_1.actors_["1083"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1083 = var_122_2.localPosition
				var_122_2.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1083", 3)

				for iter_122_4 = 0, var_122_2.childCount - 1 do
					local var_122_3 = var_122_2:GetChild(iter_122_4)

					if var_122_3.name == "" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_2.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_119_1.time_ - 0) / var_122_4)
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_122_5 = 0
			local var_122_6 = 0.525

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(423091028)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 21 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 21)

				if (21 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 21)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091028", "story_v_out_423091.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091028", "story_v_out_423091.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_423091", "423091028", "story_v_out_423091.awb")

						arg_119_1:RecordAudio("423091028", var_122_12)
						arg_119_1:RecordAudio("423091028", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_423091", "423091028", "story_v_out_423091.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_423091", "423091028", "story_v_out_423091.awb")
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
				actorName = "1083",
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
	Play423091029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 423091029
		arg_123_1.duration_ = 17.8

		local var_123_0 = {
			zh = 13.666,
			ja = 17.8
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
				arg_123_0:Play423091030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1083 = arg_123_1.actors_["1083"].transform.localPosition
				arg_123_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1083", 3)

				for iter_126_0 = 0, arg_123_1.actors_["1083"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["1083"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_126_2 = 0
			local var_126_3 = 1.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(423091029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 64 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 64)

				if (64 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 64)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091029", "story_v_out_423091.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091029", "story_v_out_423091.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_423091", "423091029", "story_v_out_423091.awb")

						arg_123_1:RecordAudio("423091029", var_126_9)
						arg_123_1:RecordAudio("423091029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_423091", "423091029", "story_v_out_423091.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_423091", "423091029", "story_v_out_423091.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423091030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play423091031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1083"]) and arg_127_1.var_.actorSpriteComps1083 == nil then
				arg_127_1.var_.actorSpriteComps1083 = arg_127_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1083"]) then
				if arg_127_1.var_.actorSpriteComps1083 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1083"]) and arg_127_1.var_.actorSpriteComps1083 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1083 = nil
			end

			local var_130_2 = 0
			local var_130_3 = 0.85

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

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_4 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(423091030).content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 34 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 34)

				if (34 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 34)) > 0 and var_130_3 < var_130_6 then
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
	Play423091031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 423091031
		arg_131_1.duration_ = 8.47

		local var_131_0 = {
			zh = 7.966,
			ja = 8.466
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
				arg_131_0:Play423091032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1083"]) and arg_131_1.var_.actorSpriteComps1083 == nil then
				arg_131_1.var_.actorSpriteComps1083 = arg_131_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1083"]) then
				if arg_131_1.var_.actorSpriteComps1083 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1083"]) and arg_131_1.var_.actorSpriteComps1083 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1083 = nil
			end

			local var_134_2 = arg_131_1.actors_["1083"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1083 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1083", 3)

				for iter_134_4 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_4)

					if var_134_3.name == "split_2" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_131_1.time_ - 0) / var_134_4)
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_134_5 = 0
			local var_134_6 = 0.8

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(423091031)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 32 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 32)

				if (32 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 32)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091031", "story_v_out_423091.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091031", "story_v_out_423091.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_423091", "423091031", "story_v_out_423091.awb")

						arg_131_1:RecordAudio("423091031", var_134_12)
						arg_131_1:RecordAudio("423091031", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_423091", "423091031", "story_v_out_423091.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_423091", "423091031", "story_v_out_423091.awb")
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
				actorName = "1083",
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
	Play423091032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423091032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play423091033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1083"]) and arg_135_1.var_.actorSpriteComps1083 == nil then
				arg_135_1.var_.actorSpriteComps1083 = arg_135_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1083"]) then
				if arg_135_1.var_.actorSpriteComps1083 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1083"]) and arg_135_1.var_.actorSpriteComps1083 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1083 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 0.425

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_4 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(423091032).content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 17 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 17)

				if (17 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 17)) > 0 and var_138_3 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_7 and arg_135_1.time_ < var_138_2 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play423091033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423091033
		arg_139_1.duration_ = 8.67

		local var_139_0 = {
			zh = 7,
			ja = 8.666
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
				arg_139_0:Play423091034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1083"]) and arg_139_1.var_.actorSpriteComps1083 == nil then
				arg_139_1.var_.actorSpriteComps1083 = arg_139_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1083"]) then
				if arg_139_1.var_.actorSpriteComps1083 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1083"]) and arg_139_1.var_.actorSpriteComps1083 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1083 = nil
			end

			local var_142_2 = arg_139_1.actors_["1083"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1083 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1083", 3)

				for iter_142_4 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_4)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_142_5 = 0
			local var_142_6 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(423091033)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 34 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 34)

				if (34 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 34)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091033", "story_v_out_423091.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091033", "story_v_out_423091.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_423091", "423091033", "story_v_out_423091.awb")

						arg_139_1:RecordAudio("423091033", var_142_12)
						arg_139_1:RecordAudio("423091033", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_423091", "423091033", "story_v_out_423091.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_423091", "423091033", "story_v_out_423091.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_13 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_13 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_13

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_13 and arg_139_1.time_ < var_142_5 + var_142_13 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 423091034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play423091035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1083"]) and arg_143_1.var_.actorSpriteComps1083 == nil then
				arg_143_1.var_.actorSpriteComps1083 = arg_143_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1083"]) then
				if arg_143_1.var_.actorSpriteComps1083 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1083"]) and arg_143_1.var_.actorSpriteComps1083 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps1083 = nil
			end

			local var_146_2 = 0
			local var_146_3 = 0.575

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

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_4 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(423091034).content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 23 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_4) / 23)

				if (23 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_4) / 23)) > 0 and var_146_3 < var_146_6 then
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
	Play423091035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 423091035
		arg_147_1.duration_ = 4.73

		local var_147_0 = {
			zh = 4.5,
			ja = 4.733
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
				arg_147_0:Play423091036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1083"]) and arg_147_1.var_.actorSpriteComps1083 == nil then
				arg_147_1.var_.actorSpriteComps1083 = arg_147_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1083"]) then
				if arg_147_1.var_.actorSpriteComps1083 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1083"]) and arg_147_1.var_.actorSpriteComps1083 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1083 = nil
			end

			local var_150_2 = arg_147_1.actors_["1083"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1083 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1083", 3)

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
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_147_1.time_ - 0) / var_150_4)
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_150_5 = 0
			local var_150_6 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(423091035)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 20 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 20)

				if (20 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 20)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091035", "story_v_out_423091.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091035", "story_v_out_423091.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_423091", "423091035", "story_v_out_423091.awb")

						arg_147_1:RecordAudio("423091035", var_150_12)
						arg_147_1:RecordAudio("423091035", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_423091", "423091035", "story_v_out_423091.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_423091", "423091035", "story_v_out_423091.awb")
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
				actorName = "1083",
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
	Play423091036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 423091036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play423091037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1083"]) and arg_151_1.var_.actorSpriteComps1083 == nil then
				arg_151_1.var_.actorSpriteComps1083 = arg_151_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1083"]) then
				if arg_151_1.var_.actorSpriteComps1083 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1083"]) and arg_151_1.var_.actorSpriteComps1083 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1083 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.775

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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(423091036).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 31 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 31)

				if (31 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 31)) > 0 and var_154_3 < var_154_6 then
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
	Play423091037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 423091037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play423091038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1083 = arg_155_1.actors_["1083"].transform.localPosition
				arg_155_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1083", 7)

				for iter_158_0 = 0, arg_155_1.actors_["1083"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["1083"].transform:GetChild(iter_158_0)

					if var_158_0.name == "" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.433333333333333 < arg_155_1.time_ and arg_155_1.time_ <= 0.433333333333333 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_158_3 = 0
			local var_158_4 = 1.05

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(423091037).content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 42 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 42)

				if (42 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 42)) > 0 and var_158_4 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_8 and arg_155_1.time_ < var_158_3 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 423091038
		arg_159_1.duration_ = 6.73

		local var_159_0 = {
			zh = 6,
			ja = 6.733
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
				arg_159_0:Play423091039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10148"]) and arg_159_1.var_.actorSpriteComps10148 == nil then
				arg_159_1.var_.actorSpriteComps10148 = arg_159_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10148"]) then
				if arg_159_1.var_.actorSpriteComps10148 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 1, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10148"]) and arg_159_1.var_.actorSpriteComps10148 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10148 = nil
			end

			local var_162_2 = arg_159_1.actors_["10148"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10148 = var_162_2.localPosition
				var_162_2.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10148", 2)

				for iter_162_4 = 0, var_162_2.childCount - 1 do
					local var_162_3 = var_162_2:GetChild(iter_162_4)

					if var_162_3.name == "" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_2.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_159_1.time_ - 0) / var_162_4)
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_2.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_162_5 = 0
			local var_162_6 = 0.6

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(423091038)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 24 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 24)

				if (24 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 24)) > 0 and var_162_6 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091038", "story_v_out_423091.awb") ~= 0 then
					local var_162_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091038", "story_v_out_423091.awb") / 1000

					if var_162_11 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_5
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_423091", "423091038", "story_v_out_423091.awb")

						arg_159_1:RecordAudio("423091038", var_162_12)
						arg_159_1:RecordAudio("423091038", var_162_12)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_423091", "423091038", "story_v_out_423091.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_423091", "423091038", "story_v_out_423091.awb")
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
				actorName = "10148",
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
	Play423091039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423091039
		arg_163_1.duration_ = 5.63

		local var_163_0 = {
			zh = 3.566,
			ja = 5.633
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
				arg_163_0:Play423091040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1083"]) and arg_163_1.var_.actorSpriteComps1083 == nil then
				arg_163_1.var_.actorSpriteComps1083 = arg_163_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1083"]) then
				if arg_163_1.var_.actorSpriteComps1083 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1083"]) and arg_163_1.var_.actorSpriteComps1083 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1083 = nil
			end

			local var_166_2 = arg_163_1.actors_["10148"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10148 == nil then
				arg_163_1.var_.actorSpriteComps10148 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10148 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_166_5 then
							if arg_163_1.isInRecall_ then
								iter_166_5.color = Color.New(Mathf.Lerp(iter_166_5.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_5.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_5.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_5.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_5.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10148 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_166_7 then
						iter_166_7.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10148 = nil
			end

			local var_166_5 = arg_163_1.actors_["1083"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1083 = var_166_5.localPosition
				var_166_5.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1083", 4)

				for iter_166_8 = 0, var_166_5.childCount - 1 do
					local var_166_6 = var_166_5:GetChild(iter_166_8)

					if var_166_6.name == "" or not string.find(var_166_6.name, "split") then
						var_166_6.gameObject:SetActive(true)
					else
						var_166_6.gameObject:SetActive(false)
					end
				end
			end

			local var_166_7 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				var_166_5.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_163_1.time_ - 0) / var_166_7)
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				var_166_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_166_8 = 0
			local var_166_9 = 0.425

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(423091039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 17 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 17)

				if (17 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 17)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091039", "story_v_out_423091.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_423091", "423091039", "story_v_out_423091.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_423091", "423091039", "story_v_out_423091.awb")

						arg_163_1:RecordAudio("423091039", var_166_15)
						arg_163_1:RecordAudio("423091039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_423091", "423091039", "story_v_out_423091.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_423091", "423091039", "story_v_out_423091.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423091040
		arg_167_1.duration_ = 10.57

		local var_167_0 = {
			zh = 8.966,
			ja = 10.566
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
				arg_167_0:Play423091041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10148"]) and arg_167_1.var_.actorSpriteComps10148 == nil then
				arg_167_1.var_.actorSpriteComps10148 = arg_167_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10148"]) then
				if arg_167_1.var_.actorSpriteComps10148 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10148"]) and arg_167_1.var_.actorSpriteComps10148 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10148 = nil
			end

			local var_170_2 = arg_167_1.actors_["1083"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1083 == nil then
				arg_167_1.var_.actorSpriteComps1083 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps1083 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								iter_170_5.color = Color.New(Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_5.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_5.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1083 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1083 = nil
			end

			local var_170_5 = arg_167_1.actors_["10148"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10148 = var_170_5.localPosition
				var_170_5.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10148", 2)

				for iter_170_8 = 0, var_170_5.childCount - 1 do
					local var_170_6 = var_170_5:GetChild(iter_170_8)

					if var_170_6.name == "split_4" or not string.find(var_170_6.name, "split") then
						var_170_6.gameObject:SetActive(true)
					else
						var_170_6.gameObject:SetActive(false)
					end
				end
			end

			local var_170_7 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_167_1.time_ - 0) / var_170_7)
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_170_8 = 0
			local var_170_9 = 0.825

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(423091040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 33 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 33)

				if (33 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 33)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091040", "story_v_out_423091.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_423091", "423091040", "story_v_out_423091.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_423091", "423091040", "story_v_out_423091.awb")

						arg_167_1:RecordAudio("423091040", var_170_15)
						arg_167_1:RecordAudio("423091040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_423091", "423091040", "story_v_out_423091.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_423091", "423091040", "story_v_out_423091.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423091041
		arg_171_1.duration_ = 7.9

		local var_171_0 = {
			zh = 4.7,
			ja = 7.9
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
				arg_171_0:Play423091042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1083"]) and arg_171_1.var_.actorSpriteComps1083 == nil then
				arg_171_1.var_.actorSpriteComps1083 = arg_171_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1083"]) then
				if arg_171_1.var_.actorSpriteComps1083 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1083"]) and arg_171_1.var_.actorSpriteComps1083 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1083 = nil
			end

			local var_174_2 = arg_171_1.actors_["10148"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10148 == nil then
				arg_171_1.var_.actorSpriteComps10148 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10148 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_5.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_5.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10148 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10148 = nil
			end

			local var_174_5 = arg_171_1.actors_["1083"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1083 = var_174_5.localPosition
				var_174_5.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1083", 4)

				for iter_174_8 = 0, var_174_5.childCount - 1 do
					local var_174_6 = var_174_5:GetChild(iter_174_8)

					if var_174_6.name == "split_6" or not string.find(var_174_6.name, "split") then
						var_174_6.gameObject:SetActive(true)
					else
						var_174_6.gameObject:SetActive(false)
					end
				end
			end

			local var_174_7 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				var_174_5.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_171_1.time_ - 0) / var_174_7)
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				var_174_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_174_8 = 0
			local var_174_9 = 0.575

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(423091041)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 23 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 23)

				if (23 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 23)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091041", "story_v_out_423091.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_423091", "423091041", "story_v_out_423091.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_423091", "423091041", "story_v_out_423091.awb")

						arg_171_1:RecordAudio("423091041", var_174_15)
						arg_171_1:RecordAudio("423091041", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_423091", "423091041", "story_v_out_423091.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_423091", "423091041", "story_v_out_423091.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423091042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423091042
		arg_175_1.duration_ = 9.5

		local var_175_0 = {
			zh = 7.033,
			ja = 9.5
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
				arg_175_0:Play423091043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10148"]) and arg_175_1.var_.actorSpriteComps10148 == nil then
				arg_175_1.var_.actorSpriteComps10148 = arg_175_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10148"]) then
				if arg_175_1.var_.actorSpriteComps10148 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10148"]) and arg_175_1.var_.actorSpriteComps10148 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10148 = nil
			end

			local var_178_2 = arg_175_1.actors_["1083"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1083 == nil then
				arg_175_1.var_.actorSpriteComps1083 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1083 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								iter_178_5.color = Color.New(Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_5.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_5.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1083 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1083 = nil
			end

			local var_178_5 = arg_175_1.actors_["10148"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10148 = var_178_5.localPosition
				var_178_5.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10148", 2)

				for iter_178_8 = 0, var_178_5.childCount - 1 do
					local var_178_6 = var_178_5:GetChild(iter_178_8)

					if var_178_6.name == "split_4" or not string.find(var_178_6.name, "split") then
						var_178_6.gameObject:SetActive(true)
					else
						var_178_6.gameObject:SetActive(false)
					end
				end
			end

			local var_178_7 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_175_1.time_ - 0) / var_178_7)
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_178_8 = 0
			local var_178_9 = 0.775

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(423091042)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 31 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 31)

				if (31 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 31)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091042", "story_v_out_423091.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_423091", "423091042", "story_v_out_423091.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_423091", "423091042", "story_v_out_423091.awb")

						arg_175_1:RecordAudio("423091042", var_178_15)
						arg_175_1:RecordAudio("423091042", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_423091", "423091042", "story_v_out_423091.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_423091", "423091042", "story_v_out_423091.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423091043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play423091044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10148"]) and arg_179_1.var_.actorSpriteComps10148 == nil then
				arg_179_1.var_.actorSpriteComps10148 = arg_179_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10148"]) then
				if arg_179_1.var_.actorSpriteComps10148 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10148"]) and arg_179_1.var_.actorSpriteComps10148 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10148 = nil
			end

			local var_182_2 = 0
			local var_182_3 = 0.775

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
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

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_4 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(423091043).content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 31 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 31)

				if (31 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 31)) > 0 and var_182_3 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_7 and arg_179_1.time_ < var_182_2 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play423091044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423091044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play423091045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.675

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(423091044).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 27 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 27)

				if (27 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 27)) > 0 and var_186_0 < var_186_3 then
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
	Play423091045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423091045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423091046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1083 = arg_187_1.actors_["1083"].transform.localPosition
				arg_187_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1083", 7)

				for iter_190_0 = 0, arg_187_1.actors_["1083"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["1083"].transform:GetChild(iter_190_0)

					if var_190_0.name == "" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_2 = arg_187_1.actors_["10148"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10148 = var_190_2.localPosition
				var_190_2.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10148", 7)

				for iter_190_1 = 0, var_190_2.childCount - 1 do
					local var_190_3 = var_190_2:GetChild(iter_190_1)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_4)
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_5 = 0
			local var_190_6 = 1.3

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(423091045).content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 52 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_7) / 52)

				if (52 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_7) / 52)) > 0 and var_190_6 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_5
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_6, arg_187_1.talkMaxDuration)

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_5) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_5 + var_190_10 and arg_187_1.time_ < var_190_5 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play423091046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423091046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play423091047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.875

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

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(423091046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 75 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 75)

				if (75 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 75)) > 0 and var_194_0 < var_194_3 then
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
	Play423091047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423091047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play423091048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.7

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(423091047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 28 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 28)

				if (28 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 28)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play423091048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 423091048
		arg_199_1.duration_ = 8.7

		local var_199_0 = {
			zh = 6.2,
			ja = 8.7
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
				arg_199_0:Play423091049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10148"]) and arg_199_1.var_.actorSpriteComps10148 == nil then
				arg_199_1.var_.actorSpriteComps10148 = arg_199_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10148"]) then
				if arg_199_1.var_.actorSpriteComps10148 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 1, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10148"]) and arg_199_1.var_.actorSpriteComps10148 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10148 = nil
			end

			local var_202_2 = arg_199_1.actors_["10148"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10148 = var_202_2.localPosition
				var_202_2.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10148", 3)

				for iter_202_4 = 0, var_202_2.childCount - 1 do
					local var_202_3 = var_202_2:GetChild(iter_202_4)

					if var_202_3.name == "" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_199_1.time_ - 0) / var_202_4)
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_202_5 = 0
			local var_202_6 = 0.85

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(423091048)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 34 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 34)

				if (34 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 34)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091048", "story_v_out_423091.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091048", "story_v_out_423091.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_423091", "423091048", "story_v_out_423091.awb")

						arg_199_1:RecordAudio("423091048", var_202_12)
						arg_199_1:RecordAudio("423091048", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_423091", "423091048", "story_v_out_423091.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_423091", "423091048", "story_v_out_423091.awb")
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
				actorName = "10148",
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
	Play423091049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 423091049
		arg_203_1.duration_ = 13.87

		local var_203_0 = {
			zh = 7.5,
			ja = 13.866
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
				arg_203_0:Play423091050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(423091049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 40 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 40)

				if (40 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 40)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091049", "story_v_out_423091.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091049", "story_v_out_423091.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_423091", "423091049", "story_v_out_423091.awb")

						arg_203_1:RecordAudio("423091049", var_206_6)
						arg_203_1:RecordAudio("423091049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_423091", "423091049", "story_v_out_423091.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_423091", "423091049", "story_v_out_423091.awb")
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
	Play423091050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 423091050
		arg_207_1.duration_ = 11.2

		local var_207_0 = {
			zh = 6.266,
			ja = 11.2
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
				arg_207_0:Play423091051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10148 = arg_207_1.actors_["10148"].transform.localPosition
				arg_207_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10148", 3)

				for iter_210_0 = 0, arg_207_1.actors_["10148"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["10148"].transform:GetChild(iter_210_0)

					if var_210_0.name == "" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_210_2 = 0
			local var_210_3 = 0.775

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(423091050)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 31 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 31)

				if (31 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 31)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091050", "story_v_out_423091.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091050", "story_v_out_423091.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_423091", "423091050", "story_v_out_423091.awb")

						arg_207_1:RecordAudio("423091050", var_210_9)
						arg_207_1:RecordAudio("423091050", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_423091", "423091050", "story_v_out_423091.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_423091", "423091050", "story_v_out_423091.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play423091051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 423091051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play423091052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10148"]) and arg_211_1.var_.actorSpriteComps10148 == nil then
				arg_211_1.var_.actorSpriteComps10148 = arg_211_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10148"]) then
				if arg_211_1.var_.actorSpriteComps10148 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10148"]) and arg_211_1.var_.actorSpriteComps10148 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10148 = nil
			end

			local var_214_2 = 0
			local var_214_3 = 0.525

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_4 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(423091051).content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_6 = 21 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_4) / 21)

				if (21 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_4) / 21)) > 0 and var_214_3 < var_214_6 then
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

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play423091052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 423091052
		arg_215_1.duration_ = 11.73

		local var_215_0 = {
			zh = 6.5,
			ja = 11.733
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
				arg_215_0:Play423091053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10148"]) and arg_215_1.var_.actorSpriteComps10148 == nil then
				arg_215_1.var_.actorSpriteComps10148 = arg_215_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10148"]) then
				if arg_215_1.var_.actorSpriteComps10148 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 1, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10148"]) and arg_215_1.var_.actorSpriteComps10148 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps10148 = nil
			end

			local var_218_2 = arg_215_1.actors_["10148"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10148 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10148", 3)

				for iter_218_4 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_4)

					if var_218_3.name == "split_2" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_218_5 = 0
			local var_218_6 = 0.725

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:GetWordFromCfg(423091052)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 29 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 29)

				if (29 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 29)) > 0 and var_218_6 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091052", "story_v_out_423091.awb") ~= 0 then
					local var_218_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091052", "story_v_out_423091.awb") / 1000

					if var_218_11 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_5
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_423091", "423091052", "story_v_out_423091.awb")

						arg_215_1:RecordAudio("423091052", var_218_12)
						arg_215_1:RecordAudio("423091052", var_218_12)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_423091", "423091052", "story_v_out_423091.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_423091", "423091052", "story_v_out_423091.awb")
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
				actorName = "10148",
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
	Play423091053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 423091053
		arg_219_1.duration_ = 9.07

		local var_219_0 = {
			zh = 4.866,
			ja = 9.066
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
				arg_219_0:Play423091054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.625

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(423091053)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 25 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 25)

				if (25 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 25)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091053", "story_v_out_423091.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091053", "story_v_out_423091.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_423091", "423091053", "story_v_out_423091.awb")

						arg_219_1:RecordAudio("423091053", var_222_6)
						arg_219_1:RecordAudio("423091053", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_423091", "423091053", "story_v_out_423091.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_423091", "423091053", "story_v_out_423091.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play423091054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 423091054
		arg_223_1.duration_ = 8.63

		local var_223_0 = {
			zh = 5.266,
			ja = 8.633
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
				arg_223_0:Play423091055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10148 = arg_223_1.actors_["10148"].transform.localPosition
				arg_223_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10148", 3)

				for iter_226_0 = 0, arg_223_1.actors_["10148"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["10148"].transform:GetChild(iter_226_0)

					if var_226_0.name == "" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_226_2 = 0
			local var_226_3 = 0.6

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:GetWordFromCfg(423091054)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 24 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 24)

				if (24 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 24)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091054", "story_v_out_423091.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091054", "story_v_out_423091.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_out_423091", "423091054", "story_v_out_423091.awb")

						arg_223_1:RecordAudio("423091054", var_226_9)
						arg_223_1:RecordAudio("423091054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_423091", "423091054", "story_v_out_423091.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_423091", "423091054", "story_v_out_423091.awb")
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

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 423091055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play423091056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["10148"]) and arg_227_1.var_.actorSpriteComps10148 == nil then
				arg_227_1.var_.actorSpriteComps10148 = arg_227_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["10148"]) then
				if arg_227_1.var_.actorSpriteComps10148 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["10148"]) and arg_227_1.var_.actorSpriteComps10148 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps10148 = nil
			end

			local var_230_2 = 0
			local var_230_3 = 0.475

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_4 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(423091055).content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 19 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_4) / 19)

				if (19 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_4) / 19)) > 0 and var_230_3 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_7 and arg_227_1.time_ < var_230_2 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play423091056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 423091056
		arg_231_1.duration_ = 14.47

		local var_231_0 = {
			zh = 9.033,
			ja = 14.466
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
				arg_231_0:Play423091057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10148"]) and arg_231_1.var_.actorSpriteComps10148 == nil then
				arg_231_1.var_.actorSpriteComps10148 = arg_231_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10148"]) then
				if arg_231_1.var_.actorSpriteComps10148 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10148"]) and arg_231_1.var_.actorSpriteComps10148 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps10148 = nil
			end

			local var_234_2 = arg_231_1.actors_["10148"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10148 = var_234_2.localPosition
				var_234_2.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10148", 3)

				for iter_234_4 = 0, var_234_2.childCount - 1 do
					local var_234_3 = var_234_2:GetChild(iter_234_4)

					if var_234_3.name == "split_1" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_2.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_231_1.time_ - 0) / var_234_4)
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_234_5 = 0
			local var_234_6 = 1.15

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(423091056)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 46 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 46)

				if (46 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 46)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091056", "story_v_out_423091.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091056", "story_v_out_423091.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_423091", "423091056", "story_v_out_423091.awb")

						arg_231_1:RecordAudio("423091056", var_234_12)
						arg_231_1:RecordAudio("423091056", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_423091", "423091056", "story_v_out_423091.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_423091", "423091056", "story_v_out_423091.awb")
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
				actorName = "10148",
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
	Play423091057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 423091057
		arg_235_1.duration_ = 9.67

		local var_235_0 = {
			zh = 3.866,
			ja = 9.666
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
				arg_235_0:Play423091058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10148 = arg_235_1.actors_["10148"].transform.localPosition
				arg_235_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10148", 3)

				for iter_238_0 = 0, arg_235_1.actors_["10148"].transform.childCount - 1 do
					local var_238_0 = arg_235_1.actors_["10148"].transform:GetChild(iter_238_0)

					if var_238_0.name == "" or not string.find(var_238_0.name, "split") then
						var_238_0.gameObject:SetActive(true)
					else
						var_238_0.gameObject:SetActive(false)
					end
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_235_1.time_ - 0) / var_238_1)
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_238_2 = 0
			local var_238_3 = 0.525

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(423091057)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 21 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 21)

				if (21 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 21)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091057", "story_v_out_423091.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091057", "story_v_out_423091.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_423091", "423091057", "story_v_out_423091.awb")

						arg_235_1:RecordAudio("423091057", var_238_9)
						arg_235_1:RecordAudio("423091057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_423091", "423091057", "story_v_out_423091.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_423091", "423091057", "story_v_out_423091.awb")
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

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play423091058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 423091058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play423091059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10148"]) and arg_239_1.var_.actorSpriteComps10148 == nil then
				arg_239_1.var_.actorSpriteComps10148 = arg_239_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10148"]) then
				if arg_239_1.var_.actorSpriteComps10148 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10148"]) and arg_239_1.var_.actorSpriteComps10148 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10148 = nil
			end

			local var_242_2 = 0
			local var_242_3 = 1.175

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_4 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(423091058).content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 47 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 47)

				if (47 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 47)) > 0 and var_242_3 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_7 and arg_239_1.time_ < var_242_2 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play423091059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 423091059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play423091060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.625

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
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

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(423091059).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 25 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 25)

				if (25 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 25)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play423091060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 423091060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play423091061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10148 = arg_247_1.actors_["10148"].transform.localPosition
				arg_247_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10148", 7)

				for iter_250_0 = 0, arg_247_1.actors_["10148"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["10148"].transform:GetChild(iter_250_0)

					if var_250_0.name == "" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["10148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_2 = 0
			local var_250_3 = 1.675

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(423091060).content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 67 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_4) / 67)

				if (67 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_4) / 67)) > 0 and var_250_3 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_7 and arg_247_1.time_ < var_250_2 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 423091061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play423091062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.725

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(423091061).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 29 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 29)

				if (29 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 29)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play423091062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 423091062
		arg_255_1.duration_ = 9.7

		local var_255_0 = {
			zh = 5.7,
			ja = 9.7
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
				arg_255_0:Play423091063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10148"]) and arg_255_1.var_.actorSpriteComps10148 == nil then
				arg_255_1.var_.actorSpriteComps10148 = arg_255_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10148"]) then
				if arg_255_1.var_.actorSpriteComps10148 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10148"]) and arg_255_1.var_.actorSpriteComps10148 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10148 = nil
			end

			local var_258_2 = arg_255_1.actors_["10148"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10148 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10148", 3)

				for iter_258_4 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_4)

					if var_258_3.name == "" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_258_5 = 0
			local var_258_6 = 0.775

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(423091062)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 31 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 31)

				if (31 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 31)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091062", "story_v_out_423091.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091062", "story_v_out_423091.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_423091", "423091062", "story_v_out_423091.awb")

						arg_255_1:RecordAudio("423091062", var_258_12)
						arg_255_1:RecordAudio("423091062", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_423091", "423091062", "story_v_out_423091.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_423091", "423091062", "story_v_out_423091.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 423091063
		arg_259_1.duration_ = 11.73

		local var_259_0 = {
			zh = 7.366,
			ja = 11.733
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
				arg_259_0:Play423091064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10148 = arg_259_1.actors_["10148"].transform.localPosition
				arg_259_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10148", 3)

				for iter_262_0 = 0, arg_259_1.actors_["10148"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["10148"].transform:GetChild(iter_262_0)

					if var_262_0.name == "" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_262_2 = 0
			local var_262_3 = 0.975

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:GetWordFromCfg(423091063)
				local var_262_5 = arg_259_1:FormatText(var_262_4.content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 39 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 39)

				if (39 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 39)) > 0 and var_262_3 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091063", "story_v_out_423091.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091063", "story_v_out_423091.awb") / 1000

					if var_262_8 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_2
					end

					if var_262_4.prefab_name ~= "" and arg_259_1.actors_[var_262_4.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_4.prefab_name].transform, "story_v_out_423091", "423091063", "story_v_out_423091.awb")

						arg_259_1:RecordAudio("423091063", var_262_9)
						arg_259_1:RecordAudio("423091063", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_423091", "423091063", "story_v_out_423091.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_423091", "423091063", "story_v_out_423091.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_10 and arg_259_1.time_ < var_262_2 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423091064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 423091064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play423091065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10148"]) and arg_263_1.var_.actorSpriteComps10148 == nil then
				arg_263_1.var_.actorSpriteComps10148 = arg_263_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10148"]) then
				if arg_263_1.var_.actorSpriteComps10148 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10148"]) and arg_263_1.var_.actorSpriteComps10148 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10148 = nil
			end

			local var_266_2 = 0
			local var_266_3 = 0.625

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(423091064).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 25 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 25)

				if (25 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 25)) > 0 and var_266_3 < var_266_6 then
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
	Play423091065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 423091065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play423091066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.575

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(423091065).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 23 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 23)

				if (23 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 23)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play423091066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 423091066
		arg_271_1.duration_ = 21.23

		local var_271_0 = {
			zh = 12.132999999999,
			ja = 21.232999999999
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play423091067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.bgs_.I26f == nil then
				local var_274_0 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I26f")
				var_274_0.name = "I26f"
				var_274_0.transform.parent = arg_271_1.stage_.transform
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_.I26f = var_274_0
			end

			if 2 < arg_271_1.time_ and arg_271_1.time_ <= 2 + arg_274_0 then
				local var_274_1 = arg_271_1.bgs_.I26f

				arg_271_1.bgs_.I26f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_2 = var_274_1:GetComponent("SpriteRenderer")

				if var_274_2 and var_274_2.sprite then
					local var_274_3 = 2 * (var_274_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_1.transform.localScale = Vector3.New(var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "I26f" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_4 = 3.999999999999

			if 3.999999999999 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= var_274_4 + 0.3 and arg_271_1.time_ < var_274_4 + 0.3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_5 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_6 = 2

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_6 then
				local var_274_7 = Color.New(0, 0, 0)

				var_274_7.a = Mathf.Lerp(0, 1, (arg_271_1.time_ - var_274_5) / var_274_6)
				arg_271_1.mask_.color = var_274_7
			end

			if arg_271_1.time_ >= var_274_5 + var_274_6 and arg_271_1.time_ < var_274_5 + var_274_6 + arg_274_0 then
				local var_274_8 = Color.New(0, 0, 0)

				var_274_8.a = 1
				arg_271_1.mask_.color = var_274_8
			end

			local var_274_9 = 2

			if 2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_10 = 2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 then
				local var_274_11 = Color.New(0, 0, 0)

				var_274_11.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_9) / var_274_10)
				arg_271_1.mask_.color = var_274_11
			end

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 then
				local var_274_12 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_12.a = 0
				arg_271_1.mask_.color = var_274_12
			end

			local var_274_13 = "10146"

			if arg_271_1.actors_["10146"] == nil then
				local var_274_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_274_14) then
					local var_274_15 = Object.Instantiate(var_274_14, arg_271_1.canvasGo_.transform)

					var_274_15.transform:SetSiblingIndex(1)

					var_274_15.name = var_274_13
					var_274_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_271_1.actors_[var_274_13] = var_274_15

					if arg_271_1.isInRecall_ then
						for iter_274_2, iter_274_3 in ipairs((var_274_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_274_16 = arg_271_1.actors_["10146"]

			if 3.8 < arg_271_1.time_ and arg_271_1.time_ <= 3.8 + arg_274_0 and not isNil(var_274_16) and arg_271_1.var_.actorSpriteComps10146 == nil then
				arg_271_1.var_.actorSpriteComps10146 = var_274_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_17 = 0.2

			if 3.8 <= arg_271_1.time_ and arg_271_1.time_ < 3.8 + var_274_17 and not isNil(var_274_16) then
				if arg_271_1.var_.actorSpriteComps10146 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								iter_274_5.color = Color.New(Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 3.8) / var_274_17), Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 3.8) / var_274_17), (Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 3.8) / var_274_17)))
							else
								local var_274_18 = Mathf.Lerp(iter_274_5.color.r, 1, (arg_271_1.time_ - 3.8) / var_274_17)

								iter_274_5.color = Color.New(var_274_18, var_274_18, var_274_18)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 3.8 + var_274_17 and arg_271_1.time_ < 3.8 + var_274_17 + arg_274_0 and not isNil(var_274_16) and arg_271_1.var_.actorSpriteComps10146 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_274_7 then
						iter_274_7.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10146 = nil
			end

			local var_274_19 = arg_271_1.actors_["10148"].transform

			if 1.966 < arg_271_1.time_ and arg_271_1.time_ <= 1.966 + arg_274_0 then
				arg_271_1.var_.moveOldPos10148 = var_274_19.localPosition
				var_274_19.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10148", 7)

				for iter_274_8 = 0, var_274_19.childCount - 1 do
					local var_274_20 = var_274_19:GetChild(iter_274_8)

					if var_274_20.name == "" or not string.find(var_274_20.name, "split") then
						var_274_20.gameObject:SetActive(true)
					else
						var_274_20.gameObject:SetActive(false)
					end
				end
			end

			local var_274_21 = 0.001

			if 1.966 <= arg_271_1.time_ and arg_271_1.time_ < 1.966 + var_274_21 then
				var_274_19.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_271_1.time_ - 1.966) / var_274_21)
			end

			if arg_271_1.time_ >= 1.966 + var_274_21 and arg_271_1.time_ < 1.966 + var_274_21 + arg_274_0 then
				var_274_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_22 = arg_271_1.actors_["10146"].transform

			if 3.8 < arg_271_1.time_ and arg_271_1.time_ <= 3.8 + arg_274_0 then
				arg_271_1.var_.moveOldPos10146 = var_274_22.localPosition
				var_274_22.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10146", 3)

				for iter_274_9 = 0, var_274_22.childCount - 1 do
					local var_274_23 = var_274_22:GetChild(iter_274_9)

					if var_274_23.name == "split_3" or not string.find(var_274_23.name, "split") then
						var_274_23.gameObject:SetActive(true)
					else
						var_274_23.gameObject:SetActive(false)
					end
				end
			end

			local var_274_24 = 0.001

			if 3.8 <= arg_271_1.time_ and arg_271_1.time_ < 3.8 + var_274_24 then
				var_274_22.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_271_1.time_ - 3.8) / var_274_24)
			end

			if arg_271_1.time_ >= 3.8 + var_274_24 and arg_271_1.time_ < 3.8 + var_274_24 + arg_274_0 then
				var_274_22.localPosition = Vector3.New(0, -350, -320)
			end

			if 0.166666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 0.166666666666667 + arg_274_0 then
				arg_271_1:AudioAction("stop", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if 1.5 < arg_271_1.time_ and arg_271_1.time_ <= 1.5 + arg_274_0 then
				arg_271_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_27 = 3.999999999999
			local var_274_28 = 0.9

			if 3.999999999999 < arg_271_1.time_ and arg_271_1.time_ <= var_274_27 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_29 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_29:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_30 = arg_271_1:GetWordFromCfg(423091066)
				local var_274_31 = arg_271_1:FormatText(var_274_30.content)

				arg_271_1.text_.text = var_274_31

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_33 = 36 <= 0 and var_274_28 or var_274_28 * (utf8.len(var_274_31) / 36)

				if (36 <= 0 and var_274_28 or var_274_28 * (utf8.len(var_274_31) / 36)) > 0 and var_274_28 < var_274_33 then
					arg_271_1.talkMaxDuration = var_274_33
					var_274_27 = var_274_27 + 0.3

					if var_274_33 + var_274_27 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_33 + var_274_27
					end
				end

				arg_271_1.text_.text = var_274_31
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091066", "story_v_out_423091.awb") ~= 0 then
					local var_274_34 = manager.audio:GetVoiceLength("story_v_out_423091", "423091066", "story_v_out_423091.awb") / 1000

					if var_274_34 + var_274_27 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_34 + var_274_27
					end

					if var_274_30.prefab_name ~= "" and arg_271_1.actors_[var_274_30.prefab_name] ~= nil then
						local var_274_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_30.prefab_name].transform, "story_v_out_423091", "423091066", "story_v_out_423091.awb")

						arg_271_1:RecordAudio("423091066", var_274_35)
						arg_271_1:RecordAudio("423091066", var_274_35)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_423091", "423091066", "story_v_out_423091.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_423091", "423091066", "story_v_out_423091.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_36 = var_274_27 + 0.3
			local var_274_37 = math.max(var_274_28, arg_271_1.talkMaxDuration)

			if var_274_27 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_36 + var_274_37 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_36) / var_274_37

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_36 + var_274_37 and arg_271_1.time_ < var_274_36 + var_274_37 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play423091067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 423091067
		arg_277_1.duration_ = 8.37

		local var_277_0 = {
			zh = 6.6,
			ja = 8.366
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
				arg_277_0:Play423091068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 1 < arg_277_1.time_ and arg_277_1.time_ <= 1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10146 = arg_277_1.actors_["10146"].transform.localPosition
				arg_277_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10146", 3)

				for iter_280_0 = 0, arg_277_1.actors_["10146"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["10146"].transform:GetChild(iter_280_0)

					if var_280_0.name == "split_5" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 1 <= arg_277_1.time_ and arg_277_1.time_ < 1 + var_280_1 then
				arg_277_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_277_1.time_ - 1) / var_280_1)
			end

			if arg_277_1.time_ >= 1 + var_280_1 and arg_277_1.time_ < 1 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_280_2 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_2 + 1 and arg_277_1.time_ < var_280_2 + 1 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			if 3 < arg_277_1.time_ and arg_277_1.time_ <= 3 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_144", "se_story_144_wood", "")
			end

			local var_280_4 = 0
			local var_280_5 = 0.55

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(423091067)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 22 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 22)

				if (22 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 22)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091067", "story_v_out_423091.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_423091", "423091067", "story_v_out_423091.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_423091", "423091067", "story_v_out_423091.awb")

						arg_277_1:RecordAudio("423091067", var_280_11)
						arg_277_1:RecordAudio("423091067", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_423091", "423091067", "story_v_out_423091.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_423091", "423091067", "story_v_out_423091.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play423091068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 423091068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play423091069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10146"]) and arg_281_1.var_.actorSpriteComps10146 == nil then
				arg_281_1.var_.actorSpriteComps10146 = arg_281_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10146"]) then
				if arg_281_1.var_.actorSpriteComps10146 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10146:ToTable()) do
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

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10146"]) and arg_281_1.var_.actorSpriteComps10146 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10146 = nil
			end

			local var_284_2 = arg_281_1.actors_["10146"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10146 = var_284_2.localPosition
				var_284_2.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10146", 7)

				for iter_284_4 = 0, var_284_2.childCount - 1 do
					local var_284_3 = var_284_2:GetChild(iter_284_4)

					if var_284_3.name == "" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				var_284_2.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_281_1.time_ - 0) / var_284_4)
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				var_284_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_281_1.time_ and arg_281_1.time_ <= 1 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_144", "se_story_144_knock", "")
			end

			local var_284_6 = 0
			local var_284_7 = 1.875

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(423091068).content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 75 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_8) / 75)

				if (75 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_8) / 75)) > 0 and var_284_7 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_11 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_11 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_11

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_11 and arg_281_1.time_ < var_284_6 + var_284_11 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423091069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 423091069
		arg_285_1.duration_ = 7.7

		local var_285_0 = {
			zh = 5.733,
			ja = 7.7
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
				arg_285_0:Play423091070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10146"]) and arg_285_1.var_.actorSpriteComps10146 == nil then
				arg_285_1.var_.actorSpriteComps10146 = arg_285_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10146"]) then
				if arg_285_1.var_.actorSpriteComps10146 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10146:ToTable()) do
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

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10146"]) and arg_285_1.var_.actorSpriteComps10146 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10146 = nil
			end

			local var_288_2 = arg_285_1.actors_["10146"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10146 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10146", 3)

				for iter_288_4 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_4)

					if var_288_3.name == "split_6" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(0, -350, -320)
			end

			local var_288_5 = 0
			local var_288_6 = 0.45

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(423091069)
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

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091069", "story_v_out_423091.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_423091", "423091069", "story_v_out_423091.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_423091", "423091069", "story_v_out_423091.awb")

						arg_285_1:RecordAudio("423091069", var_288_12)
						arg_285_1:RecordAudio("423091069", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_423091", "423091069", "story_v_out_423091.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_423091", "423091069", "story_v_out_423091.awb")
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
				actorName = "10146",
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
	Play423091070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 423091070
		arg_289_1.duration_ = 14.23

		local var_289_0 = {
			zh = 10.833,
			ja = 14.233
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
				arg_289_0:Play423091071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.9

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(423091070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 36 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 36)

				if (36 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 36)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091070", "story_v_out_423091.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091070", "story_v_out_423091.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_423091", "423091070", "story_v_out_423091.awb")

						arg_289_1:RecordAudio("423091070", var_292_6)
						arg_289_1:RecordAudio("423091070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_423091", "423091070", "story_v_out_423091.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_423091", "423091070", "story_v_out_423091.awb")
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
	Play423091071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 423091071
		arg_293_1.duration_ = 11.7

		local var_293_0 = {
			zh = 6.5,
			ja = 11.7
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
				arg_293_0:Play423091072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.575

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(423091071)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 23 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 23)

				if (23 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 23)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091071", "story_v_out_423091.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_423091", "423091071", "story_v_out_423091.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_423091", "423091071", "story_v_out_423091.awb")

						arg_293_1:RecordAudio("423091071", var_296_6)
						arg_293_1:RecordAudio("423091071", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_423091", "423091071", "story_v_out_423091.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_423091", "423091071", "story_v_out_423091.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play423091072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 423091072
		arg_297_1.duration_ = 8.97

		local var_297_0 = {
			zh = 5.566,
			ja = 8.966
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
			arg_297_1.auto_ = false
		end

		function arg_297_1.playNext_(arg_299_0)
			arg_297_1.onStoryFinished_()
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10146 = arg_297_1.actors_["10146"].transform.localPosition
				arg_297_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10146", 3)

				for iter_300_0 = 0, arg_297_1.actors_["10146"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["10146"].transform:GetChild(iter_300_0)

					if var_300_0.name == "" or not string.find(var_300_0.name, "split") then
						var_300_0.gameObject:SetActive(true)
					else
						var_300_0.gameObject:SetActive(false)
					end
				end
			end

			local var_300_1 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 then
				arg_297_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_297_1.time_ - 0) / var_300_1)
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 then
				arg_297_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_300_2 = 0
			local var_300_3 = 0.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(423091072)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 20 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 20)

				if (20 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 20)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423091", "423091072", "story_v_out_423091.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_423091", "423091072", "story_v_out_423091.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_423091", "423091072", "story_v_out_423091.awb")

						arg_297_1:RecordAudio("423091072", var_300_9)
						arg_297_1:RecordAudio("423091072", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_423091", "423091072", "story_v_out_423091.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_423091", "423091072", "story_v_out_423091.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25g",
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/I26f"
	},
	voices = {
		"story_v_out_423091.awb"
	}
}
